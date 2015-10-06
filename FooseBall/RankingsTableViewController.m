//
//  RankingsTableViewController.m
//  FooseBall
//
//  Created by SIVASANKAR DEVABATHINI on 10/4/15.
//  Copyright (c) 2015 SIVASANKAR DEVABATHINI. All rights reserved.
//

#import "RankingsTableViewController.h"
#import "AppDelegate.h"
@interface RankingsTableViewController ()
{
    NSArray *winnerArray;
    NSArray *looserArray;
    NSMutableDictionary *playerInfoDict;
    NSArray *rankingOrder;
}
@end

@implementation RankingsTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(NSSet*)returnPlayersList{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Fooseball" inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
 
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"winner"
                                                                   ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"looser"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor1,sortDescriptor2, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // error code
    }
    winnerArray = [fetchedObjects valueForKey:@"winner"];
    looserArray = [fetchedObjects valueForKey:@"looser"];
    
    NSMutableSet * playersSet = [NSMutableSet setWithArray:winnerArray];
    
    [playersSet unionSet:[NSSet setWithArray:looserArray]];

    
    return playersSet;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
   
    self.tabBarController.navigationItem.title = @"Rankings";
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    
    NSSet *playerList = [self returnPlayersList];
    NSCountedSet *winnerSet = [[NSCountedSet alloc]initWithArray:winnerArray];
    NSCountedSet *looserSet = [[NSCountedSet alloc]initWithArray:looserArray];
    playerInfoDict = [[NSMutableDictionary alloc]init];

    for (NSString *str in playerList) {
        NSUInteger total = [winnerSet countForObject:str] + [looserSet countForObject:str];
        NSUInteger win = [winnerSet countForObject:str];
        NSArray *array = [[NSArray alloc]initWithObjects:[NSNumber numberWithInteger:total],[NSNumber numberWithInteger:win], nil];
        [playerInfoDict setValue:array forKey:str];
    }
    
    
    rankingOrder = [[playerInfoDict allKeys] sortedArrayUsingComparator:^(id obj1, id obj2) {
        if ([playerInfoDict valueForKey:obj1 ][1] < [playerInfoDict valueForKey:obj2 ][1])
            return (NSComparisonResult)NSOrderedDescending;
        if ([playerInfoDict valueForKey:obj1 ][1] > [playerInfoDict valueForKey:obj2 ][1])
            return (NSComparisonResult)NSOrderedAscending;
        if ([playerInfoDict valueForKey:obj1 ][0] > [playerInfoDict valueForKey:obj2 ][0])
            return (NSComparisonResult)NSOrderedDescending;
        if ([playerInfoDict valueForKey:obj1 ][0] < [playerInfoDict valueForKey:obj2 ][0])
            return (NSComparisonResult)NSOrderedAscending;
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    [self.tableView reloadData];
    
}

-(NSManagedObjectContext*)managedObjectContext{
    return ((AppDelegate*)[[UIApplication sharedApplication] delegate]).managedObjectContext;
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [rankingOrder count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"HistoryCell"];
    }
 
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld. %@",(long)indexPath.row+1,rankingOrder[indexPath.row]];
    cell.detailTextLabel.text = [NSString stringWithFormat:
                                 @"\tGames Played:%d  Won:%d",
                                 [[playerInfoDict valueForKey:rankingOrder[indexPath.row]][0] intValue],
                                 [[playerInfoDict valueForKey:rankingOrder[indexPath.row]][1] intValue]];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
