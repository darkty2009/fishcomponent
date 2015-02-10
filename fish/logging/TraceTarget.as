package fish.logging
{
	public class TraceTarget implements ILogTarget
	{
		public function TraceTarget()
		{
			super();
		}
		
		public function log(value:*):void
		{
			trace(value);
		}
	}
}