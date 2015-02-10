package fish.skins
{
	import fish.core.IDrawable;
	
	import flash.utils.Dictionary;

	public interface ISkinable
	{
		function set skinName(value:String):void;
		function get skinName():String;
		
		function set states(value:*):void;
		function get states():Dictionary;
		
		function setStateStyle(key:*, value:ISkin):void;
		function getStateStyle(value:*):ISkin;
		
		function resolveStyles():void;
	}
}