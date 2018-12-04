//
//  GoogleMapViewController.m
//  asap
//
//  Created by Gopal Gundaram on 30/10/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "GoogleMapViewController.h"
@import GoogleMaps;
@import GooglePlaces;

@interface GoogleMapViewController ()<GMSAutocompleteResultsViewControllerDelegate>
@end
double lattitude = 0.0;
double longtude = 0.0;
@implementation GoogleMapViewController
{
    GMSMapView *mapView;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSString *address;
    GMSMarker *marker;
    CLLocation *location;
    UITextField *textField;
    CLLocationCoordinate2D CLcoordinate;
    int screenwidth;
    int screenheight;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    mapView = [[GMSMapView alloc]init];
    self.view = mapView;
    geocoder = [[CLGeocoder alloc] init];
    marker = [[GMSMarker alloc] init];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager requestWhenInUseAuthorization];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestWhenInUseAuthorization];
    CLcoordinate = [location coordinate];
    NSString *latitude1 = [NSString stringWithFormat:@"%f", CLcoordinate.latitude];
    NSString *longitude1 = [NSString stringWithFormat:@"%f", CLcoordinate.longitude];
    lattitude = [latitude1 doubleValue];
    longtude = [longitude1 doubleValue];
    //    GMSCameraPosition * camera =  [GMSCameraPosition cameraWithLatitude:lattitude
    //                                                             longitude:longtude zoom:15];
    GMSCameraPosition * camera = [GMSCameraPosition cameraWithLatitude:lattitude longitude:longtude zoom:15];
    // mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.delegate = self;
    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
    mapView.camera = camera;
    
    [mapView animateToCameraPosition:camera];
    self.navigationController.navigationBarHidden = NO;
    // [self.navigationController setNavigationBarHidden:NO];
    [locationManager startUpdatingLocation];
#define SYSTEM_VERSION_LESS_THAN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
    
    //First, checking if the location services are enabled
    if(![CLLocationManager locationServicesEnabled]){
        //  [self showMessage:@"Please enable location services to detect location!" withTitle:@"Location not enabled"];
        
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            //Now if the location is denied.
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Enable location permission"
                                                  message:@"To auto detect location, please enable location services for this app"
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            // alertController.view.tintColor = AppColor;
            UIAlertAction *cancelAction = [UIAlertAction
                                           actionWithTitle:@"Dismiss"
                                           style:UIAlertActionStyleCancel
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Cancel action");
                                           }];
            
            UIAlertAction *goToSettings = [UIAlertAction
                                           actionWithTitle:@"Settings"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               //Simple way to open settings module
                                               NSString* urlstr = SYSTEM_VERSION_LESS_THAN(@"10.0") ? @"prefs:root=LOCATION_SERVICES" : @"App-Prefs:root=Privacy&path=LOCATION";
                                               NSURL *url = [NSURL URLWithString:urlstr];
                                               [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:nil];
                                           }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:goToSettings];
            [self presentViewController:alertController animated:YES completion:^{
                // alertController.view.tintColor = AppColor;
            }];
        }
    }
    
    // [self.btnhome setBackgroundColor:[UIColor colorWithRed:199.0/255 green:47.0/255 blue:130.0/255 alpha:1]];
    UIColor *color = [UIColor colorWithRed:199.0/255 green:47.0/255 blue:130.0/255 alpha:1];
    //    self.btnhome.layer.borderWidth = 1.0f;
    //    self.btnhome.layer.cornerRadius = 3;
    //    self.btnhome.layer.borderColor = [UIColor whiteColor].CGColor;
    //    self.btnwork.layer.borderWidth = 1.0f;
    //    self.btnwork.layer.cornerRadius = 3;
    //    self.btnwork.layer.borderColor = [UIColor blackColor].CGColor;
    //    self.btnother.layer.borderWidth = 1.0f;
    //    self.btnother.layer.cornerRadius = 3;
    //    self.btnother.layer.borderColor = [UIColor blackColor].CGColor;
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    location = [locations lastObject];
    NSLog(@"lat%f - lon%f", location.coordinate.latitude, location.coordinate.longitude);
    lattitude = location.coordinate.latitude;
    longtude = location.coordinate.longitude;
    
    
    [[GMSGeocoder geocoder] reverseGeocodeCoordinate:CLLocationCoordinate2DMake(lattitude,longtude) completionHandler:^(GMSReverseGeocodeResponse* response, NSError* error) {
        NSArray *adrs = [[NSArray alloc]init];
        for(GMSAddress* addressObj in [response results])
        {
            NSLog(@"coordinate.latitude=%f", addressObj.coordinate.latitude);
            NSLog(@"coordinate.longitude=%f", addressObj.coordinate.longitude);
            NSLog(@"thoroughfare=%@", addressObj.thoroughfare);
            NSLog(@"locality=%@", addressObj.locality);
            NSLog(@"subLocality=%@", addressObj.subLocality);
            NSLog(@"administrativeArea=%@", addressObj.administrativeArea);
            NSLog(@"postalCode=%@", addressObj.postalCode);
            NSLog(@"country=%@", addressObj.country);
            NSLog(@"lines=%@", addressObj.lines);
            
            lattitude = addressObj.coordinate.latitude;
            longtude = addressObj.coordinate.longitude;
            NSNumber *mylati = [NSNumber numberWithDouble:lattitude];
            NSString *latti = [mylati stringValue];
            NSNumber *mylong = [NSNumber numberWithDouble:longtude];
            NSString *longt = [mylong stringValue];
            adrs = addressObj.lines;
            NSString *fulladrs = [adrs objectAtIndex:0];
            // imporet kjknjknjk-===--==-==-=-=-=--=-=-=-=-=-=-==--=-=-=-=-=-==-=-=--=-==--=-=
            //self.lbllocation.text = fulladrs;
            // imporet kjknjknjk-===--==-==-=-=-=--=-=-=-=-=-=-==--=-=-=-=-=-==-=-=--=-==--=-=
            
            
            GMSCameraPosition *camera =  [GMSCameraPosition cameraWithLatitude:lattitude
                                                                     longitude:longtude zoom:17];
            // mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
            mapView.delegate = self;
            mapView.myLocationEnabled = YES;
            mapView.settings.myLocationButton = YES;
            mapView.camera = camera;
            
            marker.title = fulladrs;
            marker.snippet = addressObj.country;
            //marker.icon = [UIImage imageNamed:@"pin.png"];
            // marker.map = mapView;
            marker.draggable = YES;
            // [mapView setSelectedMarker:marker];
            [mapView animateToCameraPosition:camera];
            
            
            
            break;
            
        }
        //[TRProgressHUD hideHUDForView:self.view animated:YES];
        
    }];
    [locationManager stopUpdatingLocation];
    
}
-(void)PressingBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    // your code
    NSLog(@"Location");
}

- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position
{
    CLcoordinate = CLLocationCoordinate2DMake(lattitude, longtude);
    marker.position = CLcoordinate;
    marker.position = CLLocationCoordinate2DMake(lattitude, longtude);
    // [marker setTitle:NSLocalizedString(@"current_location_title", nil)];
    marker.title = placemark.country;
    marker.snippet = placemark.name;
    //marker.icon = [UIImage imageNamed:@"pin.png"];
    marker.map = mapView;
    marker.draggable = YES;
    [mapView setSelectedMarker:marker];
}
- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"Location");
}
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"Location");
    lattitude = coordinate.latitude;
    longtude = coordinate.longitude;
    
    geocoder = [[CLGeocoder alloc]init];
    location = [[CLLocation alloc]initWithLatitude:lattitude longitude:longtude]; //insert your coordinates
    
    
    [[GMSGeocoder geocoder] reverseGeocodeCoordinate:CLLocationCoordinate2DMake(lattitude,longtude) completionHandler:^(GMSReverseGeocodeResponse* response, NSError* error) {
        NSArray *adrs = [[NSArray alloc]init];
        for(GMSAddress* addressObj in [response results])
        {
            NSLog(@"coordinate.latitude=%f", addressObj.coordinate.latitude);
            NSLog(@"coordinate.longitude=%f", addressObj.coordinate.longitude);
            NSLog(@"thoroughfare=%@", addressObj.thoroughfare);
            NSLog(@"locality=%@", addressObj.locality);
            NSLog(@"subLocality=%@", addressObj.subLocality);
            NSLog(@"administrativeArea=%@", addressObj.administrativeArea);
            NSLog(@"postalCode=%@", addressObj.postalCode);
            NSLog(@"country=%@", addressObj.country);
            NSLog(@"lines=%@", addressObj.lines);
            
            
            lattitude = addressObj.coordinate.latitude;
            longtude = addressObj.coordinate.longitude;
            NSNumber *mylati = [NSNumber numberWithDouble:lattitude];
            NSString *latti = [mylati stringValue];
            NSNumber *mylong = [NSNumber numberWithDouble:longtude];
            NSString *longt = [mylong stringValue];
            adrs = addressObj.lines;
            NSString *fulladrs = [adrs objectAtIndex:0];
            CLcoordinate = CLLocationCoordinate2DMake(lattitude, longtude);
            marker.position = CLcoordinate;
            marker.position = CLLocationCoordinate2DMake(lattitude, longtude);
            // [marker setTitle:NSLocalizedString(@"current_location_title", nil)];
            marker.title = fulladrs;
            marker.snippet = addressObj.locality;
            //marker.icon = [UIImage imageNamed:@"pin.png"];
            marker.map = mapView;
            marker.draggable = YES;
            [mapView setSelectedMarker:marker];
            
            break;
        }
    }];
    
    
}
- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backBT:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
// GMSMapView delegate methods
- (void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture
{
    mapView.myLocationEnabled = true;
    //    if(gesture){
    //        mapView.selectedMarker = nil;
    //    }
}
- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position{
    mapView.myLocationEnabled = true;
}

// GMSAutocompleteViewController delegate methods
/*- (void)viewController:(GMSAutocompleteViewController *)viewController
 didAutocompleteWithPlace:(GMSPlace *)place {
 
 //    GMSCameraPosition *camera =  [GMSCameraPosition cameraWithLatitude:place.coordinate.latitude
 //                                                             longitude:place.coordinate.longitude zoom:15];
 
 lattitude = place.coordinate.latitude;
 longtude = place.coordinate.longitude;
 
 [[GMSGeocoder geocoder] reverseGeocodeCoordinate:CLLocationCoordinate2DMake(lattitude,longtude) completionHandler:^(GMSReverseGeocodeResponse* response, NSError* error) {
 NSArray *adrs = [[NSArray alloc]init];
 for(GMSAddress* addressObj in [response results])
 {
 NSLog(@"coordinate.latitude=%f", addressObj.coordinate.latitude);
 NSLog(@"coordinate.longitude=%f", addressObj.coordinate.longitude);
 NSLog(@"thoroughfare=%@", addressObj.thoroughfare);
 NSLog(@"locality=%@", addressObj.locality);
 NSLog(@"subLocality=%@", addressObj.subLocality);
 NSLog(@"administrativeArea=%@", addressObj.administrativeArea);
 NSLog(@"postalCode=%@", addressObj.postalCode);
 NSLog(@"country=%@", addressObj.country);
 NSLog(@"lines=%@", addressObj.lines);
 
 
 lattitude = addressObj.coordinate.latitude;
 longtude = addressObj.coordinate.longitude;
 NSNumber *mylati = [NSNumber numberWithDouble:lattitude];
 NSString *latti = [mylati stringValue];
 NSNumber *mylong = [NSNumber numberWithDouble:longtude];
 NSString *longt = [mylong stringValue];
 adrs = addressObj.lines;
 NSString *fulladrs = [adrs objectAtIndex:0];
 
 GMSCameraPosition *camera =  [GMSCameraPosition cameraWithLatitude:lattitude
 longitude:longtude zoom:15];
 // mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
 mapView.delegate = self;
 mapView.myLocationEnabled = YES;
 mapView.settings.myLocationButton = YES;
 mapView.camera = camera;
 
 marker.title = fulladrs;
 marker.snippet = addressObj.country;
 //marker.icon = [UIImage imageNamed:@"pin.png"];
 // marker.map = mapView;
 marker.draggable = YES;
 [mapView setSelectedMarker:marker];
 [mapView animateToCameraPosition:camera];
 [self dismissViewControllerAnimated:YES completion:nil];
 [locationManager stopUpdatingLocation];
 
 
 
 
 //            CLcoordinate = CLLocationCoordinate2DMake(lattitude, longtude);
 //            marker.position = CLcoordinate;
 //            marker.position = CLLocationCoordinate2DMake(lattitude, longtude);
 //            // [marker setTitle:NSLocalizedString(@"current_location_title", nil)];
 //            marker.title = fulladrs;
 //            marker.snippet = addressObj.locality;
 //            //marker.icon = [UIImage imageNamed:@"pin.png"];
 //            marker.map = mapView;
 //            marker.draggable = YES;
 //            [mapView setSelectedMarker:marker];
 
 break;
 }
 }];
 
 
 
 
 //    mapView.delegate = self;
 //    mapView.camera = camera;
 //    marker.title = place.formattedAddress;
 //    marker.snippet = place.name;
 //    //marker.icon = [UIImage imageNamed:@"pin.png"];
 //
 //     NSString* adrs = place.formattedAddress;
 //     singleton.fulladdress = adrs;
 //
 //
 //     singleton.localityname = place.name;
 //
 //    marker.map = mapView;
 //    marker.draggable = YES;
 //    //  [mapView setSelectedMarker:marker];
 //    //  [mapView animateToCameraPosition:camera];
 //    [mapView setSelectedMarker:marker];
 //
 //    // Do something with the selected place.
 //    NSLog(@"Place name %@", place.name);
 //    NSLog(@"Place address %@", place.formattedAddress);
 //    NSLog(@"Place attributions %@", place.attributions.string);
 
 
 
 }*/

//- (IBAction)onLaunchClicked:(id)sender {
//    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
//    acController.delegate = self;
//    [self presentViewController:acController animated:YES completion:nil];
//}

// Handle the user's selection.

- (IBAction)autoSearch:(UIBarButtonItem *)sender {
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
}

// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end

