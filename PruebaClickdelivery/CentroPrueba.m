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
    int puntajeGanador = 0;
    for (int i=1; i<3; i++) {
        Ciudad* actual;
        if (i==1) {
            actual = self.ciudad1;
            
        }
        else
        {
            actual =self.ciudad2;
            
        }
        
        int puntaje = 0;
        
        puntaje+=actual.temperatura.intValue;
        
        if ([actual.descripcionClima isEqual:@"Despejado"]) {
            puntaje+=20;
        }
        else if([actual.descripcionClima rangeOfString:@"nublado" options:NSCaseInsensitiveSearch].location != NSNotFound || [actual.descripcionClima rangeOfString:@"nubes" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            if ([actual.descripcionClima isEqual:@"Nulado"])
                puntaje+=10;
            else if([actual.descripcionClima rangeOfString:@"parcialmente" options:NSCaseInsensitiveSearch].location != NSNotFound)
                puntaje+=15;
            else if([actual.descripcionClima rangeOfString:@"muy" options:NSCaseInsensitiveSearch].location != NSNotFound)
                puntaje+=5;
            else{
                puntaje+=11;
            }
        }
        else if ([actual.descripcionClima rangeOfString:@"lluvia" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            if ([actual.descripcionClima isEqual:@"Lluvia"])
                puntaje-=10;
            else if ([actual.descripcionClima rangeOfString:@"probabilidad" options:NSCaseInsensitiveSearch].location != NSNotFound)
                puntaje-=5;
            else{
                puntaje-=8;
            }
        }
        else if ([actual.descripcionClima rangeOfString:@"tormenta" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            if([actual.descripcionClima isEqual:@"Tormenta"])
                puntaje-=20;
            else if ([actual.descripcionClima rangeOfString:@"probabilidad" options:NSCaseInsensitiveSearch].location != NSNotFound)
                puntaje-=10;
            else{
                puntaje-=13;
            }
        }
        else if ([actual.descripcionClima rangeOfString:@"nieve" options:NSCaseInsensitiveSearch].location != NSNotFound)
            puntaje+=20;
        
        if (puntaje>=puntajeGanador) {
            puntajeGanador = puntaje;
            ganador = i;
        }

    }

    
    return ganador;
}

@end
