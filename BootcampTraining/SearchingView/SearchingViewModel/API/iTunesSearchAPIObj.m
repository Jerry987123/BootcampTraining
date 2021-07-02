//
//  iTunesSearchAPI.m
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/23.
//

#import "iTunesSearchAPIObj.h"

@implementation iTunesSearchAPIObj

- (void) callITunesAPI: (NSString*) apiUrl handler:(void(^)(NSMutableArray<iTunesSearchAPIResponseResult*>*))handler errorHandler:(void(^)(NSError *)) errorHandler {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:apiUrl
      parameters:nil
         headers:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray <iTunesSearchAPIResponseResult*> *results = [[NSMutableArray alloc] init];
        int i;
        for (i=0; i<[[responseObject objectForKey:@"results"] count];i++) {
            iTunesSearchAPIResponseResult *jsonResponseResult = [[iTunesSearchAPIResponseResult alloc] initWithDictionary: [responseObject objectForKey:@"results"][i] error:nil];
            if (jsonResponseResult != nil) {
                [results addObject:jsonResponseResult];
            }
        }
        handler(results);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorHandler(error);
    }];
}
@end
