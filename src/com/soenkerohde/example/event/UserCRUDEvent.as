package com.soenkerohde.example.event
{
	import com.soenkerohde.example.model.domain.User;

	import flash.events.Event;

	public class UserCRUDEvent extends Event
	{

		public static const CREATE:String = "create";
		public static const READ:String = "read";
		public static const UPDATE:String = "update";
		public static const DELETE:String = "delete";

		private var _user:User;

		public function get user():User
		{
			return _user;
		}

		public function UserCRUDEvent(type:String, user:User, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_user = user;
		}

		override public function clone():Event
		{
			return new UserCRUDEvent(type, user, bubbles, cancelable);
		}
	}
}