package com.effects {
	import com.effects.easing.GTween;
	import com.effects.easing.Linear;
	import flash.events.TimerEvent;
	import flash.utils.Timer;


	/**
	 * @version 20090901
	 * @author Cafe
	 */
	public class GTweenEffect extends GEffect {

		protected  var _tween : GTween;

		override protected function timerHandler(event : TimerEvent) : void {
		}

		public function GTweenEffect() {
			_timer = new Timer(30);
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
			_tween = new GTween(_duration, Linear.easeIn);
		}
	}
}
