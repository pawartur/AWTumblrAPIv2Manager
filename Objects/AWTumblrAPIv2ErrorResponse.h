//
//  AWTumblrAPIv2ErrorResponse.h
//  iPhoneTumblrAPIV2Manager
//
//  Created by Artur Wdowiarski on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AWTumblrAPIv2ErrorResponse : NSObject

@property(nonatomic, strong) NSDictionary *meta;
@property(nonatomic, strong) NSArray *response;

@end
