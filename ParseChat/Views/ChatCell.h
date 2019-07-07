//
//  ChatCell.h
//  ParseChat
//
//  Created by selinons on 7/7/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UIView *bubbleView;

@end

NS_ASSUME_NONNULL_END
