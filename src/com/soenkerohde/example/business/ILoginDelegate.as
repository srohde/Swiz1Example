package com.soenkerohde.example.business
{
	import mx.rpc.AsyncToken;

	public interface ILoginDelegate
	{
		function login(username:String, password:String):AsyncToken;

		function loginWithSignal(username:String, password:String):void;
	}
}