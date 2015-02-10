package fish.container.dialogClasses
{
	import fish.component.FButton;
	import fish.container.FContainer;
	
	public class FDialogContent extends FContainer
	{
		public function FDialogContent(value:*=null, isAdd:Boolean=true)
		{
			super(value, isAdd);
			
			if(_target["close"])
				closeButton = new FButton(_target["close"], false);
			if(_target["submit"])
				submitButton = new FButton(_target["submit"], false);
			if(_target["cancel"])
				cancelButton = new FButton(_target["cancel"], false);
		}
		
		public var closeButton:FButton;
		public var submitButton:FButton;
		public var cancelButton:FButton;
	}
}