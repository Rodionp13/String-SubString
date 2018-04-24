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
    @autoreleasepool {
    
    NSString *input = @"Prime Minister <Narendra Modi> tweeted a <link> to the speech (Human Resource Development Minister Smriti Irani) <made> in the Lok Sabha during the ((debate) on the ongoing JNU row) and the suicide of Dalit scholar Rohith Vemula at the [Hyderabad Central University].";
    NSMutableString *mutINPUT = [input mutableCopy];
    
    //diktionaries for tags
    NSMutableDictionary *openTags = [NSMutableDictionary dictionary];
    NSMutableDictionary *closeTags = [NSMutableDictionary dictionary];
    
    int counterForOpen = -1, counterForClose = -1;
    
    
    
    //added tags to collections (openTags, closeTags)
    for(int i = 0; i < [input length]; i++) {
//        NSLog(@"%d", i);
        NSMutableString *charAtIndex = [NSMutableString stringWithFormat:@"%c", [mutINPUT characterAtIndex:i]];
        if([charAtIndex isEqualToString:@"<"] || [charAtIndex isEqualToString:@"("] || [charAtIndex isEqualToString:@"["]) {
            counterForOpen++;
            NSValue *valueOfRangeOfOPENtag = [NSValue valueWithRange:[mutINPUT rangeOfString:charAtIndex]];
            [openTags setObject:valueOfRangeOfOPENtag forKey:[NSNumber numberWithInt:counterForOpen]];
            
            
            [mutINPUT replaceOccurrencesOfString:charAtIndex withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(i, 1)];
//            NSLog(@"%@", openTags);
        } else if([charAtIndex isEqualToString:@">"] || [charAtIndex isEqualToString:@")"] || [charAtIndex isEqualToString:@"]"]) {
            counterForClose++;
            NSValue *valueOfRangeOfCLOSEtag = [NSValue valueWithRange:[mutINPUT rangeOfString:charAtIndex]];
            [closeTags setObject:valueOfRangeOfCLOSEtag forKey:[NSNumber numberWithInt:counterForClose]];
            
            [mutINPUT replaceOccurrencesOfString:charAtIndex withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(i, 1)];
//            NSLog(@"%@", closeTags);
        }
    }
    
    
    
    //created an Output Array to store string, that is consisted from 2 bracket's ranges(from openTags and closeTags)
    //Так и не смог разобраться как правильно достать (или отортировать словари, а потом доставать) нужные range из openTags , closeTags, чтобы получить
    //нужные строки...   Ranges в openTags , closeTags сохранены правильно. Совместить - проблема...
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
    NSLog(@"%@", tempArrOfStringRanges);
        
        
        [mutINPUT release];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
