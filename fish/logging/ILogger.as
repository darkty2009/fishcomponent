package fish.logging
{
	public interface ILogger
	{
		function set target(value:ILogTarget):void;
		function get target():ILogTarget;
		function debug(level:uint, message:*, ...params):void;
	}
}