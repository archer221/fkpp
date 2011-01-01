package com.effects {
	import flash.events.Event;
	
	public class TweenerEvent extends Event
	{
		public static const MOTION_START:String="motionStart";
		
		public static const MOTION_FINISH:String = 'motionFinish';
		
		public var time:Number = NaN;
		
		public var position:Number = NaN;
		
		public function TweenerEvent(type:String, time:Number, position:Number, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
			this.time = time;
			this.position = position;
		}
	}
}