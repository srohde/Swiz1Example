package com.soenkerohde.example.event
{
	import flash.events.Event;

	public class CRUDEvent extends Event
	{

		public static const CREATE:String = "create";
		public static const READ:String = "read";
		public static const UPDATE:String = "update";
		public static const DELETE:String = "delete";

		public function CRUDEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		override public function clone():Event
		{
			return new CRUDEvent(type, bubbles, cancelable);
		}
	}
}