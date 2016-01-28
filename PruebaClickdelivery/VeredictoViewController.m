//
//  VeredictoViewController.m
//  PruebaClickdelivery
//
//  Created by Juan on 27/01/16.
//  Copyright © 2016 Juan. All rights reserved.
//

#import "VeredictoViewController.h"

@interface VeredictoViewController ()

@end

@implementation VeredictoViewController

- (void)viewDidLoad {
    
    CentroPrueba* centro = [CentroPrueba darInstancia];
    int ganador = [centro mejorCiudad];
    if (ganador==1) {
        self.lblCiudadGanadora.text = centro.ciudad1.nombreCiudad;
        self.lblClimaGanador.text = centro.ciudad1.descripcionClima;
        self.lblTemperaturaGanadora.text = [NSString stringWithFormat:@"%d °C", centro.ciudad1.temperatura.intValue];
        
        self.lblnombrePerdedor.text = centro.ciudad2.nombreCiudad;
        self.lblClimaPerdedor.text = centro.ciudad2.descripcionClima;
        self.lblTemperaturaPerdedor.text = [NSString stringWithFormat:@"%d °C", centro.ciudad2.temperatura.intValue];
        
        self.lblResultado.text = [NSString stringWithFormat:@"Mejor quedate en %@.", centro.ciudad1.nombreCiudad];
    }
    else if (ganador==2)
    {
        self.lblCiudadGanadora.text = centro.ciudad2.nombreCiudad;
        self.lblClimaGanador.text = centro.ciudad2.descripcionClima;
        self.lblTemperaturaGanadora.text = [NSString stringWithFormat:@"%d °C", centro.ciudad2.temperatura.intValue];
        
        self.lblnombrePerdedor.text = centro.ciudad1.nombreCiudad;
        self.lblClimaPerdedor.text = centro.ciudad1.descripcionClima;
        self.lblTemperaturaPerdedor.text = [NSString stringWithFormat:@"%d °C", centro.ciudad1.temperatura.intValue];
        
        self.lblResultado.text = [NSString stringWithFormat:@"Te iria muy bien viajando y pasando unas buenas vacaciones en %@!", centro.ciudad2.nombreCiudad];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
