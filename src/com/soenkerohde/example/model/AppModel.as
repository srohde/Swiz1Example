package com.soenkerohde.example.model
{
	import com.soenkerohde.example.model.domain.User;

	import mx.collections.IList;

	public class AppModel
	{

		[Bindable]
		public var appState:String = "login";

		[Bindable]
		public var user:User;

		[Bindable]
		public var users:IList;

		public function AppModel()
		{
		}
	}
}