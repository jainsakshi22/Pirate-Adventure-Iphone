//
//  CCFactory.h
//  PirateGame5Sept
//
//  Created by Sakshi Jain on 06/09/14.
//
//

#import <Foundation/Foundation.h>
#import "CCCharacter.h"
#import "CCBoss.h"

@interface CCFactory : NSObject

-(NSArray *) tiles;
-(CCCharacter *)character;
-(CCBoss *)boss;

@end
