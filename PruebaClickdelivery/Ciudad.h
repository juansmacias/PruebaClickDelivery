//
//  Ciudad.h
//  PruebaClickdelivery
//
//  Created by Juan on 27/01/16.
//  Copyright © 2016 Juan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ciudad : NSObject

@property(strong,nonatomic) NSString* nombreCiudad;
@property(strong,nonatomic) NSString* descripcionClima;
@property(strong,nonatomic) NSNumber* temperatura;


-(id)init:(NSString*)nombreCiudadP ConDescripcion:(NSString*) descripcionP ConTemperatura:(NSNumber*) temperaturaP;

@end
