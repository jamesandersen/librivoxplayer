package org.jandersen.lvp.model
{
	import flash.system.ApplicationDomain;
	import flash.system.Security;
	
	
	
	public class EnvironmentFactory
	{
		public static const UNSUPPORTED_FEATURE:String = "This feature is not supported in this environment";
		
		static private function getClassDef(className:String):Object{
			var def:Object = ApplicationDomain.currentDomain.getDefinition(className);
			return def;
		}
		
		static private function isAir():Boolean{
			return Security.sandboxType.toString() == "application" ? true : false;
		}
		
		static public function getInstance():IEnvironment{
			var env:IEnvironment;
			var className:String = isAir() ? 
				"org.jandersen.lvp.model.AIREnvironment" : 
				"org.jandersen.lvp.model.FlexEnvironment";
			var classDef:Object = getClassDef(className);
			env = new classDef();			
			return env;
		}
	}
	
	
}
