package fish.action
{
	import fish.logging.log;
	import fish.metadata.resolveActionListener;
	import fish.metadata.resolveListener;
	
	import flash.utils.Dictionary;
	
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	[Action(event="touch", callback="touchHandler")]
	
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
			target.touchable = true;
			fish.metadata.resolveActionListener(this, target);
		}
		
		override public function stop():void
		{
			fish.metadata.resolveActionListener(this, target, true);
		}
		
		public function touchHandler(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(target as DisplayObject);
			
			if(touch == null) {
				target.currentState = _states["normal"];
				return;
			}
			
			if(touch.phase == starling.events.TouchPhase.HOVER) {
				target.currentState = _states["over"];
			}
			if(touch.phase == starling.events.TouchPhase.ENDED) {
				target.currentState = _states["normal"];
			}
		}
		
		/*
		public function overHandler(event:TouchEvent):void
		{
			target.currentState = _states["over"];
		}
		
		public function outHandler(event:TouchEvent):void
		{
			target.currentState = _states["normal"];
		}
		
		public function downHandler(event:TouchEvent):void
		{
			target.currentState = _states["down"];
		}
		
		public function upHandler(event:TouchEvent):void
		{
			target.currentState = _states["over"];
		}
		*/
	}
}