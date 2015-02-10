package fish.core
{
	import flash.display.Stage;
	import flash.events.Event;

	public interface ICalllater
	{
		function callLater(method:Function):void;
		function callLaterHandler(event:Event):void;
	}
}