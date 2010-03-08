package com.soenkerohde.example.model
{
	import mx.collections.IList;

	public class AppModel
	{

		[Bindable]
		[Outject("appState")]
		/**
		 * Application state value.
		 * We use Swiz Outject so the AppView can use
		 * [Inject("appState")]
		 * public var appState:String;
		 */
		public var appState:String = "login";

		[Bindable]
		public var users:IList;

		public function AppModel()
		{
		}

	}
}