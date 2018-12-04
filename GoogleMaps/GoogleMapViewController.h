//
//  GoogleMapViewController.h
//  asap
//
//  Created by Gopal Gundaram on 30/10/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;
@import GooglePlaces;
@import CoreLocation;
@interface GoogleMapViewController : UIViewController<CLLocationManagerDelegate,GMSMapViewDelegate,UITextFieldDelegate,GMSAutocompleteViewControllerDelegate>
{
    CLLocationManager *locationManager;
}
@end
