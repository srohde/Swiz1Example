package com.soenkerohde.example.model.presentation
{
	import mx.collections.ArrayCollection;
	import mx.collections.IList;

	public class AppPresentationModel implements IAppPresentationModel
	{

		[Bindable]
		[Inject(source="appModel.appState", twoWay="true")]
		public var appState:String;

		[Bindable]
		[Inject(source="appModel.appIndex", twoWay="true")]
		public var appIndex:int;

		[Bindable]
		public var navigation:IList = new ArrayCollection(["login", "chart", "command", "module"]);

		public function AppPresentationModel()
		{
		}

		public function changeAppIndex(index:int):void
		{
			appIndex = index;
			switch( index )
			{
				case 0:
					appState = "login";
					break;
				case 1:
					appState = "chart";
					break;
				case 2:
					appState = "command";
					break;
				case 3:
					appState = "module";
					break;
				default:
					throw new Error("Unknown index " + index);
			}
		}
	}
}