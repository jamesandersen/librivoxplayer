package org.jandersen.lvp.components
{
	import mx.controls.Label;

	public class TimeLabel extends Label
	{
		private var _milliseconds:Number;
		private var _millisecondsDirty:Boolean = false;
		
		
		public function get milliseconds():Number{ return _milliseconds; }
		public function set milliseconds(msecs:Number):void {
			_milliseconds = msecs; 
			_millisecondsDirty = true; 
			invalidateDisplayList();
		}
		
		protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if(_millisecondsDirty){
				this.text = msecsToTime(_milliseconds);
				_millisecondsDirty = false;
			}
			
		}
		
		public static function msecsToTime(msecs:Number):String{
			var hours:Number = Math.floor(msecs/(1000*60*60));
   			msecs -= hours * (1000*60*60);
   			var mins:Number = Math.floor(msecs/(1000*60));
   			msecs -= mins * (1000*60);
   			var secs:Number = Math.round(msecs/1000);
   			
   			return (hours < 10 ? "0" + hours : hours) + ":" 
   				+ (mins < 10 ? "0" + mins : mins) + ":" 
   				+ (secs < 10 ? "0" + secs : secs);
		}
	}
}