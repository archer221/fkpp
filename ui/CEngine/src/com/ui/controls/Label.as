package com.ui.controls {
	import com.ui.cell.LabelSource;
	import com.ui.core.UIComponent;
	import com.ui.data.LabelData;
	import com.ui.manager.UIManager;
	import com.utils.BDUtil;
	import com.utils.GStringUtil;
	import flash.display.BlendMode;
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;



	/**
	 * Game Label
	 * 
	 * @author Cafe
	 * @version 20100723
	 */
	public class Label extends UIComponent {

		protected var _data : LabelData;

		protected var _icon : Icon;

		protected var _textField : TextField;

		override protected function create() : void {
			_icon = new Icon(_data.iconData);
			_textField = UIManager.getTextField();
			_textField.mouseEnabled = false;
			_textField.selectable = false;
			_textField.autoSize = TextFieldAutoSize.LEFT;
			_textField.defaultTextFormat = _data.textFormat;
			_textField.styleSheet = _data.styleSheet;
			_textField.textColor = _data.textColor;
			_textField.filters = _data.textFieldFilters;
			_textField.text = _data.text;
			if(_data.textFieldAlpha < 1) {
				blendMode = BlendMode.LAYER;
				_textField.alpha = _data.textFieldAlpha;
			}
			if(_data.width > 0) {
				_textField.width = _data.width;
				_textField.wordWrap = true;
			}
			addChild(_icon);
			addChild(_textField);
		}

		override protected function layout() : void {
			var iconW : int = _icon.width;
			var iconH : int = _icon.height;
			var textW : int = 0;
			var textH : int = 0;
			var rect : Rectangle;
			if(_textField.text.length > 0) {
				rect = BDUtil.getTextSize(_textField);
				textW = rect.x * 2 + rect.width;
				textH = rect.y * 2 + rect.height;
			}
			_width = iconW + _data.hGap + textW;
			_height = Math.max(iconH, textH);
			if(_data.iconY == 0) {
				_icon.y = int((_height - iconH) * 0.5);
			} else {
				_icon.y = _textField.y + rect.y + rect.height + _data.iconY - iconH;
			}
			_textField.x = (iconW == 0 ? 0 : iconW + _data.hGap);
			_textField.y = Math.floor((_height - textH) * 0.5);
		}

		public function Label(data : LabelData) {
			_data = data;
			super(data);
		}

		public function get icon() : Icon {
			return _icon;
		}

		public function set styleSheet(value : StyleSheet) : void {
			_textField.styleSheet = value;
		}

		public function set text(value : String) : void {
			_textField.text = GStringUtil.truncateToFit(value, _data.maxLength);
			layout();
		}

		public function get text() : String {
			return _textField.text;
		}

		public function set textColor(value : uint) : void {
			_textField.textColor = value;
		}

		public function set htmlText(value : String) : void {
			_textField.htmlText = value;
			layout();
		}

		public function get htmlText() : String {
			return _textField.htmlText;
		}

		public function clear() : void {
			_textField.text = "";
		}

		override public function set source(value : *) : void {
			var data : LabelSource = value as LabelSource;
			if(data == null) {
				clear();
			} else {
				text = data.text;
			}
			_source = data;
		}
	}
}
