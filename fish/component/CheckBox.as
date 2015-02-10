package fish.component
{
	[State(name="normal", skin="fish.skins.button.ButtonNormalSkin")]
	[State(name="over", skin="fish.skins.button.ButtonOverSkin")]
	[State(name="down", skin="fish.skins.button.ButtonDownSkin")]
	
	public class CheckBox extends Button
	{
		public function CheckBox()
		{
			super();
		}
	}
}