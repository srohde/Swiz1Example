package com.soenkerohde.example.model
{
	import com.soenkerohde.example.model.domain.User;

	import mx.collections.IList;

	import org.swizframework.storage.ISharedObjectBean;

	public class AppModel
	{

		[Inject]
		public var so:ISharedObjectBean;

		[Bindable]
		public var appState:String = "login";

		[Bindable]
		public function get mainState():String
		{
			return so.getString("mainState", "chart");
		}

		public function set mainState(state:String):void
		{
			so.setString("mainState", state);
		}

		[Bindable]
		public function get mainIndex():int
		{
			return so.getInt("mainIndex", 0);
		}

		public function set mainIndex(index:int):void
		{
			so.setInt("mainIndex", index);
		}

		[Bindable]
		public var user:User;

		[Bindable]
		public var users:IList;

		public function AppModel()
		{
		}
	}
}