//
//  CCCharacter.h
//  PirateGame5Sept
//
//  Created by Sakshi Jain on 08/09/14.
//
//

#import <Foundation/Foundation.h>
#import "CCWeapon.h"
#import "CCArmor.h"

@interface CCCharacter : NSObject

@property (strong,nonatomic) CCWeapon *weapon;
@property (strong,nonatomic) CCArmor *armor;
@property (nonatomic) int health;
@property (nonatomic) int damage;

@end
