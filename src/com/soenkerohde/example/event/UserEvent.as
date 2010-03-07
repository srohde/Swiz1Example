package com.soenkerohde.example.event
{
	import com.soenkerohde.example.model.domain.User;

	import flash.events.Event;

	public class UserEvent extends Event
	{

		public static const LOGIN:String = "UserEvent.LOGIN";
		public static const LOGOUT:String = "UserEvent.LOGOUT";

		private var _user:User;

		public function get user():User
		{
			return _user;
		}

		public function UserEvent(type:String, user:User, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
			_user = user;
		}

		override public function clone():Event
		{
			return new UserEvent(type, user, bubbles, cancelable);
		}
	}
}