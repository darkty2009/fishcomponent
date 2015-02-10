package fish.component
{
	import fish.core.IComponent;
	import fish.core.IDrawable;
	
	public interface ITip
	{
		function show(data:Object = null):void;
		function hide():void;
		function moveTo(x:Number, y:Number):void;
		function set width(value:Number):void;
		function get width():Number;
		function set height(value:Number):void;
		function get height():Number;
		function set x(value:Number):void;
		function get x():Number;
		function set y(value:Number):void;
		function get y():Number;
		function get name():String;
	}
}