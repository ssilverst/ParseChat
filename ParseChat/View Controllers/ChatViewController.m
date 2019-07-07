//
//  ChatViewController.m
//  ParseChat
//
//  Created by selinons on 7/7/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "ChatViewController.h"
#import "Parse/Parse.h"
#import "ChatCell.h"
#import "UIImageView+AFNetworking.h"

@interface ChatViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *messages;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;

}
- (void)onTimer {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Message_fbu2019"];
    [query includeKey:@"user"];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.messages = posts;
            [self.tableView reloadData];

        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];}
- (IBAction)sendMessage:(id)sender {
    PFObject *chatMessage = [PFObject objectWithClassName:@"Message_fbu2019"];
    // Use the name of your outlet to get the text the user typed
    chatMessage[@"text"] = self.messageField.text;
    
    chatMessage[@"user"] = PFUser.currentUser;
    [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (succeeded) {
            NSLog(@"The message was saved!");
        } else {
            NSLog(@"Problem saving message: %@", error.localizedDescription);
        }
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell"];
    cell.bubbleView.layer.cornerRadius = 16;
    cell.bubbleView.clipsToBounds = true;
    PFObject *chatMessage = self.messages[indexPath.row];
    //NSLog(@"%@", self.messages[indexPath.row]);
    cell.messageLabel.text = chatMessage[@"text"];
    PFUser *user = chatMessage[@"user"];
    if (user != nil) {
        // User found! update username label with username
        cell.usernameLabel.text = user.username;
        NSString *thisUsername = user.username;
        NSString *userURLString = [@"https://api.adorable.io/avatar/" stringByAppendingString:thisUsername];
        NSLog(@"%@", userURLString);
        // set the image based on poster path
        NSURL *userURL = [NSURL URLWithString:
                        userURLString];
        
        [cell.avatarImage setImageWithURL:userURL];
    } else {
        // No user found, set default username
        cell.usernameLabel.text = @"🤖";
    }
    return cell;
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
