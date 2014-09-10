//
//  CCTile.h
//  PirateGame5Sept
//
//  Created by Sakshi Jain on 06/09/14.
//
//

#import <Foundation/Foundation.h>
#import "CCWeapon.h"
#import "CCArmor.h"

@interface CCTile : NSObject

@property (strong,nonatomic) NSString *story;
@property (strong,nonatomic) UIImage *backgroundImage;
@property (strong,nonatomic) NSString *actionButtonName;
@property (strong,nonatomic) CCArmor *armor;
@property (strong,nonatomic) CCWeapon *weapon;
@property (nonatomic) int healthEffect;

@end
