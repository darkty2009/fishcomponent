package fish.core
{
	import flash.display.Stage;
	import flash.events.Event;

	public interface ICalllater
	{
		function callLater(name:String, method:Function):void;
		function callLaterHandler(event:Event):void;
	}
}