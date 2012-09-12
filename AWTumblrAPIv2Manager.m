//
//  AWTumblrAPIv2Manager.m
//  TumblrAPIV1Manager
//
//  Created by Artur Wdowiarski on 6/27/12.
//  Copyright (c) 2012 Artur Wdowiarski. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//


#import "AWTumblrAPIv2Manager.h"
#import <RestKit/RestKit.h>
#import <RestKit/GCOauth.h>
#import "AWTumblrAPIv2Response.h"


#pragma mark URL Strings
NSString * const kBaseAPIv2URLString = @"http://api.tumblr.com/v2/";

NSString * const kBaseXAuthAuthorizationURLString = @"https://www.tumblr.com/";
NSString * const kRelativeAccessTokenURLString = @"/oauth/access_token";

NSString * const kRelativeUserInfoURLString = @"/user/info";

NSString * const kRelativeUserDashboardURLString = @"/user/dashboard";

NSString * const kRelativeUserLikesURLString = @"/user/likes";
NSString * const kRelativeUserLikeURLString = @"/user/like";
NSString * const kRelativeUserUnlikeURLString = @"/user/unlike";

NSString * const kRelativeUserFollowingURLString = @"/user/following";
NSString * const kRelativeUserFollowURLString = @"/user/follow";
NSString * const kRelativeUserUnfollowURLString = @"/user/unfollow";

NSString * const kRelativeBlogFollowersURLStringFormat = @"/blog/%@/followers";
NSString * const kRelativeBlogInfoURLStringFormat = @"/blog/%@/info";
NSString * const kRelativeBlogPostsURLStringFormat = @"/blog/%@/posts";
NSString * const kRelativeBlogAvatarURLStringFormat = @"/blog/%@/avatar/";

NSString * const kRelativeCreatePostURLStringFormat = @"/blog/%@/post";
NSString * const kRelativeReblogPostURLStringFormat = @"/blog/%@/post/reblog";
NSString * const kRelativeEditPostURLStringFormat = @"/blog/%@/post/edit";
NSString * const kRelativeDeletePostURLStringFormat = @"/blog/%@/post/delete";


#pragma mark Request Params Names
NSString * const kXAuthUsernameParamName = @"x_auth_username";
NSString * const kXAuthPasswordParamName = @"x_auth_password";
NSString * const kXAuthModeParamName = @"x_auth_mode";
NSString * const kAPIKeyParamName = @"api_key";

NSString * const kLimitParamName = @"limit";
NSString * const kOffsetParamName = @"offset";
NSString * const kSinceParamName = @"since";

NSString * const kBlogURLParamName = @"url";

NSString * const kPostIdParamName = @"id";
NSString * const kPostReblogKeyParamName = @"reblog_key";
NSString * const kPostTypeParamName = @"type";
NSString * const kPostTitleParamName = @"title";
NSString * const kPostBodyParamName = @"body";
NSString * const kPostDataParamName = @"data";
NSString * const kPostPhotoLinkParamName = @"link";
NSString * const kPostCaptionParamName = @"caption";
NSString * const kPostLinkParamName = @"url";
NSString * const kPostQuoteParamName = @"quote";
NSString * const kPostCitedSourceParamName = @"source";
NSString * const kPostLinkedPageTitleParamName = @"title";
NSString * const kPostDescriptionParamName = @"description";
NSString * const kPostConversationParamName = @"conversation";
NSString * const kPostStateParamName = @"state";
NSString * const kPostTagsParamName = @"tags";
NSString * const kPostAllowsMarkdownParamName = @"markdown";
NSString * const kPostCommentParamName = @"comment";

NSString * const kPostTagParamName = @"tag";
NSString * const kPostFilterParamName = @"filter";


#pragma mark Response Keys
NSString * const kOAuthTokenResponseKey = @"oauth_token";
NSString * const kOAuthTokenSecretResponseKey = @"oauth_token_secret";
NSString * const kStatusResponseKey = @"status";
NSString * const kErrorMessageResponseKey = @"msg";
NSString * const kUserResponseKey = @"user";
NSString * const kPostsResponseKey = @"posts";
NSString * const kPostIdResponseKey = @"id";
NSString * const kBlogAvatarURLResponseKey = @"avatar_url";


@interface AWTumblrAPIv2Manager()

@property(nonatomic, strong, readonly) NSArray *postTypes;
@property(nonatomic, strong, readonly) NSArray *postFilters;
@property(nonatomic, strong, readonly) NSArray *postStates;
@property(nonatomic, strong, readonly) NSArray *blogAvatarSizes;
@property(nonatomic, strong, readonly) NSArray *imageMIMETypes;
@property(nonatomic, strong, readonly) NSArray *videoMIMETypes;
@property(nonatomic, strong, readonly) NSArray *audioMIMETypes;


-(void)callAPIWithURLString:(NSString *)urlString andQueryParams:(NSDictionary *)queryParams andParams:(RKParams *)params andMethod:(RKRequestMethod)method andDidLoadObjectsCallback:(RKObjectLoaderDidLoadObjectsBlock)successCallback andDidFailWithErrorCallback:(RKObjectLoaderDidFailWithErrorBlock)errorCallback andPreRequestCallback:(RKObjectLoaderBlock)preRequestCallback;

-(void)createOrEditPostWithId:(NSNumber *)postId type:(TumblrPostType)type title:(NSString *)title body:(NSString *)body image:(UIImage *)image caption:(NSString *)caption photoLink:(NSString *)photoLink quote:(NSString *)quote citedSource:(NSString *)citedSource link:(NSString *)link linkedPageTitle:(NSString *)linkedPageTitle description:(NSString *)description conversation:(NSString *)conversation audioFile:(NSData *)audioData videoFile:(NSData *)videoData mimeTypeString:(NSString *)mimeType state:(TumblrPostState)state tags:(NSArray *)tags create:(BOOL)create inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown expectFlatResponse:(BOOL)expectFlatResponse delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate;

-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadObjectsBlockWithBlock:(AWTumblrAPIv2ManagerDidLoadResponse)callback;
-(AWTumblrAPIv2ManagerDidLoadResponse)standardOnDidLoadAPIResponseBlockWithDelegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate andSelector:(SEL)selector andExpectedStatusCode:(NSNumber *)statusCode andKeyToGet:(NSString *)responseKey orExtraSelectorParam:(id)extraSelectorParam;

-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadUserInfoBlockWithDelegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadLikedPostsInfoWithDelegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadFollowedBlogsInfoWithDelegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidFollowBlogBlockWithBlogURLString:(NSString *)blogURLString andDelegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidUnfollowBlogBlockWithBlogURLString:(NSString *)blogURLString andDelegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLikePostBlockWithPostId:(NSNumber *)postId andDelegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidUnlikePostBlockWithPostId:(NSNumber *)postId andDelegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadPostsBlockWithDelegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(RKObjectLoaderDidLoadObjectBlock)standardOnDidLoadBlogFollowersBlockWithDelegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;


-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadCreatedPostIdBlockWithDelegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadEditPostIdBlockWithDelegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadDeletePostIdBlockWithDelegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;


-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadBlogInfoBlockWithDelegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadBlogAvatarURLStringBlockWithDelegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;


-(RKObjectLoaderDidFailWithErrorBlock)standardOnDidFailWithErrorBlockWithDelegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(NSString *)hostNameForBlogNamed:(NSString *)blogName;

@end


@implementation AWTumblrAPIv2Manager

@synthesize 
objectManager = _objectManager, 
postTypes = _postTypes, 
postFilters = _postFilters,
postStates = _postStates,
blogAvatarSizes = _blogAvatarSizes,
imageMIMETypes = _imageMIMETypes,
videoMIMETypes = _videoMIMETypes,
audioMIMETypes = _audioMIMETypes;


