//
//  EditViewController.h
//  FooseBall
//
//  Created by SIVASANKAR DEVABATHINI on 10/5/15.
//  Copyright (c) 2015 SIVASANKAR DEVABATHINI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fooseball.h"

@interface EditViewController : UIViewController{
    
}
@property (nonatomic, strong) Fooseball *currentResult;

@property (weak, nonatomic) IBOutlet UITextField *player1;

@property (weak, nonatomic) IBOutlet UITextField *player2;

@property (weak, nonatomic) IBOutlet UITextField *score1;

@property (weak, nonatomic) IBOutlet UITextField *score2;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)resign:(id)sender;

- (IBAction)doneActn:(id)sender;


@end






