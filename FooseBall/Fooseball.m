//
//  Fooseball.m
//  
//
//  Created by SIVASANKAR DEVABATHINI on 10/5/15.
//
//

#import "Fooseball.h"


@implementation Fooseball

@dynamic looser;
@dynamic winner;
@dynamic looserScore;
@dynamic winnerScore;
@dynamic interchangeFlag;
@dynamic time;
- (void) awakeFromInsert
{
    [super awakeFromInsert];
    [self setValue:[NSDate date] forKey:@"postDate"];
}
@end
