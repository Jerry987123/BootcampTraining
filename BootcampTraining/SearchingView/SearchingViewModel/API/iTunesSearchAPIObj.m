//
//  iTunesSearchAPI.m
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/23.
//

#import "iTunesSearchAPIObj.h"

@implementation iTunesSearchAPIObj

- (void) callITunesAPI: (NSString*) apiUrl handler:(void(^)(iTunesSearchAPIResponse*)) handler errorHandler:(void(^)(NSError *)) errorHandler {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:apiUrl
      parameters:nil
         headers:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        iTunesSearchAPIResponse *jsonResponse = [[iTunesSearchAPIResponse alloc] initWithDictionary:responseObject error:nil];
        handler(jsonResponse);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorHandler(error);
    }];
}
@end
