package com.ui.data {
	import com.color.ARGB;
	import com.ui.core.UIComponentData;
	import flash.text.StyleSheet;


	/**
	 * @author Cafe
	 * @version 20100321
	 */
	public class StatsData extends UIComponentData {

		public var bgColor : uint;

		public var fpsColor : uint;

		public var msColor : uint;

		public var memColor : uint;

		public var maxMemColor : uint;

		public var css : StyleSheet;

		public function StatsData() {
			width = 70;
			height = 100;
			bgColor = 0x000033;
			fpsColor = 0xffff00;
			msColor = 0x00ff00;
			memColor = 0x00ffff;
			maxMemColor = 0xff0070;
			css = new StyleSheet();
			css.setStyle("xml", {fontSize:'9px', fontFamily:'_sans', leading:'-2px'});
			css.setStyle("fps", {color:ARGB.hexToCSS(fpsColor)});
			css.setStyle("ms", {color:ARGB.hexToCSS(msColor)});
			css.setStyle("mem", {color:ARGB.hexToCSS(memColor)});
			css.setStyle("maxMem", {color:ARGB.hexToCSS(maxMemColor)});
		}
	}
}
