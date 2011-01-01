package cafe {
	import cafe.battle.BattleView;
	import com.net.LibData;
	import com.net.SWFLoader;
	import com.project.Game;
	import com.ui.controls.Button;
	import com.ui.data.ButtonData;
	import flash.events.Event;
	import flash.events.MouseEvent;




	/**
	 * @author Cafe
	 */
	public class FKPP extends Game {
		private var _openBattle : Button;
		private var _openlogin : Button;
		private var _battleView : BattleView;

		public function FKPP() {
		}

		override protected function initGame() : void {
			_res.add(new SWFLoader(new LibData("assets/ui.swf")));
			_res.add(new SWFLoader(new LibData("assets/fkpp.swf")));
			_res.addEventListener(Event.COMPLETE, completeHandler);
			_res.load();
		}

		private function completeHandler(event : Event) : void {
			var data : ButtonData = new ButtonData();
			data.labelData.text = "打开战斗界面";
			_openBattle = new Button(data);
			addChild(_openBattle);

			data = data.clone();
			data.labelData.text = "打开登陆界面";
			_openlogin = new Button(data);
			addChild(_openlogin);

			initView();
			initEvents();
		}

		private function initView() : void {
			_battleView = new BattleView(this);
			addChild(_battleView);
		}

		private function initEvents() : void {
			_openBattle.addEventListener(MouseEvent.CLICK, openBattleView_handler);
		}

		private function openBattleView_handler(event : MouseEvent) : void {
			_battleView.show();
		}
	}
}
