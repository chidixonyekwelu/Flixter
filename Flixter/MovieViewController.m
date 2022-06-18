//
//  MovieViewController.m
//  Flixter
//
//  Created by Chidi Onyekwelu on 6/15/22.
//

#import "MovieViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"
@interface MovieViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityindicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *movieTable;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityIndicator startAnimating];

    self.tableView.dataSource = self;
    [self fetchMovies];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void)fetchMovies {
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=5ac02576049eace8e81642ab421c59b9"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               [self.activityIndicator stopAnimating];
               NSLog(@"%@", dataDictionary);
               

               // TODO: Get the array of movies NSArray *myArray = dataDictionary[@"results"];
               
               self.movieTable = dataDictionary[@"results"];
               
               for (NSDictionary *movie in self.movieTable) {
               NSLog(@"%@", movie[@"title"]);

                              }
               
               // TODO: Store the movies in a property to use elsewhere
               
               // TODO: Reload your table view data
               [self.tableView reloadData];
           }
        [self.refreshControl endRefreshing];
       }];
    [task resume];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movieTable.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];

   NSDictionary *movies = self.movieTable[indexPath.row];

     cell.TitleLabel.text = movies[@"title"];
     cell.SynopsisLabel.text = movies[@"overview"];
    cell.SynopsisLabel.font = [cell.SynopsisLabel.font fontWithSize:12];
    cell.SynopsisLabel.lineBreakMode= NSLineBreakByWordWrapping;
    cell.SynopsisLabel.numberOfLines = 0;
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movies[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    cell.posterImage.image = nil;
    [cell.posterImage setImageWithURL:posterURL];
    self.tableView.rowHeight = 180;
    // cell.textLabel.text = movie[@"title"];
    return cell;
}


//#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using
    UITableViewCell *MyCell = sender;
    NSIndexPath *IndexPath = [self.tableView indexPathForCell:MyCell];
    DetailsViewController *DetailVC = [segue destinationViewController];
    DetailVC.movieTable = self.movieTable[IndexPath.row];
    
//     Pass the selected object to the new view controller.
}


@end
