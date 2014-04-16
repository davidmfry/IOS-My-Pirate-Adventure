//
//  DF_ViewController.h
//  My Pirate Adventure
//
//  Created by David Fry on 4/15/14.
//  Copyright (c) 2014 David Fry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DF_ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *healthLabel;
@property (strong, nonatomic) IBOutlet UILabel *damageLabel;
@property (strong, nonatomic) IBOutlet UILabel *weaponLabel;
@property (strong, nonatomic) IBOutlet UILabel *armorLabel;
@property (strong, nonatomic) IBOutlet UILabel *storyLabel;
@property (nonatomic) CGPoint currentLoc;

// Direction button properties used to hide the button
@property (strong, nonatomic) IBOutlet UIButton *northBtnProp;
@property (strong, nonatomic) IBOutlet UIButton *eastBtnProp;
@property (strong, nonatomic) IBOutlet UIButton *southBtnProp;
@property (strong, nonatomic) IBOutlet UIButton *westBtnProp;


- (IBAction)actionButton:(id)sender;
- (IBAction)resetButton:(id)sender;
- (IBAction)northButton:(id)sender;
- (IBAction)eastButton:(id)sender;
- (IBAction)southButton:(id)sender;
- (IBAction)westButton:(id)sender;

@end
