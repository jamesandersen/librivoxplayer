package org.jandersen.lvp.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.utils.Dictionary;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.*;
	import mx.rpc.http.HTTPService;
	
	import org.jandersen.lvp.controller.LVController;
	import org.jandersen.lvp.events.RequestFeedEvent;
	import org.jandersen.lvp.model.*;

	public class BookFeedCommand extends AbstractLVCommand
	{
		private static var rssCache:Dictionary = new Dictionary();
		private var feedURL:String;
		override public function execute(event:CairngormEvent):void
		{
			var feedEvent:RequestFeedEvent = event as RequestFeedEvent;
			var item:LibriVoxItem = feedEvent.data as LibriVoxItem;
			//var ns:Array = item.namespaceDeclarations();
			feedURL = item.guid;
			feedURL = feedURL.replace(/http:\/\/librivox.org\/(.*)\//, "http://librivox.org/bookfeeds/$1.xml");
			if(rssCache[feedURL] == null){
				//TODO remove proxy
				var hsFeed:HTTPService = new _model.environment.HTTPServiceClass();
				hsFeed.url = feedURL;
				hsFeed.resultFormat = "e4x";
				var token:AsyncToken = hsFeed.send();
				token.addResponder(this);
			}else{
				_model.currentChapters = rssCache[feedURL];
			}
			//remove any picture that may be currently displayed
			_model.currentImageURL = null;
			_model.audioControl.reset();
		}
		
		override public function result(data:Object):void
		{
			var e:ResultEvent = data as ResultEvent;
			var rss:XML = e.result as XML;
			_model.currentChapters = rss..item;
			rssCache[feedURL] = _model.currentChapters;
			
			var evt:CairngormEvent = new CairngormEvent(LVController.EVENT_PLAY_CHAPTER);
			evt.data = _model.currentChapters[0];
			evt.dispatch();
		}
		
		
	}
}