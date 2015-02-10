package fish.layout
{
	import fish.events.ResizeEvent;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;

	public class Layout
	{
		private var _target:DisplayObjectContainer;
		
		public function get target():DisplayObjectContainer
		{
			return _target;
		}
		
		public var autoLayout:Boolean = false;
		
		public function Layout(target:*)
		{
			if(target && target is DisplayObjectContainer) {
				this.target = target;
			}
		}
		
		public function set target(value:DisplayObjectContainer):void
		{
			if(_target) {
				_target.removeEventListener(ResizeEvent.CHILD_RESIZE, childResizeHandler);
			}
			
			_target = value;
			
			if(_target) {
				_target.addEventListener(ResizeEvent.CHILD_RESIZE, childResizeHandler);
			}
		}
		
		protected function childResizeHandler(event:ResizeEvent):void
		{
			execute(event.child, event.oldValue, event.newValue);
		}

		public function execute(child:DisplayObject, oldValue:Rectangle, newValue:Rectangle):void
		{
			
		}
	}
}