package 
{
	import com.adobe.serialization.json.JSON;
	import com.moulin_orange.as3.FB.FBHandler;
	import com.moulin_orange.as3.FB.FbPermission;
	import com.moulin_orange.as3.test.TestButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	/**
	 * ...
	 * @author EIA
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			Trace2("1717");
			Trace2(ExternalInterface.available);
			if (ExternalInterface.available == true){
				FBConfig.getInstance().API_Key = "321760657913063"; // recommend from FlashVars
				FBConfig.getInstance().PermissionArray = [FbPermission.USER_STATUS]; // ex:FbPermission.EMAIL
				FBHandler.getInstance().setFacebook();
				//
				FBHandler.getInstance().afterLogin = function():void {
					FBHandler.getInstance().getFriends();
				}
				FBHandler.getInstance().addEventListener(FBHandler.FB_GET_FRIENDS, _fbGetFriendsHandler);
			}
			_demo();
		}
		private function _demo():void {
			var testBtn:TestButton = addChild(new TestButton()) as TestButton;
			testBtn.msgTxt = "click login FB";
			testBtn.onClick = function():void {
				if (FBHandler.getInstance().isLogin == false) {
					if (ExternalInterface.available == true){
						FBHandler.getInstance().doLogIn();
					}
				}
			}
		}
		private function _fbGetFriendsHandler(evt:Event):void {
			Trace2("_fbGetFriendsHandler");
			Trace2(FBHandler.getInstance().friendArray);
			Trace2("------------------");
			var frArray:Array  = FBHandler.getInstance().friendArray;
			var friendNum:uint = frArray.length;
			for (var i:int = 0; i < friendNum; i++) {
				//Trace2(JSON.encode(frArray[i]));
				//Trace2("--");
				if (frArray[i].gender == "female") {
					Trace2(JSON.encode(frArray[i]));
					Trace2("--");
				}
			};
		}
	}
}