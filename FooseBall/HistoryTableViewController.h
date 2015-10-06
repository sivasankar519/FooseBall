//
//  HistoryTableViewController.h
//  FooseBall
//
//  Created by SIVASANKAR DEVABATHINI on 10/4/15.
//  Copyright (c) 2015 SIVASANKAR DEVABATHINI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "EditViewController.h"

@interface HistoryTableViewController : UITableViewController<NSFetchedResultsControllerDelegate, EditViewControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
