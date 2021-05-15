//
//  Global.m
//
//  Created by Trinidad on 5/12/21.
//

#import "Global.h"
void alertView(NSString * title, NSString *msg, UIViewController *vc)
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:msg
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    
    [alert addAction:yesButton];
    [vc presentViewController:alert animated:YES completion:nil];
}
@implementation Global

@end
