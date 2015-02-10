package fish.component
{
	import fish.action.Action;
	import fish.action.ButtonAction;
	import fish.core.IActive;
	import fish.display.FMovieClip;
	import fish.display.FTextField;
	import fish.util.UniqueUtil;
	
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Dictionary;
	
	public class FButton extends FMovieClip
	{	
		public function FButton(value:*=null, isAdd:Boolean = true)
		{
			super(value, isAdd);
			
			name = "FButton"+fish.util.UniqueUtil.getUnique();
		}
		
		/**
		 * Override
		 */
		override public function create(event:Event=null):void
		{
			super.create(event);
			
			actions[fish.action.ButtonAction] = new ButtonAction(this).regist();
			
			if(_text != "" && label != null) {
				createLabel();
			}
		}
		
		protected function createLabel():void
		{
			label.x = Math.round((this.width - label.textWidth) / 2);
			label.y = Math.round((this.height - label.textHeight) / 2);
			addChild(label);
		}
		
		override public function destroy(event:Event=null):void
		{
			if(label != null) {
				removeChild(label);
			}
			
			super.destroy();
		}
				
		/**
		 * Self Property
		 */
		protected var _label:FTextField;
		
		public function get label():FTextField
		{
			return _label;
		}
		
		public function set label(value:FTextField):void
		{
			_label = value;
		}
		
		protected var _text:String;
		
		public function set text(value:String):void
		{
			if(label == null) {
				label = new FTextField(value, true);
				label.autoSize = flash.text.TextFieldAutoSize.LEFT;
				if(this.created) {
					createLabel();
				}
			}else {
				label.text = value;
			}
			
			_text = value;
		}
	}
}