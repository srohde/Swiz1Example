package com.soenkerohde.example.ctrl
{
	import com.soenkerohde.example.business.IUserDelegate;
	import com.soenkerohde.example.model.AppModel;
	import com.soenkerohde.example.model.domain.User;

	import flash.events.IEventDispatcher;

	import mx.collections.IList;
	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;

	import org.swizframework.core.IDispatcherAware;
	import org.swizframework.utils.services.ServiceRequestUtil;

	public class AppController implements IDispatcherAware
	{
		private static const LOG:ILogger = Log.getLogger("AppController");

		[Inject]
		public var model:AppModel;

		[Inject]
		public var delegate:IUserDelegate;

		[Inject]
		public var serviceRequestUtil:ServiceRequestUtil;

		private var _dispatcher:IEventDispatcher;

		/**
		 * IDispatcherAware implementation. Will be automatically set from Swiz.
		 * Use this dispatcher instance to dispatch events Swiz should handle
		 *
		 * @param dispatcher Swiz dispacther.
		 *
		 */
		public function set dispatcher(dispatcher:IEventDispatcher):void
		{
			_dispatcher = dispatcher;
		}

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
		}

		[Mediate(event="UserEvent.LOGIN", properties="user")]
		public function loginHandler(user:User):void
		{
			model.setUser(user);

			var token:AsyncToken = delegate.loadUsers();
			serviceRequestUtil.executeServiceCall(token, usersResultHandler);
		}

		[Mediate(event="UserEvent.LOGOUT", properties="user")]
		public function logout(user:User):void
		{
			LOG.info("logging out " + user);
			model.setUser(null);
		}

		protected function usersResultHandler(event:ResultEvent):void
		{
			model.users = event.result as IList;
		}

	}
}