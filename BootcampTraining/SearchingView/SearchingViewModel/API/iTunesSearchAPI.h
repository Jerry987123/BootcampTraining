//
//  iTunesSearchAPI.h
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/23.
//

#import <AFNetworking/AFNetworking.h>
#import "iTunesSearchAPIResponseResult.h"

@interface iTunesSearchAPI : NSObject

- (void) callITunesAPI: (NSString*) url;

@end
