package org.jandersen.lvp.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import flash.events.Event;

	public class RequestFeedEvent extends CairngormEvent
	{
		public static const REQUEST_FEED:String = "Request bookfeed event";
		
		public function RequestFeedEvent(){
			super(REQUEST_FEED);
		}
		
		
		
		override public function clone():Event{
			return new RequestFeedEvent();
		}
	}
}