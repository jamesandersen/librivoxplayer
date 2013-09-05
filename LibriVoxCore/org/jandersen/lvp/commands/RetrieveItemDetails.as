package org.jandersen.lvp.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.jandersen.lvp.model.LibriVoxItem;
	
	public class RetrieveItemDetails extends AbstractLVCommand
	{
		private var lvi:LibriVoxItem;
		
		override public function execute(event:CairngormEvent):void{
			lvi = event.data as LibriVoxItem;
			if(!lvi.isFullyLoaded()){ //if not already done, retrieve and parse HTML
				var hs:HTTPService = new _model.environment.HTTPServiceClass();
				hs.url = lvi.guid;
				hs.resultFormat = "text";
				var token:AsyncToken = hs.send();
				token.addResponder(this);
			}
		}
		
		override public function result(data:Object):void{
			if(data is ResultEvent){
				var event:ResultEvent = data as ResultEvent; 
				lvi.loadFromHTML(event.result as String);
			}	
		}
		
	}
}