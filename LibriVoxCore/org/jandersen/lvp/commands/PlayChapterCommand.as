package org.jandersen.lvp.commands
{
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.media.*;
	import flash.events.*;
	import com.adobe.cairngorm.control.CairngormEvent;
	import mx.controls.Alert;
	
	public class PlayChapterCommand extends AbstractLVCommand
	{
		protected var _chapter:XML;
		
		public override function execute(event:CairngormEvent):void{
			_model.audioControl.startPlaying(event.data);
		}
		

	}
}