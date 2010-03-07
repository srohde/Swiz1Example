package com.soenkerohde.example.model.presentation
{
	import com.soenkerohde.example.model.domain.User;

	import mx.collections.IList;

	public interface IMainPresentationModel
	{
		[Bindable(event="propertyChange")]
		function get mainState():String;

		[Bindable(event="propertyChange")]
		function get mainIndex():int;

		[Bindable(event="propertyChange")]
		function get navigation():IList;

		[Bindable(event="propertyChange")]
		function get user():User;

		function changeMainIndex(index:int):void;

		function logout():void;
	}
}