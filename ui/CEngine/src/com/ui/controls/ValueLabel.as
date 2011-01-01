package com.ui.controls {
	import com.ui.core.UIComponent;
	import com.ui.data.ValueLabelData;

	/**
	 * @author Cafe
	 */
	public class ValueLabel extends UIComponent {
		protected var _data : ValueLabelData;
		protected var _nameLabel : Label;
		protected var _valueLabel : Label;

		public function ValueLabel(data : ValueLabelData) {
			_data = data;
			super(_data);
		}

		override protected function layout() : void {
			_valueLabel.x = _nameLabel.width;
		}

		override protected function create() : void {
			_nameLabel = new Label(_data.nameLableData);
			_valueLabel = new Label(_data.valueLableData);
			addChild(_nameLabel);
			addChild(_valueLabel);
			layout();
		}

		public function get value() : String {
			return _valueLabel.text;
		}

		public function set value(value : String) : void {
			_valueLabel.text = value;
		}

		public function get nameText() : String {
			return _nameLabel.text;
		}

		public function set nameText(value : String) : void {
			_nameLabel.text = value;
			layout();
		}
	}
}
