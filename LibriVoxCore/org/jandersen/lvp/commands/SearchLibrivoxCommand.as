package org.jandersen.lvp.commands
{
	import mx.rpc.events.*;
	import com.adobe.cairngorm.control.CairngormEvent;
	import mx.rpc.http.HTTPService;
	import mx.rpc.AsyncToken;
	import org.jandersen.lvp.model.*;
	
	public class SearchLibrivoxCommand extends AbstractLVCommand
	{
		
		protected var wsLVSearch:HTTPService;
		
		public override function execute(event:CairngormEvent):void{
			var params:Object = event.data;
			//remove ProxyService
			wsLVSearch = new LibriVoxModel.instance.environment.HTTPServiceClass();
			wsLVSearch.url = "http://librivox.org/newcatalog/search_advanced.php";
			wsLVSearch.method = "GET";
			wsLVSearch.resultFormat = "text";
			var token:AsyncToken = wsLVSearch.send(params);
			token.addResponder(this);
			
		}
		
		public override function result(data:Object):void{
			var event:ResultEvent = data as ResultEvent;
			_model.searchResults.removeAll();
			
			trace(event.result);
			var lvi:LibriVoxItem;
			var re:RegExp = /<a href="(http:\/\/librivox.org\/[^\/]*\/)">([^\.<]+)\.([^<]+)<\/a>/g;
			var result:Object = re.exec(event.result as String);
			while(result != null){
				lvi = new LibriVoxItem();
				lvi.guid = result[1];
				lvi.author = result[2];
				lvi.title = result[3];
				_model.searchResults.addItem(lvi);
				result = re.exec(event.result as String);
			}
			LibriVoxModel.searchState = SearchPanelState.RESULTS;
		}
	}
}