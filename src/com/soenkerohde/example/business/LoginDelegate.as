package com.soenkerohde.example.business
{
	import com.soenkerohde.example.domain.User;

	import mx.rpc.AsyncToken;

	import org.swizframework.utils.services.MockDelegateUtil;

	public class LoginDelegate implements ILoginDelegate
	{

		protected var util:MockDelegateUtil;

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
	}
}