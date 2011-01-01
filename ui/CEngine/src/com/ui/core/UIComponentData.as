package com.ui.core {
	import com.effects.GEffect;
	import com.ui.controls.ToolTip;
	import com.ui.data.ToolTipData;
	import flash.display.DisplayObjectContainer;


	/**
	 * Game Component Data
	 * 
	 * @author Cafe
	 * @version 20100724
	 */
	public class UIComponentData {

		public var parent : DisplayObjectContainer;

		public var x : int = 0;

		public var y : int = 0;

		public var width : int = 0;

		public var height : int = 0;

		public var alpha : Number = 1;

		public var enabled : Boolean = true;

		public var visible : Boolean = true;

		public var minWidth : int = 0;

		public var minHeight : int = 0;

		public var maxWidth : int = 2880;

		public var maxHeight : int = 1000;

		public var scaleMode : int = ScaleMode.SCALE9GRID;

		public var align : Align;

		public var filters : Array;

		public var showEffect : GEffect;

		public var hideEffect : GEffect;

		public var toolTip : Class = ToolTip;

		public var toolTipData : ToolTipData;

		protected function parse(source : *) : void {
			var data : UIComponentData = source as UIComponentData;
			if(data == null)return;
			data.parent = parent;
			data.x = x;
			data.y = y;
			data.width = width;
			data.height = height;
			data.alpha = alpha;
			data.enabled = enabled;
			data.visible = visible;
			data.minWidth = minWidth;
			data.minHeight = minHeight;
			data.maxWidth = maxWidth;
			data.maxHeight = maxHeight;
			data.scaleMode = scaleMode;
			data.align = (align != null ? align.clone() : null);
			data.filters = (filters ? filters.concat() : null);
			data.showEffect = showEffect;
			data.hideEffect = hideEffect;
			data.toolTip = toolTip;
			data.toolTipData = (toolTipData != null ? toolTipData.clone() : null);
		}

		public function UIComponentData() {
		}

		public function fix() : void {
		}

		public function clone() : * {
			var data : UIComponentData = new UIComponentData();
			parse(data);
			return data;
		}
	}
}
