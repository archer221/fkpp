package cafe.core {
	import flash.display.Sprite;

	import com.ui.containers.Panel;
	import com.ui.data.PanelData;

	/**
	 * @author Cafe
	 */
	public class Message extends Panel {
		public function Message(parent : Sprite) {
			_data = new PanelData();
			_data.parent = parent;
			super(_data);
		}
	}
}
