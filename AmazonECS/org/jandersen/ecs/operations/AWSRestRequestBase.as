package org.jandersen.ecs.operations
{
	import mx.rpc.http.HTTPService;
	import mx.rpc.*;
	import org.jandersen.ecs.util.AWSConstants;
	import mx.collections.ArrayCollection;

	public class AWSRestRequestBase extends HTTPService
	{
		protected var accessKey:String = AWSConstants.ACCESS_KEY_ID;
		protected var associateTag:String = AWSConstants.ASSOCIATE_TAG_ID;
		protected var service:String = "AWSECommerceService";
		protected var operation:String;
		
		public var responseGroups:ArrayCollection;
		
		
		public function AWSRestRequestBase(operation:String){
			this.url = "http://ecs.amazonaws.com/onca/xml";
			this.operation = operation;
			this.resultFormat = "e4x";
			
			responseGroups = new ArrayCollection();
		}
		
		protected function addParameters(params:Object):void{
			params['Service'] = service;
			params['Operation'] = operation;
			params['AssociateTag'] = associateTag;
			params['AWSAccessKeyId'] = accessKey;	
			if(responseGroups.length > 0){
				params['ResponseGroup'] = responseGroups.source.join(",");
			}	
		}
		
		public override function send(parameters:Object=null):AsyncToken{
			if(parameters == null) parameters = new Object();
			addParameters(parameters);
			return super.send(parameters);
		}
	}
}