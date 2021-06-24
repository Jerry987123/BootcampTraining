//
//  iTunesSearchAPIResponseResult.h
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/23.
//

#import <JSONModel/JSONModel.h>

@interface iTunesSearchAPIResponseResult : JSONModel
@property (nonatomic) NSString *trackName;
@property (nonatomic) NSString *artistName;
@property (nonatomic) NSString <Optional> *collectionName;
@property (nonatomic) NSNumber <Optional> *trackTimeMillis;
@property (nonatomic) NSString <Optional> *longDescription;
@property (nonatomic) NSString <Optional> *artworkUrl100;
@end

