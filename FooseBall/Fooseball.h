//
//  Fooseball.h
//  
//
//  Created by SIVASANKAR DEVABATHINI on 10/5/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Fooseball : NSManagedObject

@property (nonatomic, retain) NSString * looser;
@property (nonatomic, retain) NSString * winner;
@property (nonatomic, retain) NSString * looserScore;
@property (nonatomic, retain) NSString * winnerScore;
@property (nonatomic, retain) NSNumber * interchangeFlag;
@property (nonatomic, retain) NSDate * time;

@end
