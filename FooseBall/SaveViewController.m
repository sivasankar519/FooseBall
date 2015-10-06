//
//  SaveViewController.m
//  FooseBall
//
//  Created by SIVASANKAR DEVABATHINI on 10/4/15.
//  Copyright (c) 2015 SIVASANKAR DEVABATHINI. All rights reserved.
//

#import "SaveViewController.h"
#import "Fooseball.h"

#import "AppDelegate.h"
@interface SaveViewController ()



@property (weak, nonatomic) IBOutlet UITextField *player1Text;
@property (weak, nonatomic) IBOutlet UITextField *player2Text;
@property (weak, nonatomic) IBOutlet UITextField *player1Score;
@property (weak, nonatomic) IBOutlet UITextField *player2Score;

- (IBAction)saveAction:(id)sender;

- (IBAction)returnKeyBoard:(id)sender;

@end

@implementation SaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.tabBarController.navigationItem.title = @"Foose Ball";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSManagedObjectContext*)managedObjectContext{
    return ((AppDelegate*)[[UIApplication sharedApplication] delegate]).managedObjectContext;
}

- (IBAction)saveAction:(id)sender {
    
    if(![self validate]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Invalid information entered!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSManagedObjectContext *context = [self managedObjectContext];
    Fooseball *managedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Fooseball" inManagedObjectContext:context];
    
    if([self.player1Score.text integerValue] > [self.player2Score.text integerValue]){
        [managedObject setValue:self.player1Text.text forKey:@"winner"];
        [managedObject setValue:self.player2Text.text forKey:@"looser"];
        [managedObject setValue:self.player1Score.text forKey:@"winnerScore"];
        [managedObject setValue:self.player2Score.text forKey:@"looserScore"];
        [managedObject setValue:[NSNumber numberWithBool:NO] forKey:@"interchangeFlag"];
    }
    else{
        [managedObject setValue:self.player2Text.text forKey:@"winner"];
        [managedObject setValue:self.player1Text.text forKey:@"looser"];
        [managedObject setValue:self.player2Score.text forKey:@"winnerScore"];
        [managedObject setValue:self.player1Score.text forKey:@"looserScore"];
        [managedObject setValue:[NSNumber numberWithBool:YES] forKey:@"interchangeFlag"];
    }
    
    
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        NSLog(@"Error! %@", error);
    }
    
    self.player1Text.text = @"";
    self.player2Text.text = @"";
    self.player1Score.text = @"";
    self.player2Score.text = @"";
    
    [self.view endEditing:YES];
    
}

- (IBAction)returnKeyBoard:(id)sender {
    [sender resignFirstResponder];
}

-(BOOL)validate{
    if(self.player1Text.text.length && self.player2Text.text.length && [self.player1Score.text integerValue] && [self.player2Score.text integerValue] && ([self.player1Score.text integerValue] - [self.player2Score.text integerValue]))
        
        return YES;
    return NO;
}
@end
