package org.jandersen.lvp.controller
{
	import com.adobe.cairngorm.control.FrontController;
	
	import org.jandersen.lvp.commands.*;
	import org.jandersen.lvp.events.*;
	import mx.controls.Alert;

	public class LVController extends FrontController
	{
		public static const EVENT_NEW_RELEASES:String = "org.jandersen.lvp.events.NewReleasesEvent";
		public static const EVENT_PLAY_CHAPTER:String = "org.jandersen.lvp.events.PlayChapterEvent";
		public static const EVENT_SEARCH_AMAZON:String = "org.jandersen.lvp.events.SearchAmazonEvent";
		public static const EVENT_SEARCH_LIBRIVOX:String = "org.jandersen.lvp.events.SearchLibriVoxEvent";
		public static const EVENT_RETRIEVE_DETAILS:String = "org.jandersen.lvp.events.RetrieveDetailsEvent";
		public static const EVENT_DOWNLOAD_ZIP:String = "org.jandersen.lvp.events.DownloadZipEvent";
		
		public function LVController(){
			initCommands();
		}
		
		protected function initCommands():void{
			addCommand(EVENT_NEW_RELEASES, NewReleasesCommand);
			addCommand(RequestFeedEvent.REQUEST_FEED, BookFeedCommand);
			addCommand(EVENT_PLAY_CHAPTER, PlayChapterCommand);
			addCommand(EVENT_SEARCH_AMAZON, SearchAmazonCommand);
			addCommand(EVENT_SEARCH_LIBRIVOX, SearchLibrivoxCommand);
			addCommand(EVENT_RETRIEVE_DETAILS, RetrieveItemDetails);
			addCommand(EVENT_DOWNLOAD_ZIP, DownloadZipCommand);
		}
	}
}