#pragma mark Class Methods
+(AWTumblrAPIv2Manager *)sharedManager{
    static dispatch_once_t onceToken;
    static AWTumblrAPIv2Manager *manager = nil;
    dispatch_once(&onceToken, ^{
        //RKLogConfigureByName("RestKit/Network*", RKLogLevelTrace);
        //RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
        manager = [[AWTumblrAPIv2Manager alloc] init];
        
        RKObjectManager *objectManager = [RKObjectManager managerWithBaseURLString:kBaseAPIv2URLString];
        
        [objectManager.mappingProvider setMapping:[AWTumblrAPIv2Response mapping] forKeyPath:@""];
        
        [objectManager.mappingProvider setErrorMapping:[AWTumblrAPIv2FlatResponse mapping]];
        
        [RKObjectManager setSharedManager:objectManager];
        manager.objectManager = objectManager;
    });
    return manager;
}


# pragma mark Helpers
-(NSArray *)postTypes{
    // An array of post type params available in the API (the first one is never used)
    if (!_postTypes) {
        // WARNING! This has to correspond to the order in TumblrPostType enum
        _postTypes = [NSArray arrayWithObjects:
                           @"",
                           @"text", 
                           @"quote", 
                           @"photo", 
                           @"link", 
                           @"chat", 
                           @"video", 
                           @"audio",
                           @"answer",
                           nil];
    }
    return _postTypes;
}


-(NSArray *)postFilters{
    // An array of post filter params available in the API (the first one is never used)
    if (!_postFilters) {
        // WARNING! This has to correspond to the order in TumblrPostFilter enum
        _postFilters = [NSArray arrayWithObjects:
                        @"",
                        @"none",
                        @"text",
                        nil];
    }
    return _postFilters;
}


-(NSArray *)postStates{
    // An array of post state params available in the API (the first one is never used)
    if (!_postStates) {
        // WARNING! This has to correspond to the order in TumblrPostState enum
        _postStates = [NSArray arrayWithObjects:
                       @"",
                       @"draft",
                       @"queue",
                       @"published",
                       nil];
    }
    return _postStates;
}


-(NSArray *)blogAvatarSizes{
    // An array of blog avatar sizes available in the API (the first one is never used)
    if (!_blogAvatarSizes) {
        // WARNING! This has to correspond to the order in TumblrAvatarSize enum
        _blogAvatarSizes = [NSArray arrayWithObjects:
                            [NSNumber numberWithInt:0],
                            [NSNumber numberWithInt:16],
                            [NSNumber numberWithInt:24],
                            [NSNumber numberWithInt:30],
                            [NSNumber numberWithInt:40],
                            [NSNumber numberWithInt:48],
                            [NSNumber numberWithInt:64],
                            [NSNumber numberWithInt:96],
                            [NSNumber numberWithInt:128],
                            [NSNumber numberWithInt:512],
                            nil];
    }
    return _blogAvatarSizes;
}


-imageMIMETypes{
    if (!_imageMIMETypes) {
        // WARNING! This has to correspond to the order in AWImageMIMEType enum
        _imageMIMETypes = [NSArray arrayWithObjects:
                           @"image/jpeg", // This is the default mimetype
                           @"image/gif",
                           @"image/jpeg",
                           @"image/png",
                           nil];
    }
    return _imageMIMETypes;
}


-videoMIMETypes{
    if (!_videoMIMETypes) {
        // WARNING! This has to correspond to the order in AWVideoMIMEType enum
        _videoMIMETypes = [NSArray arrayWithObjects:
                           @"video/quicktime", // This is the default mimetype
                           @"video/quicktime",
                           @"video/mp4",
                           @"video/mpeg",
                           nil];
    }
    return _videoMIMETypes;
}


-audioMIMETypes{
    if (!_audioMIMETypes) {
        // WARNING! This has to correspond to the order in AWAudioMIMEType enum
        _audioMIMETypes = [NSArray arrayWithObjects:
                           @"audio/mpeg", // This is the default mimetype
                           @"audio/basic",
                           @"audio/midi",
                           @"audio/mpeg",
                           @"audio/x-wav",
                           nil];
    }
    return _audioMIMETypes;
}


-(void)callAPIWithURLString:(NSString *)urlString andQueryParams:(NSDictionary *)queryParams andParams:(RKParams *)params andMethod:(RKRequestMethod)method andDidLoadObjectsCallback:(RKObjectLoaderDidLoadObjectsBlock)successCallback andDidFailWithErrorCallback:(RKObjectLoaderDidFailWithErrorBlock)errorCallback andPreRequestCallback:(RKObjectLoaderBlock)preRequestCallback{
    [self.objectManager loadObjectsAtResourcePath:[urlString stringByAppendingQueryParameters:queryParams] usingBlock:^(RKObjectLoader *loader){
        loader.method = method;
        loader.params = params;
        loader.onDidLoadObjects = successCallback;
        loader.onDidFailWithError = errorCallback;
        if (preRequestCallback) {
            preRequestCallback(loader);
        }
    }];
}


-(void)createOrEditPostWithId:(NSNumber *)postId type:(TumblrPostType)type title:(NSString *)title body:(NSString *)body image:(UIImage *)image caption:(NSString *)caption photoLink:(NSString *)photoLink quote:(NSString *)quote citedSource:(NSString *)citedSource link:(NSString *)link linkedPageTitle:(NSString *)linkedPageTitle description:(NSString *)description conversation:(NSString *)conversation audioFile:(NSData *)audioData videoFile:(NSData *)videoData mimeTypeString:(NSString *)mimeType state:(TumblrPostState)state tags:(NSArray *)tags create:(BOOL)create inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown expectFlatResponse:(BOOL)expectFlatResponse delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    
    // Prepare POST params
    RKParams *params = [RKParams params];
    
    // Common params
    [params setValue:[[self postTypes] objectAtIndex:type] forParam:kPostTypeParamName];
    if (postId) [params setValue:[postId stringValue] forParam:kPostIdParamName];
    [params setValue:(usesMarkdown ? @"True": @"False") forParam:kPostAllowsMarkdownParamName];
    if (state) [params setValue:[self.postStates objectAtIndex:state] forParam:kPostStateParamName];
    if (tags) [params setValue:[tags componentsJoinedByString:@","] forParam:kPostTagsParamName];
    
    // Common to Text and Chat Posts
    if (title) [params setValue:title forParam:kPostTitleParamName];
    
    // Text Posts
    if (body) [params setValue:body forParam:kPostBodyParamName];
    
    // Chat Posts
    if (conversation) [params setValue:conversation forParam:kPostConversationParamName];
    
    // Common to Photo, Video and Audio Posts
    if (caption) [params setValue:caption forParam:kPostCaptionParamName];
    
    // Photo Posts
    if (image) [params setData:UIImagePNGRepresentation(image) MIMEType:mimeType forParam:kPostDataParamName];
    if (photoLink) [params setValue:photoLink forParam:kPostPhotoLinkParamName];
    
    // Video Posts
    if (videoData) [params setData:videoData MIMEType:mimeType forParam:kPostDataParamName];
    
    // Audio Posts
    if (audioData) [params setData:audioData MIMEType:mimeType  forParam:kPostDataParamName];
    
    // Quote Posts
    if (quote) [params setValue:quote forParam:kPostQuoteParamName];
    if (citedSource) [params setValue:citedSource forParam:kPostCitedSourceParamName];
    
    // Link Posts
    if (link) [params setValue:link forParam:kPostLinkParamName];
    if (linkedPageTitle) [params setValue:linkedPageTitle forParam:kPostLinkedPageTitleParamName];
    if (description) [params setValue:description forParam:kPostDescriptionParamName];
    
    // Set the url and callbacks
    NSString *urlString;
    RKObjectLoaderDidLoadObjectsBlock successCallback;
    RKObjectLoaderBlock preRequestCallback = nil;
    
    if (create) {
        urlString = [NSString stringWithFormat:kRelativeCreatePostURLStringFormat, [self hostNameForBlogNamed:blogName]];   
        successCallback = [self standardOnDidLoadCreatedPostIdBlockWithDelegate:delegate];
    }else {
        urlString = [NSString stringWithFormat:kRelativeEditPostURLStringFormat, [self hostNameForBlogNamed:blogName]];   
        successCallback = [self standardOnDidLoadEditPostIdBlockWithDelegate:delegate];
    }
    
    if (expectFlatResponse) {
        preRequestCallback = ^(RKObjectLoader *loader){
            loader.objectMapping = [AWTumblrAPIv2FlatResponse mapping];
        };
    }

    // Make the request
    [self callAPIWithURLString:urlString
                andQueryParams:nil
                     andParams:params 
                     andMethod:RKRequestMethodPOST 
     andDidLoadObjectsCallback:successCallback
   andDidFailWithErrorCallback:[self standardOnDidFailWithErrorBlockWithDelegate:delegate] 
         andPreRequestCallback:preRequestCallback];
}


