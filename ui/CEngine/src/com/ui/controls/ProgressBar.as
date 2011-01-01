package com.ui.controls {
	import com.ui.core.UIComponent;
	import com.ui.data.ProgressBarData;
	import com.ui.layout.GLayout;
	import com.ui.manager.UIManager;
	import com.ui.skin.PolledSkin;
	import flash.display.Sprite;
	import flash.geom.Rectangle;




	/**
	 * Game Progress Bar
	 * 
	 * @author Cafe
	 * @version 20100719
	 */
	public class ProgressBar extends UIComponent {

		protected var _data : ProgressBarData;

		protected var _trackSkin : Sprite;

		protected var _barSkin : Sprite;

		protected var _highLightSkin : Sprite;

		protected var _polledSkin : PolledSkin;

		protected var _label : Label;

		protected var _value : int = 0;

		protected var _max : int = 100;

		protected var _mode : int;

		override protected function create() : void {
			_trackSkin = UIManager.getUI(_data.trackAsset);
			_barSkin = UIManager.getUI(_data.barAsset);
			_barSkin.x = _data.padding;
			_barSkin.y = _data.padding;
			_polledSkin = new PolledSkin();
			_label = new Label(_data.labelData);
			_mode = _data.mode;
			_value = _data.value;
			_max = _data.max;
			addChild(_trackSkin);
			switch(_mode) {
				case ProgressBarData.MANUAL:
					addChild(_barSkin);
					break;
				case ProgressBarData.POLLED:
					addChild(_polledSkin);
					break;
			}
			if(_data.highLightAsset != null) {
				_highLightSkin = UIManager.getUI(_data.highLightAsset);
				_highLightSkin.x = _data.padding;
				_highLightSkin.y = _data.padding;
				addChild(_highLightSkin);
			}
			addChild(_label);
		}

		override protected function layout() : void {
			_trackSkin.width = _width;
			_trackSkin.height = _height;
			if(!_data.barMask) {
				_barSkin.width = _width - _data.padding * 2;
				_barSkin.height = _height - _data.padding * 2;
			} else {
				_barSkin.scrollRect = new Rectangle(0, 0, _width - _data.padding * 2, _height - _data.padding * 2);
			}
			_polledSkin.setSize(_width, _height);
			if(_highLightSkin != null) {
				_highLightSkin.width = _width - _data.padding * 2;
				_highLightSkin.height = _height - _data.padding * 2;
			}
			GLayout.layout(_label);
			reset();
		}

		protected function reset() : void {
			var w : int = Math.round(_value / _max * (_width - _data.padding * 2));
			if(!_data.barMask) {
				_barSkin.width = w;
			} else {
				_barSkin.scrollRect = new Rectangle(0, 0, w, _height - _data.padding * 2);
			}
		}

		public function ProgressBar(data : ProgressBarData) {
			_data = data;
			super(data);
		}

		public function set mode(value : int) : void {
			if(_mode == value)return;
			_mode = value;
			switch(_mode) {
				case ProgressBarData.POLLED:
					swap(_barSkin, _polledSkin);
					break;
				case ProgressBarData.MANUAL:
					swap(_polledSkin, _barSkin);
					break;
			}
		}

		public function set text(value : String) : void {
			_label.text = value;
			GLayout.layout(_label);
		}

		public function set value(value : int) : void {
			if(_value == value)return;
			_value = Math.max(0, Math.min(value, _max));
			reset();
		}

		public function get value() : int {
			return _value;
		}

		public function set max(value : int) : void {
			if(_max == value)return;
			_max = Math.max(_value, value);
			reset();
		}
	}
}
