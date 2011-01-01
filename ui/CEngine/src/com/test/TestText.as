package com.test {
	import com.net.LibData;
	import com.net.SWFLoader;
	import com.project.Game;
	import com.ui.controls.ChatTip;
	import com.ui.data.ChatTipData;
	import flash.events.Event;


	/**
	 * @version 20091101
	 * @author Cafe
	 */
	[SWF(width=1000,height=570,backgroundColor=0x003399,frameRate=30)]

	public class TestText extends Game {

		private var _chat_tip : ChatTip;

		override protected function initGame() : void {
			_res.add(new SWFLoader(new LibData("assets/ui.swf")));
			_res.addEventListener(Event.COMPLETE, completeHandler);
			_res.load();
		}

		private function completeHandler(event : Event) : void {
			graphics.beginFill(0xFF0000,1);
			graphics.drawRect(0, 0, 100,100);
			graphics.endFill();
			testGLabel();
		}

		private function testGLabel() : void {
			var data : ChatTipData = new ChatTipData();
			data.x = 100;
			data.y = 100;
			data.maxWidth = 110;
			_chat_tip = new ChatTip(data);
			_chat_tip.text = "一二三四五六七八九十";
			addChild(_chat_tip);
		}

		public function TestText() {
			super();
		}
	}
}
