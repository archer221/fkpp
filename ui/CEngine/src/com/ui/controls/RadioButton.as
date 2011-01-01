package com.ui.controls {
	import com.ui.data.IconData;
	import com.ui.data.RadioButtonData;
	import com.ui.manager.UIManager;
	import com.utils.BDUtil;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;


	/**
	 * @version 20091215
	 * @author Cafe
	 */
	public class RadioButton extends ToggleBase {

		protected var _data : RadioButtonData;

		protected var _upSkin : Sprite;

		protected var _upIcon : BitmapData;

		protected var _selected_upIcon : BitmapData;

		protected var _icon : Icon;

		protected var _label : Label;

		override protected function create() : void {
			_upSkin = UIManager.getUI(_data.upAsset);
			_upIcon = BDUtil.getBD(_data.upIcon);
			_selected_upIcon = BDUtil.getBD(_data.selectedUpIcon);
			var data : IconData = new IconData();
			data.x = _data.padding;
			_icon = new Icon(data);
			_selected = _data.selected;
			_icon.bitmapData = (_data.selected ? _selected_upIcon : _upIcon);
			_label = new Label(_data.labelData);
			addChild(_upSkin);
			addChild(_icon);
			addChild(_label);
		}

		override protected function layout() : void {
			_label.x = _data.padding + _icon.width + _data.hGap;
			_width = _icon.width + _data.hGap + _label.width + _data.padding * 2;
			_height = Math.max(_icon.height, _label.height) + _data.padding * 2;
			_icon.y = Math.floor((_height - _icon.height) / 2);
			_label.y = Math.floor((_height - _label.height) / 2);
			_upSkin.width = _width;
			_upSkin.height = _height;
		}

		protected function mouseDownHandler(event : MouseEvent) : void {
			if(!_enabled)return;
			if(_group) {
				if(!_selected)selected = true;
			} else {
				selected = !_selected;
			}
		}

		override protected function onSelect() : void {
			_icon.bitmapData = (_selected ? _selected_upIcon : _upIcon);
		}

		override protected function onEnabled() : void {
			_icon.gray = !_enabled;
			_label.enabled = _enabled;
		}

		override protected  function onShow() : void {
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}

		protected override function onHide() : void {
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}

		public function RadioButton(data : RadioButtonData) {
			_data = data;
			super(data);
		}
	}
}
