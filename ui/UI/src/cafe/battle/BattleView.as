package cafe.battle {
	import cafe.chat.ChatView;
	import cafe.chat.Message;
	import cafe.core.Command;

	import com.net.AssetData;
	import com.ui.containers.Panel;
	import com.ui.controls.Button;
	import com.ui.controls.Gird;
	import com.ui.data.ButtonData;
	import com.ui.data.GirdData;
	import com.ui.data.PanelData;

	import flash.display.Sprite;

	/**
	 * @author Cafe
	 */
	public class BattleView extends Panel {
		private var _chat : ChatView;
		private var _wind : Wind;
		private var _tack : Button;
		private var _leftTeam_gp : Gird;
		private var _rightTeam_gp : Gird;
		private var _mapView : MapView;
		private var _menu : Menu;
		private var _messageView : Message;
		private var _tools : Propertys;

		public function BattleView(parent : Sprite) {
			_data = new PanelData();
			_data.parent = parent;
			initData();
			super(_data);
			initViews();
			addbuttons();
			addTeams();
			addChat();
		}

		private function addChat() : void {
			_messageView = new Message(this);
			_messageView.y = 200;
			addChild(_messageView);
		}

		private function addTeams() : void {
			var data : GirdData = new GirdData();
			// data.bgAsset = new AssetData("alpha_panel_bg_skin", Command.Skin_FKPP);
			data.x = 200;
			data.y = 5;
			data.cell = TeamCell;
			data.cellData.allowSelect = false;
			// data.cellData.upAsset = new AssetData("alpha_panel_bg_skin", Command.Skin_FKPP);
			data.cellData.disabledAsset = null;
			data.cellData.overAsset = null;
			data.cellData.selected_overAsset = null;
			data.cellData.width = 100;
			data.cellData.height = 40;
			data.cellData.allowDoubleClick = true;
			data.columns = 2;
			data.rows = 2;
			data.padding = 5;
			data.hgap = 5;
			data.vgap = 5;
			_leftTeam_gp = new Gird(data);
			data = data.clone();
			data.x = 520;
			_rightTeam_gp = new Gird(data);
			add(_leftTeam_gp);
			add(_rightTeam_gp);
		}

		private function addbuttons() : void {
			var data : ButtonData = new ButtonData();
			data.width = 80;
			data.height = 52;
			data.x = 10;
			data.y = 10;
			data.upAsset = new AssetData("tackUPButton", Command.Skin_FKPP);
			data.downAsset = new AssetData("tackUPButton", Command.Skin_FKPP);
			data.overAsset = new AssetData("tackOverButton", Command.Skin_FKPP);
			_tack = new Button(data);
			addChild(_tack);
		}

		private function initViews() : void {
			_menu = new Menu(this);
			_menu.moveTo(0, 500);
			addChild(_menu);

			_chat = new ChatView(this);
			_chat.show();
			_chat.moveTo(250, 500);

			_wind = new Wind(this);
			_wind.show();
			_wind.moveTo(430, 10);

			_mapView = new MapView(this);
			_mapView.moveTo(800, 10);
			addChild(_mapView);

			_tools = new Propertys(this);
			_tools.moveTo(910, 200);
			add(_tools);
		}

		private function initData() : void {
			_data.width = 1000;
			_data.height = 600;
		}
	}
}
