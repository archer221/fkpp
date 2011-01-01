package com.utils {
	import com.color.ARGB;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;


	/**
	 * @version 20100115
	 * @author Cafe
	 */
	public class GColorUtil {

		/**
		 * @param rgb uint Original RGB color.
		 * @param brite Number -255 to 255.
		 * @return New RGB color.
		 */
		public static function adjustBrightness(rgb : uint, brite : Number) : uint {
			brite = Math.max(-255, Math.min(255, brite));
			var r : Number = Math.max(Math.min(((rgb >> 16) & 0xFF) + brite, 255), 0);
			var g : Number = Math.max(Math.min(((rgb >> 8) & 0xFF) + brite, 255), 0);
			var b : Number = Math.max(Math.min((rgb & 0xFF) + brite, 255), 0);
			return (r << 16) | (g << 8) | b;
		} 

		/**
		 * @param rgb uint Original RGB color.
		 * @param brite Number -100 to 100.
		 * @return New RGB color.
		 */
		public static function adjustBrightness2(rgb : uint,brite : Number) : uint {
			brite = Math.max(-100, Math.min(100, brite));
			var r : Number;
			var g : Number;
			var b : Number;
			if(brite == 0)return rgb;
			if(brite < 0) {
				brite = (100 + brite) / 100;
				r = ((rgb >> 16) & 0xFF) * brite;
				g = ((rgb >> 8) & 0xFF) * brite;
				b = (rgb & 0xFF) * brite;
			} else {
				brite /= 100;
				r = ((rgb >> 16) & 0xFF);
				g = ((rgb >> 8) & 0xFF);
				b = (rgb & 0xFF);
				r += ((0xFF - r) * brite);
				g += ((0xFF - g) * brite);
				b += ((0xFF - b) * brite);
				r = Math.min(r, 255);
				g = Math.min(g, 255);
				b = Math.min(b, 255);
			}
			return (r << 16) | (g << 8) | b;
		}

		public static function rgbMultiply(rgb1 : uint,rgb2 : uint) : uint {
			var r1 : Number = (rgb1 >> 16) & 0xFF;
			var g1 : Number = (rgb1 >> 8) & 0xFF;
			var b1 : Number = rgb1 & 0xFF;
			
			var r2 : Number = (rgb2 >> 16) & 0xFF;
			var g2 : Number = (rgb2 >> 8) & 0xFF;
			var b2 : Number = rgb2 & 0xFF;

			return ((r1 * r2 / 255) << 16) | ((g1 * g2 / 255) << 8) | (b1 * b2 / 255);
		}

		public static function changeBDColor(bd : BitmapData,color : uint) : void {
			bd.colorTransform(bd.rect, getColorTransform(color));
		}

		public static function getColorTransform(color : uint) : ColorTransform {
			var argb : ARGB = ARGB.hexToArgb(color);
			var rm : Number = argb.red / 255;
			var gm : Number = argb.green / 255;
			var bm : Number = argb.blue / 255;
			return new ColorTransform(rm, gm, bm, 1, 0, 0, 0, 0);
		}
	}
}