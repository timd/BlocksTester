//
//  ViewController.m
//  BlocksTester
//
//  Created by Tim on 21/08/14.
//  Copyright (c) 2014 Charismatic Megafauna Ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// Define a block property taking no params
@property (nonatomic, copy) void (^superSimpleBlock)();

// Define a block property taking a single param
@property (nonatomic, copy) void (^stringBlock)(NSString*);

// Define a block property taking multiple params
@property (nonatomic, copy) BOOL (^arrayBlock)(NSArray*, NSString*);

@end

@implementation ViewController

// Declare a block as a typedef that will be
// defined later
typedef void (^RemoteDeffedBlock)();

// Declare and implement typedeffed block
typedef void (^TypeDeffedBlock)();

// Implement the typedeff'd block
TypeDeffedBlock typeDeffedBlock = ^void() {
    NSLog(@"This is a typed block!");
};


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapBlockButton:(id)sender {

    // ****************************************************************
    // Define the block inline and use it with the really simple method
    // ****************************************************************

    void (^simpleBlock)() = ^void() {
        NSLog(@"this is a simple block!");
    };
    
    [self doSomethingWithReallySimpleBlock:simpleBlock];

    // *****************************************
    // Same thing as above with a block property
    // *****************************************
    
    self.superSimpleBlock = ^void() {
        NSLog(@"this is a super simple block!");
    };
    
    [self doSomethingWithReallySimpleBlock:self.superSimpleBlock];

    // **************************************************************************
    // Call the simple block method with a block that was defined using a typedef
    // **************************************************************************
    
    [self doSomethingWithReallySimpleBlock:typeDeffedBlock];

    // *************************************************************************************
    // Call the simple block method with a block that was defined using a typedef elsewhere,
    // but defined locally
    // *************************************************************************************
    
    RemoteDeffedBlock remoteDeffedBlock = ^void() {
        NSLog(@"This is a remotely-deffed typed block!");
    };
    
    [self doSomethingWithReallySimpleBlock:remoteDeffedBlock];
    

    // **********************************************************************
    // Call the simple block method with a block property that's defined here
    // **********************************************************************
    
    self.stringBlock = ^void(NSString *theText) {
        NSLog(@"did this from within a block, with text %@", theText);
    };

    [self doSomethingWithSimpleBlock:self.stringBlock];

    
    // ***************************************************************************
    // Call the betterBlock method with a block defined locally to take parameters
    // ***************************************************************************

    self.arrayBlock = ^BOOL(NSArray *theArray, NSString *theString) {
        NSLog(@"The string is %@", theString);
        for (id thing in theArray) {
            NSLog(@"thing = %@", thing);
        }
        return YES;
    };
    
    [self doSomethingWithBetterBlock:self.arrayBlock];
    
}

-(void)doSomethingWithReallySimpleBlock:(void (^)())theBlock {
    
    // Simplest possible way of executing the block
    theBlock();
}

- (void)doSomethingWithSimpleBlock:(void (^)(NSString*))theBlock {
    
    // Passing in some local data into the block
    NSString *foo = @"some more text";
    theBlock(foo);
}

-(void)doSomethingWithBetterBlock:(BOOL (^)(NSArray*, NSString*))betterBlock {
    
    // More complex local data
    NSArray *array = @[@"one", @"two", @"three", @"four", @"five"];
    NSString *string = @"foo";
    
    // And handling a return type
    BOOL blockReturn = betterBlock(array, string);
    
    NSLog(@"Result of block = %d", blockReturn);
    
}



@end
