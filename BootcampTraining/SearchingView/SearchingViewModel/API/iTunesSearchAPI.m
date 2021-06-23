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
        int i;
        for (i=0; i<[[responseObject objectForKey:@"results"] count];i++) {
            iTunesSearchAPIResponseResult *jsonResponseResult = [[iTunesSearchAPIResponseResult alloc] initWithDictionary: [responseObject objectForKey:@"results"][i] error:nil];
            NSLog(@"%@", jsonResponseResult.trackName);
            NSLog(@"%@", jsonResponseResult.artistName);
            NSLog(@"%@", jsonResponseResult.collectionName);
            NSLog(@"%ld", (long)jsonResponseResult.trackTimeMillis);
//            NSLog(@"%@", jsonResponseResult.longDescription);
            
            NSLog(@"---------------");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}
@end
