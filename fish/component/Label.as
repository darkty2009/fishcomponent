package fish.component
{
	import fish.core.AbstractComponent;
	import fish.logging.log;
	import fish.utils.Font;
	
	import flash.geom.Rectangle;
	
	import starling.events.PropertyChangeEvent;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class Label extends AbstractComponent
	{
		protected var _textfield:TextField;
		protected var _text:String;
		protected var _align:String;
		protected var _font:Font;
		protected var _icon:Image;
		protected var _source:*;
		protected var _autosize:Boolean;
		protected var _iconAlign:String;
		
		public static var H_PADDING:Number = 4;
		public static var V_PADDING:Number = 2;
		
		public function Label(text:String = "", width:Number = 82, height:Number = 22, format:Font = null)
		{
			super();
			
			_text = text;
			
			super.width = width;
			super.height = height;
			
			_font = format ? format : Font.from();
			
			_textfield = new TextField(width, height, _text, _font.fontFamily, _font.fontSize, _font.fontColor, _font.bold);
			_icon = new Image(null, 16, 16);
			_icon.visible = false;
			_foreground.addChild(_icon);
			_foreground.addChild(_textfield);
			
			_background.visible = false;
		}
		
		override public function removeAll(event:*=null):void
		{
			super.removeAll();
			_foreground.removeChild(_textfield);
			_foreground.removeChild(_icon);
		}
		
		override protected function updateBasic():void
		{
			super.updateBasic();
			
			_textfield.hAlign = align == "0" ? "left" : align;
			_textfield.vAlign = starling.utils.VAlign.CENTER;
			_textfield.text = text;
			
			if(_font) {
				_textfield.fontName = _font.fontFamily;
				_textfield.fontSize = _font.fontSize;
				_textfield.color = _font.fontColor;
				_textfield.bold = _font.bold;
			}
			
			var bound:Rectangle = _textfield.textBounds;
			if(autosize) {
				var result:Rectangle = new Rectangle(0, 0);
				result.height = height + V_PADDING * 2;
				result.width = H_PADDING * 3 + bound.width + _icon.width;
				
				super.width = result.width;
				super.height = result.height;
			}
			
			if(_source != null) {
				if(iconAlign == "left" || iconAlign == "0") {
					_icon.x = H_PADDING;
					_textfield.x = _icon.x + _icon.width + H_PADDING;
				}
				if(iconAlign == "right") {
					_textfield.x = H_PADDING;
					_icon.x = _textfield.x + _textfield.width + H_PADDING;
				}
			}
			
			_textfield.y = (height - _textfield.height) / 2;
			_icon.y = (height - _icon.height) / 2;
		}
		
		[Property(default="Button", level="basicProperties")]
		public function set text(value:String):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "text", _text, value));
			_text = value;
		}
		public function get text():String 
		{
			return _text;
		}
		
		[Property(default="left", level="basicProperties")]
		public function set align(value:String):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "align", _align, value));
			_align = value;
		}
		public function get align():String
		{
			return _align;
		}
		
		public function set font(value:Font):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "font", _font, value));
			_font = font;
		}
		public function get font():Font
		{
			return _font;
		}
		
		[Property(default="false", level="basicProperties")]
		public function set autosize(value:Boolean):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "autosize", _autosize, value));
			_autosize = value;
		}
		
		public function get autosize():Boolean
		{
			return _autosize;
		}
		
		[Property(default="left", level="basicProperties")]
		public function set iconAlign(value:String):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iconAlign", _iconAlign, value));
			_iconAlign = value;
		}
		
		public function get iconAlign():String
		{
			return _iconAlign;
		}

		public function get source():*
		{
			return _source;
		}

		public function set source(value:*):void
		{
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "source", _source, value));
			
			_source = value;
			
			_icon.fromObject(_source);
			_icon.visible = (value != null);
			_textfield.hAlign = (value != null) ? starling.utils.HAlign.LEFT : starling.utils.HAlign.CENTER;
		}

	}
}