//
//  TestPerformanceViewController.m
//  Catchpoint
//
//  Created by Matias on 6/18/15.
//  Copyright (c) 2015 Catchpoint Systems. All rights reserved.
//

#import <FSLineChart.h>
#import "CPAPIManager.h"
#import "TimeUtils.h"
#import "DataUtils.h"
#import "CPAPIRequest.h"
#import "CPParser.h"

#import "TestPerformanceViewController.h"


@interface TestPerformanceViewController ()


@property (weak, nonatomic) IBOutlet UIView *chartView;
@property (strong, nonatomic) FSLineChart *chart;
@property (weak, nonatomic) NSArray *data;
@property (weak, nonatomic) NSString *testName;

@end

@implementation TestPerformanceViewController

- (void)viewDidLoad {
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
    
    // test2: 33621, 33611

    self.data = [CPAPIRequest getPerformanceForTest:@"33621" raw:NO];
    
    [self.view addGestureRecognizer:
     [[UITapGestureRecognizer alloc] initWithTarget:self
                                             action:@selector(hideKeyboard:)]];
    
    FSLineChart *chart = [[FSLineChart alloc] initWithFrame:CGRectMake(20, 260, [UIScreen mainScreen].bounds.size.width - 40, 166)];
    
    self.chart = chart;
    [self.chartView addSubview:self.chart];
    
    [self updateChart];
}

- (IBAction)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)drawChart:(id)sender {
    NSLog(@"Drawing chart");
    
    [self.view endEditing:YES];
    
    NSString *testId = self.testIdField.text;
    self.data = [CPAPIRequest getPerformanceForTest:testId raw:NO];
    [self.chart clearChartData];
    [self updateChart];
}


- (void)updateChart {
    NSLog(@"UPDATING CHART");
    
    self.chart.verticalGridStep = 5;
    self.chart.horizontalGridStep = 5;
    
    self.chart.labelForIndex = ^(NSUInteger item) {
        return [TimeUtils formatTime:[TimeUtils utcStringToDate:self.data[item][@"dimension"][@"name"]]];
    };
    
    self.chart.labelForValue = ^(CGFloat value) {
        return [NSString stringWithFormat:@"%.f", value];
    };
    
    self.testLabel.text = [CPParser getTestNameFromSyntheticData:self.data];
    NSArray *chartData = [CPParser getMetric:17 fromSyntheticData:self.data];
    
    [self.chart setChartData:chartData];
}



@end
