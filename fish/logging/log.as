package fish.logging
{
	public function log(level:uint, message:* = null, ...params):void
	{
		Logger.getInstance().debug(level, message?message:"", params);
	}
}