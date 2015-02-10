package fish.container
{
	import fish.layout.HorizonalAlign;
	import fish.layout.VerticalLayout;
	
	public class VerticalGroup extends Container
	{
		public function VerticalGroup()
		{
			super();
			
			_layout = new VerticalLayout(this);
			(_layout as VerticalLayout).horizonalAlign = fish.layout.HorizonalAlign.CENTER;
		}
	}
}