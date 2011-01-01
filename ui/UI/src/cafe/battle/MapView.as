package cafe.battle {
	import cafe.core.Command;
	import com.net.AssetData;
	import com.ui.controls.Button;
	import com.ui.core.UIComponent;
	import com.ui.core.UIComponentData;
	import com.ui.data.ButtonData;
	import com.ui.manager.UIManager;
	import flash.display.Sprite;
	import flash.events.MouseEvent;




	/**
	 * @author Cafe
	 */
	public class MapView extends UIComponent {
		private var _bg : Sprite;
		private var _up : Sprite;
		private var _over : Sprite;
		private var _add : Button;
		private var _reduce : Button;

		public function MapView(parent : Sprite) {
			_base = new UIComponentData();
			_base.parent = parent;
			super(_base);
			_bg = new Sprite();
			_up = UIManager.getUI(new AssetData("mapUP", Command.Skin_FKPP));
			_over = UIManager.getUI(new AssetData("mapOver", Command.Skin_FKPP));
			_bg = _up;
			addChild(_bg);
			addButtons();
			initEvents();
		}

		private function addButtons() : void {
			var data : ButtonData = new ButtonData();
			data.upAsset = new AssetData("AddmapUPButton", Command.Skin_FKPP);
			data.downAsset = new AssetData("AddmapUPButton", Command.Skin_FKPP);
			data.overAsset = new AssetData("AddmapOverButton", Command.Skin_FKPP);
			data.width = 14;
			data.height = 13;
			data.x = 150;
			data.y = 5;
			_add = new Button(data);
			addChild(_add);

			data = data.clone();
			data.x = 165;
			data.upAsset = new AssetData("MinmapUPButton", Command.Skin_FKPP);
			data.downAsset = new AssetData("MinmapUPButton", Command.Skin_FKPP);
			data.overAsset = new AssetData("MinmapOverButton", Command.Skin_FKPP);
			_reduce = new Button(data);
			addChild(_reduce);
		}

		private function initEvents() : void {
			addEventListener(MouseEvent.CLICK, clickHandler);
			addEventListener(MouseEvent.MOUSE_OVER, overHandler);
		}

		private function overHandler(event : MouseEvent) : void {
			_bg = _over;
		}

		private function clickHandler(event : MouseEvent) : void {
			_bg = _up;
		}
	}
}
