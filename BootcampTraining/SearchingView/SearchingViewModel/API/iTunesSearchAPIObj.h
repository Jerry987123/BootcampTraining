//
//  iTunesSearchAPI.h
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/23.
//

#import <AFNetworking/AFNetworking.h>
#import "iTunesSearchAPIResponseResult.h"

@interface iTunesSearchAPIObj : NSObject

{
    void (^_completionHandler)(NSMutableArray<iTunesSearchAPIResponseResult*> *someParameter);
}

-(void) callITunesAPI:(NSString *)apiUrl handler:(void(^)(NSMutableArray<iTunesSearchAPIResponseResult*>*)) handler errorHandler:(void(^)(NSError *)) errorHandler;

@end
