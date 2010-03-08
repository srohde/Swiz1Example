package com.soenkerohde.example.model.presentation
{
	import com.soenkerohde.example.event.LoginEvent;
	import com.soenkerohde.example.signal.LoginInvokeSignal;

	import flash.events.IEventDispatcher;

	import mx.logging.ILogger;
	import mx.logging.Log;

	public class LoginPresentationModel implements ILoginPresentationModel
	{
		private static const LOG:ILogger = Log.getLogger("LoginPresentationModel");

		[Inject]
		public var loginInvokeSignal:LoginInvokeSignal;

		[Bindable]
		[Inject("loginModel.username")]
		public var username:String;

		[Bindable]
		[Inject("loginModel.password")]
		public var password:String;

		private var _dispatcher:IEventDispatcher;

		public function LoginPresentationModel(dispatcher:IEventDispatcher)
		{
			_dispatcher = dispatcher;
		}

		public function login(username:String, password:String, byEvent:Boolean):void
		{
			if (byEvent)
			{
				if (_dispatcher.dispatchEvent(new LoginEvent(LoginEvent.LOGIN, username, password)))
				{
					// if we arrive here LoginEvent was not canceled (no preventDefault called by any event handler)
					LOG.info("LoginEvent not cancelled");
				}
				else
				{
					LOG.info("LoginEvent cancelled");
				}
			}
			else
			{
				loginInvokeSignal.dispatch(username, password);
			}
		}
	}
}