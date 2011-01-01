package com.ui.controls {
	import com.model.RangeModel;
	import com.ui.core.UIComponent;
	import com.ui.core.UIComponentData;
	import flash.display.Sprite;
	import flash.events.Event;


	/**
	 * @version 20091015
	 * @author Cafe
	 */
	public class CD extends UIComponent {

		protected var _mask : Sprite;

		protected var _model : RangeModel;

		override protected function create() : void {
			_mask = new Sprite();
		}

		protected function redraw() : void {
			//GraphicsUtil.drawArcTorus(g, 0, 0, 30,270,_model.value);
		}

		protected function modelChangeHandler() : void {
			redraw();
		}

		public function CD(base : UIComponentData) {
			super(base);
			_model = new RangeModel();
			_model.addEventListener(Event.CHANGE, modelChangeHandler);
		}

		public function get model() : RangeModel {
			return _model;
		}
	}
}
