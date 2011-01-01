package cafe.chat {
	import cafe.core.Command;
	import com.net.AssetData;
	import com.ui.containers.Panel;
	import com.ui.controls.Button;
	import com.ui.core.Align;
	import com.ui.core.ScaleMode;
	import com.ui.data.ButtonData;
	import com.ui.data.PanelData;
	import com.ui.manager.UIManager;
	import com.utils.BDUtil;
	import flash.display.Sprite;



	/**
	 * @author Cafe
	 */
	public class Message extends Panel {
		private var _clear_btn : Button;
		private var _up_btn : Button;
		private var _down_btn : Button;
		private var _bottom_btn : Button;
		private var _pm_btn : Button;
		private var _face_btn : Button;

		public function Message(parent : Sprite) {
			_data = new PanelData();
			_data.parent = parent;
			initData();
			super(_data);
			addBar();
			addButtons();
		}

		private function addButtons() : void {
			var data : ButtonData = new ButtonData();
			data.upAsset = new AssetData("clear_upSkin");
			data.overAsset = new AssetData("clear_overSkin");
			data.downAsset = new AssetData("clear_downSkin");
			data.disabledAsset = new AssetData("clear_disabledSkin");
			data.scaleMode = ScaleMode.SCALE_NONE;
			_clear_btn = new Button(data);
			data = new ButtonData();
			data.upAsset = new AssetData("up_upSkin");
			data.overAsset = new AssetData("up_overSkin");
			data.downAsset = new AssetData("up_downSkin");
			data.disabledAsset = new AssetData("up_disabledSkin");
			data.scaleMode = ScaleMode.SCALE_NONE;
			data.y = 22;
			_up_btn = new Button(data);
			data = new ButtonData();
			data.upAsset = new AssetData("down_upSkin");
			data.overAsset = new AssetData("down_overSkin");
			data.downAsset = new AssetData("down_downSkin");
			data.disabledAsset = new AssetData("down_disabledSkin");
			data.scaleMode = ScaleMode.SCALE_NONE;
			data.y = 44;
			_down_btn = new Button(data);
			data = new ButtonData();
			data.upAsset = new AssetData("bottom_upSkin");
			data.overAsset = new AssetData("bottom_overSkin");
			data.downAsset = new AssetData("bottom_downSkin");
			data.disabledAsset = new AssetData("bottom_disabledSkin");
			data.scaleMode = ScaleMode.SCALE_NONE;
			data.y = 66;
			_bottom_btn = new Button(data);
			data = new ButtonData();
			data.parent = this;
			data.align = new Align(-1, 0, -1, 0, -1, -1);
			data.width = 22;
			data.height = 22;
			data.enabled = true;
			_face_btn = new Button(data);
			data = data.clone();
			data.align = new Align(42, -1, -1, 0, -1, -1);
			data.labelData.iconData.bitmapData = BDUtil.getBD(new AssetData("right_arrow"));
			data.labelData.align = new Align(3, -1, -1, -1, 0, 0);
			data.width = 80;
			_pm_btn = new Button(data);
			addChild(_clear_btn);
			addChild(_up_btn);
			addChild(_down_btn);
			addChild(_bottom_btn);
		}

		private function addBar() : void {
			addChild(UIManager.getUI(new AssetData("Chatcase", Command.Skin_FKPP)));
		}

		private function initData() : void {
			_data.width = 322;
			_data.height = 109;
			_data.bgAsset = new AssetData("ChatAreaBG", Command.Skin_FKPP);
		}
	}
}
