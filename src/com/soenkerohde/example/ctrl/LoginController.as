package com.soenkerohde.example.ctrl
{
	import com.soenkerohde.example.business.ILoginDelegate;
	import com.soenkerohde.example.model.domain.User;
	import com.soenkerohde.example.event.LoginEvent;
	import com.soenkerohde.example.model.AppModel;

	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;

	import org.swizframework.utils.services.ServiceRequestUtil;

	public class LoginController
	{
		private static const LOG:ILogger = Log.getLogger("LoginController");

		[Inject]
		public var model:AppModel;

		/**
		 * The login controller needs the service delegate.
		 * Swiz will inject the LoginDelegate instance by type even if you define the interface.
		 */
		[Inject]
		public var delegate:ILoginDelegate;

		/**
		 * We could create an own instance of ServiceRequestUtil but best practice is to decleare
		 * in BeanProvider so in only gets created once when used multiple times.
		 */
		[Inject]
		public var serviceRequestUtil:ServiceRequestUtil;

		public function LoginController()
		{
		}

		/**
		 * Mediate has higher priority (default is 0) and is called first when event gets dispatched.
		 * When you call stopImmediatePropagation on the event all other event listeners are skipped.
		 * When you call preventDefault on the event the dispatchEvent call returns false.
		 *
		 * @param event
		 */
		[Mediate(event="LoginEvent.LOGIN", priority="1")]
		public function loginEventHandler(event:LoginEvent):void
		{
			if( event.username == "" || event.password == "" )
			{
				event.preventDefault();
				event.stopImmediatePropagation();
			}
		}

		/**
		 * The properties have to match the getters of the event.
		 * You can pass all public properties of an event.
		 *
		 * @param username The name does not have to match the property name
		 * @param password See above
		 *
		 */
		[Mediate(event="LoginEvent.LOGIN", properties="username, password")]
		public function login(username:String, password:String):void
		{
			LOG.info("login " + username + "/" + password);
			var token:AsyncToken = delegate.login(username, password);
			serviceRequestUtil.executeServiceCall(token, loginResultHandler);
		}

		/**
		 * Result handler of the LoginDelegate service call.
		 *
		 * @param event ResultEvent containing the user in the result property.
		 *
		 */
		protected function loginResultHandler(event:ResultEvent):void
		{
			var user:User = event.result as User;
			LOG.info("loginResultHandler " + user);
			model.user = user;
		}

		[MediateSignal(type="LoginInvokeSignal")]
		public function loginInvokeSignal(username:String, password:String):void
		{
			LOG.info("loginInvokeSignal " + username + "/" + password);
			delegate.loginWithSignal(username, password);
		}

		[MediateSignal(type="LoginSignal")]
		public function loginSignal(user:User):void
		{
			LOG.info("loginSignal " + user);
		}
	}
}