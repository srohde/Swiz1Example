package com.soenkerohde.example.model
{

	public class AppModel
	{

		[Bindable]
		public var foo:String = "Hello";

		public function AppModel()
		{
			trace("new AppModel");
		}
	}
}