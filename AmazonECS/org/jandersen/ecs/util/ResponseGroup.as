package org.jandersen.ecs.util
{
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	public class ResponseGroup
	{
		
		private static var _constants:XMLList;
		private static function get constants():XMLList{
			if(_constants == null){
				var _typeDescription:XML = describeType(getDefinitionByName("org.jandersen.ecs.util"));
				_constants = _typeDescription..constant;
			}
			return _constants;
		}
		
		
		//static 
		private static var nextBitValue:int = 1;
		public static const ACCESSORIES:ResponseGroup = new ResponseGroup("Accessories");
		public static const ALT_VERSIONS:ResponseGroup = new ResponseGroup("AlternateVersions");
		public static const BROWSE_NODE_INFO:ResponseGroup = new ResponseGroup("BrowseNodeInfo");
		public static const BROWSE_NODES:ResponseGroup = new ResponseGroup("BrowseNodes");
		public static const CART:ResponseGroup = new ResponseGroup("Cart");
		public static const CART_NEW_RELEASES:ResponseGroup = new ResponseGroup("CartNewReleases");
		public static const CART_TOP_SELLERS:ResponseGroup = new ResponseGroup("CartTopSellers");
		public static const CART_SIMILARITIES:ResponseGroup = new ResponseGroup("CartSimilarities");
		public static const COLLECTIONS:ResponseGroup = new ResponseGroup("Collections");
		public static const CUSTOMER_FULL:ResponseGroup = new ResponseGroup("CustomerFull");
		public static const CUSTOMER_INFO:ResponseGroup = new ResponseGroup("CustomerInfo");
		public static const CUSTOMER_LISTS:ResponseGroup = new ResponseGroup("CustomerLists");
		public static const CUSTOMER_REVIEWS:ResponseGroup = new ResponseGroup("CustomerReviews");
		public static const EDITORIAL_REVIEW:ResponseGroup = new ResponseGroup("EditorialReview");
		public static const HELP:ResponseGroup = new ResponseGroup("Help");
		public static const IMAGES:ResponseGroup = new ResponseGroup("Images");
		public static const ITEM_ATTRIBUTES:ResponseGroup = new ResponseGroup("ItemAttributes");
		public static const ITEM_IDS:ResponseGroup = new ResponseGroup("ItemIds");
		public static const LARGE:ResponseGroup = new ResponseGroup("Large");
		///...
		public static const MEDIUM:ResponseGroup = new ResponseGroup("Medium");
		public static const SMALL:ResponseGroup = new ResponseGroup("Small");
		
		
		
		
		
		//instance members
		[DefaultProperty]
		public var name:String;
		public var bit:int;
		
		public function ResponseGroup(group:String){
			this.name = group;
			this.bit = nextBitValue;
			nextBitValue *= 2;
		}
		
		public function toString():String{
			return name;
		}
		
	}
}