package com.effects {
	import com.core.IDispose;
	import flash.display.Sprite;


	/**
	 * @author Cafe
	 */
	public interface IGEffect extends IDispose {

		function set target(target : Sprite) : void;

		function start() : void;

		function end() : void;
	}
}
