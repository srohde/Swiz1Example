package com.soenkerohde.example.event
{
	import flash.events.Event;

	public class LoginEvent extends Event
	{

		public static const LOGIN:String = "LOGIN";

		private var _username:String
		private var _password:String;

		public function get username():String
		{
			return _username;
		}

		public function get password():String
		{
			return _password;
		}

		public function LoginEvent(type:String, username:String, password:String, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super(type, bubbles, cancelable);
			_username = username;
			_password = password;
		}

		override public function clone():Event
		{
			return new LoginEvent(type, username, password, bubbles, cancelable);
		}
	}
}