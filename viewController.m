//
//  ViewController.m
//  Flir One
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

UIView *hotView;
CGFloat screenWidth;
CGFloat screenHeight;

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    
    [[FLIROneSDKStreamManager sharedInstance] addDelegate:self];
    
    [[FLIROneSDKStreamManager sharedInstance] setImageOptions:FLIROneSDKImageOptionsBlendedMSXRGBA8888Image];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    // Flirt logo
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25,150, 35)];
    logo.image=[UIImage imageNamed:@"FLIRt_logo.png"];
    [self.view addSubview:logo];
 
    
 // TODO - Disabled until I figure out how to close keyboard
    /*
    // Write icon
    UIImageView  *notepad = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth - 58, 20, 48, 48)];
    notepad.image = [UIImage imageNamed:@"notepadicon.png"];
    [self.view addSubview:notepad];
    
    
    // Notepad gestures
    UITapGestureRecognizer *notepadDoneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageNotepadTapped:)];
    notepadDoneTap.numberOfTapsRequired = 1;
    notepadDoneTap.numberOfTouchesRequired = 1;
    [notepad addGestureRecognizer:notepadDoneTap];
    [notepad setUserInteractionEnabled:YES];
*/

    
    int iconHeight = 50;
    int iconWidth  = 50;
    
    int border = 10;
    
    int iconVerticalPosition = (iconVerticalPosition = screenHeight - iconWidth -border);

    // Facebook logo
    UIImageView *facebook =[[UIImageView alloc] initWithFrame:CGRectMake(
            10,
            iconVerticalPosition,
            iconWidth,
            iconHeight)];
    facebook.image=[UIImage imageNamed:@"fb_icon.png"];
    [self.view addSubview:facebook];
    
    // Twitter logo
    UIImageView *twitter =[[UIImageView alloc] initWithFrame:CGRectMake(
            //(screenWidth  + iconWidth) / 2,
            135,
            iconVerticalPosition,
            iconWidth,
            iconHeight)];
    twitter.image=[UIImage imageNamed:@"tw_icon.png"];
    [self.view addSubview:twitter];
    
    // Chat message logo
    UIImageView *chat = [[UIImageView alloc] initWithFrame: CGRectMake(
            screenWidth - iconWidth - border,
            iconVerticalPosition,
            iconWidth,
            iconHeight)];
    chat.image=[UIImage imageNamed:@"chat_icon.png"];
    [self.view addSubview:chat];
    
    // Flirtometer
    int meterHeight = 45;
    UIImageView *meter = [[UIImageView alloc] initWithFrame:CGRectMake(
            border,
            //screenHeight - iconHeight - (2 * border),
            screenHeight - iconHeight - meterHeight - (border *2),
            screenWidth - (border * 2),
            meterHeight)];
    
    meter.image = [UIImage imageNamed:@"flirtometer.png"];
    [self.view addSubview:meter];

 /* TODO - Add code to send message to Facebook and Twitter
    // Facebook gestures
    UITapGestureRecognizer *facbookDoneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageFacebookTapped:)];
    facbookDoneTap.numberOfTapsRequired = 1;
    facbookDoneTap.numberOfTouchesRequired = 1;
    [facebook addGestureRecognizer:facbookDoneTap];
    [facebook setUserInteractionEnabled:YES];
    
    // Twitter gestures
    UITapGestureRecognizer *twitterDoneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imagetwitterTapped:)];
    twitterDoneTap.numberOfTapsRequired = 1;
    twitterDoneTap.numberOfTouchesRequired = 1;
    [twitter addGestureRecognizer:twitterDoneTap];
    [twitter setUserInteractionEnabled:YES];
 */
        
} // End of viewDidLoad

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)FLIROneSDKDelegateManager:     (FLIROneSDKDelegateManager *)delegateManager didReceiveBlendedMSXRGBA8888Image: (NSData *)msxImage
                        imageSize:     (CGSize)size {

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        self.thermalImage = [FLIROneSDKUIImage imageWithFormat:FLIROneSDKImageOptionsBlendedMSXRGBA8888Image
                                 andData: msxImage
                                 andSize: size];
    });
                   
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.thermalImgeView setImage:self.thermalImage];
    });
}


