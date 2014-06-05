//
//  ARCurrentLocationViewController.m
//  MyLocations
//
//  Created by Anton Rivera on 6/3/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "ARCurrentLocationViewController.h"

@interface ARCurrentLocationViewController ()

@property (nonatomic, weak) IBOutlet UILabel *messageLabel;
@property (nonatomic, weak) IBOutlet UILabel *latitudeLabel;
@property (nonatomic, weak) IBOutlet UILabel *longitudeLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UIButton *tagButton;
@property (nonatomic, weak) IBOutlet UIButton *getButton;

- (IBAction)getLocation:(id)sender;

@end

@implementation ARCurrentLocationViewController
{
    CLLocationManager *_locationManager;
    CLLocation *_location;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self updateLabels];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getLocation:(id)sender
{
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [_locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    // kclErrorDenied - User didn't allow us to use their current location
    NSLog(@"didFailWithError %@", error);
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    NSLog(@"didUpdateLocations %@", newLocation);
    
    _location = newLocation;
    [self updateLabels];
}

- (void)updateLabels {
    if (_location != nil) {
        self.latitudeLabel.text = [NSString stringWithFormat: @"%.8f", _location.coordinate.latitude];
        self.longitudeLabel.text = [NSString stringWithFormat: @"%.8f", _location.coordinate.longitude]; self.tagButton.hidden = NO;
        self.messageLabel.text = @"";
    } else {
        self.latitudeLabel.text = @""; self.longitudeLabel.text = @"";
        self.addressLabel.text = @"";
        self.tagButton.hidden = YES;
        self.messageLabel.text = @"Press the Button to Start";
    }
}

@end















