package cafe.battle {
	import cafe.core.Command;
	import cafe.core.ItemCell;
	import com.net.AssetData;
	import com.ui.containers.Panel;
	import com.ui.controls.Button;
	import com.ui.controls.Gird;
	import com.ui.controls.ProgressBar;
	import com.ui.core.ScaleMode;
	import com.ui.data.ButtonData;
	import com.ui.data.GirdData;
	import com.ui.data.PanelData;
	import com.ui.data.ProgressBarData;
	import com.ui.skin.SkinStyle;
	import flash.display.DisplayObject;
	import flash.display.Sprite;



	/**
	 * @author Cafe
	 */
	public class Menu extends Panel {
		private var _openFriendList : Button;
		private var _seeting : Button;
		private var _ext : Button;
		private var _power_bar : DisplayObject;
		private var _anger : ProgressBar;
		private var _weapon_gp : Gird;
		private var _item_gp : Gird;

		public function Menu(parent : Sprite) {
			_data = new PanelData();
			_data.parent = parent;
			initData();
			super(_data);
			addButtons();
			addProgressBar();
			addGirds();
		}

		private function addGirds() : void {
			var data : GirdData = new GirdData();
			data.scaleMode = ScaleMode.AUTO_SIZE;
			data.bgAsset = new AssetData(SkinStyle.emptySkin, AssetData.AS_LIB);
			data.columns = 3;
			data.rows = 1;
			data.vgap = 3;
			data.hgap = 7;
			data.cell = WeaponThumbCell;
			data.cellData.width = 44;
			data.cellData.height = 44;
			data.cellData.toolTipData.alginMode = 1;
			data.hotKeys = ["Z", "X", "C"];
			data.x = 92;
			data.y = 54;
			_weapon_gp = new Gird(data);
			data = new GirdData();
			data.bgAsset = new AssetData(SkinStyle.emptySkin, AssetData.AS_LIB);
			data.x = 250;
			data.y = 65;
			data.cell = ItemCell;
			data.cellData.width = 30;
			data.cellData.height = 30;
			data.cellData.toolTipData.alginMode = 1;
			data.cellData.allowSelect = false;
			data.columns = 8;
			data.rows = 1;
			data.hgap = 5;
			data.vgap = 5;
			data.enabled = false;
			data.hotKeys = ["1", "2", "3", "4", "5", "6", "7", "8"];
			_item_gp = new Gird(data);
			addChild(_weapon_gp);
			addChild(_item_gp);
		}

		private function addProgressBar() : void {
			var data : PowerBarData = new PowerBarData();
			data.x = 550;
			data.y = 60;
			_power_bar = new PowerBar(data);
			addChild(_power_bar);

			var barData : ProgressBarData = new ProgressBarData();
			barData.x = 777;
			barData.y = 60;
			barData.width = 220;
			barData.height = 39;
			barData.trackAsset = new AssetData("MenuPerceAngeFull", Command.Skin_FKPP);
			barData.highLightAsset = new AssetData("MenuPerceAngeZero", Command.Skin_FKPP);
			_anger = new ProgressBar(barData);
			addChild(_anger);
		}

		private function addButtons() : void {
			var data : ButtonData = new ButtonData();
			data.upAsset = new AssetData("MenufriendUPButton", Command.Skin_FKPP);
			data.downAsset = new AssetData("MenufriendUPButton", Command.Skin_FKPP);
			data.overAsset = new AssetData("MenufriendOver", Command.Skin_FKPP);
			data.x = 890;
			data.y = 32;
			data.width = 39;
			data.height = 43;
			_openFriendList = new Button(data);
			addChild(_openFriendList);

			data = data.clone();
			data.x = 925;
			data.upAsset = new AssetData("MenuSetUPButton", Command.Skin_FKPP);
			data.downAsset = new AssetData("MenuSetUPButton", Command.Skin_FKPP);
			data.overAsset = new AssetData("MenuSetOverButton", Command.Skin_FKPP);
			_seeting = new Button(data);
			addChild(_seeting);

			data = data.clone();
			data.x = 959;
			data.upAsset = new AssetData("MenuOutUPButton", Command.Skin_FKPP);
			data.downAsset = new AssetData("MenuOutUPButton", Command.Skin_FKPP);
			data.overAsset = new AssetData("MenuOutOverButton", Command.Skin_FKPP);
			_ext = new Button(data);
			addChild(_ext);
		}

		private function initData() : void {
			_data.width = 1000;
			_data.height = 101;
			_data.bgAsset = new AssetData("Menumerg", Command.Skin_FKPP);
		}
	}
}
