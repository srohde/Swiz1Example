package com.soenkerohde.example.model.presentation
{
	import mx.collections.ArrayCollection;
	import mx.collections.IList;

	public class AppPresentationModel implements IAppPresentationModel
	{

		[Bindable]
		[Inject(source="appModel.appState", twoWay="true")]
		public var appState:String;

		public function AppPresentationModel()
		{
		}

	}
}