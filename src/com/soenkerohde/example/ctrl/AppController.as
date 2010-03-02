package com.soenkerohde.example.ctrl
{
	import com.soenkerohde.example.event.TestEvent;
	import com.soenkerohde.example.model.AppModel;
	import com.soenkerohde.example.signal.TestSignal;

	public class AppController
	{

		[Autowire]
		public var model:AppModel;

		public function AppController()
		{
			trace("new AppController");
		}

		[PostConstruct]
		public function init():void
		{
			trace("init");
		}

		[Mediate(event="TestEvent.TEST", properties="value", priority="1")]
		public function testHandler(value:String):void
		{
			trace("testHandler " + value);
			model.foo = value;
		}

		[Mediate(event="TestEvent.TEST")]
		public function testHandlerEvent(event:TestEvent):void
		{
			trace("testHandlerEvent " + event.value);
		}

		[Mediate(event="TestEvent.TEST", priority="2")]
		public function testEmptyHandlerEvent():void
		{
			trace("testEmptyHandlerEvent");
		}

		[MediateSignal(type="TestSignal")]
		public function handleTestSignal2(message:String):void
		{
			trace("handleTestSignal " + message);
		}
	}
}