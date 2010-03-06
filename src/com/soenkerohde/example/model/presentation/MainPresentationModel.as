package com.soenkerohde.example.model.presentation
{
	import mx.collections.ArrayCollection;
	import mx.collections.IList;

	import org.swizframework.storage.ISharedObjectBean;

	public class MainPresentationModel implements IMainPresentationModel
	{
		[Inject]
		public var so:ISharedObjectBean;

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
		public var navigation:IList = new ArrayCollection(["chart", "user", "module"]);

		public function MainPresentationModel()
		{
		}

		public function changeMainIndex(index:int):void
		{
			mainIndex = index;
			switch (index)
			{
				case 0:
					mainState = "chart";
					break;
				case 1:
					mainState = "user";
					break;
				case 2:
					mainState = "module";
					break;
				default:
					throw new Error("Unknown index " + index);
			}
		}

	}
}