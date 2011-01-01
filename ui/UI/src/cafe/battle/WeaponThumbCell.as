package cafe.battle {
	import com.effects.CDEffect;
	import com.ui.cell.Cell;
	import com.ui.cell.CellData;
	import com.ui.controls.Icon;
	import com.ui.controls.Label;
	import com.ui.core.Align;
	import com.ui.data.IconData;
	import com.ui.data.LabelData;
	import com.ui.manager.UIManager;

	import flash.filters.DropShadowFilter;

	/**
	 * @author cafe
	 */
	public class WeaponThumbCell extends Cell {

		private var _thumb_icon : Icon;

		private var _name_lb : Label;

		private var _cd : CDEffect;

		override protected function create() : void {
			super.create();
			addIcon();
			addLabels();
			addChild(_name_lb);
			if(_key_lb != null) {
				_key_lb.hide();
				addChild(_key_lb);
			}
		}

		private function addIcon() : void {
			var iconData : IconData = new IconData();
			iconData.filters = [new DropShadowFilter(2, 45, 0x000000, 0.3, 2, 2)];
			iconData.align = new Align(-1, -1, -1, -1, 0, 0);
			_thumb_icon = new Icon(iconData);
			addChild(_thumb_icon);
		}

		private function addLabels() : void {
			var data : LabelData = new LabelData();
			data.textColor = 0xEFEFEF;
			data.textFieldFilters = UIManager.getEdgeFilters(0x000000, 0.9);
			data.align = new Align(-1, -1, -1, 1, 0, 0);
			_name_lb = new Label(data);
			addChild(_name_lb);
		}

		override protected function onEnabled() : void {
			super.onEnabled();
			if(!_cd)_thumb_icon.gray = !_enabled;
		}

		public function WeaponThumbCell(data : CellData) {
			super(data);
		}

		public function set cdValue(value : int) : void {
			if(value == 0) {
				enabled = false;
			}else if(value == 100) {
				enabled = true;
			}
			_cd.model.value = value;
		}

		public function get cdValue() : int {
			return _cd.model.value;
		}

		override public function set source(value : *) : void {

		}
	}
}
