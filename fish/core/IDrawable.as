package fish.core
{
	public interface IDrawable
	{
		function set level(value:uint):void;
		function get level():uint;
		
		function redraw():void;
	}
}