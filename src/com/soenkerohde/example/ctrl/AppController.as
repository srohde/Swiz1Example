package com.soenkerohde.example.ctrl
{
	import com.soenkerohde.example.business.IUserDelegate;
	import com.soenkerohde.example.model.AppModel;

	import mx.collections.IList;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;

	import org.swizframework.utils.services.ServiceRequestUtil;

	public class AppController
	{
		private static const LOG:ILogger = Log.getLogger("AppController");

		[Inject]
		public var model:AppModel;

		[Inject]
		public var delegate:IUserDelegate;

		[Inject]
		public var serviceRequestUtil:ServiceRequestUtil;

		public function AppController()
		{
			// Note that now Injection has not happened yet like meaning all
			// members marked with Inject are still null
		}

		[PostConstruct]
		public function init():void
		{
			// This could be the starting point of your application when
			// you for instance make an initial service call etc.
			// In that case inject the service delegate and call it here.
			var token:AsyncToken = delegate.loadUsers();
			serviceRequestUtil.executeServiceCall(token, usersResultHandler);
		}

		protected function usersResultHandler(event:ResultEvent):void
		{
			model.users = event.result as IList;
		}

	}
}