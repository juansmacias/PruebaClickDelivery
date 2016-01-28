//
//  InicioViewController.m
//  PruebaClickdelivery
//
//  Created by Juan on 27/01/16.
//  Copyright © 2016 Juan. All rights reserved.
//

#import "InicioViewController.h"

@interface InicioViewController ()

@end

@implementation InicioViewController

@synthesize ciudad1=_ciudad1,ciudad2 = _ciudad2;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    AppDelegate* appDelagate = [AppDelegate sharedAppDelegate];
    CLLocation* localizacionUsuario = appDelagate.localizacionActual;
    GMSCameraPosition *posCamara;
    if (localizacionUsuario!=nil) {
        posCamara = [GMSCameraPosition cameraWithLatitude:localizacionUsuario.coordinate.latitude longitude:localizacionUsuario.coordinate.longitude zoom:4];
        dispatch_queue_t colaT = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(colaT, ^{
           [self buscarClimaCiudad:localizacionUsuario.coordinate ConNumeroC:1];

        });
    }
    else
    {
        posCamara = [GMSCameraPosition cameraWithLatitude:4.719722 longitude:-74.036667 zoom:1];
        CLLocation* cl = [[CLLocation alloc] initWithLatitude:4.719722 longitude:-74.036667];
        dispatch_queue_t colaT = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(colaT, ^{
            [self buscarClimaCiudad:cl.coordinate ConNumeroC:1];
            
        });
    }
    self.viewMapa.delegate = self;
    [self.viewMapa setCamera:posCamara];
    self.viewMapa.settings.myLocationButton = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.viewMapa.myLocationEnabled = YES;
    });
    
    UIAlertController *alerta = [UIAlertController alertControllerWithTitle:@"Bienvenidos!" message:@"Vas o te quedas? es una app facil de usar que te ayuda a decidir si irte de viaje o mejor quedarse donde estas." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* salir = [UIAlertAction actionWithTitle:@"Salir" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action){
        
    }];
    
    [alerta addAction:salir];
    UIAlertAction* siguiente = [UIAlertAction actionWithTitle:@"Continuar" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              [self mostrarAlertaInstruciones];
                                                          }];
    [alerta addAction:siguiente];

    [self presentViewController:alerta animated:YES completion:nil];
}

#pragma mark - Metodos Vista


-(void) buscarClimaCiudad:(CLLocationCoordinate2D)localizacionU ConNumeroC: (int) numeroC
{
    AppDelegate* appDelagate = [AppDelegate sharedAppDelegate];
    NSString* urlCompletaString = [NSString stringWithFormat:@"%@/conditions/lang:SP/q/%f,%f.json",appDelagate.urlBaseClima,localizacionU.latitude,localizacionU.longitude];
    NSURL* url = [NSURL URLWithString:urlCompletaString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if(error==nil)
                {
                    NSDictionary* dicRespuesta = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                    NSDictionary* dicResponse = [dicRespuesta valueForKey:@"response"];
                    if ([dicResponse valueForKey:@"error"]==nil) {
                        
                        NSDictionary* dicObservaciones = [dicRespuesta valueForKey:@"current_observation"];
                        NSString* nombre= [[dicObservaciones valueForKey:@"display_location"]valueForKey:@"full"];
                        NSString* descripcion = [dicObservaciones valueForKey:@"weather"];
                        NSNumber* temperatura = [dicObservaciones valueForKey:@"temp_c"];
    
                        CentroPrueba *centro = [CentroPrueba darInstancia];
                        [centro agregarCiudad:nombre ConDescripcion:descripcion ConTemperatura:temperatura ConCiudad:numeroC];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self agregarMarcador:localizacionU ConNumeroC:numeroC];
                        });
                    }
                }
                else{
                    NSLog(@"Error de geolocalizacion: %@",error.description);
                }
            }] resume];
}
                       
