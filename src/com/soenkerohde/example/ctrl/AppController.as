package com.soenkerohde.example.ctrl
{
	import com.soenkerohde.example.model.AppModel;

	import mx.logging.ILogger;
	import mx.logging.Log;

	public class AppController
	{
		private static const LOG:ILogger = Log.getLogger("AppController");

		[Inject]
		public var model:AppModel;


		public function AppController()
		{
			// Note that now Injection has not happened yet like meaning all
			// members marked with Inject are still null
		}

		[PostConstruct]
		public function init():void
		{
			LOG.info("PostConstruct. Injection done like e.g. model " + model);
		}

		[MediateSignal(type="TestSignal")]
		public function handleTestSignal2(message:String):void
		{
			trace("handleTestSignal " + message);
		}
	}
}