//
//  Photo.m
//  InstaKilo
//
//  Created by Philip Ha on 2016-09-21.
//  Copyright © 2016 Philip Ha. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithLocation:(NSString*)location Subject:(NSString*)subject
{
    self = [super init];
    if (self) {
        
        _location = location;
        _subject = subject;
        
    }
    return self;
}

@end
