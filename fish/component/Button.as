package fish.component
{
	import fish.action.ButtonAction;
	import fish.action.IActive;
	import fish.core.AbstractComponent;
	
	import flash.utils.Dictionary;
	
	import starling.utils.HAlign;
	
	[State(name="normal", skin="fish.skins.button.ButtonNormalSkin")]
	[State(name="over", skin="fish.skins.button.ButtonOverSkin")]
	[State(name="down", skin="fish.skins.button.ButtonDownSkin")]
	
	public class Button extends AbstractComponent implements IActive
	{
		protected var _actions:Dictionary = new Dictionary();
		protected var _label:Label;
		
		public function Button(width:Number = 82, height:Number = 22)
		{
			super();
			
			this.width = width;
			this.height = height;
			
			_label = new Label();
			_label.align = starling.utils.HAlign.LEFT;
			
			actions[fish.action.ButtonAction] = new ButtonAction(this);
			
			_foreground.addChild(_label);
		}
		
		override protected function updateBasic():void
		{
			super.updateBasic();
			
			super.measure();
			
			_label.x = (width - _label.width) / 2;
			_label.y = (height - _label.height) /2;
		}
		
		public function set label(value:Label):void
		{
			_label = value;
		}
		
		public function get label():Label
		{
			return _label;
		}
		
		public function get actions():Dictionary
		{
			return _actions;
		}
	}
}