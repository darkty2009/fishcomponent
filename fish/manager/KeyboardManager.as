package fish.manager
{
	import fish.util.KeyCode;
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;

	public class KeyboardManager
	{
		private static var instance:KeyboardManager;
		
		private static function getInstance():KeyboardManager
		{
			if(instance == null)
				instance = new KeyboardManager();
			
			return instance;
		}
		
		public static function registStage(stage:Stage):void
		{
			getInstance().registStage(stage);
		}
		
		public static function addMonitor(key:String, handler:Function):void
		{
			getInstance().addMonitor(key, handler);
		}
		
		public static function removeMonitor(key:String):void
		{
			getInstance().removeMonitor(key);
		}
		
		private var stage:Stage;
		private var monitor:Dictionary = new Dictionary();
		private var stats:Dictionary = new Dictionary();
		private var count:Number = 0;
		
		public function registStage(stage:Stage):void
		{
			this.stage = stage;
		}
		
		public function addMonitor(key:String, handler:Function):void
		{
			if(stage == null) {
				throw new Error("Please initialize stage before use.");
			}
			
			if(!stage.hasEventListener(KeyboardEvent.KEY_DOWN)) {
				stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			}
			if(!stage.hasEventListener(KeyboardEvent.KEY_UP)) {
				stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			}
			
			if(monitor[key.toUpperCase()] == null) {
				count++;
			}
			monitor[key.toUpperCase()] = handler;
		}
		
		public function removeMonitor(key:String):void
		{
			if(monitor[key] != null) {
				monitor[key] = null;
				delete monitor[key];
				count--;
			}
			
			if(count <= 0) {
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
				stage.removeEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			}
		}
		
		private function keyDownHandler(event:KeyboardEvent):void
		{
			var key:String = fish.util.KeyCode.getCodeChar(event.keyCode);
			if(stats[key] == null) {
				stats[key] = {
					up:false,
					down:false
				}
			}
			
			stats[key].down = true;
			stats[key].up = false;
			
			if(monitor[key] != null) {
				monitor[key](key);
			}
		}
		
		private function keyUpHandler(event:KeyboardEvent):void
		{
			var key:String = fish.util.KeyCode.getCodeChar(event.keyCode);
			if(stats[key] == null) {
				stats[key] = {
					up:false,
					down:false
				};
			}
			stats[key].down = false;
			stats[key].up = true;
		}
	}
}