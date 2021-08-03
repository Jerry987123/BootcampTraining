//
//  iTunesSearchAPIResponse.h
//  BootcampTraining
//
//  Created by Jayyi on 2021/7/3.
//

#import <JSONModel/JSONModel.h>
#import "iTunesSearchAPIResponseResult.h"

@interface iTunesSearchAPIResponse : JSONModel
@property (nonatomic) NSArray<iTunesSearchAPIResponseResult *> <iTunesSearchAPIResponseResult> *results;
@end
