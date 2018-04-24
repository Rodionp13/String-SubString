//
//  ViewController.m
//  Brackets
//
//  Created by User on 4/23/18.
//  Copyright © 2018 BNR. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *input = @"Prime Minister <Narendra Modi> tweeted a <link> to the speech (Human Resource Development Minister Smriti Irani) <made> in the Lok Sabha during the ((debate) on the ongoing JNU row) and the suicide of Dalit scholar Rohith Vemula at the [Hyderabad Central University].";
    NSMutableString *mutINPUT = [input mutableCopy];
    
    NSMutableDictionary *openTags = [NSMutableDictionary dictionary];
    NSMutableDictionary *closeTags = [NSMutableDictionary dictionary];
    
    int counterForOpen = -1, counterForClose = -1;
    
    
    for(int i = 0; i < [input length]; i++) {
        NSLog(@"%d", i);
        NSMutableString *charAtIndex = [NSMutableString stringWithFormat:@"%c", [mutINPUT characterAtIndex:i]];
        if([charAtIndex isEqualToString:@"<"] || [charAtIndex isEqualToString:@"("] || [charAtIndex isEqualToString:@"["]) {
            counterForOpen++;
            NSValue *valueOfRangeOfOPENtag = [NSValue valueWithRange:[mutINPUT rangeOfString:charAtIndex]];
            [openTags setObject:valueOfRangeOfOPENtag forKey:[NSNumber numberWithInt:counterForOpen]];
            
            [mutINPUT replaceOccurrencesOfString:charAtIndex withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(i, 1)];
            NSLog(@"%@", openTags);
        } else if([charAtIndex isEqualToString:@">"] || [charAtIndex isEqualToString:@")"] || [charAtIndex isEqualToString:@"]"]) {
            counterForClose++;
            NSValue *valueOfRangeOfCLOSEtag = [NSValue valueWithRange:[mutINPUT rangeOfString:charAtIndex]];
            [closeTags setObject:valueOfRangeOfCLOSEtag forKey:[NSNumber numberWithInt:counterForClose]];
            
            [mutINPUT replaceOccurrencesOfString:charAtIndex withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(i, 1)];
            NSLog(@"%@", closeTags);
        }
    }
    
    
    
    
    NSMutableArray *tempArrOfStringRanges = [NSMutableArray array];
    
    for(int i = 0; i < [openTags count]; i++) {
        NSRange valOp = [[openTags objectForKey:[NSNumber numberWithInt:i]] rangeValue];
        NSString *op = [input substringWithRange:valOp];
        for(int j = 0; j < [closeTags count]; j++) {

            NSRange valCl = [[closeTags objectForKey:[NSNumber numberWithInt:j]] rangeValue];
            NSString *cl = [input substringWithRange:valCl];

//            NSLog(@"%d, %d",i,j);
            if(([op isEqualToString:@"<"] && [cl isEqualToString:@">"])) {

                [tempArrOfStringRanges addObject:[input substringWithRange:NSMakeRange(valOp.location + 1, valCl.location - valOp.location - 1)]];
                [openTags removeObjectForKey:[NSNumber numberWithInt:i]];
                [closeTags removeObjectForKey:[NSNumber numberWithInt:j]];

            } else if([op isEqualToString:@"("] && [cl isEqualToString:@")"]) {
                [tempArrOfStringRanges addObject:[input substringWithRange:NSMakeRange(valOp.location + 1, valCl.location - valOp.location - 1)]];
                [openTags removeObjectForKey:[NSNumber numberWithInt:i]];
                [closeTags removeObjectForKey:[NSNumber numberWithInt:j]];

            }  else if([op isEqualToString:@"["] && [cl isEqualToString:@"]"]) {
                [tempArrOfStringRanges addObject:[input substringWithRange:NSMakeRange(valOp.location + 1, valCl.location - valOp.location - 1)]];
                [openTags removeObjectForKey:[NSNumber numberWithInt:i]];
                [closeTags removeObjectForKey:[NSNumber numberWithInt:j]];

            }

        }
    }
    
    
    
    
    
    NSLog(@"%@", openTags);
    NSLog(@"%@", closeTags);
//    NSLog(@"%@", [input substringWithRange:NSMakeRange(6 + 1, 61 - 6 - 1)]);
//    NSLog(@"%@", [input substringWithRange:NSMakeRange(7 + 1, 31 - 7 - 1)]);
//    NSLog(@"%@", [input substringWithRange:NSMakeRange(14 + 1, 25 - 14 - 1)]);
//    NSLog(@"%@", [input substringWithRange:NSMakeRange(21 + 1, 181 - 21 - 1)]);
//    NSLog(@"%@", [input substringWithRange:NSMakeRange(306 + 1, 384 - 306 - 1)]);
//    NSLog(@"%@", [input substringWithRange:NSMakeRange(327, 376 - 327 - 1)]);
//    NSLog(@"%@", [input substringWithRange:NSMakeRange(335 + 1, 347 - 335 - 1)]);
    NSLog(@"%@", tempArrOfStringRanges);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
