package org.jandersen.lvp.components
{
	import mx.rpc.http.HTTPService;
	import mx.rpc.IResponder;
	import mx.rpc.events.*;
	import mx.utils.StringUtil;

	public class BookFeedService extends HTTPService implements IResponder
	{
		protected var _lbvGUID:String;
		
		public function BookFeedService(lbvGUID:String){
			//http://librivox.org/the-memoirs-of-sherlock-holmes-by-sir-arthur-conan-doyle/
			this._lbvGUID = lbvGUID;
		}
		
		public function result( data:Object ):void
		{
		 	// Most of the time the data is a ResultEvent, so just cast it here
		 	var e:ResultEvent = data as ResultEvent;
			var lines:Array = StringUtil.trim(e.result.toString()).split("\n");
			
			
		}
		
		
		public function fault( info:Object ):void
		{
		 	// Most of the time the info is a FaultEvent, so just cast it here
		 	var event:FaultEvent = info as FaultEvent;
		}
	}
}