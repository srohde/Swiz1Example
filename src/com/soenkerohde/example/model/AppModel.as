package com.soenkerohde.example.model
{
	import com.soenkerohde.example.domain.User;

	import org.swizframework.storage.ISharedObjectBean;

	public class AppModel
	{

		[Inject]
		public var so:ISharedObjectBean;

		[Bindable]
		public function get appState():String
		{
			return so.getString("appState", "login");
		}

		public function set appState(state:String):void
		{
			so.setString("appState", state);
		}

		[Bindable]
		public function get appIndex():int
		{
			return so.getInt("appIndex", 0);
		}

		public function set appIndex(index:int):void
		{
			so.setInt("appIndex", index);
		}

		[Bindable]
		public var user:User;

		public function AppModel()
		{
		}
	}
}