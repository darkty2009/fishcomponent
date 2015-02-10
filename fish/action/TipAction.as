package fish.action
{
	import fish.manager.TipManager;
	
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	
	public class TipAction extends Action
	{
		public function TipAction(target:IEventDispatcher, ...parameters)
		{
			super(target, parameters);
			
			name = parameters[0] as String;
			tipClass = parameters[1] as Class;
			delay = parameters[2] as Number;
			data = parameters[3] as Object;
		}
		
		protected var name:String;
		protected var tipClass:Class;
		protected var delay:Number = 0;
		protected var data:Object = null;
		
		override public function regist():IAction
		{
			if(target) {
				fish.manager.TipManager.getInstance().regist(target as DisplayObject, name, tipClass, delay, data);
			}
			
			return this;
		}
		
		override public function unregist():IAction
		{
			if(target) {
				fish.manager.TipManager.getInstance().unregist(target as DisplayObject);
			}
			
			return this;
		}
	}
}