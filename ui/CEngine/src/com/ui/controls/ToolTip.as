package com.ui.controls {
	import com.ui.core.UIComponent;
	import com.ui.data.ToolTipData;
	import com.ui.manager.UIManager;
	import flash.display.Sprite;


	/**
	 * Game ToolTip
	 * 
	 * @author Cafe
	 * @version 20100719
	 */
	public class ToolTip extends UIComponent {

		protected var _data : ToolTipData;

		protected var _backgroundSkin : Sprite;

		protected var _label : Label;

		override protected function create() : void {
			_backgroundSkin = UIManager.getUI(_data.backgroundAsset);
			addChild(_backgroundSkin);
			_label = new Label(_data.labelData);
			_label.x = _label.y = _data.padding;
			addChild(_label);
		}

		override protected function layout() : void {
			_width = _label.width + _data.padding * 2;
			_height = _label.height + _data.padding * 2;
			_backgroundSkin.width = _width;
			_backgroundSkin.height = _height;
		}

		public function ToolTip(data : ToolTipData) {
			_data = data;
			super(data);
			mouseEnabled = mouseChildren = false;
		}

		public function get data() : ToolTipData {
			return _data;
		}

		public function get text() : String {
			return _label.text;
		}

		override public function set source(value : *) : void {
			if(value == null) {
				_label.clear();
			} else {
				_label.text = String(value);
				layout();
			}
			_source = value;
		}
	}
}