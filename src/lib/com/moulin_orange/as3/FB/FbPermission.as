package com.moulin_orange.as3.FB {
	/**
	 * https://developers.facebook.com/docs/authentication/permissions/
	 * Last update: 2012/06/26
	 * @link https://developers.facebook.com/docs/authentication/permissions/
	 * @update 2012/06/26
	 */
	public class FbPermission {
		/**
		 * ////////////////////////////
		 * User and Friends Permissions
		 * ////////////////////////////
		 */

		/**
		 * Provides access to the "About Me" section of the profile in the about property
		 */
		public static const USER_ABOUT_ME:String = "user_about_me";
		public static const FRIENDS_ABOUT_ME:String = "friends_about_me";

		/**
		 * Provides access to the user's list of activities as the activities connection
		 */
		public static const USER_ACTIVITIES:String = "user_activities";
		public static const FRIENDS_ACTIVITIES:String = "friends_activities";

		/**
		 * Provides access to the birthday with year as the birthday property
		 */
		public static const USER_BIRTHDAY:String = "user_birthday";
		public static const FRIENDS_BIRTHDAY:String = "friends_birthday";

		/**
		 * Provides read access to the authorized user's check-ins or a friend's check-ins that the user can see. This permission is superseded by user_status for new applications as of March, 2012.
		 */
		public static const USER_CHECKINS:String = "user_checkins";
		public static const FRIENDS_CHECKINS:String = "friends_checkins";

		/**
		 * Provides access to education history as the education property
		 */
		public static const USER_EDUCATION_HISTORY:String = "user_education_history";
		public static const FRIENDS_EDUCATION_HISTORY:String = "friends_education_history";

		/**
		 * Provides access to the list of events the user is attending as the events connection
		 */
		public static const USER_EVENTS:String = "user_events";
		public static const FRIENDS_EVENTS:String = "friends_events";

		/**
		 * Provides access to the list of groups the user is a member of as the groups connection
		 */
		public static const USER_GROUPS:String = "user_groups";
		public static const FRIENDS_GROUPS:String = "friends_groups";

		/**
		 * Provides access to the user's list of interests as the interests connection
		 */
		public static const USER_HOMETOWN:String = "user_hometown";
		public static const FRIENDS_HOMETOWN:String = "friends_hometown";

		/**
		 * Provides access to the list of all of the pages the user has liked as the likes connection
		 */
		public static const USER_INTERESTS:String = "user_interests";
		public static const FRIENDS_INTERESTS:String = "friends_interests";

		/**
		 * Provides access to the list of all of the pages the user has liked as the likes connection
		 */
		public static const USER_LIKES:String = "user_likes";
		public static const FRIENDS_LIKES:String = "friends_likes";

		/**
		 * Provides access to the user's current location as the location property
		 */
		public static const USER_LOCATION:String = "user_location";
		public static const FRIENDS_LOCATION:String = "friends_location";

		/**
		 * Provides access to the user's notes as the notes connection
		 */
		public static const USER_NOTES:String = "user_notes";
		public static const FRIENDS_NOTES:String = "friends_notes";

		/**
		 * Provides access to the photos the user has uploaded, and photos the user has been tagged in
		 */
		public static const USER_PHOTOS:String = "user_photos";
		public static const FRIENDS_PHOTOS:String = "friends_photos";

		/**
		 * Provides access to the questions the user or friend has asked
		 */
		public static const USER_QUESTIONS:String = "user_questions";
		public static const FRIENDS_QUESTIONS:String = "friends_questions";

		/**
		 * Provides access to the user's family and personal relationships and relationship status
		 */
		public static const USER_RELATIONSHIPS:String = "user_relationships";
		public static const FRIENDS_RELATIONSHIPS:String = "friends_relationships";

		/**
		 * Provides access to the user's relationship preferences
		 */
		public static const USER_RELATIONSHIP_DETAILS:String = "user_relationship_details";
		public static const FRIENDS_RELATIONSHIP_DETAILS:String = "friends_relationship_details";

		/**
		 * Provides access to the user's religious and political affiliations
		 */
		public static const USER_RELIGION_POLITICS:String = "user_religion_politics";
		public static const FRIENDS_RELIGION_POLITICS:String = "friends_religion_politics";

		/**
		 * Provides access to the user's status messages and checkins. Please see the documentation for the location_post table for information on how this permission may affect retrieval of information about the locations associated with posts.
		 */
		public static const USER_STATUS:String = "user_status";
		public static const FRIENDS_STATUS:String = "friends_status";

		/**
		 * Provides access to the user's subscribers and subscribees
		 */
		public static const USER_SUBSCRIPTIONS:String = "user_subscriptions";
		public static const FRIENDS_SUBSCRIPTIONS:String = "friends_subscriptions";

		/**
		 * Provides access to the videos the user has uploaded, and videos the user has been tagged in
		 */
		public static const USER_VIDEOS:String = "user_videos";
		public static const FRIENDS_VIDEOS:String = "friends_videos";

		/**
		 * Provides access to the user's web site URL
		 */
		public static const USER_WEBSITE:String = "user_website";
		public static const FRIENDS_WEBSITE:String = "friends_website";

		/**
		 * Provides access to work history as the work property
		 */
		public static const USER_WORK_HISTORY:String = "user_work_history";
		public static const FRIENDS_WORK_HISTORY:String = "friends_work_history";

		/**
		 * Provides access to the user's primary email address in the email property. Do not spam users. Your use of email must comply both with Facebook policies and with the CAN-SPAM Act.
		 */
		public static const EMAIL:String = "email";

		/**
		 * ////////////////////
		 * Extended Permissions
		 * ////////////////////
		 */

		/**
		 * Provides access to any friend lists the user created. All user's friends are provided as part of basic data, this extended permission grants access to the lists of friends a user has created, and should only be requested if your application utilizes lists of friends.
		 */
		public static const READ_FRIENDLISTS:String = "read_friendlists";

		/**
		 * Provides read access to the Insights data for pages, applications, and domains the user owns.
		 */
		public static const READ_INSIGHTS:String = "read_insights";

		/**
		 * Provides the ability to read from a user's Facebook Inbox.
		 */
		public static const READ_MAILBOX:String = "read_mailbox";

		/**
		 * Provides read access to the user's friend requests
		 */
		public static const READ_REQUESTS:String = "read_requests";

		/**
		 * Provides access to all the posts in the user's News Feed and enables your application to perform searches against the user's News Feed
		 */
		public static const READ_STREAM:String = "read_stream";

		/**
		 * Provides applications that integrate with Facebook Chat the ability to log in users.
		 */
		public static const XMPP_LOGIN:String = "xmpp_login";

		/**
		 * Provides the ability to manage ads and call the Facebook Ads API on behalf of a user.
		 */
		public static const ADS_MANAGEMENT:String = "ads_management";

		/**
		 * Enables your application to create and modify events on the user's behalf
		 */
		public static const CREATE_EVENT:String = "create_event";

		/**
		 * Enables your app to create and edit the user's friend lists.
		 */
		public static const MANAGE_FRIENDLISTS:String = "manage_friendlists";

		/**
		 * Enables your app to read notifications and mark them as read. Intended usage: This permission should be used to let users read and act on their notifications; it should not be used to for the purposes of modeling user behavior or data mining. Apps that misuse this permission may be banned from requesting it.
		 */
		public static const MANAGE_NOTIFICATIONS:String = "manage_notifications";

		/**
		 * Provides access to the user's online/offline presence
		 */
		public static const USER_ONLINE_PRESENCE:String = "user_online_presence";

		/**
		 * Provides access to the user's friend's online/offline presence
		 */
		public static const FRIENDS_ONLINE_PRESENCE:String = "friends_online_presence";

		/**
		 * Enables your app to perform checkins on behalf of tohe user.
		 */
		public static const PUBLISH_CHECKINS:String = "publish_checkins";

		/**
		 * Enables your app to post content, comments, and likes to a user's stream and to the streams of the user's friends. This is a superset publishing permission which also includes publish_actions. However, please note that Facebook recommends a user-initiated sharing model. Please read the Platform Policies to ensure you understand how to properly use this permission. Note, you do not need to request the publish_stream permission in order to use the Feed Dialog, the Requests Dialog or the Send Dialog.
		 */
		public static const PUBLISH_STREAM:String = "publish_stream";

		/**
		 * Enables your application to RSVP to events on the user's behalf
		 */
		public static const RSVP_EVENT:String = "rsvp_event";

		/**
		 * //////////////////////
		 * Open Graph Permissions
		 * //////////////////////
		 */

		/**
		 * Allows your app to publish to the Open Graph using Built-in Actions, Achievements, Scores, or Custom Actions. Your app can also publish other activity which is detailed in the Publishing Permissions doc. Note: The user-prompt for this permission will be displayed in the first screen of the Enhanced Auth Dialog and cannot be revoked as part of the authentication flow. However, a user can later revoke this permission in their Account Settings. If you want to be notified if this happens, you should subscribe to the permissions object within the Realtime API.
		 */
		public static const PUBLISH_ACTIONS:String = "publish_actions";

		/**
		 * Allows you to retrieve the actions published by all applications using the built-in music.listens action.
		 */
		public static const USER_ACTIONS_MUSIC:String = "user_actions.music";
		public static const FRIENDS_ACTIONS_MUSIC:String = "friends_actions.music";

		/**
		 * Allows you to retrieve the actions published by all applications using the built-in news.reads action.
		 */
		public static const USER_ACTIONS_NEWS:String = "user_actions.news";
		public static const FRIENDS_ACTIONS_NEWS:String = "friends_actions.news";

		/**
		 * Allows you to retrieve the actions published by all applications using the built-in video.watches action.
		 */
		public static const USER_ACTIONS_VIDEO:String = "user_actions.video";
		public static const FRIENDS_ACTIONS_VIDEO:String = "friends_actions.video";

		/**
		 * Allows you retrieve the actions published by another application as specified by the app namespace. For example, to request the ability to retrieve the actions published by an app which has the namespace awesomeapp, prompt the user for the users_actions:awesomeapp and/or friends_actions:awesomeapp permissions.
		 */
		public static const USER_ACTIONS_APP_NAMESPACE:String = "user_actions:APP_NAMESPACE";
		public static const FRIENDS_ACTIONS_APP_NAMESPACE:String = "friends_actions:APP_NAMESPACE";

		/**
		 * Allows you post and retrieve game achievement activity.
		 */
		public static const USER_GAMES_ACTIVITY:String = "user_games_activity";
		public static const FRIENDS_GAMES_ACTIVITY:String = "friends_games_activity";

		/**
		 * ////////////////
		 * Page Permissions
		 * ////////////////
		 */

		/**
		 * Enables your application to retrieve access_tokens for Pages and Applications that the user administrates. The access tokens can be queried by calling /<user_id>/accounts via the Graph API. This permission is only compatible with the Graph API, not the deprecated REST API.See here for generating long-lived Page access tokens that do not expire after 60 days.
		 */
		public static const MANAGE_PAGES:String = "manage_pages";
	}
}
