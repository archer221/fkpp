package com.ui.data {
	import com.net.AssetData;
	import com.ui.core.ScaleMode;
	import com.ui.core.UIComponentData;
	import com.ui.manager.UIManager;
	import com.ui.skin.SkinStyle;

	/**
	 * @author Cafe
	 * @version 20100317
	 */
	public class ChatTipData extends UIComponentData {

		public var bodyAsset : AssetData;

		public var tailAsset : AssetData;

		public var labelData : LabelData;

		public var gap : int;

		public var timeout : int;

		override protected function parse(source : *) : void {
			super.parse(source);
			var data : ChatTipData = source as ChatTipData;
			if(data == null)return;
			data.bodyAsset = bodyAsset;
			data.tailAsset = tailAsset;
			data.labelData = (labelData == null ? null : labelData.clone());
		}

		public function ChatTipData() {
			scaleMode = ScaleMode.AUTO_SIZE;
			minWidth = 60;
			minHeight = 30;
			maxWidth = 240;
			maxHeight = 200;
			bodyAsset = new AssetData(SkinStyle.chatTip_bodySkin);
			tailAsset = new AssetData(SkinStyle.chatTip_tailSkin);
			labelData = new LabelData();
			labelData.textColor = 0x000000;
			labelData.textFieldFilters = UIManager.getEdgeFilters(0xFFFFFF, 1);
			labelData.textFieldFilters = null;
			labelData.maxLength = 48;
			gap = 7;
			timeout = 10;
		}

		override public function clone() : * {
			var data : ChatTipData = new ChatTipData();
			parse(data);
			return data;
		}
	}
}
