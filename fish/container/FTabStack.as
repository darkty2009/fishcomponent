package fish.container
{
	import fish.component.FToggleButton;
	import fish.container.tabClasses.FStack;
	import fish.container.tabClasses.FTab;
	import fish.display.FMovieClip;
	import fish.events.TabChangeEvent;
	import fish.layout.VerticalLayout;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	public class FTabStack extends FContainer
	{
		public function FTabStack(value:*=null, isAdd:Boolean=true)
		{
			super(value, isAdd);
			
			tab = new FTab();
			tab.height = tabHeight;
			content = new FContainer();
		}
		
		public var tab:FTab;
		public var content:FContainer;
		
		public var tabHeight:Number = 31;
		
		override public function create(event:Event=null):void
		{	
			super.create();
			
			target.addChild(content);
			target.addChild(tab);
			
			tab.addEventListener(TabChangeEvent.CHANGE, tabChangeHandler);
		}
		
		override public function destroy(event:Event=null):void
		{
			tab.removeEventListener(TabChangeEvent.CHANGE, tabChangeHandler);
		}
		
		protected function tabChangeHandler(event:TabChangeEvent):void
		{
			showStack(event.index);
		}
		
		public function showStack(index:Number):void
		{
			var last:FStack = content.target.getChildAt(tab.current) as FStack;
			last.visible = last.mouseEnabled = last.mouseChildren = false;
			
			var current:FStack = content.target.getChildAt(index) as FStack;
			current.visible = current.mouseEnabled = current.mouseChildren = true;
			
			tab.current = index;
		}
		
		public function addStack(button:FToggleButton, stack:FStack):void
		{	
			tab.addTab(button);
			
			stack.visible = stack.mouseEnabled = stack.mouseChildren = false;
			
			content.target.addChild(stack);
		}
		
		public function getStack(index:Number):FStack
		{
			if(index >= 0 && index < content.target.numChildren) {
				return content.target.getChildAt(index) as FStack;
			}else {
				return null;
			}
		}
	}
}