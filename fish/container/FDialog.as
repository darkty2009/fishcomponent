package fish.container
{
	import aze.motion.eaze;
	
	import fish.container.dialogClasses.FDialogContent;
	import fish.display.FDisplayObject;
	import fish.display.FSprite;
	import fish.events.DialogEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class FDialog extends FContainer
	{
		public function FDialog(value:FDialogContent=null, isModal:Boolean = true, autoShow:Boolean = true)
		{
			super(value, true);
			
			this.autoShow = autoShow;
			this.isModal = isModal;
			this.visible = false;
			this.alpha = 0;
		}
		
		protected var autoShow:Boolean;
		protected var isModal:Boolean;
		
		public var content:FDialogContent;
		
		override public function create(event:Event=null):void
		{
			if(background == null && _target == null) {
				background = new FSprite();
				with(background.graphics) {
					beginFill(0x787878, 0.7);
					drawRect(0, 0, width, height);
					endFill();
				}
			}
			
			super.create();
			
			content = _target as FDialogContent;
			if(content) {
				if(content.closeButton) {
					content.closeButton.target.addEventListener(MouseEvent.CLICK, closeHandler);
				}
				if(content.submitButton) {
					content.submitButton.target.addEventListener(MouseEvent.CLICK, submitHandler);
				}
				if(content.cancelButton) {
					content.cancelButton.target.addEventListener(MouseEvent.CLICK, cancelHandler);
				}
			}
		}
		
		public function show():void
		{
			var temp:Point = new Point(this.x, this.y);
			this.x = temp.x;
			this.y = -1 * this.height;
			this.visible = true;
			this.alpha = 1;
			
			aze.motion.eaze(this).to(0.3, {y:temp.y}).onComplete(showComplete);
		}
		
		protected function showComplete():void
		{
			this.dispatchEvent(new DialogEvent(DialogEvent.SHOW));
		}
		
		public function hide():void
		{
			var h:Number = this.height;
			aze.motion.eaze(this).to(0.3, {y:-1 * h}).onComplete(hideComplete);
		}
		
		protected function hideComplete():void
		{
			this.visible = false;
			this.alpha = 0;
			this.dispatchEvent(new DialogEvent(DialogEvent.HIDE));
		}
		
		protected function closeHandler(event:MouseEvent):void
		{
			this.dispatchEvent(new DialogEvent(DialogEvent.CLOSE));
		}
		
		protected function submitHandler(event:MouseEvent):void
		{
			this.dispatchEvent(new DialogEvent(DialogEvent.SUBMIT));
		}
		
		protected function cancelHandler(event:MouseEvent):void
		{
			this.dispatchEvent(new DialogEvent(DialogEvent.CANCEL));
		}
		
		protected var _dragEnable:Boolean;
		
		public function get dragEnable():Boolean
		{
			return _dragEnable;
		}
		
		public function set dragEnable(value:Boolean):void
		{
			if(_dragEnable == value) {
				return;
			}
			
			_dragEnable = value;
			if(_dragEnable) {
				
			}else {
				
			}
		}
	}
}