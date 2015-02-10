package fish.component
{
	import fish.action.ToggleAction;
	import fish.display.FMovieClip;
	import fish.display.FTextField;
	
	import flash.events.Event;
	
	public class FToggleButton extends FMovieClip
	{
		public function FToggleButton(value:*=null, groupName:String = "fishcomponent_default", isSingle:Boolean = true, isAdd:Boolean=true)
		{
			super(value, isAdd);
			
			this.groupName = groupName;
			this.isSingle = isSingle;
		}
		
		protected var groupName:String;
		protected var isSingle:Boolean;
		
		/**
		 * Override
		 */
		override public function create(event:Event=null):void
		{
			super.create(event);
			
			actions[fish.action.ToggleAction] = new ToggleAction(this, groupName, isSingle).regist();
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
	}
}