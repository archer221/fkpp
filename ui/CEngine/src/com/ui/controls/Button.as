package com.ui.controls {
	import com.ui.core.PhaseState;
	import com.ui.core.ScaleMode;
	import com.ui.core.UIComponent;
	import com.ui.data.ButtonData;
	import com.ui.layout.GLayout;
	import com.ui.manager.UIManager;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;


	/**
	 * Game Button
	 * 
	 * @author Cafe
	 * @version 20100708
	 */
	public class Button extends UIComponent {

		protected var _data : ButtonData;

		protected var _upSkin : Sprite;

		protected var _overSkin : Sprite;

		protected var _downSkin : Sprite;

		protected var _disabledSkin : Sprite;

		protected var _label : Label;

		protected var _current : Sprite;

		protected var _phase : int = PhaseState.UP;

		override protected function create() : void {
			_upSkin = UIManager.getUI(_data.upAsset);
			_overSkin = UIManager.getUI(_data.overAsset);
			_downSkin = UIManager.getUI(_data.downAsset);
			_disabledSkin = UIManager.getUI(_data.disabledAsset);
			_current = _upSkin;
			addChild(_current);
			_label = new  Label(_data.labelData);
			addChild(_label);
			switch(_data.scaleMode) {
				case ScaleMode.SCALE_WIDTH:
					_height = _upSkin.height;
					break;
				case ScaleMode.SCALE_NONE:
					_width = _upSkin.width;
					_height = _upSkin.height;
					break;
			}
		}

		override protected function layout() : void {
			GLayout.layout(_label);
			_upSkin.width = _width;
			_upSkin.height = _height;
			if(_overSkin != null) {
				_overSkin.width = _width;
				_overSkin.height = _height;
			}
			if(_downSkin != null) {
				_downSkin.width = _width;
				_downSkin.height = _height;
			}
			if(_disabledSkin != null) {
				_disabledSkin.width = _width;
				_disabledSkin.height = _height;
			}
		}

		override protected function onEnabled() : void {
			_label.enabled = _enabled;
			viewSkin();
		}

		override protected  function onShow() : void {
			super.onShow();
			addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}

		override protected function onHide() : void {
			super.onHide();
			removeEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}

		protected function rollOverHandler(event : MouseEvent) : void {
			if(!_enabled)return;
			_phase = PhaseState.OVER;
			viewSkin();
		}

		protected function rollOutHandler(event : MouseEvent) : void {
			if(!_enabled)return;
			_phase = PhaseState.UP;
			viewSkin();
		}

		protected function mouseDownHandler(event : MouseEvent) : void {
			if(!_enabled)return;
			_phase = PhaseState.DOWN;
			viewSkin();
		}

		protected function mouseUpHandler(event : MouseEvent) : void {
			if(!_enabled)return;
			_phase = ((event.currentTarget == this) ? PhaseState.OVER : PhaseState.UP);
			viewSkin();
		}

		protected function viewSkin() : void {
			if (!_enabled) {
				_label.textColor = _data.disabledColor;
				_current = swap(_current, _disabledSkin);
			}else if(_phase == PhaseState.UP) {
				_label.textColor = _data.labelData.textColor;
				_current = swap(_current, _upSkin);
			}else if (_phase == PhaseState.OVER) {
				_label.textColor = _data.rollOverColor;
				_current = swap(_current, _overSkin);
			}else if(_phase == PhaseState.DOWN) {
				_label.textColor = _data.labelData.textColor;
				_current = swap(_current, _downSkin);
			}
		}

		public function Button(data : ButtonData) {
			_data = data;
			super(data);
		}

		public function resetColor(textColor : uint,rollOverColor : uint) : void {
			_data.labelData.textColor = textColor;
			_data.rollOverColor = rollOverColor;
			if (!_enabled) {
				_label.textColor = _data.disabledColor;
			}else if(_phase == PhaseState.UP) {
				_label.textColor = _data.labelData.textColor;
			}else if (_phase == PhaseState.OVER) {
				_label.textColor = _data.rollOverColor;
			}else if(_phase == PhaseState.DOWN) {
				_label.textColor = _data.labelData.textColor;
			}
		}

		public function set text(value : String) : void {
			_label.text = value;
			GLayout.layout(_label);
		}

		public function get label() : Label {
			return _label;
		}

		public function set icon(value : BitmapData) : void {
			_label.icon.bitmapData = value;
			GLayout.layout(_label);
		}

		public function set iconGray(value : Boolean) : void {
			_label.icon.gray = value;
		}
	}
}
