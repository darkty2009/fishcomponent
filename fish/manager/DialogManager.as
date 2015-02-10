package fish.manager
{
	import fish.container.FDialog;
	import fish.display.FBitmap;
	import fish.display.FDisplayObject;
	import fish.events.DialogEvent;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	public class DialogManager
	{
		protected static var instance:DialogManager;
		
		protected static function getInstance():DialogManager
		{
			if(instance == null)
				instance = new DialogManager();
			
			return instance;
		}
		
		public static function createDialog(parent:DisplayObjectContainer, clazz:Class, content:* = null, modal:Boolean = true, autoShow:Boolean = true):FDialog
		{
			return getInstance().createDialog(parent, clazz, content, modal, autoShow);
		}
		
		public static function addDialog(dialog:FDialog, parent:DisplayObjectContainer, modal:Boolean = true):void
		{
			getInstance().addDialog(dialog, parent, modal);
		}
		
		public static function centerDialog(dialog:FDialog):void
		{
			getInstance().centerDialog(dialog);
		}
		
		public static function removeDialogByClass(value:Class):void
		{
			getInstance().removeDialogByClass(value);
		}
		
		public static function removeDialog(dialog:FDialog, now:Boolean = false):void
		{
			getInstance().removeDialog(dialog, now);
		}
		
		protected var dialogMap:Dictionary = new Dictionary(false);
		
		public function createDialog(parent:DisplayObjectContainer, clazz:Class, content:* = null, modal:Boolean = true, autoShow:Boolean = true):FDialog
		{
			const dialog:FDialog = new clazz(content, modal, autoShow);
			addDialog(dialog, parent, modal);
			return dialog;
		}
		
		public function addDialog(dialog:FDialog, parent:DisplayObjectContainer, modal:Boolean = true):void
		{
			if(parent.contains(dialog))
				return;
			
			if(modal) {
				dialog.addEventListener(DialogEvent.SHOW, dialogShowHandler);
			}
			dialog.addEventListener(DialogEvent.HIDE, dialogHideHandler);
			
			parent.addChild(dialog);
			centerDialog(dialog);
			
			if(modal && modalMask == null) {
				modalMask = new FDisplayObject();
				modalMask.graphics.beginFill(0x000000, 0.5);
				modalMask.graphics.drawRect(0, 0, dialog.stage.stageWidth, dialog.stage.stageHeight);
				modalMask.graphics.endFill();
				modalMask.mouseEnabled = true;
			}
			
			dialog.show();
			
			var dialogClass:String = flash.utils.getQualifiedClassName(dialog);
			if(dialogMap[dialogClass] != null) {
				removeDialog(dialogMap[dialogClass] as FDialog);
			}
			
			dialogMap[dialogClass] = dialog;
		}
		
		public function centerDialog(dialog:FDialog):void
		{
			var rect:Rectangle = new Rectangle(dialog.x, dialog.y, dialog.width, dialog.height);
			var stage:Stage = dialog.stage;
			
			rect.x = Math.round((stage.stageWidth - rect.width) / 2);
			rect.y = Math.round((stage.stageHeight - rect.height) / 2);
			
			dialog.x = rect.x;
			dialog.y = rect.y;
		}
		
		public function removeDialogByClass(value:Class):void
		{
			var dialogClass:String = flash.utils.getQualifiedClassName(value);
			if(dialogMap[dialogClass] != null) {
				removeDialog(dialogMap[dialogClass] as FDialog);
			}
		}
		
		public function removeDialog(dialog:FDialog, now:Boolean = false):void
		{
			var dialogClass:String = flash.utils.getQualifiedClassName(dialog);
			delete dialogMap[dialogClass];
			
			if(now) {
				dialogHideHandler(dialog);
			}else {
				dialog.hide();
			}
		}
		
		protected var modalMask:FDisplayObject;
		
		protected function dialogShowHandler(event:DialogEvent):void
		{
			var stage:Stage = event.target.stage as Stage;
			var parent:DisplayObjectContainer = event.target.parent as DisplayObjectContainer;
			
			parent.addChildAt(modalMask, parent.getChildIndex(event.target as DisplayObject));
		}
		
		protected function dialogHideHandler(value:* = null):void
		{
			var dialog:FDialog = null;
			if(value is Event) {
				dialog = value.target as FDialog;
			}
			if(value is FDialog) {
				dialog = value as FDialog;
			}
			
			dialog.removeEventListener(DialogEvent.SHOW, dialogShowHandler);
			dialog.removeEventListener(DialogEvent.HIDE, dialogHideHandler);
			
			try {
				dialog.parent.removeChild(dialog);
			}catch(err:Error) {
				
			}
			
			if(modalMask && modalMask.parent) {
				modalMask.parent.removeChild(modalMask);
			}
		}
	}
}