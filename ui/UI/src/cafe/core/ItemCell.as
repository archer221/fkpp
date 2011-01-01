package cafe.core {
	import com.ui.cell.Cell;
	import com.ui.cell.CellData;
	import com.ui.controls.Icon;
	import com.ui.controls.Label;
	import com.ui.core.Align;
	import com.ui.core.ScaleMode;
	import com.ui.data.IconData;
	import com.ui.data.LabelData;
	import com.ui.drag.IDragSource;
	import com.ui.layout.GLayout;
	import com.ui.manager.UIManager;

	import flash.display.BitmapData;

	/**
	 * @author cafe
	 */
	public class ItemCell extends Cell implements IDragSource {
		private var _thumb_icon : Icon;
		private var _count_lb : Label;

		override protected function create() : void {
			_upSkin = UIManager.getUI(_data.upAsset);
			_overSkin = UIManager.getUI(_data.overAsset);
			_selected_upSkin = UIManager.getUI(_data.selected_upAsset);
			_selected_overSkin = UIManager.getUI(_data.selected_overAsset);
			_disabledSkin = UIManager.getUI(_data.disabledAsset);
			_current = _upSkin;
			addChild(_current);
			_data.lockIconData.parent = this;
			_lockIcon = new Icon(_data.lockIconData);
			switch(_data.scaleMode) {
				case ScaleMode.SCALE_WIDTH:
					_height = _upSkin.height;
					break;
				case ScaleMode.SCALE_NONE:
					_width = _upSkin.width;
					_height = _upSkin.height;
					break;
			}
			addThumb();
			addLabel();
			addKeyLabel();
		}

		private function addThumb() : void {
			var data : IconData = new IconData();
			// data.filters = [new DropShadowFilter(2, 45, 0x000000, 0.5, 2, 2)];
			data.align = new Align(-1, -1, -1, -1, 0, 0);
			data.enabled = false;
			_thumb_icon = new Icon(data);
			addChild(_thumb_icon);
		}

		private function addLabel() : void {
			var data : LabelData = new LabelData();
			data.textColor = 0xFFFFFF;
			data.textFieldFilters = UIManager.getEdgeFilters(0x000000, 1);
			data.align = new Align(-1, 2, -1, 2, -1, -1);
			_count_lb = new Label(data);
			addChild(_count_lb);
		}

		override protected function onEnabled() : void {
			super.onEnabled();
			_thumb_icon.gray = !_enabled;
			_count_lb.enabled = _enabled;
		}

		public function ItemCell(data : CellData) {
			// data.toolTip = ItemToolTip;
			data.toolTipData.labelData.textFieldFilters = UIManager.getEdgeFilters(0x000000, 0.7);
			super(data);
		}

		public function get thumb() : Icon {
			return _thumb_icon;
		}

		override public function set source(value : *) : void {
			if (_source == value) return;
			enabled = (_source != null);
			if (value == null) {
				_thumb_icon.bitmapData = null;
				_count_lb.clear();
				_toolTip.source = null;
			} else {
				// _thumb_icon.bitmapData =
				_count_lb.text = "0";
				GLayout.layout(_thumb_icon);
				GLayout.layout(_count_lb);
			}
			var data : BitmapData = new BitmapData(10, 10, false, 0x00ffff00);
			_thumb_icon.bitmapData = data;
			_count_lb.text = "9";
			enabled = true;
			_source = value;
		}

		override public function clone() : Cell {
			var cell : ItemCell = new ItemCell(_data.clone());
			cell.source = _source;
			return cell;
		}

		public function get dragImage() : Icon {
			var source : Icon = _thumb_icon.clone();
			//source.gray = false;
			//source.enabled = false;
			return source;
		}
	}
}
