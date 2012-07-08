//
//  AWTumblrAPIv2Manager.h
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


#import <Foundation/Foundation.h>
#import "AWTumblrAPIv2Response.h"
#import "AWTumblrAPIv2FlatResponse.h"
#import <RestKit/RestKit.h>
#import "AWTumblrAPIv2ManagerDelegate.h"

typedef enum {
    TumblrPostTypeAny,
    TumblrPostTypeText,
    TumblrPostTypeQuote,
    TumblrPostTypePhoto,
    TumblrPostTypeLink,
    TumblrPostTypeChat,
    TumblrPostTypeVideo,
    TumblrPostTypeAudio,
    TumblrPostTypeAnswer
} TumblrPostType;

typedef enum {
    TumblrPostFilterAny,
    TumblrPostFilterNone,
    TumblrPostFilterText
} TumblrPostFilter;

typedef enum {
    TumblrBlogAvatarSizeDefault,
    TumblrBlogAvatarSize16,
    TumblrBlogAvatarSize24,
    TumblrBlogAvatarSize30,
    TumblrBlogAvatarSize40,
    TumblrBlogAvatarSize48,
    TumblrBlogAvatarSize64,
    TumblrBlogAvatarSize96,
    TumblrBlogAvatarSize128,
    TumblrBlogAvatarSize512
} TumblrBlogAvatarSize;

typedef enum{
    TumblrPostStateDefault,
    TumblrPostStateDraft,
    TumblrPostStateQueue,
    TumblrPostStatePublished
} TumblrPostState;


typedef void(^AWTumblrAPIv2ManagerDidLoadResponse)(AWTumblrAPIv2Response *apiResponse);

@interface AWTumblrAPIv2Manager : NSObject

@property(nonatomic, strong) RKObjectManager *objectManager;

#pragma mark Class Methods
+(AWTumblrAPIv2Manager *)sharedManager;


# pragma mark Helpers
-(NSDictionary *)parseTokensFromQueryString:(NSString *)query;


# pragma mark Authentication
-(void)requestAccessTokensWithConsumerKey:(NSString *)consumerKey andConsumerSecretKey:(NSString *)consumerSecretKey andUsername:(NSString *)username andPassword:(NSString *)password delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate;


# pragma mark API Call with OAuth Authentication
-(void)requestUserInfoWithDelegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(void)requestDashboardWithLimit:(NSNumber *)limit andOffset:(NSNumber *)offset andType:(TumblrPostType)type since:(NSNumber *)since delegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(void)requestPostsLikedByUserWithLimit:(NSNumber *)limit andOffset:(NSNumber *)offset delegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(void)requestBlogsFollowedByUserWithLimit:(NSNumber *)limit andOffset:(NSNumber *)offset delegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(void)followBlogWithURLString:(NSString *)blogURLString delegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(void)unfollowBlogWithURLString:(NSString *)blogURLString delegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(void)requestFollowersForBlogWithName:(NSString *)blogName andLimit:(NSNumber *)limit andOffset:(NSNumber *)offset delegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(void)likePostWithId:(NSNumber *)postId andReblogKey:(NSString *)reblogKey delegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(void)unlikePostWithId:(NSNumber *)postId andReblogKey:(NSString *)reblogKey delegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(void)createTextPostWithTitle:(NSString *)title andBody:(NSString *)body andState:(TumblrPostState)state andTags:(NSArray *)tags inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate;
-(void)reblogPostWithId:(NSNumber *)postId andReblogKey:(NSString *)reblogKey withComment:(NSString *)comment andState:(TumblrPostState)state andTags:(NSArray *)tags inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate;
-(void)editTextPostWithId:(NSNumber *)postId withNewTitle:(NSString *)title andBody:(NSString *)body andState:(TumblrPostState)state andTags:(NSArray *)tags inBlogWithName:(NSString *)blogName usesMarkdown:(BOOL)usesMarkdown delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate;
-(void)deletePostWithId:(NSNumber *)postId inBlogWithName:(NSString *)blogName delegate:(id<AWTumblrAPIv2ManagerDelegate>)delegate;


# pragma mark API Call with API Key Authentication
-(void)requestInfoAboutBlogNamed:(NSString *)blogName delegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(void)requestPostsFromBlogNamed:(NSString *)blogName withLimit:(NSNumber *)limit andOffset:(NSNumber *)offset andType:(TumblrPostType)type andTag:(NSString *)tag andFilter:(TumblrPostFilter)filter delegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;
-(void)requestPostFromBlogNamed:(NSString *)blogName withId:(NSNumber *)postId delegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;

# pragma marga API Call without Authentication
-(void)requestAvatarOfBlogNamed:(NSString *)blogName withSize:(TumblrBlogAvatarSize)size delegate:(id <AWTumblrAPIv2ManagerDelegate>)delegate;

@end
