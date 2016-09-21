//
//  Photo.h
//  InstaKilo
//
//  Created by Philip Ha on 2016-09-21.
//  Copyright © 2016 Philip Ha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property (nonatomic) NSString* location;
@property (nonatomic) NSString* subject;
@property (nonatomic) UIImage* image;

- (instancetype)initWithImage:(UIImage*)image Location:(NSString*)location Subject:(NSString*)subject;

@end
