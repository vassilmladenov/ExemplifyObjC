//
//  MainViewController.m
//  Scanner
//
//  Created by David Prorok on 12/26/13.
//  Copyright (c) 2013 NADCA. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

id<PPScanningViewController> currentCameraViewController;
NSMutableArray *notes;
NSString *currentScanMessage;
bool animating=false;

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (notes==NULL)
    notes = [[NSMutableArray alloc] init];
    
    self.backimage.alpha = .8;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    UIAlertView *messageAlert;
    switch (result)
    {
        case MFMailComposeResultCancelled:
            messageAlert  = [[UIAlertView alloc]
                             initWithTitle:@"Mail Cancelled" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            break;
        case MFMailComposeResultSaved:
            messageAlert  = [[UIAlertView alloc]
                             initWithTitle:@"Mail Saved" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            break;
        case MFMailComposeResultSent:
            messageAlert  = [[UIAlertView alloc]
                             initWithTitle:@"Mail Sent" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [notes removeAllObjects];
            [[NSUserDefaults standardUserDefaults] setObject:notes forKey:@"notes"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            break;
        case MFMailComposeResultFailed:
            messageAlert  = [[UIAlertView alloc]
                             initWithTitle:@"Mail sent failure:" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            break;
        default:
            break;
    }
    
    
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self performSelector:@selector(showMessage:) withObject:messageAlert afterDelay:0.4];
    
    
}

-(void)showMessage:(UIAlertView *)messageAlert
{
    [messageAlert show];
}



- (IBAction)send:(id)sender
    {
        [self.goldbar setAlpha:.65];
        [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(resetBars)
                                       userInfo:nil repeats:NO];
        
        notes = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"notes"]];
        if (notes.count>0){
        NSMutableString *mailBody = [[NSMutableString alloc]init];
        
        NSString* x = [notes componentsJoinedByString:@"<br>*****<br>"];
        
        [mailBody appendString: @"Here are my scans from today:<br><br>*****<br>"];
            
            
        if(x.length>0)
        [mailBody appendString: x];
        
        mailBody = (NSMutableString*)[mailBody stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
        [mailBody appendString:@"<br>*****<br><br>Thank you for visiting the 2014 Die Casting Congress & Tabletop!"];
        NSString *emailTitle = @"2014 Die Casting Congress & Tabletop Scans";
        
        NSString *messageBody = mailBody;
        
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:YES];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
        }
        else
        {
            NSString *titleString = @"You haven't added any notes yet!";
            NSString *messageString = @"Try scanning something.";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleString
                                                            message:messageString
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
}

- (IBAction)scan:(id)sender
{
    [self.graybar setAlpha:.65];
    [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(resetBars)
                                   userInfo:nil repeats:NO];
    [self checkCompatibility];
    [self setupDictionaries];
}

-(void)resetBars
{
    [self.graybar setAlpha:1];
    [self.ironbar setAlpha:1];
    [self.bronzebar setAlpha:1];
    [self.goldbar setAlpha:1];
}
- (IBAction)help:(id)sender {
    [self.bronzebar setAlpha:.65];
    [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(resetBars)
                                   userInfo:nil repeats:NO];
    if(animating == false){
        [self toggleFlag];
    
        int offset;
        if (self.backimage.hidden==false)
        {
            [self toggleTop];
            offset = 0;
        }
        else
        {
            [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(toggleTop)
                                       userInfo:nil repeats:NO];
            offset = 0.5;
        }
    
    
        [NSTimer scheduledTimerWithTimeInterval:.5-offset target:self selector:@selector(togglelabel1)
                                   userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:.75-offset target:self selector:@selector(togglelabel2)
                                   userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:1-offset target:self selector:@selector(togglelabel3)
                                   userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:1.25-offset target:self selector:@selector(togglelabel4)
                                   userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:1.5-offset target:self selector:@selector(togglelabel5)
                                   userInfo:nil repeats:NO];
        [NSTimer scheduledTimerWithTimeInterval:1.75-offset target:self selector:@selector(toggleFlag)
                                   userInfo:nil repeats:NO];
    }
}

- (IBAction)currentNotes:(id)sender {
    [self.ironbar setAlpha:.65];
    [NSTimer scheduledTimerWithTimeInterval:.2 target:self selector:@selector(resetBars)
                                   userInfo:nil repeats:NO];
}

- (IBAction)holdHelp:(id)sender {
    [self.bronzebar setAlpha:.65];
}

- (IBAction)holdSend:(id)sender {
    [self.goldbar setAlpha:.65];
}

- (IBAction)holdCurrentNotes:(id)sender {
    [self.ironbar setAlpha:.65];
}

- (IBAction)holdScan:(id)sender {
    [self.graybar setAlpha:.65];
}

- (IBAction)stopHoldScan:(id)sender {
    [self.graybar setAlpha:1];
}

- (IBAction)stopHoldCurrentNotes:(id)sender {
    [self.ironbar setAlpha:1];
}

- (IBAction)stopHoldSend:(id)sender {
    [self.goldbar setAlpha:1];
}

- (IBAction)stopHoldHelp:(id)sender {
    [self.bronzebar setAlpha:1];
}

-(void)toggleFlag
{
    animating = !animating;
}
-(void)toggleTop
{
    self.backimage.hidden = !self.backimage.hidden;
    self.label6.hidden = !self.label6.hidden;
    self.label7.hidden = !self.label7.hidden;
    self.label8.hidden = !self.label8.hidden;
}
-(void)togglelabel1
{
    self.label1.hidden = !self.label1.hidden;
}
-(void)togglelabel2
{
    self.label2.hidden = !self.label2.hidden;
}
-(void)togglelabel3
{
    self.label3.hidden = !self.label3.hidden;
}
-(void)togglelabel4
{
    self.label4.hidden = !self.label4.hidden;
}
-(void)togglelabel5
{
    self.label5.hidden = !self.label5.hidden;
}
-(void)checkCompatibility
{
    NSError *error;
    if ([PPBarcodeCoordinator isScanningUnsupported:&error]) {
        NSString *messageString = [error localizedDescription];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                        message:messageString
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
}
-(void)setupDictionaries
{
    // Create object which stores pdf417 framework settings
    NSMutableDictionary* coordinatorSettings = [[NSMutableDictionary alloc] init];
    
    // Set YES/NO for scanning pdf417 barcode standard (default YES)
    [coordinatorSettings setValue:[NSNumber numberWithBool:YES] forKey:kPPRecognizePdf417Key];
    
    // Set YES/NO for scanning qr code barcode standard (default NO)
    [coordinatorSettings setValue:[NSNumber numberWithBool:YES] forKey:kPPRecognizeQrCodeKey];
    
    [coordinatorSettings setValue:[NSNumber numberWithBool:YES] forKey:kPPRecognize1DBarcodesKey];
    // Set YES/NO for scanning code 128 barcode standard (default NO)
    [coordinatorSettings setValue:[NSNumber numberWithBool:YES] forKey:kPPRecognizeCode128Key];
    // Set YES/NO for scanning code 39 barcode standard (default NO)
    [coordinatorSettings setValue:[NSNumber numberWithBool:YES] forKey:kPPRecognizeCode39Key];
    // Set YES/NO for scanning EAN 8 barcode standard (default NO)
    [coordinatorSettings setValue:[NSNumber numberWithBool:YES] forKey:kPPRecognizeEAN8Key];
    // Set YES/NO for scanning EAN 13 barcode standard (default NO)
    [coordinatorSettings setValue:[NSNumber numberWithBool:YES] forKey:kPPRecognizeEAN13Key];
    // Set YES/NO for scanning ITF barcode standard (default NO)
    [coordinatorSettings setValue:[NSNumber numberWithBool:YES] forKey:kPPRecognizeITFKey];
    // Set YES/NO for scanning UPCA barcode standard (default NO)
    [coordinatorSettings setValue:[NSNumber numberWithBool:YES] forKey:kPPRecognizeUPCAKey];
    // Set YES/NO for scanning UPCE barcode standard (default NO)
    [coordinatorSettings setValue:[NSNumber numberWithBool:YES] forKey:kPPRecognizeUPCEKey];
    
        // There are 4 resolution modes:
    //      kPPUseVideoPreset640x480
    //      kPPUseVideoPresetMedium
    //      kPPUseVideoPresetHigh
    //      kPPUseVideoPresetHighest
    // Set only one.
    [coordinatorSettings setValue:[NSNumber numberWithBool:YES] forKey:kPPUseVideoPresetHighest];
    
    [coordinatorSettings setValue:@"1672a675bc3f3697c404a87aed640c8491b26a4522b9d4a2b61ad6b225e3b390d58d662131708451890b33"
                           forKey:kPPLicenseKey];
    
        [coordinatorSettings setValue:[NSNumber numberWithInt:UIInterfaceOrientationMaskAll] forKey:kPPHudOrientation];
    
    // Define the sound filename played on successful recognition
    NSString* soundPath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    [coordinatorSettings setValue:soundPath forKey:kPPSoundFile];
    
    // Allocate the recognition coordinator object
    PPBarcodeCoordinator *coordinator = [[PPBarcodeCoordinator alloc] initWithSettings:coordinatorSettings];
    // Create camera view controller
    UIViewController *cameraViewController = [coordinator cameraViewControllerWithDelegate:self];
    
    // present it modally
    cameraViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:cameraViewController animated:YES completion:nil];
    
}

- (void)cameraViewControllerWasClosed:(id<PPScanningViewController>)cameraViewController {
    // this stops the scanning and dismisses the camera screen
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraViewController:(id<PPScanningViewController>)cameraViewController
              obtainedResult:(PPScanningResult*)result {
    
    // continue scanning if nothing was returned
    if (result == nil) {
        return;
    }
    
    // this pauses scanning without dismissing camera screen
    [cameraViewController pauseScanning];
    currentCameraViewController = cameraViewController;
    
    // obtain UTF8 string from barcode data
    NSString *message = [[NSString alloc] initWithData:[result data] encoding:NSUTF8StringEncoding];
    if (message == nil) {
        // if UTF8 wasn't correct encoding, try ASCII
        message = [[NSString alloc] initWithData:[result data] encoding:NSASCIIStringEncoding];
    }
    NSLog(@"Barcode text:\n%@", message);
    
    // Check if barcode is uncertain
    // This is guaranteed not to happen if you didn't set kPPScanUncertainBarcodes key value
    BOOL isUncertain = [result isUncertain];
    if (isUncertain) {
        NSLog(@"Uncertain scanning data!");
        
        // Perform some kind of integrity validation to see if the returned value is really complete
        BOOL valid = YES;
        if (!valid) {
            // this resumes scanning, and tries agian to find valid barcode
            [cameraViewController resumeScanning];
            return;
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:message forKey:@"currentMessage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Add Note", nil];
    
    [alertView show];
    
    // don't forget to dismiss camera view controller when the alert view is dismissed
    // [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == [alertView cancelButtonIndex])
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"currentMessage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [currentCameraViewController resumeScanning];
    }
    
    else {
        [self dismissViewControllerAnimated:NO completion:^{[self performSegueWithIdentifier:@"addNote" sender:self];}];
    }
}

@end
