//
//  MovieCell.h
//  Flixter
//
//  Created by Chidi Onyekwelu on 6/16/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterImage;
@property (weak, nonatomic) IBOutlet UILabel *SynopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;

@end

NS_ASSUME_NONNULL_END
