package fish.action
{
	import fish.logging.log;
	import fish.metadata.resolveActionListener;
	import fish.metadata.resolveListener;
	
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import mx.events.PropertyChangeEvent;
	
	[Action(event="mouseOver", callback="overHandler")]
	[Action(event="mouseOut", callback="outHandler")]
	[Action(event="mouseDown", callback="downHandler")]
	[Action(event="mouseUp", callback="upHandler")]
	
	public class ButtonAction extends Action
	{
		protected var _states:Dictionary;
		
		public function ButtonAction(value:Object=null)
		{
			super(value);
		}
		
		override public function set target(value:Object):void
		{
			if(target != null) {
				stop();
			}
			
			super.target = value;
			_states = value.states;
			start();
		}
		
		override public function start():void
		{
			target.buttonMode = true;
			fish.metadata.resolveActionListener(this, target);
		}
		
		override public function stop():void
		{
			target.buttonMode = false;
			fish.metadata.resolveActionListener(this, target, true);
		}
		
		public function overHandler(event:MouseEvent):void
		{
			target.currentState = _states["over"];
		}
		
		public function outHandler(event:MouseEvent):void
		{
			target.currentState = _states["normal"];
		}
		
		public function downHandler(event:MouseEvent):void
		{
			target.currentState = _states["down"];
		}
		
		public function upHandler(event:MouseEvent):void
		{
			target.currentState = _states["over"];
		}
	}
}