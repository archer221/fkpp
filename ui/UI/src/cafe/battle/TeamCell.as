package cafe.battle {
	import com.ui.cell.Cell;
	import com.ui.cell.CellData;
	import com.ui.controls.Label;
	import com.ui.controls.ProgressBar;
	import com.ui.data.LabelData;
	import com.ui.data.ProgressBarData;

	/**
	 * @author Cafe
	 */
	public class TeamCell extends Cell {
		private var _userName : Label;
		private var _hp : ProgressBar;

		public function TeamCell(cellData:CellData) {
			super(cellData);
		}

		override protected function create() : void {
			super.create();
			addLabel();
			addPor();
		}

		private function addPor() : void {
			var data : ProgressBarData = new ProgressBarData();
			data.width = 50;
			_hp = new ProgressBar(data);
			_hp.moveTo(30, 20);
			addChild(_hp);
		}

		private function addLabel() : void {
			var data : LabelData = new LabelData();
			data.text = "我是名字";
			_userName = new Label(data);
			_userName.moveTo(30, 5);
			addChild(_userName);
		}
	}
}
