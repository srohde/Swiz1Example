package com.soenkerohde.example.ctrl
{
	import com.soenkerohde.example.business.ILoginDelegate;
	import com.soenkerohde.example.domain.User;
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
		public var delegate:ILoginDelegate;

		[Inject]
		public var serviceRequestUtil:ServiceRequestUtil;

		[Inject]
		public var model:AppModel;

		public function LoginController()
		{
		}

		[Mediate(event="LoginEvent.LOGIN", priority="1")]
		public function loginEventHandler(event:LoginEvent):void
		{
			if( event.username == "" || event.password == "" )
			{
				event.preventDefault();
				event.stopImmediatePropagation();
			}
		}

		[Mediate(event="LoginEvent.LOGIN", properties="username, password")]
		public function login(username:String, password:String):void
		{
			LOG.info("login " + username + "/" + password);
			var token:AsyncToken = delegate.login(username, password);
			serviceRequestUtil.executeServiceCall(token, loginResultHandler);
		}

		protected function loginResultHandler(event:ResultEvent):void
		{
			var user:User = event.result as User;
			LOG.info("loginResultHandler " + user);
			model.user = user;
		}

		[MediateSignal(type="LoginSignal")]
		public function loginSignal(user:User):void
		{
			LOG.info("loginSignal " + user);
		}
	}
}