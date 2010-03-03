package com.soenkerohde.example.ctrl
{
	import com.soenkerohde.example.event.CRUDEvent;

	import mx.logging.ILogger;
	import mx.logging.Log;

	public class CommandController
	{
		private static const LOG:ILogger = Log.getLogger("CommandController");

		public function CommandController()
		{
		}

		[Mediate(event="CRUDEvent.*")]
		public function handleCRUDEvent(event:CRUDEvent):void
		{
			LOG.info("handleCRUDEvent " + event.type);
		}
	}
}