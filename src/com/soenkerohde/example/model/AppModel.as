package com.soenkerohde.example.model
{
	import mx.collections.ArrayCollection;

	public class AppModel
	{

		[Bindable]
		public var foo:String = "Hello";

		[Bindable]
		[Outject(name="myList")]
		public var myList:ArrayCollection = new ArrayCollection(["Foo", "Bar"]);

		public function AppModel()
		{
			trace("new AppModel");
		}
	}
}