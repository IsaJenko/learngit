//
//  newsInfoViewController.m
//  SlamDunk_Demo
//
//  Created by jinke on 15/10/27.
//  Copyright © 2015年 IsaJenko.github.io. All rights reserved.
//

#import "newsInfoViewController.h"

@interface newsInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ptimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;


@end

@implementation newsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}
- (void) loadData
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:[NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",_nbaNews.docid] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [responseObject valueForKey:[NSString stringWithFormat:@"%@",_nbaNews.docid]];
//        NSLog(@"%@",dict);
        NBANEWS *nbaNews = [NBANEWS new];
        [nbaNews setValuesForKeysWithDictionary:dict];
        self.titleLabel.text = nbaNews.title;
        self.ptimeLabel.text = nbaNews.ptime;
        nbaNews.body = [nbaNews.body stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
        nbaNews.body = [nbaNews.body stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
        nbaNews.body = [nbaNews.body stringByReplacingOccurrencesOfString:@"<!--IMG#0-->" withString:@""];
        nbaNews.body = [nbaNews.body stringByReplacingOccurrencesOfString:@"<!--IMG#1-->" withString:@""];
        nbaNews.body = [nbaNews.body stringByReplacingOccurrencesOfString:@"<!--link0-->" withString:@""];
        self.contentLabel.text = nbaNews.body;
    
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                UIImageView *errorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error.jpg"]];
                errorImageView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
                [self.view addSubview:errorImageView];
                
    }];

}
- (void)setNbaNews:(NBANEWS *)nbaNews
{
    _nbaNews = nbaNews;
}
@end
