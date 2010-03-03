package com.soenkerohde.example.model.domain
{
	[Bindable]
	[RemoteClass("com.soenkerohde.example.domain.User")]
	public class User
	{

		public var id:Number;
		public var username:String;

		public function User()
		{
		}

		public function toString():String
		{
			return "[User id="+id+" username="+username+"]";
		}
	}
}