-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadObjectsBlockWithBlock:(AWTumblrAPIv2ManagerDidLoadResponse)callback{
    // This is our standard way of interacting with responses from the API: we check, if we actually succeeded
    // with loading a AWTumblrAPIv2Response object from the response and if so, we fire a provided callback with
    // the object as only parameter
    return ^(NSArray *objects){
        if (![objects count]) {
            NSLog(@"Strange... the api manager received a proper response with no data in it.");
            return;
        }
        AWTumblrAPIv2Response *apiResponse = [objects objectAtIndex:0];
        callback(apiResponse);
    };
}


-(AWTumblrAPIv2ManagerDidLoadResponse)standardOnDidLoadAPIResponseBlockWithDelegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate andSelector:(SEL)selector andExpectedStatusCode:(NSNumber *)statusCode andKeyToGet:(NSString *)responseKey orExtraSelectorParam:(id)extraSelectorParam{
    AWTumblrAPIv2ManagerDidLoadResponse block = ^(AWTumblrAPIv2Response *apiResponse){
        // This is our standard way of interacting with AWTumblrAPIv2Response objects
        
        // First we check if we got the expected status code
        if ([[apiResponse.meta valueForKey:kStatusResponseKey] isEqualToNumber:statusCode]) {
            // Then we stop, if the provided delegate doesn't respond to the provided selector
            if (![delegate respondsToSelector:selector]) {
                return;
            }
            id param;
            if (responseKey) {
                // If we want value for some specific key in apiResponse.response, we get it here...
                param = [apiResponse.response valueForKey:responseKey];
            }else if(extraSelectorParam){
                // If we don't want any specific key, maybe we have some extra param to give to selector...
                param = extraSelectorParam;
            }else{
                // ... otherwire we will just pass the apiResponse.response itself as the parameter
                // of the provided selector on our delegate
                param = apiResponse.response;
            }
            // We perform the selector on delegate with current instance of api manager as the first
            // parameter and the second parameter being the object we have just set.
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            // NOTE: It seems to me that we can safely turn off the leak warning in this case,
            // since we're not assigning the return value of the message, so ARC won't have to decide
            // whether to retain or release anything because of this unknown selector.
            [delegate performSelector:selector withObject:self withObject:param];
            #pragma clang diagnostic pop
        }else if ([delegate respondsToSelector:@selector(tumblrAPIv2Manager:didReceiveErrorMessage:)]) {
            // If we didn't get the expected status code, we just call a default error selector
            // on the delegate
            // Note: it would be better to map tumblr's error messages to something else
            [delegate tumblrAPIv2Manager:self didReceiveErrorMessage:[apiResponse.meta valueForKey:kErrorMessageResponseKey]];
        }
    };
    return block;
}


-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadUserInfoBlockWithDelegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    SEL delegateSelector = @selector(tumblrAPIv2Manager:didLoadUserInfo:);
    NSNumber *expectedStatusCode = [NSNumber numberWithInt:200];
    NSString *responseKeyToGet = kUserResponseKey;
    
    AWTumblrAPIv2ManagerDidLoadResponse block = [self standardOnDidLoadAPIResponseBlockWithDelegate:delegate 
                                                                                        andSelector:delegateSelector
                                                                              andExpectedStatusCode:expectedStatusCode
                                                                                        andKeyToGet:responseKeyToGet 
                                                                               orExtraSelectorParam:nil];
    
    return [self standardOnDidLoadObjectsBlockWithBlock:block];
}


-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadLikedPostsInfoWithDelegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    SEL delegateSelector = @selector(tumblrAPIv2Manager:didLoadLikedPostsInfo:);
    NSNumber *expectedStatusCode = [NSNumber numberWithInt:200];
    NSString *responseKeyToGet = nil;
    
    AWTumblrAPIv2ManagerDidLoadResponse block = [self standardOnDidLoadAPIResponseBlockWithDelegate:delegate 
                                                                                        andSelector:delegateSelector
                                                                              andExpectedStatusCode:expectedStatusCode
                                                                                        andKeyToGet:responseKeyToGet 
                                                                               orExtraSelectorParam:nil];
    
    return [self standardOnDidLoadObjectsBlockWithBlock:block];
}


-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadFollowedBlogsInfoWithDelegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    SEL delegateSelector = @selector(tumblrAPIv2Manager:didLoadFollowedBlogsInfo:);
    NSNumber *expectedStatusCode = [NSNumber numberWithInt:200];
    NSString *responseKeyToGet = nil;
    
    AWTumblrAPIv2ManagerDidLoadResponse block = [self standardOnDidLoadAPIResponseBlockWithDelegate:delegate 
                                                                                        andSelector:delegateSelector
                                                                              andExpectedStatusCode:expectedStatusCode
                                                                                        andKeyToGet:responseKeyToGet 
                                                                               orExtraSelectorParam:nil];
    
    return [self standardOnDidLoadObjectsBlockWithBlock:block];
}


-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidFollowBlogBlockWithBlogURLString:(NSString *)blogURLString andDelegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    SEL delegateSelector = @selector(tumblrAPIv2Manager:didFollowBlogWithURLString:);
    NSNumber *expectedStatusCode = [NSNumber numberWithInt:200];
    NSString *responseKeyToGet = nil;
    
    AWTumblrAPIv2ManagerDidLoadResponse block = [self standardOnDidLoadAPIResponseBlockWithDelegate:delegate 
                                                                                        andSelector:delegateSelector
                                                                              andExpectedStatusCode:expectedStatusCode
                                                                                        andKeyToGet:responseKeyToGet 
                                                                               orExtraSelectorParam:blogURLString];
    
    return [self standardOnDidLoadObjectsBlockWithBlock:block];
}


-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidUnfollowBlogBlockWithBlogURLString:(NSString *)blogURLString andDelegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    SEL delegateSelector = @selector(tumblrAPIv2Manager:didUnfollowBlogWithURLString:);
    NSNumber *expectedStatusCode = [NSNumber numberWithInt:200];
    NSString *responseKeyToGet = nil;
    
    AWTumblrAPIv2ManagerDidLoadResponse block = [self standardOnDidLoadAPIResponseBlockWithDelegate:delegate 
                                                                                        andSelector:delegateSelector
                                                                              andExpectedStatusCode:expectedStatusCode
                                                                                        andKeyToGet:responseKeyToGet 
                                                                               orExtraSelectorParam:blogURLString];
    
    return [self standardOnDidLoadObjectsBlockWithBlock:block];
}


