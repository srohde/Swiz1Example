package com.soenkerohde.example.business
{
	import mx.rpc.AsyncToken;

	public interface IUserDelegate
	{
		function login(username:String, password:String):AsyncToken;

		function loadUsers():AsyncToken;

		function loginWithSignal(username:String, password:String):void;
	}
}