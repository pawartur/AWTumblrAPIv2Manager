# AWTumblrAPIv2Manager

This is a wrapper aroung RestKit that enables easy creation requests and handling of responses from the Tumblr v2 API.
The main aim is to make the manager's interface as transparent as possible, so that knowing how the Tumblr's API works
would be sufficient to use the manager.

It requires RestKit 0.10.0.

It currently supports (see the manager's header file for details):
- authentication via XAuth!
- /user/info
- /user/dashboard
- /user/likes
- /user/following
- /user/follow
- /user/unfollow
- /user/like
- /user/unlike
- /blog/{base-hostname}/post
- /blog/{base-hostname}/post/reblog
- /blog/{base-hostname}/post/edit
- /blog/{base-hostname}/delete
- /blog/{base-hostname}/info
- /blog/{base-hostname}/followers
- /blog/{base-hostname}/posts
- /blog/{base-hostname}/avatar

Remaining problems:
- creating/editing a post so that it uses markdown doesn't seem to work

## Usage

* Install RestKit!

Got to RestKit's GitHub page and follow the installation instructions. This manager has been written for and tested with RestKit 0.10.0.

* Get the sharedManager instance and use it to get access tokens from Tumblr

```objective-c
[[AWTumblrAPIv2Manager sharedManager] requestAccessTokensWithConsumerKey:@"consumerKeyYouGotFromTumblr" 
                                                        andConsumerSecretKey:@"consumerSecretYouGotFromTumblr" 
                                                                 andUsername:@"tumblrUsername" 
                                                                 andPassword:@"tumblrPasswordForUsername" 
                                                                    delegate:aDelegate];
```

* check if you successfully received the tokens by implementing the tumblrAPIv2Manager:didAuthenticateAndReceivedAccessToken:andAccessTokenSecret: method in your delegate

```objective-c
-(void)tumblrAPIv2Manager:(AWTumblrAPIv2Manager *)manager didAuthenticateAndReceivedAccessToken:(NSString *)accessToken andAccessTokenSecret:(NSString *)accessTokenSecret{
    NSLog(@"I can now use the [AWTumblrAPIv2Manager sharedManager] to get data from Tumblr's API!");
}
```

* if the sharedManager fails with its request, the tumblrAPIv2Manager:didFailWithError: method of the delegate will be called.

```objective-c
-(void)tumblrAPIv2Manager:(AWTumblrAPIv2Manager *)manager didFailWithError:(NSError *)error{
    NSLog(@"We failed with error %@", error);
}
```

* implement other AWTumblrAPIv2ManagerDelegate methods and make other API calls with sharedManager, depending on your needs.

* if the manager get an error message from the Tumblr API, the  method tumblrAPIv2Manager:didReceiveErrorMessage: of the delegate will be called

```objective-c
-(void)tumblrAPIv2Manager:(AWTumblrAPIv2Manager *)manager didReceiveErrorMessage:(NSString *)message{
    NSLog(@"Received error message %@", message);
}
```
