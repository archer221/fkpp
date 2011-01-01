package com.ui.controls {
	import com.ui.core.UIComponent;
	import com.ui.data.CheckBoxData;
	import com.ui.data.IconData;
	import com.ui.manager.UIManager;
	import com.utils.BDUtil;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;


	/**
	 * Game Check Box
	 * 
	 * @author Cafe
	 * @version 20100712
	 */
	public class CheckBox extends UIComponent {

		protected var _data : CheckBoxData;

		protected var _upSkin : Sprite;

		protected var _upIcon : BitmapData;

		protected var _selected_upIcon : BitmapData;

		protected var _icon : Icon;

		protected var _label : Label;

		protected var _selected : Boolean;

		override protected function create() : void {
			_upSkin = UIManager.getUI(_data.upAsset);
			var data : IconData = new IconData();
			data.x = _data.padding;
			_icon = new Icon(data);
			_upIcon = BDUtil.getBD(_data.upIcon);
			_selected_upIcon = BDUtil.getBD(_data.selectedUpIcon);
			_selected = _data.selected;
			_icon.bitmapData = (_selected ? _selected_upIcon : _upIcon);
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

		protected override function onShow() : void {
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}

		protected override function onHide() : void {
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}

		protected function mouseDownHandler(event : MouseEvent) : void {
			if(!_enabled)return;
			selected = !_selected;
		}

		override protected function onEnabled() : void {
			_icon.gray = !_enabled;
			_label.enabled = _enabled;
		}

		public function CheckBox(data : CheckBoxData) {
			_data = data;
			super(_data);
		}

		public function set selected(value : Boolean) : void {
			if(_selected == value)return;
			_selected = value;
			_icon.bitmapData = _selected ? _selected_upIcon : _upIcon;
			if(_selected)dispatchEvent(new Event(Event.SELECT));
			dispatchEvent(new Event(Event.CHANGE));
		}

		public function get selected() : Boolean {
			return _selected;
		}
	}
}
