package fish.container
{
	import fish.core.AbstractComponent;
	import fish.layout.ILayout;
	import fish.layout.Layout;
	
	public class Container extends AbstractComponent
	{
		public function Container()
		{
			super();
		}
		
		override public function measure():void
		{
			_layout.measure();
		}
	}
}