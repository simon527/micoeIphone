//
//  RbtGongChengJianJieViewController.m
//  RedBudTek
//
//  Created by 黄川 on 13-11-7.
//  Copyright (c) 2013年 redbudtek. All rights reserved.
//
//    NSLog(@"潢川大帅哥");

#import "RbtGongChengJianJieViewController.h"
#import "RbtGongChengDaoHangViewController.h"
#import "RbtProjectInfoModel.h"

#define TOP 20
#define GAP 20

@interface RbtGongChengJianJieViewController ()

@end

@implementation RbtGongChengJianJieViewController

@synthesize gcTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"工程简介";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((self.view.bounds.size.width - 596/2)/2, 64+TOP, 596/2, 96/2);
    [btn setImage:[UIImage imageNamed:@"headerBtn"] forState:UIControlStateNormal];
//    [btn setTitle:[RbtProjectModel sharedInstance].name forState:UIControlStateNormal];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:[btn bounds]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    titleLabel.text = [RbtProjectModel sharedInstance].name;
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont fontWithName:kFontName size:19]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [btn addSubview:titleLabel];
    [btn addTarget:self action:@selector(getinProject) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
	// Do any additional setup after loading the view.
    
    
    gcTableView = [[UITableView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 596/2)/2, 64+TOP+96/2, 596/2, self.view.bounds.size.height - 64- TOP*2-96/2- 70)];
//    gcTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [gcTableView setSectionIndexColor:[UIColor clearColor]];
    [gcTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [gcTableView setSeparatorColor:[UIColor clearColor]];
    [gcTableView setBackgroundView:nil];
    gcTableView.dataSource = self;
    gcTableView.delegate = self;
//    gcTableView.userInteractionEnabled = NO;
    [self.view addSubview:gcTableView];
    
    UIImageView *buttomImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 596/2)/2, gcTableView.height + gcTableView.frame.origin.y-20, 596/2, 60)];
    [buttomImageView setImage:[UIImage imageNamed:@"cellBGImage"]];
    [self.view addSubview:buttomImageView];
    
    UIButton *buttomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buttomBtn.frame = CGRectMake(buttomImageView.frame.origin.x + 20, self.view.height - 70/2-TOP-23-20, 596/2-40, 70/2);
    [buttomBtn setImage:[UIImage imageNamed:@"buttomBtn"] forState:UIControlStateNormal];
    UILabel *buttomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, buttomBtn.width, buttomBtn.height)];
    [buttomLabel setBackgroundColor:[UIColor clearColor]];
    buttomLabel.text = @"进入";
    [buttomLabel setTextAlignment:NSTextAlignmentCenter];
    [buttomLabel setTextColor:[UIColor whiteColor]];
    [buttomLabel setFont:[UIFont fontWithName:kFontName size:17]];
    [buttomBtn addSubview:buttomLabel];
    [buttomBtn addTarget:self action:@selector(getinProject) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttomBtn];
    
    row2BtnClicked = NO;
    
    jieshaoLabel = [[UILabel alloc] init];
    jieshaoLabel.text = [RbtProjectInfoModel sharedInstance].i;
            CGSize size = [jieshaoLabel.text sizeWithFont:jieshaoLabel.font constrainedToSize:self.view.bounds.size lineBreakMode:jieshaoLabel.lineBreakMode];
    labelHeight = size.height+30;
    [jieshaoLabel setFont:[UIFont fontWithName:kFontName size:15]];
    [jieshaoLabel setTextColor:[UIColor grayColor]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        if (row2BtnClicked) {
            return labelHeight;
        }
        else{
            return 0;
        }
    }
    
    if (IS_IPHONE_5) {
        return 346/8;
    }
    return 258/8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProjectCell"];
