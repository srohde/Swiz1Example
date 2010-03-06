package com.soenkerohde.example.model.presentation
{
	import mx.collections.IList;

	public interface IAppPresentationModel
	{
		[Bindable(event="propertyChange")]
		function get appState():String;

		[Bindable(event="propertyChange")]
		function get mainState():String;

		[Bindable(event="propertyChange")]
		function get mainIndex():int;

		[Bindable(event="propertyChange")]
		function get navigation():IList;

		function changeMainIndex(index:int):void;
	}
}