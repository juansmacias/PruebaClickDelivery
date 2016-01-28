//
//  Ciudad.m
//  PruebaClickdelivery
//
//  Created by Juan on 27/01/16.
//  Copyright © 2016 Juan. All rights reserved.
//

#import "Ciudad.h"

@implementation Ciudad

@synthesize nombreCiudad = _nombreCiudad;
@synthesize descripcionClima = _descripcionClima;
@synthesize temperatura = _temperatura;

-(id)init:(NSString*)nombreCiudadP ConDescripcion:(NSString*) descripcionP ConTemperatura:(NSNumber*) temperaturaP
{
    self = [super init];
    if (self) {
        self.nombreCiudad = nombreCiudadP;
        self.descripcionClima = descripcionP;
        self.temperatura = temperaturaP;
    }
    return self;
}

@end
