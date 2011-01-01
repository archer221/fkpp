package com.test {
	import com.model.ListModel;
	import flash.display.Sprite;


	/**
	 * @author Cafe
	 */
	public class TestListModel extends Sprite {

		public function TestListModel() {
			var model : ListModel = new ListModel(true);
			model.setAt(0, "a");
			model.setAt(1, "b");
			model.removeAt(0);
			trace(model.getAt(4), model.getAt(1), model.size);
		}
	}
}
