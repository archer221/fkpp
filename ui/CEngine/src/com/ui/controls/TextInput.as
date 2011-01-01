package com.ui.controls {
	import com.ui.core.UIComponent;
	import com.ui.data.TextInputData;
	import com.ui.manager.UIManager;
	import com.utils.GStringUtil;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.system.Capabilities;
	import flash.system.IME;
	import flash.text.TextField;
	import flash.ui.Keyboard;


	/**
	 * Game Text Input
	 * 
	 * @author Cafe
	 * @version 20100725
	 */
	public class TextInput extends UIComponent {

		public static const ENTER : String = "enter";

		protected var _data : TextInputData;

		protected var _borderSkin : Sprite;

		protected var _disabledSkin : Sprite;

		protected var _textField : TextField;

		protected var _current : Sprite;

		override protected function create() : void {
			_borderSkin = UIManager.getUI(_data.borderAsset);
			_disabledSkin = UIManager.getUI(_data.disabledAsset);
			_current = _borderSkin;
			_textField = UIManager.getInputTextField();
			_textField.defaultTextFormat = _data.textFormat;
			_textField.condenseWhite = true;
			_textField.textColor = _data.textColor;
			_textField.filters = _data.textFieldFilters;
			_textField.maxChars = _data.maxChars;
			_textField.displayAsPassword = _data.displayAsPassword;
			if(_data.restrict.length > 0) {
				_textField.restrict = _data.restrict;
			}
			_textField.text = _data.text;
			_textField.x = 3;
			addChild(_borderSkin);
			addChild(_textField);
		}

		override protected function layout() : void {
			_borderSkin.width = _width;
			_borderSkin.height = _height;
			_disabledSkin.width = _width;
			_disabledSkin.height = _height;
			_textField.y = Math.floor((_height - _textField.textHeight - 4) / 2);
			_textField.width = _width - 4;
		}

		override protected function onEnabled() : void {
			if(_enabled) {
				swap(_current, _borderSkin);
				_current = _borderSkin;
				_textField.textColor = _data.textColor;
			} else {
				swap(_current, _disabledSkin);
				_current = _disabledSkin;
				_textField.textColor = _data.disabledColor;
			}
		}

		override protected function onShow() : void {
			if(Capabilities.hasIME) {
				IME.enabled = _data.allowIME;
			}
			_textField.addEventListener(TextEvent.TEXT_INPUT, textInputHandler);
			addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			if(_data.maxChars > 0) {
				_textField.addEventListener(TextEvent.TEXT_INPUT, textInputHandler);
			}
			_textField.addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
			_textField.addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
		}

		override protected function onHide() : void {
			_textField.removeEventListener(TextEvent.TEXT_INPUT, textInputHandler);
			removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			if(_data.maxChars > 0) {
				_textField.removeEventListener(TextEvent.TEXT_INPUT, textInputHandler);
			}
			_textField.removeEventListener(FocusEvent.FOCUS_IN, focusInHandler);
			_textField.removeEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
			if(Capabilities.hasIME) {
				IME.enabled = false;
			}
			if(stage.focus == _textField) {
				stage.focus = null;
			}
		}

		private function textInputHandler(event : TextEvent) : void {
			if(_data.maxChars > 0 && GStringUtil.getDwordLength(_textField.text) >= _data.maxChars) {
				event.preventDefault();
				return;
			}
			event.stopImmediatePropagation();
			var newEvent : TextEvent = new TextEvent(TextEvent.TEXT_INPUT, false, true);
			newEvent.text = event.text;
			dispatchEvent(newEvent);
			if (newEvent.isDefaultPrevented())event.preventDefault();
		}

		private function focusInHandler(event : FocusEvent) : void {
			if(Capabilities.hasIME) {
				IME.enabled = _data.allowIME;
			}
			dispatchEvent(event);
		}

		private function focusOutHandler(event : FocusEvent) : void {
			if(Capabilities.hasIME) {
				IME.enabled = false;
			}
			dispatchEvent(event);
		}

		private function keyDownHandler(event : KeyboardEvent) : void {
			if(event.keyCode == Keyboard.ENTER) {
				if(stage.focus == _textField) {
					dispatchEvent(new Event(TextInput.ENTER));
				}
			}
		}

		public function TextInput(data : TextInputData) {
			_data = data;
			super(data);
		}

		public function selectAll() : void {
			if(_textField.text.length < 1)return;
			_textField.setSelection(0, _textField.text.length);
		}

		public function setFocus(focus : Boolean = true) : void {
			if(focus) {
				if(UIManager.root.stage.focus != _textField) {
					UIManager.root.stage.focus = _textField;
				}
			} else {
				if(UIManager.root.stage.focus == _textField) {
					UIManager.root.stage.focus = null;
				}
			}
		}

		public function isFocus() : Boolean {
			return UIManager.root.stage.focus == _textField;
		}

		public function set text(value : String) : void {
			_textField.text = value;
		}

		public function get text() : String {
			return _textField.text;
		}

		public function get textField() : TextField {
			return _textField;
		}

		public function clear() : void {
			_textField.text = "";
		}
	}
}
