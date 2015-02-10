package fish.container.tabClasses
{
	import fish.container.FContainer;

	public class FStack extends FContainer
	{
		public function FStack(value:*=null, title:String = "", isAdd:Boolean=true)
		{
			super(value, isAdd);
			
			this.title = title;
		}
		
		public var title:String;
	}
}