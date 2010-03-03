package com.soenkerohde.example.model.presentation
{
	import mx.collections.IList;

	public interface IAppPresentationModel
	{
		[Bindable(event="propertyChange")]
		function get appState():String;

		[Bindable(event="propertyChange")]
		function get appIndex():int;
		
		[Bindable(event="propertyChange")]
		function get navigation():IList;

		function changeAppIndex(index:int):void;
	}
}