package fish.core
{
	import flash.events.Event;

	public interface IComponent
	{
		function set width(value:Number):void;
		function get width():Number;
		function set height(value:Number):void;
		function get height():Number;
		function set x(value:Number):void;
		function get x():Number;
		function set y(value:Number):void;
		function get y():Number;
		function get name():String;
		function resolveProperties():void;
		function resolveEvent():void;
		function validate(event:Event = null):void;
		function toString():String;
	}
}