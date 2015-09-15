
#import <UIKit/UIKit.h>

@interface OAuthLoginViewController : UIViewController

@property (strong, nonatomic) NSString *userToken;
- (IBAction)requestToken:(id)sender;

@end
