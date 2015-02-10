package fish.action
{
	import fish.metadata.resolveDefaultProperties;
	import fish.metadata.resolveListener;
	import fish.metadata.resolveStyles;
	import fish.skins.ISkinable;
	
	import starling.events.EventDispatcher;
	import starling.events.PropertyChangeEvent;
	
	[Listener(event="propertyChange", callback="propertiesChange")]
	
	public class Action extends EventDispatcher implements IAction
	{
		protected var _target:Object;
		
		public function Action(value:Object = null)
		{
			super();

			target = value;
			
			fish.metadata.resolveDefaultProperties(this, propertiesChange);
			fish.metadata.resolveListener(this);
		}
		
		public function propertiesChange(event:PropertyChangeEvent):void
		{
			// nothing to do
		}
		
		public function start():void
		{
			// working with the Target
		}
		
		public function stop():void
		{
			// clear all instances and listeners
		}
		
		public function set target(value:Object):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "target", _target, value));
			_target = value;
		}
		
		public function get target():Object
		{
			return _target;
		}
	}
}