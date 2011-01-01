package cafe.battle {
	import com.model.RangeModel;
	import com.ui.core.UIComponent;
	import com.ui.manager.UIManager;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * @author cafe
	 */
	public class PowerBar extends UIComponent {
		private var _trackSkin : Sprite;
		private var _barSkin : Sprite;
		private var _lastSkin : Sprite;
		private var _tipSkin : Sprite;
		private var _ticks : Shape;
		private var _data : PowerBarData;
		private var _model : RangeModel;

		override protected function create() : void {
			_trackSkin = UIManager.getUI(_data.trackAsset);
			_barSkin = UIManager.getUI(_data.barAsset);
			_barSkin.width = 0;
			_lastSkin = UIManager.getUI(_data.lastAsset);
			_lastSkin.x = 1;
			_tipSkin = UIManager.getUI(_data.tipAsset);
			_tipSkin.mouseEnabled = true;
			_ticks = new Shape;
			addChild(_trackSkin);
			addChild(_barSkin);
			addChild(_ticks);
			addChild(_lastSkin);
			addChild(_tipSkin);
		}

		override protected function layout() : void {
			_trackSkin.width = _width;
			_trackSkin.height = _height;
			_barSkin.height = _height;
			_tipSkin.x = int(_width * 0.5);
		}

		override protected function onShow() : void {
			super.onShow();
			addEventListener(MouseEvent.CLICK, clickHandler);
			_tipSkin.addEventListener(MouseEvent.MOUSE_DOWN, tip_mouseDownHandler);
		}

		override protected function onHide() : void {
			super.onHide();
			removeEventListener(MouseEvent.MOUSE_DOWN, clickHandler);
			_tipSkin.removeEventListener(MouseEvent.MOUSE_DOWN, tip_mouseDownHandler);
		}

		private function clickHandler(event : MouseEvent) : void {
			_tipSkin.x = Math.max(1, Math.min(_width - 3, mouseX));
		}

		private function tip_mouseDownHandler(event : MouseEvent) : void {
			_tipSkin.startDrag(false, new Rectangle(6, 0, _width - 25, 0));
			stage.addEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
		}

		private function stage_mouseUpHandler(event : MouseEvent) : void {
			_tipSkin.stopDrag();
			_tipSkin.x = Math.round(_tipSkin.x);
			_tipSkin.y = Math.round(_tipSkin.y);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stage_mouseUpHandler);
		}

		private function model_changeHandler(event : Event) : void {
			updateBar();
		}

		private function updateBar() : void {
			_barSkin.width = int(_model.percent * _width);
		}

		public function PowerBar(data : PowerBarData) {
			_data = data;
			super(data);
			_model = new RangeModel();
			_model.addEventListener(Event.CHANGE, model_changeHandler);
		}

		public function resetLast() : void {
			_lastSkin.x = Math.max(1, this._barSkin.width - 2);
		}

		public function set model(value : RangeModel) : void {
			if (_model) {
				_model.removeEventListener(Event.CHANGE, model_changeHandler);
			}
			_model = value;
			if (_model) {
				_model.addEventListener(Event.CHANGE, model_changeHandler);
				updateBar();
			}
		}

		public function get model() : RangeModel {
			return _model;
		}
	}
}