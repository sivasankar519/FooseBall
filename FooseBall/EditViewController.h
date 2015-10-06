//
//  EditViewController.h
//  FooseBall
//
//  Created by SIVASANKAR DEVABATHINI on 10/5/15.
//  Copyright (c) 2015 SIVASANKAR DEVABATHINI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fooseball.h"
@protocol EditViewControllerDelegate;
@interface EditViewController : UIViewController{
    
}
@property (nonatomic, strong) Fooseball *currentResult;

@property (weak, nonatomic) IBOutlet UITextField *player1;

@property (weak, nonatomic) IBOutlet UITextField *player2;

@property (weak, nonatomic) IBOutlet UITextField *score1;

@property (weak, nonatomic) IBOutlet UITextField *score2;


- (IBAction)resign:(id)sender;

- (IBAction)doneActn:(id)sender;

@property (nonatomic, weak) id <EditViewControllerDelegate> delegate;

@end


@protocol EditViewControllerDelegate

-(void)updateResult;

@end



