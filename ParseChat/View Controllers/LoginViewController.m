//
//  LoginViewController.m
//  ParseChat
//
//  Created by selinons on 7/7/19.
//  Copyright © 2019 codepath. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) NSString *username;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)signUp:(id)sender {
    [self performSegueWithIdentifier:@"signupSegue" sender:nil];

}
- (IBAction)logIn:(id)sender {
    self.username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:self.username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            [self performSegueWithIdentifier:@"loggedInSegue" sender:nil];

        }
    }];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    UINavigationController *navigationController = [segue destinationViewController];
//
//    ChatViewController *chatController = (ChatViewController*)navigationController.topViewController;
//    chatController.username = self.username;
//}


@end
