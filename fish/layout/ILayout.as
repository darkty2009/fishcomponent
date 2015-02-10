package fish.layout
{
	public interface ILayout
	{
		function get top():Number;
		function get bottom():Number;
		function get left():Number;
		function get right():Number;
		function get gap():Number;
		
		function measure():void;
	}
}