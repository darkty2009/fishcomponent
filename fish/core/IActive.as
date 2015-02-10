package fish.core
{
	import flash.utils.Dictionary;

	public interface IActive
	{
		function get actions():Dictionary;
		function registAction(action:Class):void;
	}
}