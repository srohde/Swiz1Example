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
		[Inject(source="appModel.mainState", twoWay="true")]
		public var mainState:String;

		[Bindable]
		[Inject(source="appModel.mainIndex", twoWay="true")]
		public var mainIndex:int;

		[Bindable]
		public var navigation:IList = new ArrayCollection(["chart", "user", "module"]);

		public function AppPresentationModel()
		{
		}

		public function changeMainIndex(index:int):void
		{
			mainIndex = index;
			switch (index)
			{
				case 0:
					mainState = "chart";
					break;
				case 1:
					mainState = "user";
					break;
				case 2:
					mainState = "module";
					break;
				default:
					throw new Error("Unknown index " + index);
			}
		}
	}
}