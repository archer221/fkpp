package cafe.battle {
	import com.ui.skin.SkinStyle;
	import com.net.AssetData;
	import com.ui.controls.Gird;
	import com.ui.data.GirdData;

	import flash.display.Sprite;

	import com.ui.containers.Panel;
	import com.ui.data.PanelData;

	/**
	 * @author Cafe
	 */
	public class Propertys extends Panel {
		private var _tools : Gird;

		public function Propertys(parent : Sprite) {
			_data = new PanelData();
			_data.parent = parent;
			_data.bgAsset = new AssetData(SkinStyle.emptySkin);
			super(_data);
			addGird();
		}

		private function addGird() : void {
			var data : GirdData = new GirdData();
			data.columns = 2;
			data.rows = 7;
			data.cellData.width = 30;
			data.cellData.height = 30;
			data.bgAsset = new AssetData(SkinStyle.emptySkin);
			_tools = new Gird(data);
			addChild(_tools);
		}
	}
}
