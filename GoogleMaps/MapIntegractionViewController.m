//
//  MapIntegractionViewController.m
//  asap
//
//  Created by Gopal Gundaram on 31/10/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "MapIntegractionViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import <CoreLocation/CoreLocation.h>

@interface MapIntegractionViewController ()
{
   
}
@end

@implementation MapIntegractionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [self.locationManager requestAlwaysAuthorization];
        // Or [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    self.locationManager.delegate = self;
    self.location = [[CLLocation alloc] init];
    self.placesClient = [GMSPlacesClient sharedClient];
}
//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//    MKCoordinateRegion region;
//    MKCoordinateSpan span;
//    span.latitudeDelta = 0.005;
//    span.longitudeDelta = 0.005;
//    CLLocationCoordinate2D location;
//    location.latitude = userLocation.coordinate.latitude;
//    location.longitude = userLocation.coordinate.longitude;
//    region.span = span;
//    region.center = location;
//    [mapView setRegion:region animated:YES];
//}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    self.location = locations.lastObject;
//    self.lblLatitude.text = [NSString stringWithFormat:@"%f", self.location.coordinate.latitude];
//    self.lblLongitude.text = [NSString stringWithFormat:@"%f", self.location.coordinate.longitude];
//    self.lblAltitude.text = [NSString stringWithFormat:@"%f", self.location.altitude];
    
    NSLog(@"%@", self.location.description);
    
    [self.placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *likelihoodList, NSError *error) {
        
        if (error != nil) {
            NSLog(@"Current Place error %@", [error localizedDescription]);
            return;
        }
        NSMutableString *strPlaces = [NSMutableString stringWithString:@""];
        
        for (GMSPlaceLikelihood *likelihood in likelihoodList.likelihoods)
        {
            GMSPlace* place = likelihood.place;
            NSLog(@"Current Place name %@ at likelihood %g", place.name, likelihood.likelihood);
            NSLog(@"Current Place address %@", place.formattedAddress);
            NSLog(@"Current Place attributions %@", place.attributions);
            NSLog(@"Current PlaceID %@", place.placeID);
            [strPlaces appendString:place.name];
            [strPlaces appendString:@" "];
            [strPlaces appendFormat:@"%g",likelihood.likelihood];
            [strPlaces appendString:@"\n"];
        }
       // self.lblPlaces.text = strPlaces;
    }];
    GMSMarker * marker1 = [[GMSMarker alloc]init];
    marker1.map = nil;
   marker1.position = CLLocationCoordinate2DMake(+37.78583400,-122.40641700);
    //CLLocationCoordinate2DMake(manager.location., longtude);
    marker1.map = self.mapView;
    [self.mapView setSelectedMarker:marker1];
    NSLog(@"[self.mapView setSelectedMarker:self->marker]; %@",locations);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