-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLikePostBlockWithPostId:(NSNumber *)postId andDelegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    SEL delegateSelector = @selector(tumblrAPIv2Manager:didLikePostWithId:);
    NSNumber *expectedStatusCode = [NSNumber numberWithInt:200];
    NSString *responseKeyToGet = nil;
    
    AWTumblrAPIv2ManagerDidLoadResponse block = [self standardOnDidLoadAPIResponseBlockWithDelegate:delegate 
                                                                                        andSelector:delegateSelector
                                                                              andExpectedStatusCode:expectedStatusCode
                                                                                        andKeyToGet:responseKeyToGet 
                                                                               orExtraSelectorParam:postId];
    return [self standardOnDidLoadObjectsBlockWithBlock:block];
}


-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidUnlikePostBlockWithPostId:(NSNumber *)postId andDelegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    SEL delegateSelector = @selector(tumblrAPIv2Manager:didUnlikePostWithId:);
    NSNumber *expectedStatusCode = [NSNumber numberWithInt:200];
    NSString *responseKeyToGet = nil;
    
    AWTumblrAPIv2ManagerDidLoadResponse block = [self standardOnDidLoadAPIResponseBlockWithDelegate:delegate 
                                                                                        andSelector:delegateSelector
                                                                              andExpectedStatusCode:expectedStatusCode
                                                                                        andKeyToGet:responseKeyToGet 
                                                                               orExtraSelectorParam:postId];
    return [self standardOnDidLoadObjectsBlockWithBlock:block];
}


-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadPostsBlockWithDelegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    SEL delegateSelector = @selector(tumblrAPIv2Manager:didLoadPosts:);
    NSNumber *expectedStatusCode = [NSNumber numberWithInt:200];
    NSString *responseKeyToGet = kPostsResponseKey;
    
    AWTumblrAPIv2ManagerDidLoadResponse block = [self standardOnDidLoadAPIResponseBlockWithDelegate:delegate 
                                                                                        andSelector:delegateSelector
                                                                              andExpectedStatusCode:expectedStatusCode
                                                                                        andKeyToGet:responseKeyToGet 
                                                                               orExtraSelectorParam:nil];
    
    return [self standardOnDidLoadObjectsBlockWithBlock:block];
}


-(RKObjectLoaderDidLoadObjectBlock)standardOnDidLoadBlogFollowersBlockWithDelegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    SEL delegateSelector = @selector(tumblrAPIv2Manager:didLoadBlogFollowersInfo:);
    NSNumber *expectedStatusCode = [NSNumber numberWithInt:200];
    NSString *responseKeyToGet = nil;
    
    AWTumblrAPIv2ManagerDidLoadResponse block = [self standardOnDidLoadAPIResponseBlockWithDelegate:delegate 
                                                                                        andSelector:delegateSelector
                                                                              andExpectedStatusCode:expectedStatusCode
                                                                                        andKeyToGet:responseKeyToGet 
                                                                               orExtraSelectorParam:nil];
    
    return [self standardOnDidLoadObjectsBlockWithBlock:block];
}


-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadCreatedPostIdBlockWithDelegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    SEL delegateSelector = @selector(tumblrAPIv2Manager:didCreatePostWithId:);
    NSNumber *expectedStatusCode = [NSNumber numberWithInt:201];
    NSString *responseKeyToGet = kPostIdResponseKey;
    
    AWTumblrAPIv2ManagerDidLoadResponse block = [self standardOnDidLoadAPIResponseBlockWithDelegate:delegate 
                                                                                        andSelector:delegateSelector
                                                                              andExpectedStatusCode:expectedStatusCode
                                                                                        andKeyToGet:responseKeyToGet 
                                                                               orExtraSelectorParam:nil];
    
    return [self standardOnDidLoadObjectsBlockWithBlock:block];
}


-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadEditPostIdBlockWithDelegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{   
    SEL delegateSelector = @selector(tumblrAPIv2Manager:didEditPostWithId:);
    NSNumber *expectedStatusCode = [NSNumber numberWithInt:200];
    NSString *responseKeyToGet = kPostIdResponseKey;
    
    AWTumblrAPIv2ManagerDidLoadResponse block = [self standardOnDidLoadAPIResponseBlockWithDelegate:delegate 
                                                                                        andSelector:delegateSelector
                                                                              andExpectedStatusCode:expectedStatusCode
                                                                                        andKeyToGet:responseKeyToGet 
                                                                               orExtraSelectorParam:nil];
    
    return [self standardOnDidLoadObjectsBlockWithBlock:block];
}


-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadDeletePostIdBlockWithDelegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{    
    SEL delegateSelector = @selector(tumblrAPIv2Manager:didDeletePostWithId:);
    NSNumber *expectedStatusCode = [NSNumber numberWithInt:200];
    NSString *responseKeyToGet = kPostIdResponseKey;
    
    AWTumblrAPIv2ManagerDidLoadResponse block = [self standardOnDidLoadAPIResponseBlockWithDelegate:delegate 
                                                                                        andSelector:delegateSelector
                                                                              andExpectedStatusCode:expectedStatusCode
                                                                                        andKeyToGet:responseKeyToGet 
                                                                               orExtraSelectorParam:nil];
    
    return [self standardOnDidLoadObjectsBlockWithBlock:block];
}


-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadBlogInfoBlockWithDelegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    SEL delegateSelector = @selector(tumblrAPIv2Manager:didLoadBlogInfo:);
    NSNumber *expectedStatusCode = [NSNumber numberWithInt:200];
    NSString *responseKeyToGet = nil;
    
    AWTumblrAPIv2ManagerDidLoadResponse block = [self standardOnDidLoadAPIResponseBlockWithDelegate:delegate 
                                                                                        andSelector:delegateSelector
                                                                              andExpectedStatusCode:expectedStatusCode
                                                                                        andKeyToGet:responseKeyToGet 
                                                                               orExtraSelectorParam:nil];
    
    return [self standardOnDidLoadObjectsBlockWithBlock:block];
}


-(RKObjectLoaderDidLoadObjectsBlock)standardOnDidLoadBlogAvatarURLStringBlockWithDelegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    SEL delegateSelector = @selector(tumblrAPIv2Manager:didLoadBlogAvatarURLString:);
    NSNumber *expectedStatusCode = [NSNumber numberWithInt:301];
    NSString *responseKeyToGet = kBlogAvatarURLResponseKey;
    
    AWTumblrAPIv2ManagerDidLoadResponse block = [self standardOnDidLoadAPIResponseBlockWithDelegate:delegate 
                                                                                        andSelector:delegateSelector
                                                                              andExpectedStatusCode:expectedStatusCode
                                                                                        andKeyToGet:responseKeyToGet 
                                                                               orExtraSelectorParam:nil];
    
    return [self standardOnDidLoadObjectsBlockWithBlock:block];
}


-(RKObjectLoaderDidFailWithErrorBlock)standardOnDidFailWithErrorBlockWithDelegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    return ^(NSError *error){
        if ([delegate respondsToSelector:@selector(tumblrAPIv2Manager:didFailWithError:)]) {
            [delegate tumblrAPIv2Manager:self didFailWithError:error];
        }
    };
}


-(NSString *)hostNameForBlogNamed:(NSString *)blogName{
    return [NSString stringWithFormat:@"%@.tumblr.com", blogName];
}


-(NSDictionary *)parseTokensFromQueryString:(NSString *)query{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:2];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}


