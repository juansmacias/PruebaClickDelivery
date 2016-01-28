//
//  CentroPrueba.h
//  PruebaClickdelivery
//
//  Created by Juan on 27/01/16.
//  Copyright © 2016 Juan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ciudad.h"

@interface CentroPrueba : NSObject

@property (strong,nonatomic) Ciudad* ciudad1;
@property (strong,nonatomic) Ciudad* ciudad2;

+(CentroPrueba*)darInstancia;

-(void)agregarCiudad:(NSString*)nombreCiudadP ConDescripcion:(NSString*) descripcionP ConTemperatura:(NSNumber*) temperaturaP ConCiudad: (int)numeroC;

-(Ciudad*) darCiudadPorID:(int)idCiudad;

-(int) mejorCiudad;

@end
