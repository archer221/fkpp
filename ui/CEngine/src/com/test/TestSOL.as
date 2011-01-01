package com.test {
	import com.model.LocalSO;
	import flash.display.Sprite;


	/**
	 * @author Cafe
	 */
	public class TestSOL extends Sprite {

		public function TestSOL() {
			var sol : LocalSO = new LocalSO("game");
			trace(sol.getAt("username"));
		}
	}
}
