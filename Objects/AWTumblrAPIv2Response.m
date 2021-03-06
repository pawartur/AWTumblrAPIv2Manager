//
//  AWTumblrAPIv2Response.m
//  TumblrAPIV2Manager
//
//  Created by Artur Wdowiarski on 6/29/12.
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

#import "AWTumblrAPIv2Response.h"

static RKObjectMapping *mapping;

@implementation AWTumblrAPIv2Response

@synthesize meta = _meta, response = _response;

+(RKObjectMapping *)mapping{
    if (!mapping) {
        mapping = [RKObjectMapping mappingForClass:[AWTumblrAPIv2Response class]];
        [mapping mapKeyPath:@"meta" toAttribute:@"meta"];
        [mapping mapKeyPath:@"response" toAttribute:@"response"];
    }
    return mapping;
}

@end
