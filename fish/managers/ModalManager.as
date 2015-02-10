package fish.managers
{
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;

	public class ModalManager
	{
		protected static var instance:ModalManager;
		
		public static function getInstance():ModalManager
		{
			if(instance == null)
				instance = new ModalManager();
			
			return instance;
		}
		
		public static function registRoot(root:DisplayObjectContainer):void
		{
			getInstance().regist(root);
		}
		
		public static function show():void
		{
			getInstance().show();
		}
		
		public static function hide():void
		{
			getInstance().hide();
		}
		
		protected var root:DisplayObjectContainer;
		protected var modal:Quad;
		
		
		protected function regist(value:DisplayObjectContainer):void
		{
			this.root = value;
		}
		
		protected function show():void
		{
			if(modal == null)
				create();
			
			if(!modal.visible) {
				root.setChildIndex(modal, root.numChildren - 2);
				modal.visible = true;
			}
		}
		
		protected function hide():void
		{
			modal && (modal.visible = false);
		}
		
		private function create():void
		{
			modal = new Quad(root.width, root.height, 0x333333);
			modal.alpha = 0.9;
			modal.visible = false;
			root.addChildAt(modal, root.numChildren - 2);
		}
	}
}