//
//  VeredictoViewController.h
//  PruebaClickdelivery
//
//  Created by Juan on 27/01/16.
//  Copyright © 2016 Juan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CentroPrueba.h"
#import "Ciudad.h"

@interface VeredictoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblResultado;
@property (weak, nonatomic) IBOutlet UILabel *lblCiudadGanadora;
@property (weak, nonatomic) IBOutlet UILabel *lblClimaGanador;
@property (weak, nonatomic) IBOutlet UILabel *lblTemperaturaGanadora;
@property (weak, nonatomic) IBOutlet UILabel *lblnombrePerdedor;
@property (weak, nonatomic) IBOutlet UILabel *lblClimaPerdedor;
@property (weak, nonatomic) IBOutlet UILabel *lblTemperaturaPerdedor;

@end
