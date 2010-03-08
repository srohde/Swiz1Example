package com.soenkerohde.example.ctrl
{
	import com.soenkerohde.example.business.IUserDelegate;
	import com.soenkerohde.example.event.UserCRUDEvent;

	import mx.logging.ILogger;
	import mx.logging.Log;

	public class UserController
	{

		private static const LOG:ILogger = Log.getLogger("UserController");

		[Inject]
		public var delegate:IUserDelegate;

		public function UserController()
		{
		}

		[Mediate(event="UserCRUDEvent.*")]
		public function handleCRUDEvent(event:UserCRUDEvent):void
		{
			LOG.info("handleCRUDEvent " + event.type + " user: " + event.user);

			switch (event.type)
			{
				case UserCRUDEvent.CREATE:
					// TODO implement CREATE
					break;
				case UserCRUDEvent.READ:
					// TODO implement READ
					break;
				case UserCRUDEvent.UPDATE:
					// TODO implement UPDATE
					break;
				case UserCRUDEvent.DELETE:
					// TODO implement DELETE
					break;
				default:
					throw new Error("Unknown event type " + event.type);
			}

		}
	}
}