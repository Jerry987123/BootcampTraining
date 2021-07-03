//
//  iTunesSearchAPI.h
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/23.
//

#import <AFNetworking/AFNetworking.h>
#import "iTunesSearchAPIResponse.h"
#import "iTunesSearchAPIResponseResult.h"

@interface iTunesSearchAPIObj : NSObject

-(void) callITunesAPI:(NSString *)apiUrl handler:(void(^)(iTunesSearchAPIResponse*)) handler errorHandler:(void(^)(NSError *)) errorHandler;

@end
