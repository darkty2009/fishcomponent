package fish.logging
{
	public class Logger implements ILogger
	{
		public static const ERROR:uint = 2;
		public static const WARNING:uint = 1;
		public static const TRACE:uint = 0;
		
		private static var _instance:ILogger;
		
		public static function getInstance():ILogger
		{
			if(_instance == null)
				_instance = new Logger;
			
			return _instance;
		}
		
		private var _target:ILogTarget;
		
		public function Logger()
		{
			super();
			
			target = new TraceTarget();
		}
		
		public function set target(value:ILogTarget):void
		{
			_target = value;
		}
		
		public function get target():ILogTarget
		{
			return _target;
		}
		
		public function debug(level:uint, message:*, ...params):void
		{
			var type:String = "";
			switch(level) {
				case ERROR:type = "ERROR";break;
				case WARNING:type = "WARNING";break;
				case TRACE:type = "TRACE";break;
				default:type = "TRACE";
			}
			var print_message:Array = [type, message.toString()].concat(params);
			target.log(print_message.join(" "));
		}
	}
}