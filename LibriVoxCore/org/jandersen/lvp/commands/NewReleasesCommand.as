package org.jandersen.lvp.commands
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.*;
	import mx.rpc.http.HTTPService;
	
	import org.jandersen.lvp.model.*;

	public class NewReleasesCommand extends AbstractLVCommand implements ICommand, IResponder
	{
		public override function execute(event:CairngormEvent):void
		{
			//TODO remove proxy
			var serviceClass:Class = LibriVoxModel.instance.environment.HTTPServiceClass;
			var hsLibriVox:HTTPService = new serviceClass();
			hsLibriVox.url = "http://archive.org/services/collection-rss.php?collection=librivoxaudio";
			hsLibriVox.resultFormat = HTTPService.RESULT_FORMAT_E4X;
			var token:AsyncToken = hsLibriVox.send();
			token.addResponder(this);
		}
		
		public override function result(data:Object):void
		{
			var e:ResultEvent = data as ResultEvent;
			var rss:XML = e.result as XML;
			var items:XMLList = rss..item;
			var item:XML;
			for each(item in items){
				_model.newItems.addItem(new LibriVoxItem(item));
			}
			
		}
		
		public override function fault(info:Object):void
		{
			var e:FaultEvent = info as FaultEvent;
		}
		
	}
}