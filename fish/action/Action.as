package fish.action
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class Action extends EventDispatcher implements IAction
	{
		protected var _target:IEventDispatcher;
		protected var _parameters:Array;
		
		public function Action(target:IEventDispatcher, ...parameters)
		{
			super();
			_target = target;
			_parameters = parameters || [];
		}
		
		public function get target():IEventDispatcher
		{
			return _target;
		}
		
		public function set target(value:IEventDispatcher):void
		{
			_target = value;
		}
		
		public function regist():IAction
		{
			// Need to override
			
			return this;
		}
		
		public function unregist():IAction
		{
			// Need to override
			
			return this;
		}
	}
}