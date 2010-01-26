package com.soenkerohde.example.ctrl
{
	import com.soenkerohde.example.event.TestEvent;
	import com.soenkerohde.example.model.AppModel;

	public class AppController
	{

		[Autowire]
		public var model:AppModel;

		public function AppController()
		{
			trace("new AppController");
		}

		[Mediate(event="TestEvent.TEST", properties="value")]
		public function testHandler(value:String):void
		{
			model.foo = value;
		}

		[Mediate(event="TestEvent.TEST")]
		public function testHandlerEvent(event:TestEvent):void
		{
			trace("testHandlerEvent " + event.value);
		}
	}
}