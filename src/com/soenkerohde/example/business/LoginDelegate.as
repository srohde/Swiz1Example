package com.soenkerohde.example.business
{
	import com.soenkerohde.example.domain.User;
	import com.soenkerohde.example.signal.LoginSignal;

	import mx.rpc.AsyncToken;

	import org.swizframework.utils.services.MockDelegateUtil;

	public class LoginDelegate implements ILoginDelegate
	{

		protected var util:MockDelegateUtil;

		[Inject]
		public var loginSignal:LoginSignal;

		public function LoginDelegate()
		{
			util = new MockDelegateUtil();
		}

		public function login(username:String, password:String):AsyncToken
		{
			var user:User = new User();
			user.username = username;
			user.id = 1;
			return util.createMockResult(user);
		}

		public function loginWithSignal(username:String, password:String):void
		{
			var user:User = new User();
			user.username = username;
			user.id = 1;
			loginSignal.dispatch(user);
		}
	}
}