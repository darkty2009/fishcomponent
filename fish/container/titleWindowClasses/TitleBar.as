package fish.container.titleWindowClasses
{
	import fish.component.Button;
	import fish.component.Image;
	import fish.component.Label;
	import fish.container.Container;
	
	import flash.geom.Rectangle;
	
	import starling.events.Event;
	import starling.events.PropertyChangeEvent;
	
	public class TitleBar extends Container
	{
		protected var _icon:Image;
		protected var _label:Label;
		protected var _close:Button;
		protected var _title:String;
		
		protected static var H_PADDING:Number = 4;
		protected static var V_PADDING:Number = 3;
		
		public function TitleBar()
		{
			super();
			
			_label = new Label(name, width, 30);
			_close = new Button(20, 20);
			_close.label.text = "X";
			_close.label.autosize = true;
		}
		
		override public function added(event:Event=null):void
		{
			super.added(event);
			
			if(!checkEventTarget(event))
				return;
			
			_foreground.addChild(_label);
			_foreground.addChild(_close);
		}
		
		override protected function updateBasic():void
		{
			super.updateBasic();
			
			var bound:Rectangle = this.parent.bounds;
			
			width = bound.width;
			
			_label.text = title;
			_label.width = width;
			_label.x = H_PADDING;
			_label.y = (height - _label.height) / 2;
			_close.x = bound.width - _close.width - H_PADDING;
			_close.y = (height - _close.height) / 2;
		}

		public function get icon():Image
		{
			return _icon;
		}

		public function set icon(value:Image):void
		{
			_icon = value;
		}

		public function get label():Label
		{
			return _label;
		}

		public function set label(value:Label):void
		{
			_label = value;
		}

		public function get close():Button
		{
			return _close;
		}

		public function set close(value:Button):void
		{
			_close = value;
		}

		public function get title():String
		{
			return _title;
		}
		
		[Property(default="title", level="basicProperties")]
		public function set title(value:String):void
		{
			dispatchEvent(starling.events.PropertyChangeEvent.createUpdateEvent(this, "title", _title, value));
			_title = value;
		}


	}
}