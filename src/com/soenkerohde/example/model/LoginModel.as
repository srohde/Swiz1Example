package com.soenkerohde.example.model
{
	import com.soenkerohde.example.model.domain.User;

	public class LoginModel
	{

		[Bindable]
		public var username:String = "";

		[Bindable]
		public var password:String = "";

		[Bindable]
		public var user:User;
		
		[Bindable]
		public var pending:Boolean = false;

		public function LoginModel()
		{
		}

		public function setUser(user:User):void
		{
			this.user = user;
		}
	}
}