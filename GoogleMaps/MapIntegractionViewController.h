//
//  MapIntegractionViewController.h
//  asap
//
//  Created by Gopal Gundaram on 31/10/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;
@import GooglePlaces;
//#import <MapKit/MapKit.h>
@interface MapIntegractionViewController : UIViewController<CLLocationManagerDelegate,GMSMapViewDelegate,GMSAutocompleteViewControllerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property GMSPlacesClient *placesClient;
@property (strong , nonatomic) IBOutlet GMSMapView * mapView;
@end
