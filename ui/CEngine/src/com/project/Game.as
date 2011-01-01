package com.project {
	import com.net.AssetData;
	import com.net.RESManager;
	import com.ui.manager.UIManager;
	import com.ui.skin.ASSkin;
	import com.ui.theme.BlackTheme;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;


	public class Game extends Sprite {

		protected var _res : RESManager;

		private function addedToStageHandler(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.HIGH;
			stage.frameRate = 48;
			stage.showDefaultContextMenu = false;
			ASSkin.setTheme(AssetData.AS_LIB, new BlackTheme());
			UIManager.setRoot(this);
			_res = RESManager.instance;
			initGame();
		}

		protected function initGame() : void {
		}

		public function Game() {
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
	}
}