package com.ui.controls {
	import com.ui.core.UIComponent;
	import com.ui.data.ChatTipData;
	import com.ui.manager.UIManager;
	import flash.display.Sprite;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;



	/**
	 * Game Chat Tip
	 * 
	 * @author Cafe
	 * @version 20100723
	 */
	public class ChatTip extends UIComponent {

		private var _data : ChatTipData;

		private var _bodySkin : Sprite;

		private var _tailSkin : Sprite;

		private var _label : Label;

		private var _timeout : uint;

		override protected function create() : void {
			_bodySkin = UIManager.getUI(_data.bodyAsset);
			_tailSkin = UIManager.getUI(_data.tailAsset);
			_tailSkin.x = -int(_tailSkin.width * 0.5);
			_tailSkin.y = -_tailSkin.height - 1;
			_data.labelData.width = _data.maxWidth - _data.gap * 2;
			_label = new Label(_data.labelData);
			addChild(_bodySkin);
			addChild(_tailSkin);
			addChild(_label);
		}

		override protected function layout() : void {
			_width = Math.max(_data.minWidth, Math.min(_data.maxWidth, _label.width + _data.gap * 2));
			_height = Math.max(_data.minHeight, Math.min(_data.maxHeight, _label.height + _data.gap * 2));
			_bodySkin.width = _width;
			_bodySkin.height = _height - _tailSkin.height;
			_bodySkin.x = -int(_width * 0.5);
			_bodySkin.y = -_height;
			_label.x = -int(_label.width * 0.5);
			_label.y = -_height + int((_bodySkin.height - _label.height) * 0.5);
		}

		override protected function onShow() : void {
			super.onShow();
			if(_timeout != 0) {
				clearTimeout(_timeout);
				_timeout = 0;
			}
			_timeout = setTimeout(hide, _data.timeout * 1000);
		}

		override protected function onHide() : void {
			super.onHide();
			if(_timeout != 0) {
				clearTimeout(_timeout);
				_timeout = 0;
			}
		}

		public function ChatTip(data : ChatTipData) {
			_data = data;
			super(_data);
		}

		public function set text(value : String) : void {
			_label.text = value;
			layout();
			if(_timeout != 0) {
				clearTimeout(_timeout);
				_timeout = 0;
			}
			_timeout = setTimeout(hide, _data.timeout * 1000);
		}

		public function get text() : String {
			return _label.text;
		}

		public function set htmlText(value : String) : void {
			_label.htmlText = value;
		}

		public function get htmlText() : String {
			return _label.htmlText;
		}
	}
}
