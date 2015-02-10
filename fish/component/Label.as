package fish.component
{
	import fish.core.AbstractComponent;
	import fish.logging.log;
	import fish.utils.TextFormatFactory;
	
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class Label extends AbstractComponent
	{
		protected var _textField:TextField = new TextField();
		protected var _text:String;
		protected var _align:String;
		
		public function Label()
		{
			super();
			
			width = 82;
			height = 22;

			defaultTextFormat();
			_textField.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			_textField.mouseEnabled = false;
			_textField.x = _textField.y = 0;
			_textField.autoSize = flash.text.TextFieldAutoSize.LEFT;
			
			_foreground.addChild(_textField);
		}
		
		override protected function updateBasic():void
		{
			super.updateBasic();
			
			fish.logging.log(0, "rectangle", width, height, x, y);
			_textField.text = _text;
			
			_textField.width = width;
			_textField.height = height;
			
			switch(align) {
				case "right":{
					_textField.x = width - _textField.textWidth;
				};break;
				case "center":{
					_textField.x = (width - _textField.textWidth) / 2;
				};break;
				case "left":{
					
				};break;
			}
			
			_textField.y = (height - _textField.textHeight) / 2 - height / Number(_textField.getTextFormat().size);
		}
		
		[Property(default="Button", level="basicProperties")]
		[Bindable]
		public function set text(value:String):void
		{
			_text = value;
		}
		
		public function get text():String
		{
			return _text;
		}
		
		public function set textField(value:TextField):void
		{
			_textField = value;
			defaultTextFormat();
		}
		
		public function get textField():TextField
		{
			return _textField;
		}
		
		protected function defaultTextFormat():void
		{
			if(_textField == null)
				return;
			
			_textField.setTextFormat(fish.utils.TextFormatFactory.create({
				"size":12,
				"color":0x555555,
				"align":"left"
			}));
		}
		
		[Property(default="center", level="basicProperties")]
		[Bindable]
		public function set align(value:String):void
		{
			if(value == "0")
				value = "center";
			_align = value;
		}
		
		public function get align():String
		{
			return _align;
		}
	}
}