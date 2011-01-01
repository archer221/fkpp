package com.ui.controls {
	import com.ui.core.UIComponent;
	import com.ui.core.UIComponentData;
	import com.ui.group.GToggleGroup;

	/**
	 * @version 20091215
	 * @author Cafe
	 */
	public class ToggleBase extends UIComponent {

		protected var _selected : Boolean = false;

		protected var _group : GToggleGroup;

		protected function onSelect() : void {
			// this is abstract function
		}

		public function ToggleBase(data : UIComponentData) {
			super(data);
		}

		public function set selected(value : Boolean) : void {
			if(_selected == value)return;
			_selected = value;
			if(_group != null && _selected) {
				_group.isSelected(this);
			}
			onSelect();
		}

		public function get selected() : Boolean {
			return _selected;
		}

		public function set group(value : GToggleGroup) : void {
			_group = value;
		}
	}
}