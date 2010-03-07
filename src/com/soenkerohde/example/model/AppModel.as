package com.soenkerohde.example.model
{
	import com.soenkerohde.example.model.domain.User;

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
		public var user:User;

		[Bindable]
		public var users:IList;

		public function AppModel()
		{
		}

		public function setUser(user:User):void
		{
			this.user = user;
			appState = user != null ? "main" : "login";
		}

	}
}