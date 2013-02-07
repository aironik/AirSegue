//
//  ASEffectListViewController.m
//  AirSegue
//
//  Created by Oleg Lobachev  (aironik@gmail.com) on 26.02.2013.
//  Copyright 2013 aironik. All rights reserved.
//

#if !(__has_feature(objc_arc))
#error ARC required. Add -fobjc-arc compiler flag for this file.
#endif

#import "ASEffectListViewController.h"

#import "ASNavigationController.h"
#import "ASRibbonPushEffect.h"
#import "ASTestStandViewController.h"


enum {
    ASEffectListViewControllerSectionEffect = 0,
    ASEffectListViewControllerSectionTestStand,

    ASEffectListViewControllerSectionsCount
} ASEffectListViewControllerSections;

enum {
    ASEffectListViewControllerEffectDemoRibbon1 = 0,

    ASEffectListViewControllerEffectDemosCount,
} ASEffectListViewControllerEffectDemos;


@interface ASEffectListViewController ()

@end


#pragma mark - Implementation

@implementation ASEffectListViewController

- (void)viewDidAppear:(BOOL)animated {
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return ASEffectListViewControllerSectionsCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger result = 0;
    switch (section) {
        case ASEffectListViewControllerSectionEffect:
            result = ASEffectListViewControllerEffectDemosCount;
            break;
        case ASEffectListViewControllerSectionTestStand:
            result = 1;
            break;
        default:
        case ASEffectListViewControllerSectionsCount:
            NSAssert(NO, @"Unknown section");
            break;
    }
    return result;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *result = nil;
    switch (section) {
        case ASEffectListViewControllerSectionEffect:
            result = NSLocalizedString(@"Effects", @"Effects section title.");
            break;
        case ASEffectListViewControllerSectionTestStand:
            result = NSLocalizedString(@"Bench-test", @"Bench-test section title.");
            break;
        default:
        case ASEffectListViewControllerSectionsCount:
            NSAssert(NO, @"Unknown section");
            break;
    }
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *result = nil;
    switch (indexPath.section) {
        case ASEffectListViewControllerSectionEffect:
            result = [self tableView:tableView cellForEffectDemoAtRow:indexPath.row];
            break;
        case ASEffectListViewControllerSectionTestStand:
            result = [self tableView:tableView cellForTestStandAtRow:indexPath.row];
            break;
        default:
        case ASEffectListViewControllerSectionsCount:
            NSAssert(NO, @"Unknown section");
            break;
    }
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForEffectDemoAtRow:(NSInteger)row {
    NSString *cellId = @"effectDemoCell";
    UITableViewCell *result = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!result) {
        result = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    result.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (row) {
        case ASEffectListViewControllerEffectDemoRibbon1:
            result.textLabel.text = @"Ribbon";
            break;

        default:
        case ASEffectListViewControllerEffectDemosCount:
            NSAssert(NO, @"Unknown Demo Effect.");
            break;
    }
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForTestStandAtRow:(NSInteger)row {
    NSAssert(row == 0, @"Unknown test stand row.");
    NSString *cellId = @"testStandCell";
    UITableViewCell *result = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!result) {
        result = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    result.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    result.textLabel.text = NSLocalizedString(@"Test Stand", @"Test Stand cell name.");
    return result;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case ASEffectListViewControllerSectionEffect:
            [self startEffectDemoAtRow:indexPath.row];
            break;
        case ASEffectListViewControllerSectionTestStand:
            [self startTestStandAtRow:indexPath.row];
            break;
        default:
        case ASEffectListViewControllerSectionsCount:
            NSAssert(NO, @"Unknown section");
            break;
    }
}

- (void)startEffectDemoAtRow:(NSInteger)row {
    switch (row) {
        case ASEffectListViewControllerEffectDemoRibbon1:
            [self showRibbonEffect1];
            break;
            
        default:
        case ASEffectListViewControllerEffectDemosCount:
            NSAssert(NO, @"Unknown Demo Effect.");
            break;
    }
}

- (void)showRibbonEffect1 {
    // TODO: push ribbon effect settings view controller
    UIViewController *vc = [[UIViewController alloc] init];
    ASRibbonPushEffect *pushEffect = [ASRibbonPushEffect effect];
    [(ASNavigationController *)self.navigationController pushViewController:vc
                                                            withChangeEffect:pushEffect];
}

- (void)startTestStandAtRow:(NSInteger)row {
    ASTestStandViewController *vc = [[ASTestStandViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


@end