package fish.manager
{
	import fish.display.FBitmap;
	
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;

	public class DragDropManager
	{
		public static var instance:DragDropManager;
		{
			instance = new DragDropManager();
		}
		
		public static var stage:Stage;
		
		public static function doDrag(container:*, bitmap:FBitmap, source:DragSource, event:MouseEvent):void
		{
			instance.doDrag(container, bitmap, source, event);
		}
		
		private var __proxy:DragProxy;
		
		public function doDrag(container:*, bitmap:FBitmap, source:DragSource, event:MouseEvent):void
		{
			__proxy = new DragProxy();
			__proxy.mouseChildren = false;
			bitmap.alpha = 0.7;
			__proxy.addChild(bitmap);
			__proxy.source = source;
			__proxy.container = container;
			
			var _x:Number = event.stageX - event.localX;
			var _y:Number = event.stageY - event.localY;
			__proxy.x = _x - (bitmap.width/2);
			__proxy.y = _y - (bitmap.height/2);
			__proxy.width = bitmap.width;
			__proxy.height = bitmap.height;
			
			stage.addChild(__proxy);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, __dragUpHandler);
			__proxy.addEventListener(MouseEvent.MOUSE_UP, __dragUpHandler);
			
			__proxy.startDrag(false, new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
		}
		
		private function __dragUpHandler(event:MouseEvent):void
		{
			var list:Array = stage.getObjectsUnderPoint(new Point(event.stageX, event.stageY));
			var target:*;
			
			for(var i:Number=0;i<list.length;i++) {
				var temp:* = list[i];
				while(temp.parent) {
					if(temp.hasOwnProperty("canDrop") && temp.canDrop == true) {
						target = temp;
						break;
					}
					temp = temp.parent;
				}
				if(target) {
					break;
				}
			}
			
			__proxy.stopDrag();
			
			stage.removeEventListener(MouseEvent.MOUSE_UP, __dragUpHandler);
			__proxy.removeEventListener(MouseEvent.MOUSE_UP, __dragUpHandler, true);
			
			stage.removeChild(__proxy);
			
			if(target) {
				__proxy.source = target.onDrop(__proxy.source);
				if(__proxy.source.success) {
					__proxy.container.dragOver(true, __proxy.source);
				}else {
					__proxy.container.dragOver(false, __proxy.source);
				}
			}else {
				__proxy.container.dragOver(false, __proxy.source);
			}
			
			__proxy = null;
		}
	}
}