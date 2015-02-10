package fish.container.tabClasses
{
	import fish.action.ToggleAction;
	import fish.component.FToggleButton;
	import fish.container.FContainer;
	import fish.display.FSprite;
	import fish.events.TabChangeEvent;
	import fish.layout.HorizonalLayout;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class FTab extends FContainer
	{
		public function FTab(value:*=null, isAdd:Boolean=true)
		{
			super(value, isAdd);
		}
		
		private var _tabs:Array = [];
		
		public function addTab(tab:FToggleButton):void
		{
			addTabByIndex(tab, _tabs.length);
		}
		
		public function addTabByIndex(tab:FToggleButton, index:Number):void
		{
			_tabs[index] = tab;
			
			if(_current < 0) {
				_current = 0;
			}
			
			updateTabs(tab);
		}
		
		public function removeTab(tab:FToggleButton):void
		{
			for(var i:Number=0;i<_tabs.length;i++) {
				if(_tabs[i] === tab) {
					removeTabByIndex(i);
					break;
				}
			}
		}
		
		public function removeTabByIndex(index:Number):void
		{
			updateTabs(null, _tabs.splice(index, 1));
		}
		
		private var _current:Number = -1;
		
		public function get current():Number
		{
			return _current;
		}
		
		public function set current(value:Number):void
		{
			if(value < _tabs.length) {
				_current = value;
			}
		}
		
		protected function updateTabs(addOne:FToggleButton = null, delOne:FToggleButton = null):void
		{
			if(addOne) {
				addOne.addEventListener(MouseEvent.CLICK, clickHandler);
				_target.addChild(addOne);
			}
			if(delOne) {
				delOne.removeEventListener(MouseEvent.CLICK, clickHandler);
				_target.removeChild(delOne);
			}
			
			if(_current >-1 && _current < _tabs.length) {
				_target.getChildAt(_current).gotoAndStop("selected");
			}
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			var index:Number = _target.getChildIndex(event.currentTarget);
			var tabEvent:TabChangeEvent = new TabChangeEvent(TabChangeEvent.CHANGE);
			tabEvent.tab = event.currentTarget as FToggleButton;
			tabEvent.index = index;
			
			dispatchEvent(tabEvent);
		}
		
		override public function create(event:Event=null):void
		{
			layout = new HorizonalLayout(_target);
			(layout as HorizonalLayout).padding = 0;
			
			super.create();
			
			updateTabs();
			
			layout.execute(null, null, null);
		}
	}
}