package fish.container
{
	import fish.container.titleWindowClasses.TitleBar;
	import fish.managers.ModalManager;
	
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.PropertyChangeEvent;
	
	public class TitleWindow extends Container
	{
		protected var _title:TitleBar;
		
		protected var _titleHeight:Number = 22;
		protected var _titleShow:Boolean = true;
		protected var _closeShow:Boolean = true;
		protected var _titleIcon:* = null;
		protected var _isModule:Boolean = true;
		
		public function TitleWindow()
		{
			super();
			
			_title = new TitleBar();
			_title.title = "TitleWindow";
		}
		
		override public function added(event:Event = null):void
		{
			super.added(event);
			
			if(!checkEventTarget(event))
				return;
			
			if(titleShow) {
				title.height = titleHeight;
				title.close.visible = closeShow;
				title.icon = titleIcon;
				
				_foreground.addChild(title);
			}
			
			if(_isModule) {
				fish.managers.ModalManager.show();
			}else {
				fish.managers.ModalManager.hide();
			}
		}
		
		override protected function updateBasic():void
		{
			super.updateBasic();
			
			if(titleShow) {
				title.visible = true;
				title.height = titleHeight;
				title.close.visible = closeShow;
				title.icon = titleIcon;
			}else {
				title.visible = false;
			}
			
			if(isModule) {
				fish.managers.ModalManager.show();
			}else {
				fish.managers.ModalManager.hide();
			}
		}
		
		override public function removeAll(event:*=null):void
		{
			super.removeAll();
			
			if(isModule) {
				fish.managers.ModalManager.hide();
			}
		}
		
		override public function measure():void
		{
			_layout.measure();
		}
		
		public function get titleHeight():Number
		{
			return _titleHeight;
		}

		public function set titleHeight(value:Number):void
		{
			dispatchEvent(starling.events.PropertyChangeEvent.createUpdateEvent(this, "titleHeight", _titleHeight, value));
			_titleHeight = value;
			_title.height = value;
		}

		public function get titleShow():Boolean
		{
			return _titleShow;
		}

		public function set titleShow(value:Boolean):void
		{
			dispatchEvent(starling.events.PropertyChangeEvent.createUpdateEvent(this, "titleShow", _titleShow, value));
			_titleShow = value;
			_title.visible = value;
			_title.touchable = value;
		}

		public function get closeShow():Boolean
		{
			return _closeShow;
		}

		public function set closeShow(value:Boolean):void
		{
			dispatchEvent(starling.events.PropertyChangeEvent.createUpdateEvent(this, "closeShow", _closeShow, value));
			_closeShow = value;
		}

		public function get titleIcon():*
		{
			return _titleIcon;
		}

		public function set titleIcon(value:*):void
		{
			dispatchEvent(starling.events.PropertyChangeEvent.createUpdateEvent(this, "titleIcon", _titleIcon, value));
			_titleIcon = value;
		}

		public function get title():TitleBar
		{
			return _title;
		}

		public function set title(value:TitleBar):void
		{
			dispatchEvent(starling.events.PropertyChangeEvent.createUpdateEvent(this, "title", _title, value));
			_title = value;
		}

		public function get isModule():Boolean
		{
			return _isModule;
		}

		public function set isModule(value:Boolean):void
		{
			dispatchEvent(starling.events.PropertyChangeEvent.createUpdateEvent(this, "isModule", _isModule, value));
			_isModule = value;
		}

	}
}