package com.test {
	import com.net.LibData;
	import com.net.SWFLoader;
	import com.project.Game;
	import com.ui.controls.TextArea;
	import com.ui.data.TextAreaData;
	import flash.events.Event;
	import flash.events.TextEvent;


	/**
	 * @version 20100115
	 * @author Cafe
	 */
	[SWF(width=1000,height=570,backgroundColor=0x003399,frameRate=30)]

	public class TestTextArea extends Game {

		override protected function initGame() : void {
			_res.add(new SWFLoader(new LibData("assets/ui.swf")));
			_res.addEventListener(Event.COMPLETE, completeHandler);
			_res.load();
		}

		private function completeHandler(event : Event) : void {
			var data : TextAreaData = new TextAreaData();
			data.styleSheet.parseCSS(".blue{color:#FFFF00}");
			data.x = 10;
			data.y = 50;
			data.width = 320;
			data.height = 240;
			data.selectable = true;
			var ta : TextArea = new TextArea(data);
			ta.appendHtmlText("<a href='event:hello'>hello</a>");
			addChild(ta);
			ta.textField.addEventListener(TextEvent.LINK, linkHandler);
		}

		private function linkHandler(event : TextEvent) : void {
			trace(event.text);
		}
	}
}
