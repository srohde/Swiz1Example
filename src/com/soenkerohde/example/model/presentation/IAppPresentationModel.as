package com.soenkerohde.example.model.presentation
{

	public interface IAppPresentationModel
	{
		[Bindable(event="propertyChange")]
		function get appState():String;

	}
}