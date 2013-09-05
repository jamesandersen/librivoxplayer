package org.jandersen.lvp.commands
{
	import org.jandersen.ecs.operations.BookSearchRequest;
	import org.jandersen.ecs.util.*;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.*;
	import com.adobe.cairngorm.control.CairngormEvent;
	import flash.media.ID3Info;
	
	public class SearchAmazonCommand extends AbstractLVCommand
	{
		
		public override function execute(event:CairngormEvent):void{
			var bsr:BookSearchRequest = new BookSearchRequest();
			var id3:ID3Info = event.data as ID3Info;
			bsr.title = id3.album;
			bsr.author = id3.artist;
			bsr.responseGroups.addItem(ResponseGroup.MEDIUM);
			var token:AsyncToken = bsr.send();
			token.addResponder(this);
		}
		
		public override function result(data:Object):void{
			var event:ResultEvent = data as ResultEvent;
			var result:XML = event.result as XML;
			if (result.namespace("") != undefined){
			    default xml namespace = result.namespace("");
			}
			
			var errors:XMLList = result..Error;
			if(errors.length() ==0){		
				var firstItem:XML = result..Item[0];
				_model.currentImageURL = firstItem.MediumImage.URL;
				_model.audioControl.imgTrack.height = firstItem.MediumImage.Height;
				_model.audioControl.imgTrack.width = firstItem.MediumImage.Width;
			}
		}
	}
}