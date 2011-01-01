package com.test {
	import com.net.AssetData;
	import com.net.LibData;
	import com.net.SWFLoader;
	import com.project.Game;
	import com.ui.controls.Poster;
	import com.ui.core.Align;
	import com.ui.core.UIComponentData;
	import com.utils.BDUtil;
	import flash.events.Event;


	/**
	 * @version 20100115
	 * @author Cafe
	 */
	public class TestPoster extends Game {

		private var _poster : Poster;

		override protected function initGame() : void {
			_res.add(new SWFLoader(new LibData("assets/ui.swf")));
			_res.add(new SWFLoader(new LibData("assets/mapThumbs.swf")));
			_res.addEventListener(Event.COMPLETE, completeHandler);
			_res.load();
		}

		private function completeHandler(event : Event) : void {
			testGPoster();
		}

		private function testGPoster() : void {
			var data : UIComponentData = new UIComponentData();
			data.width = 120;
			data.height = 90;
			data.align = Align.CENTER;
			_poster = new Poster(data);
			addChild(_poster);
			_poster.model.source = [BDUtil.getBD(new AssetData("t_0", "mapThumbs")),BDUtil.getBD(new AssetData("t_1", "mapThumbs"))];
			_poster.selectionModel.index = 1;
		}

		public function TestPoster() {
		}
	}
}
