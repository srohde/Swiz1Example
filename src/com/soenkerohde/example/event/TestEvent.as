package com.soenkerohde.example.event
{
	import flash.events.Event;

	public class TestEvent extends Event
	{

		public static const TEST:String = "TestEvent.TEST";

		public var value:String;

		public function TestEvent(type:String, value:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.value = value;
		}
	}
}