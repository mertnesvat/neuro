//
//  DetailViewController.m
//  neuro
//
//  Created by Mert Neşvat on 01/05/2017.
//  Copyright © 2017 Mert Neşvat. All rights reserved.
//

#import "DetailViewController.h"
#import "ObserveViewController.h"

@interface DetailViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation DetailViewController

- (void)fetchOptions{
    self.options = @[@"IXNMuseDataPacketTypeAccelerometer",
                     @"IXNMuseDataPacketTypeGyro",
                     @"IXNMuseDataPacketTypeEeg",
                     @"IXNMuseDataPacketTypeDroppedAccelerometer",
                     @"IXNMuseDataPacketTypeDroppedEeg",
                     @"IXNMuseDataPacketTypeQuantization",
                     @"IXNMuseDataPacketTypeBattery",
                     @"IXNMuseDataPacketTypeDrlRef",
                     @"IXNMuseDataPacketTypeAlphaAbsolute",
                     @"IXNMuseDataPacketTypeBetaAbsolute",
                     @"IXNMuseDataPacketTypeDeltaAbsolute",
                     @"IXNMuseDataPacketTypeThetaAbsolute",
                     @"IXNMuseDataPacketTypeGammaAbsolute",
                     @"IXNMuseDataPacketTypeAlphaRelative",
                     @"IXNMuseDataPacketTypeBetaRelative",
                     @"IXNMuseDataPacketTypeDeltaRelative",
                     @"IXNMuseDataPacketTypeThetaRelative",
                     @"IXNMuseDataPacketTypeGammaRelative",
                     @"IXNMuseDataPacketTypeAlphaScore",
                     @"IXNMuseDataPacketTypeBetaScore",
                     @"IXNMuseDataPacketTypeDeltaScore",
                     @"IXNMuseDataPacketTypeThetaScore",
                     @"IXNMuseDataPacketTypeGammaScore",
                     @"IXNMuseDataPacketTypeIsGood",
                     @"IXNMuseDataPacketTypeHsi",
                     @"IXNMuseDataPacketTypeHsiPrecision",
                     @"IXNMuseDataPacketTypeArtifacts",
                     @"IXNMuseDataPacketTypeTotal"
                     ];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchOptions];
    // Do any additional setup after loading the view.
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(next)];
    
    self.navigationItem.rightBarButtonItem = nextButton;
    
    self.selectedOptions = @{}.mutableCopy;
}

- (void)next{
    [self performSegueWithIdentifier:@"goToObserve" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.options count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    
    cell.textLabel.text = self.options[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *packet = self.options[indexPath.row];
    NSString *number = [NSString stringWithFormat:@"%ld",(long)indexPath.row];

    if (!(cell.backgroundColor == [UIColor whiteColor])) {
        [self.selectedOptions removeObjectForKey:number];
        [tableView cellForRowAtIndexPath:indexPath].selected = NO;
        cell.backgroundColor = [UIColor whiteColor];
    }else{
        self.selectedOptions[number] = packet;
        [tableView cellForRowAtIndexPath:indexPath].selected = YES;
        cell.backgroundColor = [UIColor grayColor];
    }
    
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    ObserveViewController *obs = [segue destinationViewController];
    obs.selectedOptions = self.selectedOptions.copy;
    
}


@end
