package com.soenkerohde.example.model.presentation
{

	public interface ILoginPresentationModel
	{
		[Bindable(event="propertyChange")]
		function get username():String;

		[Bindable(event="propertyChange")]
		function get password():String;
		
		[Bindable(event="propertyChange")]
		function get error():String;
		
		[Bindable(event="propertyChange")]
		function get pending():Boolean;

		function login(username:String, password:String, byEvent:Boolean):void;
	}
}