package fish.layout
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	public class TileLayout extends Layout
	{
		public function TileLayout(target:*)
		{
			super(target);
		}
		
		public var padding:Number = 2;
		public var columns:Number = 2;
		public var rows:Number = 2;
		public var colWidth:Number = 50;
		public var rowHeight:Number = 50;
		
		override public function execute(child:DisplayObject, oldValue:Rectangle, newValue:Rectangle):void
		{
			var width:Number = target.width;
			var height:Number = target.height;
			
			if(autoLayout) {
				colWidth = (width - padding) / columns - padding;
				rowHeight = (height - padding) / rows - padding;
			}
			
			var len:Number = target.numChildren;
			
			for(var i:int = 0; i<len;i++) {
				var x:Number = (i%columns);
				var y:Number = Math.floor((i - x) / columns);
				
				var child:DisplayObject = target.getChildAt(i);
				child.x = x * padding + x * colWidth;
				child.y = y * padding + y * rowHeight;
			}
		}
	}
}