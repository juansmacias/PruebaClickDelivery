//
//  InicioViewController.h
//  PruebaClickdelivery
//
//  Created by Juan on 27/01/16.
//  Copyright © 2016 Juan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "InfoView.h"
#import "CentroPrueba.h"
#import <GoogleMaps/GoogleMaps.h>

@interface InicioViewController : UIViewController<GMSMapViewDelegate>

@property (strong, nonatomic) IBOutlet GMSMapView *viewMapa;
@property (weak, nonatomic) IBOutlet UIButton *btnDescubrelo;

@property (strong,nonatomic) GMSMarker* ciudad1;
@property (strong,nonatomic) GMSMarker* ciudad2;

@end

