package fish.layout
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	public class VerticalLayout extends Layout
	{
		public var padding:Number = 2;
		public var autoCenter:Boolean = false;
		
		public function VerticalLayout(target:*)
		{
			super(target);
		}
		
		override public function execute(child:DisplayObject, oldValue:Rectangle, newValue:Rectangle):void
		{
			var width:Number = target.width;
			var height:Number = target.height;
			
			var len:Number = target.numChildren;
			
			var base:Number = 0;
			for(var i:Number=0;i<len;i++) {
				var item:DisplayObject = target.getChildAt(i);
				if(!autoCenter) {
					item.x = 0;
				}else {
					var tw:Number = item is TextField?(item as TextField).textWidth+8:item.width;
					item.x = (width - tw) / 2;
				}
				item.y = base;
				if(item is TextField) {
					base += (item as TextField).textHeight + padding;
				}else {
					base += height + padding;
				}
			}
		}
	}
}