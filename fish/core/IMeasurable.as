package fish.core
{
	public interface IMeasurable
	{
		function set width(value:Number):void;
		function get width():Number;
		
		function set minWidth(value:Number):void;
		function get minWidth():Number;
		
		function set maxWidth(value:Number):void;
		function get maxWidth():Number;
		
		function set minHeight(value:Number):void;
		function get minHeight():Number;
		
		function set maxHeight(value:Number):void;
		function get maxHeight():Number;
		
		function set percentWidth(value:Number):void;
		function get percentWidth():Number;
		
		function set percentHeight(value:Number):void;
		function get percentHeight():Number;
		
		function setSize(widthValue:Number, heightValue:Number):void;
	}
}