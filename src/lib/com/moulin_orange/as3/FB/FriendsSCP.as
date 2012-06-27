package com.moulin_orange.as3.FB{
	import com.moulin_orange.as3.display.ScrollPage;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author eia
	 */
	[Embed(source = '../../shell.swf', symbol = 'swc_friendsSCP')]
	public class FriendsSCP extends ScrollPage {
		public var mContent:MovieClip;
		public var mMask:MovieClip;
		public var ibar:MovieClip;
		public var il:MovieClip;
		public function FriendsSCP():void {
			mMask.visible = false;
			ibar.ib.enableReleaseOutside = true;
			il.visible = false;
			ibar.ib.visible = false;
			new scBMC()
		}
		public function startRend():void {
			mMask.visible = true;
			rend(mContent, mMask, ibar.ib);
			il.visible = ibar.ib.visible;
		}
	}
}