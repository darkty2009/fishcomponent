package fish.component
{
	import fish.action.ButtonAction;
	import fish.action.IActive;
	import fish.core.AbstractComponent;
	
	import flash.utils.Dictionary;
	
	[State(name="normal", skin="fish.skins.button.ButtonNormalSkin")]
	[State(name="over", skin="fish.skins.button.ButtonOverSkin")]
	[State(name="down", skin="fish.skins.button.ButtonDownSkin")]
	
	public class Button extends AbstractComponent implements IActive
	{
		protected var _actions:Dictionary = new Dictionary();
		protected var _label:Label;
		
		public function Button()
		{
			super();
			
			width = 82;
			height = 22;
			
			_label = new Label();
			_label.x = _label.y = 0;
			
			actions[fish.action.ButtonAction] = new ButtonAction(this);
			
			_foreground.addChild(_label);
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