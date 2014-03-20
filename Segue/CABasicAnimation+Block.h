//
//  CABasicAnimation+Block.h
//  Segue
//
//  Created by Bahry Yasin on 16/03/2014.
//  Copyright (c) 2014 FalconsSoft. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef void (^Completion)(void);

@interface CABasicAnimation (Block)

-(void)completionBlock:(Completion)completion;

@end
