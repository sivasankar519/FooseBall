//
//  EditViewController.m
//  FooseBall
//
//  Created by SIVASANKAR DEVABATHINI on 10/5/15.
//  Copyright (c) 2015 SIVASANKAR DEVABATHINI. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([[self.currentResult valueForKey:@"interchangeFlag"] boolValue]){
        self.player1.text = [self.currentResult valueForKey:@"looser"];
        self.player2.text = [self.currentResult valueForKey:@"winner"];
        self.score1.text = [self.currentResult valueForKey:@"looserScore"];
        self.score2.text = [self.currentResult valueForKey:@"winnerScore"];
        
    }
    else{
        self.player2.text = [self.currentResult valueForKey:@"looser"];
        self.player1.text = [self.currentResult valueForKey:@"winner"];
        self.score2.text = [self.currentResult valueForKey:@"looserScore"];
        self.score1.text = [self.currentResult valueForKey:@"winnerScore"];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationController.title = @"Update Results";
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)resign:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)doneActn:(id)sender {
    
    // check data validations
    if(![self validate]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid information entered!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if([self.player1.text integerValue] > [self.player2.text integerValue]){
        [self.currentResult setValue:self.player1.text forKey:@"winner"];
        [self.currentResult setValue:self.player2.text forKey:@"looser"];
        [self.currentResult setValue:self.score1.text forKey:@"winnerScore"];
        [self.currentResult setValue:self.score2.text forKey:@"looserScore"];
        [self.currentResult setValue:[NSNumber numberWithBool:NO] forKey:@"interchangeFlag"];
        [self.currentResult setValue:[NSDate date] forKey:@"postDate"];
    }
    else{
        [self.currentResult setValue:self.player2.text forKey:@"winner"];
        [self.currentResult setValue:self.player1.text forKey:@"looser"];
        [self.currentResult setValue:self.score2.text forKey:@"winnerScore"];
        [self.currentResult setValue:self.score1.text forKey:@"looserScore"];
        [self.currentResult setValue:[NSNumber numberWithBool:YES] forKey:@"interchangeFlag"];
        [self.currentResult setValue:[NSDate date] forKey:@"postDate"];
    }
    
    [self.delegate updateResult];
    
}

-(BOOL)validate{
    if(self.player1.text.length && self.player2.text.length && [self.score1.text integerValue] && [self.score2.text integerValue] && ([self.score1.text integerValue] - [self.score2.text integerValue]))
        
        return YES;
    return NO;
}
@end