//    
//    if (cell == nil) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProjectCell"];
//    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    NSInteger row = [indexPath row];
    
    cell.height = IS_IPHONE_5?346/8:258/8;
    if (row == 2) {
        if (row2BtnClicked) {
            cell.height = labelHeight;
        }
        else{
            cell.height = 0;
            return cell;
        }
    }
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 596/2, cell.height)];
    [bgImageView setImage:[UIImage imageNamed:@"cellBGImage"]];
    [cell addSubview:bgImageView];
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, cell.height-2, 596/2, 4)];
    [lineImageView setImage:[UIImage imageNamed:@"cellLine"]];
    [cell addSubview:lineImageView];
    
    NSLog(@"size %f, %f", bgImageView.width, bgImageView.height);
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 120, cell.frame.size.height)];
    [leftLabel setFont:[UIFont fontWithName:kFontName size:15]];
    [cell addSubview:leftLabel];
    
    UIButton *cellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cellBtn setFrame:CGRectMake(596/2-42-20, (cell.frame.size.height-24)/2, 42, 24)];
    [cellBtn addTarget:self action:@selector(cellBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cellBtn setImage:[UIImage imageNamed:@"row2Image"] forState:UIControlStateNormal];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(596/2-150-20, 0, 150, cell.frame.size.height)];
    [rightLabel setFont:[UIFont fontWithName:kFontName size:15]];
    [rightLabel setTextColor:[UIColor colorWithRed:0/255.0f green:162/255.0f blue:233/255.0f alpha:1]];
    [rightLabel setTextAlignment:NSTextAlignmentRight];
    
    if (row2BtnClicked) {
//        [jieshaoLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [jieshaoLabel setNumberOfLines:0];

        CGRect rect = jieshaoLabel.frame;
        rect.size.height = labelHeight;
        rect.size.width = cell.width-40;
        jieshaoLabel.frame = rect;
    }
    else
    {
        [jieshaoLabel setNumberOfLines:1];
        [jieshaoLabel setFrame:CGRectMake(20, 0, 80, cell.height)];
    }
    
    [jieshaoLabel setBackgroundColor:[UIColor clearColor]];
    
    if (row == 1)
    {
//        [cell addSubview:cellBtn];
        [cell setAccessoryView:cellBtn];
    }
    else if (row == 2)
    {
        [cell addSubview:jieshaoLabel];
    }
    else{
        
        [cell addSubview:rightLabel];
    }
    
    switch (row) {
        case 0:
        {
            leftLabel.text = @"项目类型";
            rightLabel.text = [RbtProjectInfoModel sharedInstance].n;
        }
            break;
            
        case 1:
        {
            leftLabel.text = @"项目介绍";
        }
            break;
        case 2:
        {
//            jieshaoLabel.text = [RbtProjectInfoModel sharedInstance].i;
        }
            break;
        case 3:
        {
            leftLabel.text = @"设计用水量";
            rightLabel.text = [RbtProjectInfoModel sharedInstance].w;
        }
            break;
        case 4:
        {
            leftLabel.text = @"甲方单位";
            rightLabel.text = [RbtProjectInfoModel sharedInstance].c;
        }
            break;
        case 5:
        {
            leftLabel.text = @"联系人";
            rightLabel.text = [RbtProjectInfoModel sharedInstance].t;
        }
            break;
        case 6:
        {
            leftLabel.text = @"联系电话";
            rightLabel.text = [RbtProjectInfoModel sharedInstance].p;
        }
            break;
        case 7:
        {
            leftLabel.text = @"竣工时间";
            rightLabel.text = [RbtProjectInfoModel sharedInstance].ct;
        }

            break;
        default:
            break;
    }
    return cell;
}

-(void)cellBtnClicked:(UIButton *)sender
{
    row2BtnClicked = !row2BtnClicked;
    [gcTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getinProject{
    RbtGongChengDaoHangViewController *dhVc = [[RbtGongChengDaoHangViewController alloc] init];
    [self.navigationController pushViewController:dhVc animated:YES];
}

@end
