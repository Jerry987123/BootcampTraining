//
//  iTunesSearchAPI.m
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/23.
//

#import "iTunesSearchAPI.h"

@implementation iTunesSearchAPI

- (void) callITunesAPI: (NSString*) url {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url
      parameters:nil
         headers:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSError *error;
            iTunesSearchAPIResponse *jsonResponse = [[iTunesSearchAPIResponse alloc] initWithDictionary: responseObject error:&error];
            NSLog(@"%@", jsonResponse);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}
@end