- (void)imageNotepadTapped:(UIGestureRecognizer *)gestureRecognizer {
    
    NSLog(@"Notepad clicked");
    
    [self openFlirtWindow];
    
}


- (void)imageFacebookTapped:(UIGestureRecognizer *)gestureRecognizer {
    
    NSLog(@"Facebook clicked");
    
    [self openFlirtWindow];
    
}

- (void)imageTwitterTapped:(UIGestureRecognizer *)gestureRecognizer {
    
    NSLog(@"Twitter clicked");
    
    [self openFlirtWindow];
    
}



// Opens a window with a notepad the allow user to send a message
//    before posting on Facebook, Twitter and etc.
- (void) openFlirtWindow {
   
    int border;
    UIButton * hotDone;
    
    
    
    hotView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, screenWidth -20, 200)];
    [hotView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:hotView];
    
    
    border = 5;
    // Label for new draft
    UILabel * hotLabelNewDraft = [[UILabel alloc] initWithFrame:CGRectMake(
            102,
            border,
            hotView.frame.size.width - (border * 2),
            25)];
    [hotLabelNewDraft setText:@"New Draft"];
    [hotView addSubview:hotLabelNewDraft];
    
    // Text box for hot messages
    border = 10;
    UITextView *hotText = [[UITextView alloc] initWithFrame:CGRectMake(
            10,
            hotLabelNewDraft.frame.size.height + 5,
            hotView.frame.size.width - (border *2),
            125)];
    [hotText setBackgroundColor:[UIColor whiteColor]];
    hotText.layer.cornerRadius = 15;
    hotText.layer.borderColor=[[UIColor blackColor]CGColor];
    hotText.layer.borderWidth= 1.0f;
    hotText.editable = YES;
    
    hotText.userInteractionEnabled = YES;
    [hotView addSubview:hotText];
    
    
    int buttonsHorizontalPosition = hotView.frame.size.height - 40;
    
    // Button cancel
    UIButton * hotCancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    hotCancel.frame = CGRectMake(
            border,
            buttonsHorizontalPosition,
            100,
            30);
    [hotCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [hotView addSubview:hotCancel];
    
    UITapGestureRecognizer *hotCancelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hotCancelSelecter:)];
    hotCancelTap.numberOfTapsRequired = 1;
    hotCancelTap.numberOfTouchesRequired = 1;
    [hotCancel addGestureRecognizer:hotCancelTap];
    [hotCancel setUserInteractionEnabled:YES];
    
    
    // Button Done
    hotDone = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    hotDone.frame = CGRectMake(
            hotText.frame.size.width -100,
            buttonsHorizontalPosition,
            100,
            30);
    
    [hotDone setTitle:@"Done" forState:UIControlStateNormal];
    [hotView addSubview:hotDone];
    
    UITapGestureRecognizer *hotDoneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hotDoneSelecter:)];
    hotDoneTap.numberOfTapsRequired = 1;
    hotDoneTap.numberOfTouchesRequired = 1;
    [hotDone addGestureRecognizer:hotDoneTap];
    [hotDone setUserInteractionEnabled:YES];
    
} // Endof imageTaped


- (void)hotDoneSelecter:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"Done pressed");
    
    hotView.hidden = YES;
    
    // TODO - Add Twitter and Facebook connections
    
}

- (void)hotCancelSelecter:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"Cancel pressed");
    
    hotView.hidden = YES;
    
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)hotView
{
    return YES;
}






/*
-(BOOL)textFieldShouldReturn:(UITextField *)hotText{
    if(hotText == self.FirstTextField){
        [hotText resignFirstResponder];
    }else{
        [hotText resignFirstResponder];
    }
    return YES;
}
*/

@end
