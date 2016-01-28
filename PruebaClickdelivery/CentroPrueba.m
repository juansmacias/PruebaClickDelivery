//
//  CentroPrueba.m
//  PruebaClickdelivery
//
//  Created by Juan on 27/01/16.
//  Copyright © 2016 Juan. All rights reserved.
//

#import "CentroPrueba.h"

@implementation CentroPrueba

@synthesize ciudad1 = _ciudad1,ciudad2 = _ciudad2;

static CentroPrueba* instancia =nil;

+(CentroPrueba*)darInstancia
{
    if (instancia==nil) {
        instancia = [[CentroPrueba alloc]init];
        [instancia inicializar];
    }
    return instancia;
}

-(void) inicializar
{
    
}

-(void)agregarCiudad:(NSString*)nombreCiudadP ConDescripcion:(NSString*) descripcionP ConTemperatura:(NSNumber*) temperaturaP ConCiudad: (int)numeroC
{
    if (numeroC==1) {
        self.ciudad1 = [[Ciudad alloc]init:nombreCiudadP ConDescripcion:descripcionP ConTemperatura:temperaturaP];
    }
    else if(numeroC==2){
        self.ciudad2 = [[Ciudad alloc]init:nombreCiudadP ConDescripcion:descripcionP ConTemperatura:temperaturaP];
    }
}

-(Ciudad*) darCiudadPorID:(int)idCiudad
{
    Ciudad* buscada = nil;
    if(idCiudad==1)
        buscada = self.ciudad1;
    else if(idCiudad==2)
        buscada = self.ciudad2;
    
    return buscada;
}

-(int) mejorCiudad
{
    int ganador = 0;
    NSArray* climaC1 =[self.ciudad1.descripcionClima componentsSeparatedByString:@" "];
    NSArray* climaC2 =[self.ciudad2.descripcionClima componentsSeparatedByString:@" "];
    if ([[climaC2 objectAtIndex:0] isEqualToString:@"Probabilidad"])
        ganador = 1;
    else if ([[climaC1 objectAtIndex:0] isEqualToString:@"Probabilidad"])
        ganador = 2;
    else{
        if (self.ciudad1.temperatura.intValue >self.ciudad2.temperatura.intValue)
            ganador = 1;
        else
            ganador = 2;
    }

    
    return ganador;
}

@end
