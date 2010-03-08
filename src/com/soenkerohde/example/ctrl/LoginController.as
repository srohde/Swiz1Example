package com.soenkerohde.example.ctrl
{
	import com.soenkerohde.example.business.IUserDelegate;
	import com.soenkerohde.example.event.LoginEvent;
	import com.soenkerohde.example.event.UserEvent;
	import com.soenkerohde.example.model.LoginModel;
	import com.soenkerohde.example.model.domain.User;

	import flash.events.IEventDispatcher;

	import mx.logging.ILogger;
	import mx.logging.Log;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;

	import org.swizframework.core.IDispatcherAware;
	import org.swizframework.utils.services.ServiceRequestUtil;

	public class LoginController implements IDispatcherAware
	{
		private static const LOG:ILogger = Log.getLogger("LoginController");

		/**
		 * The login controller needs the service delegate.
		 * Swiz will inject the LoginDelegate instance by type even if you define the interface.
		 */
		[Inject]
		public var delegate:IUserDelegate;

		[Inject]
		public var model:LoginModel;

		[Inject]
		/**
		 * We could create an own instance of ServiceRequestUtil but best practice is to decleare
		 * in BeanProvider so in only gets created once when used multiple times.
		 */
		public var serviceRequestUtil:ServiceRequestUtil;

		private var _dispatcher:IEventDispatcher;

		/**
		 * IDispatcherAware implementation.
		 * @param dispatcher Swiz dispatcher instance.
		 *
		 */
		public function set dispatcher(dispatcher:IEventDispatcher):void
		{
			_dispatcher = dispatcher;
		}

		public function LoginController()
		{
		}

		[Mediate(event="LoginEvent.LOGIN", priority="1")]
		/**
		 * Mediate has higher priority (default is 0) and is called first when event gets dispatched.
		 * When you call stopImmediatePropagation on the event all other event listeners are skipped.
		 * When you call preventDefault on the event the dispatchEvent call returns false.
		 *
		 * @param event
		 */
		public function loginEventHandler(event:LoginEvent):void
		{
			if (event.username == "" || event.password == "")
			{
				event.preventDefault();
				event.stopImmediatePropagation();
			}
		}

		[Mediate(event="LoginEvent.LOGIN", properties="username, password")]
		/**
		 * The properties have to match the getters of the event.
		 * You can pass all public properties of an event.
		 *
		 * @param username The name does not have to match the property name
		 * @param password See above
		 *
		 */
		public function login(username:String, password:String):void
		{
			LOG.info("login " + username + "/" + password);
			var token:AsyncToken = delegate.login(username, password);
			serviceRequestUtil.executeServiceCall(token, loginResultHandler, null, [username, password]);
		}

		/**
		 * Result handler of the LoginDelegate service call.
		 *
		 * @param event ResultEvent containing the user in the result property.
		 *
		 */
		protected function loginResultHandler(event:ResultEvent, username:String, password:String):void
		{
			model.username = username;
			model.password = password;
			var user:User = event.result as User;
			LOG.info("loginResultHandler " + user);
			model.setUser(user);
			_dispatcher.dispatchEvent(new UserEvent(UserEvent.LOGIN, user));
		}

		/* AS3-Signal based login version */

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
			_dispatcher.dispatchEvent(new UserEvent(UserEvent.LOGIN, user));
		}

		[Mediate(event="UserEvent.LOGOUT", properties="user")]
		public function logout(user:User):void
		{
			model.password = "";
		}
	}
}