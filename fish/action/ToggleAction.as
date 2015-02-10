package fish.action
{
	import fish.display.FMovieClip;
	
	import flash.display.MovieClip;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	public class ToggleAction extends Action implements IAction
	{
		protected var name:String;
		protected var isSingle:Boolean;
		
		public function ToggleAction(target:IEventDispatcher=null, name:String = "fishcomponent_default", isSingle:Boolean = true)
		{
			super(target);
			
			this.name = name;
			this.isSingle = isSingle;
		}
		
		override public function regist():IAction
		{
			addEvent();
			
			try {
				target["target"].buttonMode = true;
				target["target"].mouseEnable = true;
			}catch(e:Error) {}
			
			FMovieClip(target).gotoAndStop("normal");
			
			addToggleToGroup(target, name, isSingle);
			
			return this;
		}
		
		override public function unregist():IAction
		{
			removeEvent();
			
			try {
				target["target"].buttonMode = false;
				target["target"].mouseEnable = false;
			}catch(e:Error) {}
			
			removeToggle(target, name);
			
			return this;
		}
		
		protected function addEvent():void
		{
			target["target"].addEventListener(MouseEvent.CLICK, mouseClickHandler);
		}
		
		protected function removeEvent():void
		{
			target["target"].removeEventListener(MouseEvent.CLICK, mouseClickHandler);
		}
		
		protected function mouseClickHandler(event:MouseEvent):void
		{
			if(validate(target, name)) {
				if(FMovieClip(target).currentFrameLabel == "normal") {
					FMovieClip(target).gotoAndStop("selected");
				}else {
					FMovieClip(target).gotoAndStop("normal");
				}
			}else {
				event.stopImmediatePropagation();
			}
		}
		
		protected static var group:Dictionary = new Dictionary();
		protected static var nameProperties:Dictionary = new Dictionary();
		
		public static function addToggleToGroup(toggle:*, name:String = "fishcomponent_default", isSingle:Boolean = true):void
		{
			if(group[name] == null) {
				group[name] = [];
			}
			if(nameProperties[name] == null) {
				nameProperties[name] = isSingle;
			}
			
			group[name].push(toggle);
			nameProperties[name] = isSingle;
		}
		
		public static function removeToggle(toggle:*, name:String = "fishcomponent_default"):void
		{
			for(var i:Number=0;i<group[name].length;i++) {
				if(group[name][i] === toggle) {
					group[name].splice(i, 1);
					break;
				}
			}
			
			delete nameProperties[name];
		}
		
		public static function validate(toggle:*, name:String = "fishcomponent_default"):Boolean
		{
			var isSelected:Boolean = true;
			if(nameProperties[name]) {
				for(var i:Number=0;i<group[name].length;i++) {
					if(group[name][i] !== toggle && FMovieClip(group[name][i]).currentFrameLabel == "selected") {
						break;
					}
				}
				
				if(i >= group[name].length) {
					isSelected = false;
				}
				
				if(isSelected) {
					FMovieClip(group[name][i]).gotoAndStop("normal");
				}
			}
			
			return isSelected;
		}
	}
}