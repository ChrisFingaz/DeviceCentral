//
//  DeviceAddViewController.m
//  DeviceCentral
//
//  Created by Oli Griffiths on 05/11/2013.
//  Copyright (c) 2013 Oli Griffiths. All rights reserved.
//

#import "DeviceAddViewController.h"

@interface DeviceAddViewController ()

@end

@implementation DeviceAddViewController


-(void)addDevice:(void (^)(void))complete
{
    DevicesModel *model = [DevicesModel new];

    if([self.nameTextField.text isEqualToString:@""])
    {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];

    }else if(![self.identifierTextField.text isEqualToString:@""] && [model fetchWithId:self.identifierTextField.text] != nil){

        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter a unique identifier" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }else{

        Device *device = (Device*)[model newObject];
        device.name = self.nameTextField.text;
        device.id = self.identifierTextField.text;

        if([device.id isEqualToString:@""]){
            NSManagedObjectID *managedObject = device.objectID;
            NSURL *url = managedObject.URIRepresentation;
            device.id = [[url path] stringByReplacingOccurrencesOfString:@"/Device/" withString:@""];
        }

        [model saveContext];
        
        NSLog(@"Added device : %@ " , self.nameTextField.text);
        
        //Call completion block
        complete();
    }
}

@end
