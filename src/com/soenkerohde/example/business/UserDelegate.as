package com.soenkerohde.example.business
{
	import com.soenkerohde.example.model.domain.User;
	import com.soenkerohde.example.signal.LoginSignal;

	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.rpc.AsyncToken;

	import org.swizframework.utils.services.MockDelegateUtil;

	public class UserDelegate implements IUserDelegate
	{

		protected var util:MockDelegateUtil;

		[Inject]
		public var loginSignal:LoginSignal;

		public function UserDelegate()
		{
			util = new MockDelegateUtil();
		}

		public function login(username:String, password:String):AsyncToken
		{
			var user:User = new User(1, username);
			return util.createMockResult(user);
		}

		public function loadUsers():AsyncToken
		{
			var a:Array = [];
			a.push(new User(1, "Adam"));
			a.push(new User(2, "Ben"));
			a.push(new User(3, "Brian"));
			a.push(new User(4, "Darron"));
			a.push(new User(5, "Chris"));
			a.push(new User(6, "John"));
			a.push(new User(7, "Ryan"));
			a.push(new User(8, "Sönke"));
			var users:IList = new ArrayCollection(a);
			return util.createMockResult(users);
		}

		public function loginWithSignal(username:String, password:String):void
		{
			loginSignal.dispatch(new User(1, username));
		}
	}
}