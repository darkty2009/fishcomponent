package fish.manager
{
	import fish.component.ITip;
	import fish.core.IComponent;
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	public class TipManager
	{
		protected static var instance:TipManager;
		
		public static function getInstance():TipManager
		{
			if(instance == null) {
				instance = new TipManager();
			}
			
			return instance;
		}
		
		public function TipManager()
		{
			if(instance != null) {
				throw new Error("TipManager had been created");
			}
		}
		
		protected var classPool:Dictionary = new Dictionary();
		protected var targetMap:Dictionary = new Dictionary();
		
		public function regist(target:DisplayObject, name:String, tipClass:Class, delay:Number = 0, d:Object = null):void
		{
			if(target) {
				var data:TipManagerData = new TipManagerData();
				data.name = name;
				data.target = target;
				data.tipClass = tipClass;
				data.delay = delay;
				data.data = d;
				targetMap[target.name] = data;
				
				target.addEventListener(MouseEvent.MOUSE_OVER, rollOverHandler);
				target.addEventListener(MouseEvent.MOUSE_OUT, rollOutHandler);
				target.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				target.addEventListener(MouseEvent.CLICK, rollOutHandler);
			}
		}
		
		public function unregist(target:DisplayObject):void
		{
			if(target) {
				var data:TipManagerData = targetMap[target.name] as TipManagerData;
				hide(data);
				
				target.removeEventListener(MouseEvent.MOUSE_OVER, rollOverHandler);
				target.removeEventListener(MouseEvent.MOUSE_OUT, rollOutHandler);
				target.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				target.removeEventListener(MouseEvent.CLICK, rollOutHandler);
				
				targetMap[target.name] = null;
				delete targetMap[target.name];
			}
		}
		
		protected var isRollOver:Boolean = false;
		protected var isShow:Boolean = true;
		protected var timer:Number = -1;
		
		protected function rollOverHandler(event:MouseEvent):void
		{
			var data:TipManagerData = targetMap[event.currentTarget.name] as TipManagerData;
			
			isRollOver = true;
			
			resetTimer();
			if(data.delay > 0) {
				flash.utils.setTimeout(show.call(this, data), data.delay);
			}else {
				show(data);
			}
		}
		
		protected function rollOutHandler(event:MouseEvent):void
		{
			var data:TipManagerData = targetMap[event.currentTarget.name] as TipManagerData;
			
			isRollOver = false;
			
			resetTimer();
			hide(data);
		}
		
		protected function mouseMoveHandler(event:MouseEvent):void
		{
			// nothing to do
		}
		
		protected var lastTip:ITip;
		
		protected function show(data:TipManagerData):void
		{
			var tip:ITip = getTipInstance(data);
			var stage:Stage = data.target.stage;
			
			if(tip && stage) {
				measure(data, tip);
				if(!stage.contains(tip as DisplayObject)) {
					stage.addChild(tip as DisplayObject);
				}
				tip.show(data.data);
				lastTip = tip;
				
				measure(data, tip);
			}
		}
		
		protected function hide(data:TipManagerData):void
		{
			var stage:Stage = data.target.stage;
			
			if(lastTip && stage) {
				lastTip.hide();
				destroyTipInstance(lastTip, data.name);
				lastTip = null;
			}
		}
		
		protected function measure(data:TipManagerData, tip:ITip):void
		{
			var stage:Stage = data.target.stage;
			var target:DisplayObject = data.target;
			
			if (Math.round(stage.mouseX + 1) + tip.width < stage.stageWidth) {
				tip.x=Math.round(stage.mouseX + 1);
			}else {
				tip.x=Math.round(stage.mouseX - tip.width + 10);
			}
			
			if (Math.round(stage.mouseY + 24) + tip.height < stage.stageHeight) {
				tip.y=Math.round(stage.mouseY + 24);
			}else {
				tip.y=Math.round(stage.mouseY - 2 - tip.height);
			}
			
			if(tip.x < 0) {
				tip.x = 0;
			}
			if((tip.x + tip.width) > stage.stageWidth) {
				tip.x -= (tip.x + tip.width) - stage.stageWidth;
			}
			if(tip.y < 0) {
				tip.y = 0;
			}
			if((tip.y + tip.height) > stage.stageHeight) {
				tip.y -= (tip.y + tip.height) - stage.stageHeight;
			}
		}
		
		protected function getTipInstance(data:TipManagerData):ITip
		{
			if(classPool[data.name] == null) {
				classPool[data.name] = [];
				
				var tipInstance:ITip;
				var clazz:Class = data.tipClass as Class;
				tipInstance = new clazz();
				
				classPool[data.name].push(tipInstance);
			}
			
			return classPool[data.name].pop();
		}
		
		protected function destroyTipInstance(tip:ITip, name:String):void
		{
			classPool[name].push(tip);
		}

		private function resetTimer():void
		{
			if(timer > 0) {
				flash.utils.clearTimeout(timer);
			}
		}
	}
}
import flash.display.DisplayObject;

class TipManagerData {
	public var name:String;
	public var target:DisplayObject;;
	public var tipClass:Class;
	public var delay:Number = 0;
	public var data:Object = null;
}