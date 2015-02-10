package fish.core
{
	import flash.events.Event;

	public interface IComponent
	{
		function get name():String;
		function resolveProperties():void;
		function validate(event:Event = null):void;
		function toString():String;
	}
}