-(void)agregarMarcador:(CLLocationCoordinate2D)localizacionU ConNumeroC:(int)numeroC
{
    GMSMarker* marcadorUsuario = [[GMSMarker alloc] init];

    marcadorUsuario.position = localizacionU;
    [marcadorUsuario setDraggable:YES];
    marcadorUsuario.title = @"Mi ubicacion!";
    marcadorUsuario.userData = [NSNumber numberWithInt:numeroC];
    if (numeroC==1) {
        if (self.ciudad1!=nil) {
            self.ciudad1.map = nil;
        }
        self.ciudad1 = marcadorUsuario;
    }
    else if (numeroC==2){
        if (self.ciudad2!=nil) {
            self.ciudad2.map = nil;
        }
        marcadorUsuario.icon = [GMSMarker markerImageWithColor:[UIColor greenColor]];
        self.ciudad2 = marcadorUsuario;
    }
    marcadorUsuario.map = self.viewMapa;
    [self.viewMapa setSelectedMarker:marcadorUsuario];
}

#pragma mark - GMS


-(UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker
{
    InfoView* info = [[[NSBundle mainBundle]loadNibNamed:@"InfoView" owner:self options:nil] objectAtIndex:0];
    CentroPrueba* centro = [CentroPrueba darInstancia];
    NSNumber* numeroCiudad = marker.userData;
    Ciudad* buscada = [centro darCiudadPorID:numeroCiudad.intValue];
    if(buscada!=nil)
    {
        if (numeroCiudad.intValue==1) {
            info.lblTitulo.text = @"Ciudad Inicial";
            info.lblTitulo.textColor = [UIColor redColor];
        }
        else if (numeroCiudad.intValue==2)
        {
            info.lblTitulo.text = @"Ciudad Final";
            info.lblTitulo.textColor = [UIColor greenColor];
        }
        info.lblCiudad.text = buscada.nombreCiudad;
        info.lblClima.text = buscada.descripcionClima;
        info.lblTemperatura.text = [NSString stringWithFormat:@"%d °C",buscada.temperatura.intValue];
    }
    return info;
}

- (void)mapView:(GMSMapView *)mapView
didTapAtCoordinate	:(CLLocationCoordinate2D)coordinate
{
    dispatch_queue_t colaT = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(colaT, ^{
        [self buscarClimaCiudad:coordinate ConNumeroC:2];
    });
    self.btnDescubrelo.hidden = NO;	
}

-(void)mapView:(GMSMapView *)mapView didEndDraggingMarker:(GMSMarker *)marker
{
    dispatch_queue_t colaT = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(colaT, ^{
        NSNumber* numeroC = marker.userData;
        [self buscarClimaCiudad:marker.position ConNumeroC: numeroC.intValue];
    });
}

#pragma mark - Alertas

-(void)mostrarAlertaInstruciones
{
        UIAlertController *alerta = [UIAlertController alertControllerWithTitle:@"Instrucciones" message:@"Tu ubicacion inicial sera tu ciudad inicial y para seleccionar tu ciudad final solo tienes que seleccionar una ciudad en el mapa." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* salir = [UIAlertAction actionWithTitle:@"Salir" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action){
        
    }];
    
    [alerta addAction:salir];
    UIAlertAction* siguiente = [UIAlertAction actionWithTitle:@"Continuar" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                          [self mostrarAlertaFinal];
                                                      }];
    [alerta addAction:siguiente];
    
    [self presentViewController:alerta animated:YES completion:nil];
}

-(void)mostrarAlertaFinal
{
    UIAlertController *alerta = [UIAlertController alertControllerWithTitle:@"Instrucciones" message:@"Al seleccionar las dos ciudades de tu preferencia podras averiguar si te vas o te quedas!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* siguiente = [UIAlertAction actionWithTitle:@"Comenzar" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                        
                                                      }];
    [alerta addAction:siguiente];
    
    [self presentViewController:alerta animated:YES completion:nil];
}


@end
