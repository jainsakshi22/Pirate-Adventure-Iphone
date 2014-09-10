//
//  CCViewController.m
//  PirateGame5Sept
//
//  Created by Sakshi Jain on 05/09/14.
//
//

#import "CCViewController.h"
#import "CCFactory.h"
#import "CCTile.h"

@interface CCViewController ()

@end

@implementation CCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CCFactory *factory = [[CCFactory alloc] init];
    self.tiles = [factory tiles];
    self.character = [factory character];
    self.boss = [factory boss];
    
    [self updateCharacterStatsForArmor:nil withWeapons:nil withHealthEffect:0];
    NSLog(@"%@", self.tiles);
    self.currentPoint = CGPointMake(0, 0);
    [self updateTile];
    [self updateButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -helper methods

-(void)updateTile
{
    CCTile *tile = [[self.tiles objectAtIndex: self.currentPoint.x] objectAtIndex:self.currentPoint.y];
    self.storyLabel.text = tile.story;
    self.backgroundImageView.image = tile.backgroundImage;
    self.healthLabel.text = [NSString stringWithFormat: @"%i",self.character.health];
    self.damageLabel.text = [NSString stringWithFormat:@"%i", self.character.damage];
    self.weaponLabel.text = self.character.weapon.name;
    self.armorLabel.text = self.character.armor.name;
    [self.actionButton setTitle: tile.actionButtonName forState: UIControlStateNormal];
    
}

-(void)updateButtons
{
    self.northButton.hidden = [self tileExistAtPoint: CGPointMake(self.currentPoint.x, self.currentPoint.y+1)];
    self.westButton.hidden = [self tileExistAtPoint: CGPointMake(self.currentPoint.x-1, self.currentPoint.y)];
    self.southButton.hidden = [self tileExistAtPoint: CGPointMake(self.currentPoint.x, self.currentPoint.y-1)];
    self.eastButton.hidden = [self tileExistAtPoint:CGPointMake(self.currentPoint.x+1, self.currentPoint.y)];
}


-(BOOL)tileExistAtPoint :(CGPoint) myPoint
{
    if ( myPoint.x >=0 && myPoint.y >=0 && myPoint.x < [self.tiles count] && myPoint.y < [[self.tiles objectAtIndex:myPoint.x] count] )
    {
        return NO;
    }
    else
    {
    return YES;
    }
}

-(void)updateCharacterStatsForArmor : (CCArmor *)armor withWeapons : (CCWeapon *)weapon withHealthEffect: (int)health
{
    if(armor !=NULL)
    {
        self.character.health = self.character.health - self.character.armor.health +armor.health;
        self.character.armor = armor;
    }
    else if (weapon !=NULL)
    {
        self.character.damage = self.character.damage - self.character.weapon.damage + weapon.damage;
        self.character.weapon = weapon;
    }
    else if (health !=0)
    {
        self.character.health = self.character.health + health;
    }
    else
    {
        self.character.health = self.character.health +armor.health;
        self.character.damage = self.character.damage+ weapon.damage;

    }
}


#pragma mark - IBAction

- (IBAction)actionButtonPressed:(UIButton *)sender
{
    CCTile *tile = [[self.tiles objectAtIndex:self.currentPoint.x] objectAtIndex:self.currentPoint.y];
    if((tile.healthEffect == -15))
    {
        self.boss.health = self.boss.health - self.character.damage;
    }
    
    [self updateCharacterStatsForArmor:tile.armor withWeapons:tile.weapon withHealthEffect:tile.healthEffect];
    
    if (self.character.health <=0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Death Message" message:@"You have died, Please restart the game" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else if(self.boss.health <=0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Victory Message" message:@"You have defeated the evil pirate boss" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    [self updateTile];
    
}

- (IBAction)northButtonPressed:(UIButton *)sender
{
    self.currentPoint = CGPointMake(self.currentPoint.x,self.currentPoint.y+1);
    [self updateTile];
    [self updateButtons];
}

- (IBAction)westButtonPressed:(UIButton *)sender
{
    self.currentPoint = CGPointMake(self.currentPoint.x-1,self.currentPoint.y);
    [self updateButtons];
    [self updateTile];
}

- (IBAction)southButtonPressed:(UIButton *)sender
{
    self.currentPoint = CGPointMake(self.currentPoint.x,self.currentPoint.y-1);
    [self updateTile];
    [self updateButtons];
}

- (IBAction)eastButtonPressed:(UIButton *)sender
{
    self.currentPoint = CGPointMake(self.currentPoint.x+1, self.currentPoint.y);
    [self updateTile];
    [self updateButtons];
}

- (IBAction)resetButtonPressed:(UIButton *)sender
{
    self.character = nil;
    self.boss = nil;
    [self viewDidLoad];
}
@end
