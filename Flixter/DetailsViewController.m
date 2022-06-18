//
//  DetailsViewController.m
//  Flixter
//
//  Created by Chidi Onyekwelu on 6/17/22.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *SynopsisTitle;
@property (weak, nonatomic) IBOutlet UILabel *MovieTitle;
@property (weak, nonatomic) IBOutlet UIImageView *UnderBannerImage;
@property (weak, nonatomic) IBOutlet UIImageView *BannerImage;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.MovieTitle.text = self.movieTable[@"title"];
    self.SynopsisTitle.text = self.movieTable[@"overview"];
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = _movieTable[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    
    NSString *backdropURLString = _movieTable[@"backdrop_path"];
    NSString *fullPosterURLString2 = [baseURLString stringByAppendingString:backdropURLString];
    
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    NSURL *posterURL2 = [NSURL URLWithString:fullPosterURLString2];
    self.BannerImage.image = nil;
    [self.BannerImage setImageWithURL:posterURL2];
    self.UnderBannerImage.image = nil;
    [self.UnderBannerImage setImageWithURL:posterURL];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
