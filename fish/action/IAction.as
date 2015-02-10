package fish.action
{
	import fish.display.FDisplayObject;
	
	import flash.events.IEventDispatcher;

	public interface IAction
	{
		function get target():IEventDispatcher;
		function set target(value:IEventDispatcher):void;
		
		function regist():IAction;
		function unregist():IAction;
	}
}