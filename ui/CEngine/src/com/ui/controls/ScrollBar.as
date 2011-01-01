package com.ui.controls {
	import com.ui.core.UIComponent;
	import com.ui.data.ScrollBarData;
	import com.ui.events.GScrollBarEvent;
	import com.ui.manager.UIManager;
	import flash.display.Sprite;
	import flash.events.MouseEvent;


	/**
	 * @version 20091215
	 * @author Cafe
	 */
	public class ScrollBar extends UIComponent {

		protected var _data : ScrollBarData;

		protected var _trackSkin : Sprite;

		protected var _thumb_btn : Button;

		protected var _direction : int;

		protected var _pageSize : int = 10;

		protected var _min : int = 0;

		protected var _max : int = 0;

		protected var _value : int = 0;

		protected var _old : int = 0;

		protected var _thumbScrollOffset : Number;

		protected var _fireEvent : Boolean = false;

		override protected function create() : void {
			_trackSkin = UIManager.getUI(_data.trackAsset);
			_thumb_btn = new Button(_data.thumbButtonData);
			addChild(_trackSkin);
			addChild(_thumb_btn);
			direction = _data.direction;
		}

		override protected function layout() : void {
			_trackSkin.width = _width;
			_trackSkin.height = _height;
			_thumb_btn.width = _width;
			reset();
		}

		protected function reset() : void {
			var per : Number = _max - _min + _pageSize;
			if (_max <= _min) {
				_thumb_btn.height = 12;
				_thumb_btn.visible = false;
			} else {
				_thumb_btn.height = Math.max(12, Math.round(_pageSize / per * _trackSkin.height));
				_thumb_btn.y = Math.round((_trackSkin.height - _thumb_btn.height) * (_value - _min) / (_max - _min));
				_thumb_btn.visible = true;
			}
		}

		protected function set direction(value : int) : void {
			_direction = value;
			if(_direction == ScrollBarData.HORIZONTAL) {
				rotation = -90;
				scaleX = -1;
			} else {
				rotation = 0;
				scaleX = 1;
			}
		}

		override protected function onShow() : void {
			_thumb_btn.addEventListener(MouseEvent.MOUSE_DOWN, thumb_mouseDownHandler);
		}

		override protected function onHide() : void {
			_thumb_btn.removeEventListener(MouseEvent.MOUSE_DOWN, thumb_mouseDownHandler);
		}

		protected function thumb_mouseDownHandler(event : MouseEvent) : void {
			_thumbScrollOffset = mouseY - _thumb_btn.y;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
		}

		protected function stage_mouseMoveHandler(event : MouseEvent) : void {
			var position : int = Math.max(0, Math.min(_trackSkin.height - _thumb_btn.height, mouseY - _thumbScrollOffset));
			var newScrollPosition : int = Math.round(position / (_trackSkin.height - _thumb_btn.height) * (_max - _min) + _min);
			if(_value != newScrollPosition) {
				var oldScrollPosition : int = _value;
				_value = newScrollPosition;
				reset();
				dispatchEvent(new GScrollBarEvent(_direction, _value - oldScrollPosition, _value));
			}
		}

		protected function stage_mouseUpHandler(event : MouseEvent) : void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stage_mouseMoveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
		}

		public function ScrollBar(data : ScrollBarData) {
			_data = data;
			super(data);
		}

		public function set fireEvent(value : Boolean) : void {
			_fireEvent = value;
		}

		public function get pageSize() : int {
			return _pageSize;
		}

		public function get min() : int {
			return _min;
		}

		public function get max() : int {
			return _max;
		}

		public function get value() : int {
			return _value;
		}

		public function resetValue(pageSize : int,min : int,max : int,value : int) : void {
			var isUpdate : Boolean = false;
			var isChange : Boolean = false;
			if(_pageSize != pageSize) {
				_pageSize = pageSize;
				isUpdate = true;
			}
			if(_min != min) {
				_min = min;
				isUpdate = true;
			}
			if(_max != max) {
				_max = max;
				isUpdate = true;
			}
			value = Math.max(_min, Math.min(value, _max));
			if(_value != value) {
				_old = _value;
				_value = value;
				isUpdate = true;
				isChange = true;
			}
			if(isUpdate)reset();
			if(isChange)dispatchEvent(new GScrollBarEvent(_direction, _value - _old, _value));
		}

		public function get scrollPosition() : int {
			return _value;
		}

		public function scroll(delta : int) : void {
			var newValue : int = Math.max(_min, Math.min(_value - delta * _data.wheelSpeed, _max));
			if(_value == newValue)return;
			_old = _value;
			_value = newValue;
			reset();
			dispatchEvent(new GScrollBarEvent(_direction, _value - _old, _value));
		}

		override public function setSize(width : int,height : int) : void {
			if(_direction == ScrollBarData.HORIZONTAL) {
				super.setSize(height, width);
			} else {
				super.setSize(width, height);
			}
		}

		override public function set width(value : Number) : void {
			if(_direction == ScrollBarData.HORIZONTAL) {
				super.height = value;
			} else {
				super.width = value;
			}
		}

		override public function get width() : Number {
			return (_direction == ScrollBarData.HORIZONTAL) ? _height : _width;
		}

		override public function set height(value : Number) : void {
			if(_direction == ScrollBarData.HORIZONTAL) {
				super.width = value;
			} else {
				super.height = value;
			}
		}

		override public function get height() : Number {
			return (_direction == ScrollBarData.HORIZONTAL) ? _width : _height;
		}
	}
}
