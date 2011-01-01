package com.effects {
	import com.effects.easing.GTween;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;


	/**
	 * Game Fade Effect
	 * 
	 * @author Cafe
	 * @version 20100531
	 */
	public class GFade extends GTweenEffect {

		private var _waitDelay : int;

		private var _alphaFrom : Number = 1;

		private var _alphaTo : Number = 0;

		private var _wait : uint;

		private function startFade() : void {
			if(_wait != 0) {
				clearTimeout(_wait);
				_wait = 0;
			}
			_tween.duration = _duration;
			_target.alpha = _alphaFrom;
			_tween.init(_alphaFrom, _alphaTo);
			_timer.start();
		}

		override protected function timerHandler(event : TimerEvent) : void {
			if(!_tween.isEnd) {
				_target.alpha = _tween.next();
				return;
			}
			_timer.stop();
			dispatchEvent(new Event(END));
		}

		public function GFade(waitDelay : int = 100,duration : int = 30,alphaFrom : Number = 1,alphaTo : Number = 0) {
			_waitDelay = waitDelay;
			_duration = duration;
			_alphaFrom = alphaFrom;
			_alphaTo = alphaTo;
			_tween = new GTween();
		}

		override public function start() : void {
			if(_target == null)return;
			if(_wait != 0) {
				clearTimeout(_wait);
				_wait = 0;
			}
			if(_timer.running) {
				_timer.stop();
			}
			if(_delay > 0) {
				_wait = setTimeout(startFade, _waitDelay);
			} else {
				startFade();
			}
		}
	}
}
