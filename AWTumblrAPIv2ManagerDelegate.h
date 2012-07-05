//
//  AWTumblrAPIv2ManagerDelegate.h
//  TumblrAPIV2Manager
//
//  Created by Artur Wdowiarski on 6/28/12.
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

@class AWTumblrAPIv2Manager;

@protocol AWTumblrAPIv2ManagerDelegate <NSObject>

-(void)tumblrAPIv2Manager:(AWTumblrAPIv2Manager *)manager didAuthenticateAndReceivedAccessToken:(NSString *)accessToken andAccessTokenSecret:(NSString *)accessTokenSecret;

-(void)tumblrAPIv2Manager:(AWTumblrAPIv2Manager *)manager didLoadUserInfo:(NSDictionary *)userInfo;
-(void)tumblrAPIv2Manager:(AWTumblrAPIv2Manager *)manager didLoadPosts:(NSArray *)posts;
-(void)tumblrAPIv2Manager:(AWTumblrAPIv2Manager *)manager didLoadLikedPostsInfo:(NSDictionary *)likedPostsInfo;
-(void)tumblrAPIv2Manager:(AWTumblrAPIv2Manager *)manager didLoadFollowedBlogsInfo:(NSDictionary *)followedBlogsInfo;
-(void)tumblrAPIv2Manager:(AWTumblrAPIv2Manager *)manager didFollowBlogWithURLString:(NSString *)blogURLString;
-(void)tumblrAPIv2Manager:(AWTumblrAPIv2Manager *)manager didUnfollowBlogWithURLString:(NSString *)blogURLString;
-(void)tumblrAPIv2Manager:(AWTumblrAPIv2Manager *)manager didBlogFollowersInfo:(NSDictionary *)blogFollowersInfo;
-(void)tumblrAPIv2Manager:(AWTumblrAPIv2Manager *)manager didCreatePostWithId:(NSNumber *)postId;
-(void)tumblrAPIv2Manager:(AWTumblrAPIv2Manager *)manager didEditPostWithId:(NSNumber *)postId;
-(void)tumblrAPIv2Manager:(AWTumblrAPIv2Manager *)manager didDeletePostWithId:(NSNumber *)postId;
-(void)tumblrAPIv2Manager:(AWTumblrAPIv2Manager *)manager didLoadBlogInfo:(NSDictionary *)blogInfo;
-(void)tumblrAPIv2Manager:(AWTumblrAPIv2Manager *)manager didLoadBlogAvatarURLString:(NSString *)urlString;
-(void)tumblrAPIv2Manager:(AWTumblrAPIv2Manager *)manager didReceiveErrorMessage:(NSString *)message;
-(void)tumblrAPIv2Manager:(AWTumblrAPIv2Manager *)manager didFailWithError:(NSError *)error;

@end
