package com.soenkerohde.example.model
{
	import com.soenkerohde.example.domain.User;

	public class AppModel
	{

		[Bindable]
		[Outject(name="username")]
		public var user:User;

		public function AppModel()
		{
		}
	}
}