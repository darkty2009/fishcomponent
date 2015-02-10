package fish.container
{
	import fish.layout.HorizonalLayout;
	import fish.layout.VerticalAlign;

	public class HorizonalGroup extends Container
	{
		public function HorizonalGroup()
		{
			super();
			
			_layout = new HorizonalLayout(this);
			(_layout as HorizonalLayout).verticalAlign = fish.layout.VerticalAlign.MIDDLE;
		}
	}
}