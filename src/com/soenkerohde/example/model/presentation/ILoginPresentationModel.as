package com.soenkerohde.example.model.presentation
{

	public interface ILoginPresentationModel
	{
		[Bindable(event="propertyChange")]
		function get username():String;

		[Bindable(event="propertyChange")]
		function get password():String;

		function login(username:String, password:String, byEvent:Boolean):void;
	}
}