-(NSString *)stringByEscapingHTMLFromString:(NSString *)string{
    NSString *escapedString = [string copy];
    escapedString = [escapedString stringByReplacingOccurrencesOfString:@"&"  withString:@"&amp;"];
    escapedString = [escapedString stringByReplacingOccurrencesOfString:@"<"  withString:@"&lt;"];
    escapedString = [escapedString stringByReplacingOccurrencesOfString:@">"  withString:@"&gt;"];
    escapedString = [escapedString stringByReplacingOccurrencesOfString:@"""" withString:@"&quot;"];    
    escapedString = [escapedString stringByReplacingOccurrencesOfString:@"'"  withString:@"&#039;"];
    return escapedString;
}


# pragma mark Authentication
-(void)requestAccessTokensWithConsumerKey:(NSString *)consumerKey andConsumerSecretKey:(NSString *)consumerSecretKey andUsername:(NSString *)username andPassword:(NSString *)password delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    NSString *path = kRelativeAccessTokenURLString;
    
    // For authentication only we need a manager with different BaseUrl
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURLString:kBaseXAuthAuthorizationURLString];;
    [RKObjectManager setSharedManager:objectManager];
    
    // Prepare the XAuth params
    NSDictionary *params = [NSDictionary dictionaryWithKeysAndObjects:
                            kXAuthUsernameParamName, username, 
                            kXAuthPasswordParamName, password, 
                            kXAuthModeParamName, @"client_auth", 
                            nil];
    
    // Use CGOauth to get a request with properly set headers for our XAuth authentication
    NSURLRequest *xauth = [GCOAuth URLRequestForPath:path
                                      POSTParameters:params
                                                host:[objectManager.client.baseURL host]
                                         consumerKey:consumerKey
                                      consumerSecret:consumerSecretKey
                                         accessToken:nil
                                         tokenSecret:nil];
    
    // Make a RestKit request and rewrite the headers from CGOauth request
    RKRequest *request = [objectManager.client requestWithResourcePath:path];
    NSDictionary *headers = [NSDictionary dictionaryWithKeysAndObjects:
                             @"Authorization", [xauth valueForHTTPHeaderField:@"Authorization"],
                             @"Accept-Encoding", [xauth valueForHTTPHeaderField:@"Accept-Encoding"], nil];
    request.additionalHTTPHeaders = headers;
    
    // Further set up the request
    request.params = params;
    request.method = RKRequestMethodPOST;
    
    // Set up the request for our authentication type
    // In this case there's no authenticationType, because our
    // request is just a regular POST request with all the data
    // needed to retrieve OAuth access tokens
    request.authenticationType = RKRequestAuthenticationTypeNone;
    request.OAuth1ConsumerKey = nil;
    request.OAuth1ConsumerSecret = nil;
    request.OAuth1AccessToken = nil;
    request.OAuth1AccessTokenSecret = nil;
    
    // Define the onDidLoadResponse handler
    request.onDidLoadResponse = ^(RKResponse *response){
        // Get the access tokens
        NSDictionary *accessTokens = [self parseTokensFromQueryString:[response bodyAsString]];
        NSString *accessToken = [accessTokens valueForKey:kOAuthTokenResponseKey];
        NSString *accessTokenSecret = [accessTokens valueForKey:kOAuthTokenSecretResponseKey];
        
        // Return to shared manager with proper BaseURL
        [RKObjectManager setSharedManager:self.objectManager];
        
        // Save all the tokens needed for later OAuth authorization
        self.objectManager.client.OAuth1ConsumerKey = consumerKey;
        self.objectManager.client.OAuth1ConsumerSecret = consumerSecretKey;
        self.objectManager.client.OAuth1AccessToken = accessToken;
        self.objectManager.client.OAuth1AccessTokenSecret = accessTokenSecret;
        self.objectManager.client.authenticationType = RKRequestAuthenticationTypeOAuth1;
        
        // Let the delegate know that we're finished
        if ([delegate respondsToSelector:@selector(tumblrAPIv2Manager:didAuthenticateAndReceivedAccessToken:andAccessTokenSecret:)]) {
            [delegate tumblrAPIv2Manager:self didAuthenticateAndReceivedAccessToken:accessToken andAccessTokenSecret:accessTokenSecret];
        }
    };
    
    // Define the onDidFailLoadWithError handler
    request.onDidFailLoadWithError = [self standardOnDidFailWithErrorBlockWithDelegate:delegate];
    
    // Send the request
    [request send];
}


# pragma mark API Call with OAuth Authentication
-(void)requestUserInfoWithDelegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    [self callAPIWithURLString:kRelativeUserInfoURLString 
                andQueryParams:nil
                     andParams:nil 
                     andMethod:RKRequestMethodPOST 
     andDidLoadObjectsCallback:[self standardOnDidLoadUserInfoBlockWithDelegate:delegate] 
   andDidFailWithErrorCallback:[self standardOnDidFailWithErrorBlockWithDelegate:delegate] 
         andPreRequestCallback:nil];
}

-(void)requestDashboardWithLimit:(NSNumber *)limit andOffset:(NSNumber *)offset andType:(TumblrPostType)type since:(NSNumber *)since delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    // Prepare params
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithCapacity:4];
    if (limit)[queryParams setObject:limit forKey:kLimitParamName];
    if (offset)[queryParams setObject:offset forKey:kOffsetParamName];
    if (type)[queryParams setObject:[self.postTypes objectAtIndex:type] forKey:kPostTypeParamName];
    if (since)[queryParams setObject:since forKey:kSinceParamName];
    
    // Prepare base URL string
    NSString *dashboardURLString = kRelativeUserDashboardURLString;
    
    // Make the request
    [self callAPIWithURLString:dashboardURLString
                andQueryParams:queryParams
                     andParams:nil 
                     andMethod:RKRequestMethodGET 
     andDidLoadObjectsCallback:[self standardOnDidLoadPostsBlockWithDelegate:delegate] 
   andDidFailWithErrorCallback:[self standardOnDidFailWithErrorBlockWithDelegate:delegate] 
         andPreRequestCallback:nil];
}


-(void)requestPostsLikedByUserWithLimit:(NSNumber *)limit andOffset:(NSNumber *)offset delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithCapacity:2];
    if (limit)[queryParams setObject:limit forKey:kLimitParamName];
    if (offset)[queryParams setObject:offset forKey:kOffsetParamName];
    
    // Prepare base URL string
    NSString *likedPostsURLString = kRelativeUserLikesURLString;
    
    // Make the request
    [self callAPIWithURLString:likedPostsURLString
                andQueryParams:queryParams
                     andParams:nil 
                     andMethod:RKRequestMethodGET 
     andDidLoadObjectsCallback:[self standardOnDidLoadLikedPostsInfoWithDelegate:delegate] 
   andDidFailWithErrorCallback:[self standardOnDidFailWithErrorBlockWithDelegate:delegate] 
         andPreRequestCallback:nil];
}


-(void)requestBlogsFollowedByUserWithLimit:(NSNumber *)limit andOffset:(NSNumber *)offset delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithCapacity:2];
    if (limit)[queryParams setObject:limit forKey:kLimitParamName];
    if (offset)[queryParams setObject:offset forKey:kOffsetParamName];
    
    // Prepare base URL string
    NSString *followedBlogsURLString = kRelativeUserFollowingURLString;
    
    // Make the request
    [self callAPIWithURLString:followedBlogsURLString
                andQueryParams:queryParams
                     andParams:nil 
                     andMethod:RKRequestMethodGET 
     andDidLoadObjectsCallback:[self standardOnDidLoadFollowedBlogsInfoWithDelegate:delegate] 
   andDidFailWithErrorCallback:[self standardOnDidFailWithErrorBlockWithDelegate:delegate] 
         andPreRequestCallback:nil];
}


-(void)followBlogWithURLString:(NSString *)blogURLString delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    RKParams *params = [RKParams params];
    [params setValue:blogURLString forParam:kBlogURLParamName];
    // Prepare base URL string
    NSString *followBlogURLString = kRelativeUserFollowURLString;
    
    // Make the request
    [self callAPIWithURLString:followBlogURLString
                andQueryParams:nil
                     andParams:params 
                     andMethod:RKRequestMethodPOST
     andDidLoadObjectsCallback:[self standardOnDidFollowBlogBlockWithBlogURLString:blogURLString 
                                                                       andDelegate:delegate]
   andDidFailWithErrorCallback:[self standardOnDidFailWithErrorBlockWithDelegate:delegate] 
         andPreRequestCallback:^(RKObjectLoader *loader){
             loader.objectMapping = [AWTumblrAPIv2FlatResponse mapping];
         }];
}


-(void)unfollowBlogWithURLString:(NSString *)blogURLString delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    RKParams *params = [RKParams params];
    [params setValue:blogURLString forParam:kBlogURLParamName];
    // Prepare base URL string
    NSString *unfollowBlogURLString = kRelativeUserUnfollowURLString;
    
    // Make the request
    [self callAPIWithURLString:unfollowBlogURLString
                andQueryParams:nil
                     andParams:params 
                     andMethod:RKRequestMethodPOST
     andDidLoadObjectsCallback:[self standardOnDidUnfollowBlogBlockWithBlogURLString:blogURLString                                                                     
                                                                         andDelegate:delegate]
   andDidFailWithErrorCallback:[self standardOnDidFailWithErrorBlockWithDelegate:delegate] 
         andPreRequestCallback:^(RKObjectLoader *loader){
             loader.objectMapping = [AWTumblrAPIv2FlatResponse mapping];
         }];
}


-(void)likePostWithId:(NSNumber *)postId andReblogKey:(NSString *)reblogKey delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    // Prepare POST params
    RKParams *params = [RKParams params];
    [params setValue:[postId stringValue] forParam:kPostIdParamName];
    [params setValue:reblogKey forParam:kPostReblogKeyParamName];
    
    // Prepare base URL string
    NSString *likePostURLString = kRelativeUserLikeURLString;
    
    // Make the request
    [self callAPIWithURLString:likePostURLString
                andQueryParams:nil
                     andParams:params 
                     andMethod:RKRequestMethodPOST
     andDidLoadObjectsCallback:[self standardOnDidLikePostBlockWithPostId:postId andDelegate:delegate]
   andDidFailWithErrorCallback:[self standardOnDidFailWithErrorBlockWithDelegate:delegate] 
         andPreRequestCallback:^(RKObjectLoader *loader){
             loader.objectMapping = [AWTumblrAPIv2FlatResponse mapping];
         }];
}


-(void)unlikePostWithId:(NSNumber *)postId andReblogKey:(NSString *)reblogKey delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    RKParams *params = [RKParams params];
    [params setValue:[postId stringValue] forParam:kPostIdParamName];
    [params setValue:reblogKey forParam:kPostReblogKeyParamName];
    // Prepare base URL string
    NSString *unlikePostURLString = kRelativeUserUnlikeURLString;
    
    // Make the request
    [self callAPIWithURLString:unlikePostURLString
                andQueryParams:nil
                     andParams:params 
                     andMethod:RKRequestMethodPOST
     andDidLoadObjectsCallback:[self standardOnDidUnlikePostBlockWithPostId:postId andDelegate:delegate]
   andDidFailWithErrorCallback:[self standardOnDidFailWithErrorBlockWithDelegate:delegate] 
         andPreRequestCallback:^(RKObjectLoader *loader){
             loader.objectMapping = [AWTumblrAPIv2FlatResponse mapping];
         }];
}


-(void)requestFollowersForBlogWithName:(NSString *)blogName andLimit:(NSNumber *)limit andOffset:(NSNumber *)offset delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    // Prepare params
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithCapacity:2];
    if (limit)[queryParams setObject:limit forKey:kLimitParamName];
    if (offset)[queryParams setObject:offset forKey:kOffsetParamName];

    // Prepare base URL string
    NSString *blogFollowersURLString = [NSString stringWithFormat:kRelativeBlogFollowersURLStringFormat, [self hostNameForBlogNamed:blogName]];
    [self callAPIWithURLString:blogFollowersURLString
                andQueryParams:queryParams
                     andParams:nil 
                     andMethod:RKRequestMethodGET 
     andDidLoadObjectsCallback:[self standardOnDidLoadBlogFollowersBlockWithDelegate:delegate] 
   andDidFailWithErrorCallback:[self standardOnDidFailWithErrorBlockWithDelegate:delegate] 
         andPreRequestCallback:nil];
}


-(void)createTextPostWithTitle:(NSString *)title andBody:(NSString *)body andState:(TumblrPostState)state andTags:(NSArray *)tags inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    
    [self createOrEditPostWithId:nil 
                            type:TumblrPostTypeText 
                           title:title 
                            body:body 
                           image:nil 
                         caption:nil 
                       photoLink:nil 
                           quote:nil 
                     citedSource:nil 
                            link:nil 
                 linkedPageTitle:nil 
                     description:nil
                    conversation:nil
                       audioFile:nil 
                       videoFile:nil 
                  mimeTypeString:nil
                           state:state 
                            tags:tags 
                          create:YES 
                  inBlogWithName:blogName 
                    usesMarkdown:usesMarkdown 
              expectFlatResponse:NO 
                        delegate:delegate];
}


-(void)editTextPostWithId:(NSNumber *)postId withNewTitle:(NSString *)title andNewBody:(NSString *)body andNewState:(TumblrPostState)state andNewTags:(NSArray *)tags inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    
    [self createOrEditPostWithId:postId 
                            type:TumblrPostTypeText 
                           title:title 
                            body:body 
                           image:nil 
                         caption:nil 
                       photoLink:nil 
                           quote:nil 
                     citedSource:nil 
                            link:nil 
                 linkedPageTitle:nil 
                     description:nil 
                    conversation:nil
                       audioFile:nil 
                       videoFile:nil
                  mimeTypeString:nil
                           state:state 
                            tags:tags 
                          create:NO 
                  inBlogWithName:blogName 
                    usesMarkdown:usesMarkdown 
              expectFlatResponse:NO 
                        delegate:delegate];
    
}


-(void)createPhotoPostWithImage:(UIImage *)image andMIMEType:(AWImageMIMEType)mimeType andCaption:(NSString *)caption andLink:(NSString *)link andState:(TumblrPostState)state andTags:(NSArray *)tags inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    
    [self createOrEditPostWithId:nil 
                            type:TumblrPostTypePhoto 
                           title:nil    
                            body:nil 
                           image:image 
                         caption:caption 
                       photoLink:link 
                           quote:nil 
                     citedSource:nil 
                            link:nil 
                 linkedPageTitle:nil 
                     description:nil 
                    conversation:nil
                       audioFile:nil 
                       videoFile:nil 
                  mimeTypeString:[self.imageMIMETypes objectAtIndex:mimeType]
                           state:state 
                            tags:tags 
                          create:YES 
                  inBlogWithName:blogName 
                    usesMarkdown:usesMarkdown 
              expectFlatResponse:NO 
                        delegate:delegate];
}


-(void)editPhotoPostWithId:(NSNumber *)postId withNewImage:(UIImage *)image andNewMIMEType:(AWImageMIMEType)mimeType andNewCaption:(NSString *)caption andNewLink:(NSString*)link andNewState:(TumblrPostState)state andNewTags:(NSArray *)tags inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    
    [self createOrEditPostWithId:postId 
                            type:TumblrPostTypePhoto 
                           title:nil    
                            body:nil 
                           image:image 
                         caption:caption 
                       photoLink:link 
                           quote:nil 
                     citedSource:nil 
                            link:nil 
                 linkedPageTitle:nil 
                     description:nil 
                    conversation:nil
                       audioFile:nil 
                       videoFile:nil
                  mimeTypeString:[self.imageMIMETypes objectAtIndex:mimeType]
                           state:state 
                            tags:tags 
                          create:NO 
                  inBlogWithName:blogName 
                    usesMarkdown:usesMarkdown 
              expectFlatResponse:NO 
                        delegate:delegate];
}


-(void)createAudioPostWithFile:(NSData *)audioData andMIMEType:(AWAudioMIMEType)mimeType andCaption:(NSString *)caption andState:(TumblrPostState)state andTags:(NSArray *)tags inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    
    [self createOrEditPostWithId:nil 
                            type:TumblrPostTypeAudio
                           title:nil    
                            body:nil 
                           image:nil 
                         caption:caption 
                       photoLink:nil 
                           quote:nil 
                     citedSource:nil 
                            link:nil 
                 linkedPageTitle:nil 
                     description:nil 
                    conversation:nil
                       audioFile:audioData 
                       videoFile:nil 
                  mimeTypeString:[self.audioMIMETypes objectAtIndex:mimeType]
                           state:state 
                            tags:tags 
                          create:YES 
                  inBlogWithName:blogName 
                    usesMarkdown:usesMarkdown 
              expectFlatResponse:NO 
                        delegate:delegate];
}


-(void)editAudioPostWithId:(NSNumber *)postId withNewFile:(NSData *)audioData andNewMIMEType:(AWAudioMIMEType)mimeType andNewCaption:(NSString *)caption andNewState:(TumblrPostState)state andNewTags:(NSArray *)tags inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    
    [self createOrEditPostWithId:postId 
                            type:TumblrPostTypeAudio
                           title:nil    
                            body:nil 
                           image:nil 
                         caption:caption 
                       photoLink:nil 
                           quote:nil 
                     citedSource:nil 
                            link:nil 
                 linkedPageTitle:nil 
                     description:nil 
                    conversation:nil
                       audioFile:audioData 
                       videoFile:nil 
                  mimeTypeString:[self.audioMIMETypes objectAtIndex:mimeType]
                           state:state 
                            tags:tags 
                          create:NO 
                  inBlogWithName:blogName 
                    usesMarkdown:usesMarkdown 
              expectFlatResponse:NO 
                        delegate:delegate];
}


-(void)createVideoPostWithFile:(NSData *)videoData andMIMEType:(AWVideoMIMEType)mimeType andCaption:(NSString *)caption andState:(TumblrPostState)state andTags:(NSArray *)tags inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    
    [self createOrEditPostWithId:nil 
                            type:TumblrPostTypeVideo
                           title:nil    
                            body:nil 
                           image:nil 
                         caption:caption 
                       photoLink:nil 
                           quote:nil 
                     citedSource:nil 
                            link:nil 
                 linkedPageTitle:nil 
                     description:nil 
                    conversation:nil
                       audioFile:nil 
                       videoFile:videoData
                  mimeTypeString:[self.videoMIMETypes objectAtIndex:mimeType]
                           state:state 
                            tags:tags 
                          create:YES 
                  inBlogWithName:blogName 
                    usesMarkdown:usesMarkdown 
              expectFlatResponse:NO 
                        delegate:delegate];
}


-(void)editVideoPostWithId:(NSNumber *)postId withNewFile:(NSData *)videoData andNewMIMEType:(AWVideoMIMEType)mimeType andNewCaption:(NSString *)caption andNewState:(TumblrPostState)state andNewTags:(NSArray *)tags inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    
    [self createOrEditPostWithId:postId 
                            type:TumblrPostTypeVideo
                           title:nil    
                            body:nil 
                           image:nil 
                         caption:caption 
                       photoLink:nil 
                           quote:nil 
                     citedSource:nil 
                            link:nil 
                 linkedPageTitle:nil 
                     description:nil 
                    conversation:nil
                       audioFile:nil 
                       videoFile:videoData
                  mimeTypeString:[self.videoMIMETypes objectAtIndex:mimeType]
                           state:state 
                            tags:tags 
                          create:NO 
                  inBlogWithName:blogName 
                    usesMarkdown:usesMarkdown 
              expectFlatResponse:NO 
                        delegate:delegate];
}


-(void)createQuotePostWithQuote:(NSString *)quote andCitedSource:(NSString *)source andState:(TumblrPostState)state andTags:(NSArray *)tags inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    
    [self createOrEditPostWithId:nil 
                            type:TumblrPostTypeQuote
                           title:nil    
                            body:nil 
                           image:nil 
                         caption:nil 
                       photoLink:nil 
                           quote:quote 
                     citedSource:source 
                            link:nil 
                 linkedPageTitle:nil 
                     description:nil 
                    conversation:nil
                       audioFile:nil 
                       videoFile:nil 
                  mimeTypeString:nil
                           state:state 
                            tags:tags 
                          create:YES 
                  inBlogWithName:blogName 
                    usesMarkdown:usesMarkdown 
              expectFlatResponse:NO 
                        delegate:delegate];
}


-(void)editQuotePostWithId:(NSNumber *)postId withNewQuote:(NSString *)quote andNewCitedSource:(NSString *)source andNewState:(TumblrPostState)state andNewTags:(NSArray *)tags inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    
    [self createOrEditPostWithId:postId 
                            type:TumblrPostTypeQuote
                           title:nil    
                            body:nil 
                           image:nil 
                         caption:nil 
                       photoLink:nil 
                           quote:quote 
                     citedSource:source 
                            link:nil 
                 linkedPageTitle:nil 
                     description:nil 
                    conversation:nil
                       audioFile:nil 
                       videoFile:nil 
                  mimeTypeString:nil
                           state:state 
                            tags:tags 
                          create:NO 
                  inBlogWithName:blogName 
                    usesMarkdown:usesMarkdown 
              expectFlatResponse:NO 
                        delegate:delegate];
}


-(void)createLinkPostWithLink:(NSString *)link andLinkedPageTitle:(NSString *)title andDescription:(NSString *)description andState:(TumblrPostState)state andTags:(NSArray *)tags inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    
    [self createOrEditPostWithId:nil 
                            type:TumblrPostTypeLink
                           title:nil    
                            body:nil 
                           image:nil 
                         caption:nil 
                       photoLink:nil 
                           quote:nil 
                     citedSource:nil 
                            link:link 
                 linkedPageTitle:title 
                     description:description 
                    conversation:nil
                       audioFile:nil 
                       videoFile:nil 
                  mimeTypeString:nil
                           state:state 
                            tags:tags 
                          create:YES 
                  inBlogWithName:blogName 
                    usesMarkdown:usesMarkdown 
              expectFlatResponse:NO 
                        delegate:delegate];
}


-(void)editLinkPostWithId:(NSNumber *)postId withNewLink:(NSString *)link andNewLinkedPageTitle:(NSString *)title andNewDescription:(NSString *)description andNewState:(TumblrPostState)state andNewTags:(NSArray *)tags inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{

    [self createOrEditPostWithId:postId 
                            type:TumblrPostTypeLink
                           title:nil    
                            body:nil 
                           image:nil 
                         caption:nil 
                       photoLink:nil 
                           quote:nil 
                     citedSource:nil 
                            link:link 
                 linkedPageTitle:title 
                     description:description 
                    conversation:nil
                       audioFile:nil 
                       videoFile:nil 
                  mimeTypeString:nil
                           state:state 
                            tags:tags 
                          create:NO 
                  inBlogWithName:blogName 
                    usesMarkdown:usesMarkdown 
              expectFlatResponse:NO 
                        delegate:delegate];
}


-(void)createChatPostWithConversation:(NSString *)conversation andTitle:(NSString *)title andState:(TumblrPostState)state andTags:(NSArray *)tags inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    
    [self createOrEditPostWithId:nil 
                            type:TumblrPostTypeChat
                           title:nil    
                            body:nil 
                           image:nil 
                         caption:nil 
                       photoLink:nil 
                           quote:nil 
                     citedSource:nil 
                            link:nil 
                 linkedPageTitle:title 
                     description:nil 
                    conversation:conversation
                       audioFile:nil 
                       videoFile:nil 
                  mimeTypeString:nil
                           state:state 
                            tags:tags 
                          create:YES 
                  inBlogWithName:blogName 
                    usesMarkdown:usesMarkdown 
              expectFlatResponse:NO 
                        delegate:delegate];
}


-(void)editChatPostWithId:(NSNumber *)postId withNewConversation:(NSString *)conversation andNewTitle:(NSString *)title andNewState:(TumblrPostState)state andNewTags:(NSArray *)tags inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    
    [self createOrEditPostWithId:postId 
                            type:TumblrPostTypeChat
                           title:nil    
                            body:nil 
                           image:nil 
                         caption:nil 
                       photoLink:nil 
                           quote:nil 
                     citedSource:nil 
                            link:nil 
                 linkedPageTitle:title 
                     description:nil 
                    conversation:conversation
                       audioFile:nil 
                       videoFile:nil 
                  mimeTypeString:nil
                           state:state 
                            tags:tags 
                          create:NO 
                  inBlogWithName:blogName 
                    usesMarkdown:usesMarkdown 
              expectFlatResponse:NO 
                        delegate:delegate];
}


-(void)reblogPostWithId:(NSNumber *)postId andReblogKey:(NSString *)reblogKey withComment:(NSString *)comment andState:(TumblrPostState)state andTags:(NSArray *)tags inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    RKParams *params = [RKParams params];
    [params setValue:[postId stringValue] forParam:kPostIdParamName];
    [params setValue:reblogKey forParam:kPostReblogKeyParamName];
    [params setValue:comment forParam:kPostCommentParamName];
    [params setValue:(usesMarkdown ? @"True": @"False") forParam:kPostAllowsMarkdownParamName];
    if (state) [params setValue:[self.postStates objectAtIndex:state] forParam:kPostStateParamName];
    if (tags) [params setValue:[tags componentsJoinedByString:@","] forParam:kPostTagsParamName];
    
    NSString *reblogPostURLString = [NSString stringWithFormat:kRelativeReblogPostURLStringFormat, [self hostNameForBlogNamed:blogName]];   
    [self callAPIWithURLString:reblogPostURLString
                andQueryParams:nil
                     andParams:params 
                     andMethod:RKRequestMethodPOST 
     andDidLoadObjectsCallback:[self standardOnDidLoadCreatedPostIdBlockWithDelegate:delegate] 
   andDidFailWithErrorCallback:[self standardOnDidFailWithErrorBlockWithDelegate:delegate] 
         andPreRequestCallback:nil];
}


-(void)deletePostWithId:(NSNumber *)postId inBlogWithName:(NSString *)blogName delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    // Prepare POST params
    RKParams *params = [RKParams params];
    [params setValue:[postId stringValue] forParam:kPostIdParamName];
    
    NSString *deletePostURLString = [NSString stringWithFormat:kRelativeDeletePostURLStringFormat, [self hostNameForBlogNamed:blogName]];
    [self callAPIWithURLString:deletePostURLString
                andQueryParams:nil
                     andParams:params 
                     andMethod:RKRequestMethodPOST 
     andDidLoadObjectsCallback:[self standardOnDidLoadDeletePostIdBlockWithDelegate:delegate] 
   andDidFailWithErrorCallback:[self standardOnDidFailWithErrorBlockWithDelegate:delegate] 
         andPreRequestCallback:nil];
}


# pragma mark API Call with API Key Authorization
-(void)requestInfoAboutBlogNamed:(NSString *)blogName delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    // Add the api_key param, since we're not authenticating with oauth in this case
    NSDictionary *queryParams = [NSDictionary dictionaryWithKeysAndObjects:
                                 kAPIKeyParamName, self.objectManager.client.OAuth1ConsumerKey,
                                 nil];
    
    // Make the request
    NSString *blogInfoURLString = [NSString stringWithFormat:kRelativeBlogInfoURLStringFormat, [self hostNameForBlogNamed:blogName]];
    [self callAPIWithURLString:blogInfoURLString
                andQueryParams:queryParams
                     andParams:nil 
                     andMethod:RKRequestMethodGET 
     andDidLoadObjectsCallback:[self standardOnDidLoadBlogInfoBlockWithDelegate:delegate] 
   andDidFailWithErrorCallback:[self standardOnDidFailWithErrorBlockWithDelegate:delegate] 
         andPreRequestCallback:nil];
}


-(void)requestPostsFromBlogNamed:(NSString *)blogName withLimit:(NSNumber *)limit andOffset:(NSNumber *)offset andType:(TumblrPostType)type andTag:(NSString *)tag andFilter:(TumblrPostFilter)filter delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    // Prepare params
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithCapacity:6];
    if (limit)[queryParams setObject:limit forKey:kLimitParamName];
    if (offset)[queryParams setObject:offset forKey:kOffsetParamName];
    if (type)[queryParams setObject:[self.postTypes objectAtIndex:type] forKey:kPostTypeParamName];
    if (tag)[queryParams setObject:tag forKey:kPostTagParamName];
    if (filter)[queryParams setObject:[self.postFilters objectAtIndex:type] forKey:kPostFilterParamName];
    // Also add the api_key param, since we're not authenticating with oauth in this case
    [queryParams setObject:self.objectManager.client.OAuth1ConsumerKey forKey:kAPIKeyParamName];
    
    // Make the request
    NSString *postsURLString = [NSString stringWithFormat:kRelativeBlogPostsURLStringFormat, [self hostNameForBlogNamed:blogName]];
    [self callAPIWithURLString:postsURLString
                andQueryParams:queryParams
                     andParams:nil 
                     andMethod:RKRequestMethodGET 
     andDidLoadObjectsCallback:[self standardOnDidLoadPostsBlockWithDelegate:delegate] 
   andDidFailWithErrorCallback:[self standardOnDidFailWithErrorBlockWithDelegate:delegate] 
         andPreRequestCallback:nil];
}


-(void)requestPostFromBlogNamed:(NSString *)blogName withId:(NSNumber *)postId delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    // Prepare params
    NSDictionary *queryParams = [NSDictionary dictionaryWithKeysAndObjects:
                                 kPostIdParamName, postId,
                                 kAPIKeyParamName, self.objectManager.client.OAuth1ConsumerKey,
                                 nil];
    // Make the request
    NSString *postsURLString = [NSString stringWithFormat:kRelativeBlogPostsURLStringFormat, [self hostNameForBlogNamed:blogName]];
    [self callAPIWithURLString:postsURLString
                andQueryParams:queryParams
                     andParams:nil 
                     andMethod:RKRequestMethodGET 
     andDidLoadObjectsCallback:[self standardOnDidLoadPostsBlockWithDelegate:delegate] 
   andDidFailWithErrorCallback:[self standardOnDidFailWithErrorBlockWithDelegate:delegate] 
         andPreRequestCallback:nil];
}


# pragma mark API Call without Authentication
-(void)requestAvatarOfBlogNamed:(NSString *)blogName withSize:(TumblrBlogAvatarSize)size delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate{
    // Make the request
    NSString *blogInfoURLString = [NSString stringWithFormat:kRelativeBlogAvatarURLStringFormat, [self hostNameForBlogNamed:blogName]];
    if (size) {
        blogInfoURLString = [blogInfoURLString stringByAppendingFormat:@"%@", [self.blogAvatarSizes objectAtIndex:size]];
    }
    // This time we'll get a response with the needed url in body
    // and status code 301. It will be a redirect to that url.
    // We don't want to follow it. We just need the url.
    [self callAPIWithURLString:blogInfoURLString
                andQueryParams:nil
                     andParams:nil 
                     andMethod:RKRequestMethodGET 
     andDidLoadObjectsCallback:[self standardOnDidLoadBlogAvatarURLStringBlockWithDelegate:delegate] 
   andDidFailWithErrorCallback:[self standardOnDidFailWithErrorBlockWithDelegate:delegate] 
         andPreRequestCallback:^(RKObjectLoader *loader){loader.followRedirect = NO;}];
}

@end
