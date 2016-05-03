#define CHECK_NULL_STRING(str) ([str isKindOfClass:[NSNull class]])?@"":str;

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#define kStatusBarHeight 20
#define kDefaultToolbarHeight 40
#define kKeyboardHeightPortrait 216
#define kKeyboardHeightLandscape 140

#define TRIM(string) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]


#define NAVBARCOLOR  [UIColor colorWithRed:189.0/255 green:57.0/255 blue:49.0/255 alpha:1.0]
#define NAV_FONT_COLOR [UIColor colorWithRed:191.0/255 green:186.0/255 blue:177.0/255 alpha:1.0]
#define BG_COLOR [UIColor colorWithRed:227.0/255 green:222.0/255 blue:214.0/255 alpha:1.0]

#define SEP_COLOR [UIColor colorWithRed:127.0/255 green:126.0/255 blue:120.0/255 alpha:1.0]
#define BTN_BORDER_COLOR [UIColor colorWithRed:124.0/255 green:117.0/255 blue:102.0/255 alpha:1.0]



#define DARK_ThemeColor @"014852"
#define LIGHT_ThemeColor @"0393A6"

#define  FONT_NAV_NAME @"Helvetica"
#define FONT_COLOR [UIColor colorWithRed:168.0/255 green:168.0/255 blue:168.0/255 alpha:1.0]
#define PLACEHOLDERCOLOR @"aeaeae"
#define FONT_LBL_REG @"Helvetica-Light"

#define HEIGHT_IPHONE_5 568
#define IS_IPHONE   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds ].size.height == HEIGHT_IPHONE_5)
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width


#define LOGIN_TYPE [[NSUserDefaults standardUserDefaults]integerForKey:@"LoginType"]

#define REMEMBER_USER [[NSUserDefaults standardUserDefaults]boolForKey:@"RememberMe"]

#define FONT_SIZE 13.0
#define CELL_CONTENT_MARGIN 15.0f
#define TEXTLABELORIGINY 74.0


#define NSUSERDEFAULT     [NSUserDefaults standardUserDefaults]

#define TOKEN [[NSUserDefaults standardUserDefaults]valueForKey:@"token"]
#define USER_ID [[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"]

#define KEY_TOKEN @"token"
#define KEY_USERID @"user_id"
#define KEY_CRITERIA_SELECTION @"Criteria_Selection"
// Webservice Macros

#define WEBSERVICE_URL @"http://192.168.1.100:86/tunedinn/index.php"  // live
#define LOGIN_Key @"login"
#define REG_Key @"signup"
#define FORGOTPWD_Key @"forgotpassword"
#define GETCOUNTRIES @"listallcountry"
#define GETCITIES @"listallcity"
#define GET_ALL_PROFESSION @"professions"
#define SET_PROFESSION @"setprofession"
#define SET_ABOUTME @"setaboutme"
#define GET_PROFILE @"getprofile"
#define ADD_POST @"addworkorpost"
#define GET_NEWSFEED @"GetWorkOrNewsfeedByUser"
#define LIKE_UNLIKE @"AddLikeOrUnLike"
#define GET_ALL_FEED @"GetNewsFeeds"
#define GET_MATCHES @"GetMatches"
#define SEARCH_USER @"SearchUser"
#define GET_COMMENT @"GetCommentList"
#define ADD_COMMENT @"AddComment"
#define ADD_FRIEND @"AddFriendRequest"
#define GET_ALL_FRNDS @"GetFriendList"
#define GET_ALL_NOTIFICATION @"GetNotification"
#define ACCEPT_REJECT_REQ @"AcceprOrRejectRequest"
#define UPDATE_PROFILE @"setuserprofile"


#define NOTIFICATION_RECEIVED_MESSGAE @"MessageReceived"
#define NOTIFICATION_CHANGE_LANG @"LangChange"

