package cafe.chat {
	import cafe.core.Command;
	import com.net.AssetData;
	import com.ui.containers.Panel;
	import com.ui.controls.Button;
	import com.ui.controls.TextInput;
	import com.ui.data.ButtonData;
	import com.ui.data.PanelData;
	import com.ui.data.TextInputData;
	import com.ui.skin.SkinStyle;
	import flash.display.Sprite;



	/**
	 * @author Cafe
	 */
	public class ChatView extends Panel {
		private var _chatMode : Button;
		private var _inputText : TextInput;
		private var _openFriendsList : Button;
		private var _openFaceList : Button;
		private var _utilMessages : Button;

		public function ChatView(parent : Sprite) {
			_data = new PanelData();
			_data.parent = parent;
			initData();
			super(_data);
			addButtons();
			addInput();
		}

		private function addInput() : void {
			var data : TextInputData = new TextInputData();
			data.text = "我是输入框......";
			data.width = 305;
			data.height = 16;
			data.borderAsset = new AssetData(SkinStyle.emptySkin);
			_inputText = new TextInput(data);
			_inputText.moveTo(69, 10);
			addChild(_inputText);
		}

		private function addButtons() : void {
			var data : ButtonData = new ButtonData();
			data.width = 39;
			data.height = 19;
			data.x = 18;
			data.y = 8;
			data.upAsset = new AssetData("ChatpersonUPButton", Command.Skin_FKPP);
			data.downAsset = new AssetData("ChatpersonOverButton", Command.Skin_FKPP);
			data.overAsset = new AssetData("ChatpersonOverButton", Command.Skin_FKPP);
			_chatMode = new Button(data);
			addChild(_chatMode);

			data = data.clone();
			data.upAsset = new AssetData("ChatGroupUPButton", Command.Skin_FKPP);
			data.downAsset = new AssetData("ChatGroupUPButton", Command.Skin_FKPP);
			data.overAsset = new AssetData("ChatGroupOverButton", Command.Skin_FKPP);
			data.x = 390;
			data.width = 21;
			data.height = 20;
			_openFriendsList = new Button(data);
			addChild(_openFriendsList);

			data = data.clone();
			data.upAsset = new AssetData("sendMessUPButton", Command.Skin_FKPP);
			data.downAsset = new AssetData("sendMessUPButton", Command.Skin_FKPP);
			data.overAsset = new AssetData("sendMessOverButton", Command.Skin_FKPP);
			data.x = 414;
			_utilMessages = new Button(data);
			addChild(_utilMessages);

			data = data.clone();
			data.upAsset = new AssetData("ChatfaceUPButton", Command.Skin_FKPP);
			data.downAsset = new AssetData("ChatfaceUPButton", Command.Skin_FKPP);
			data.overAsset = new AssetData("ChatfaceOverButton", Command.Skin_FKPP);
			data.x = 439;
			_openFaceList = new Button(data);
			addChild(_openFaceList);
		}

		private function initData() : void {
			_data.bgAsset = new AssetData("ChatBG", Command.Skin_FKPP);
			_data.width = 484;
			_data.height = 33;
		}
	}
}
