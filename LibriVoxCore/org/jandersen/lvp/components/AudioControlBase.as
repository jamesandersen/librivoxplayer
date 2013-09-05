package org.jandersen.lvp.components
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.fusiox.ui.Visualization;
	
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	import flash.utils.Timer;
	
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.controls.Button;
	import mx.controls.HSlider;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.controls.List;
	import mx.controls.ProgressBar;
	import mx.events.ListEvent;
	import mx.events.SliderEvent;
	
	import org.jandersen.lvp.controller.LVController;
	import org.jandersen.lvp.model.LibriVoxModel;

	public class AudioControlBase extends Canvas
	{
		[Bindable] public var sound:Sound;
		[Bindable] public var channel:SoundChannel;
		[Bindable] public var chapter:XML;
		[Bindable] public var progressBar:ProgressBar;
		
		public var lblTrack:Label;
		public var lblStatus:TimeLabel;
		public var lblDuration:TimeLabel;
		public var imgTrack:Image;
		
		public var positionSlider:HSlider;
		public var visualization:Visualization;
		public var btnPause:Button;
		public var lstPlaylist:List;
		[Bindable] public var bxControls:HBox;
		
		[Bindable] protected var loading:Boolean;
		[Bindable] protected var playing:Boolean;
		protected var thumbDragging:Boolean;
		protected var timer:Timer;
		protected var pausePos:Number;
		
		
		[Bindable]
		public function get playlist():Object { return lstPlaylist.dataProvider; }
		public function set playlist(o:Object):void { lstPlaylist.dataProvider = o; }
		
		public function get imgSource():Object { return imgTrack.source; }
		public function set imgSource(o:Object):void { 
			imgTrack.source = o; 
			if(imgTrack.source != null){
				imgTrack.visible = imgTrack.includeInLayout = true;
			}else{
				imgTrack.visible = imgTrack.includeInLayout = false;
				bxControls.percentWidth = 100;
				//this.height = bxControls.height;
			}
		}
		
		public function AudioControlBase(){
			super();
			loading = false;
			playing = false;
			thumbDragging = false;
			timer = new Timer(500);
			timer.addEventListener(TimerEvent.TIMER, handleTimerEvent);
		}
		
		protected override function createChildren():void{
			super.createChildren();
			imgTrack.addEventListener(Event.COMPLETE, handleImgComplete);
		}
		
		public function startPlaying(chap:XML):void{
			stopPlaying();
			chapter = chap;
			lblStatus.text = "loading " + chapter.link;
	        //sound = new Sound(new URLRequest(chapter.link));
	       	sound = LibriVoxModel.instance.environment.getSound(chapter.link);
	        loading = true;
	        sound.addEventListener(Event.ID3, handleID3);
	        sound.addEventListener(Event.COMPLETE, completeSound);
	        sound.addEventListener(IOErrorEvent.IO_ERROR, handleError);
	        channel = sound.play();
	        channel.addEventListener(Event.SOUND_COMPLETE, handleChannelComplete);
	        playing = true;
	        progressBar.source = sound;
	        timer.start();
	      }
	      
		public function reset():void{
			stopPlaying();
			this.lblStatus.text = "";
			this.lblTrack.text = "";
		}
	              
		protected function stopPlaying():void{
			if(channel != null) channel.stop();
			SoundMixer.stopAll();
			if(sound != null){
				sound.removeEventListener(Event.COMPLETE,completeSound);
				sound.removeEventListener(IOErrorEvent.IO_ERROR, handleError);
				sound.removeEventListener(Event.ID3, handleID3);
			}
			sound = null;
			loading = false;
			playing = false;
			timer.stop();
			progressBar.source = null;
			progressBar.mode = "manual";
			progressBar.setProgress(0, 0);
			progressBar.mode = "event";
			positionSlider.value = 0;
			lblStatus.milliseconds = positionSlider.value;
		}
		
		protected function pause():void{
			if(btnPause.label == "Pause"){
				pausePos = channel.position;
				SoundMixer.stopAll();
				btnPause.label = "Resume";
				timer.stop();
			}else{
				channel = sound.play(pausePos);
				timer.start();
				btnPause.label = "Pause"
			}
		}
		
		private function handleID3(event:Event):void{
			lblTrack.text = sound.id3.artist + " - " + sound.id3.songName;
			var dispatcher:CairngormEventDispatcher = CairngormEventDispatcher.getInstance();
			var evt:CairngormEvent = new CairngormEvent(LVController.EVENT_SEARCH_AMAZON);
			evt.data = sound.id3;
			dispatcher.dispatchEvent(evt);
		}
   		
   		
   		private function completeSound(e:Event):void{
   			lblStatus.text = "chapter complete";
   			loading = false;
   			positionSlider.maximum = Math.round(sound.length);
   			lblDuration.milliseconds = sound.length;
   		}
   		
   		private function handleError(e:IOErrorEvent):void{
   			lblTrack.text = e.text;
   		}
		
		//this executes every 500 msecs
		//moves the slider along and updates the status
		protected function handleTimerEvent(e:TimerEvent):void{
			if(!loading && !thumbDragging){
				positionSlider.value = Math.round(channel.position);
				lblStatus.milliseconds = positionSlider.value;
			}
		}
		
		//stop the timer when the sound is finished playing
		protected function handleChannelComplete(e:Event):void{
			timer.stop();
		}
		
		//allow slider to navigate within the sound
		protected function slider_change(e:SliderEvent):void{
			SoundMixer.stopAll();
			trace("released at", e.thumbIndex, positionSlider.value);
			channel = sound.play(positionSlider.value);
			timer.start();
			thumbDragging = false;
		}
		
		//add vertical scroll effect to audio visualization
		protected function verticalScroll( e:Event ):void {
   			e.target.bitmapData.scroll(0,5);
   		}
   		
   		//convert data tips from msecs to time
   		protected function sliderDataTipFormat(val:String):String {
   			try{
   				var msecs:Number = parseFloat(val);
   				return TimeLabel.msecsToTime(msecs);
   			}catch(e:Error){
   				
   			}
   			return val;
   		}
   		
   		protected function btnPlaylist_click(e:MouseEvent):void{
   			this.currentState = ((!currentState || currentState == "") ? "playlist" : "");
   		}
   		
   		protected function handleChapterChange(e:ListEvent):void{
			var evt:CairngormEvent = new CairngormEvent(LVController.EVENT_PLAY_CHAPTER);
			evt.data = e.itemRenderer.data;
			evt.dispatch();
			lblStatus.text = "";
			lblTrack.text = "";
		}
		
		protected function handleImgComplete(e:Event):void{
			if(imgTrack.visible){
				bxControls.percentWidth = (100 * (1- (imgTrack.width/this.width)))-2;
			}else{
				bxControls.percentWidth = 100;
			}
			this.height = Math.max(bxControls.height, imgTrack.height + 10);
		}
	}
}