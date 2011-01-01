package com.ui.containers {
	import com.ui.controls.Label;
	import com.ui.core.ScaleMode;
	import com.ui.core.UIComponent;
	import com.ui.data.TitleBarData;
	import com.ui.layout.GLayout;
	import com.ui.manager.UIManager;
	import flash.display.Sprite;


	com.ui.controls.Label;


	/**
	 * @version 20091215
	 * @author Cafe
	 */
	public class TitleBar extends UIComponent {

		protected var _data : TitleBarData;

		protected var _backgroundSkin : Sprite;

		protected var _label : Label;

		protected var _layout : GLayout;

		override protected function create() : void {
			_backgroundSkin = UIManager.getUI(_data.backgroundAsset);
			_label = new Label(_data.labelData);
			addChild(_backgroundSkin);
			addChild(_label);
			switch(_data.scaleMode) {
				case ScaleMode.SCALE_WIDTH:
					_height = _backgroundSkin.height;
					break;
				case ScaleMode.SCALE_NONE:
					_width = _backgroundSkin.width;
					_height = _backgroundSkin.height;
					break;
			}
		}

		override protected function layout() : void {
			switch(_data.scaleMode) {
				case ScaleMode.SCALE9GRID:
					_backgroundSkin.width = _width;
					_backgroundSkin.height = _height;
					break;
				case ScaleMode.SCALE_WIDTH:
					_backgroundSkin.width = _width;
					break;
				case ScaleMode.SCALE_NONE:
					break;
				default:
					//Logger.error("scale mode is invalid!");
					break;
			}
			GLayout.layout(_label);
		}

		public function TitleBar(data : TitleBarData) {
			_data = data;
			super(data);
		}

		public function set text(value : String) : void {
			_label.text = value;
			GLayout.layout(_label);
		}
	}
}
