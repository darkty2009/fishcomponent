package fish.action
{
	import flash.events.IEventDispatcher;

	public interface IAction
	{
		function set target(value:Object):void;
		function get target():Object;
		
		function start():void;
		function stop():void;
	}
}