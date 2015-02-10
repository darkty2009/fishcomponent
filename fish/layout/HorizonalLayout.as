package fish.layout
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	public class HorizonalLayout extends Layout
	{
		public var padding:Number = 2;
		
		public function HorizonalLayout(target:*)
		{
			super(target);
		}
		
		override public function execute(child:DisplayObject, oldValue:Rectangle, newValue:Rectangle):void
		{
			var width:Number = target.width;
			var height:Number = target.height;
			
			var len:Number = target.numChildren;
			
			var base:Number = 0;
			for(var i:Number = 0;i<len;i++) {
				var item:DisplayObject = target.getChildAt(i);
				item.y = 0;
				item.x = base;
				
				base += item.width + padding;
			}
		}
	}
}