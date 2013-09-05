package org.jandersen.ecs.util
{
	public class SearchIndex
	{
		//Static members
		public static const ALL:SearchIndex = new SearchIndex("All");
		public static const APPAREL:SearchIndex = new SearchIndex("Apparel");
		public static const AUTO:SearchIndex = new SearchIndex("Automotive");
		public static const BABY:SearchIndex = new SearchIndex("Baby");
		public static const BEAUTY:SearchIndex = new SearchIndex("Beauty");
		public static const BLENDED:SearchIndex = new SearchIndex("Blended");
		public static const BOOKS:SearchIndex = new SearchIndex("Books");
		public static const CLASSICAL:SearchIndex = new SearchIndex("Classical");
		public static const DIGITAL_MUSIC:SearchIndex = new SearchIndex("DigitalMusic");
		public static const DVD:SearchIndex = new SearchIndex("DVD");
		public static const ELECTRONICS:SearchIndex = new SearchIndex("Electronics");
		public static const GOURMENT_FOOD:SearchIndex = new SearchIndex("GourmetFood");
		public static const HEALTH_PERSONALL:SearchIndex = new SearchIndex("HealthPersonalCare");
		public static const HOME_GARDEN:SearchIndex = new SearchIndex("HomeGarden");
		public static const MUSIC:SearchIndex = new SearchIndex("Music");
		
		//Instance members
		public var index:String;
		
		public function SearchIndex(i:String){
			index = i;
		}
		
		public function toString():String{
			return index;
		}
	}
}