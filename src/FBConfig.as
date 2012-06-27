package {
	import com.moulin_orange.as3.FB.FbPermission;
	public class FBConfig {
		private static var _instance:FBConfig;
		// App ID/API Key //
		public var API_Key:String = ""; //load from flashVars
		// Secret KEY //
		public const Secret_Key:String = "";
		// CreatAlbumName //
		// LikeURL //
		// PermissionArray //
		public var PermissionArray:Array = [];
		
		///////////////////////// 0725 ///////////////////////// 
		public function FBConfig():void {
		}
		public static function getInstance():FBConfig {
			if ( !_instance ) {
				trace("[FBConfig builded]");
				_instance = new FBConfig();				
			}
			return _instance;
		}
	}
}