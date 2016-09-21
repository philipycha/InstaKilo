//
//  Photo.m
//  InstaKilo
//
//  Created by Philip Ha on 2016-09-21.
//  Copyright © 2016 Philip Ha. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithImage:(UIImage*)image Location:(NSString*)location Subject:(NSString*)subject
{
    self = [super init];
    if (self) {
        
        _image = image;
        _location = location;
        _subject = subject;
        
    }
    return self;
}



@end
