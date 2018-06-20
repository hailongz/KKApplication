//
//  KKGeoLocation.m
//  KKApplication
//
//  Created by hailong11 on 2018/6/19.
//  Copyright © 2018年 kkmofang.cn. All rights reserved.
//

#import "KKGeoLocation.h"
#import "KKProtocol.h"
#import <CoreLocation/CoreLocation.h>

@interface KKGeoLocationObjectObserver : NSObject

@property(nonatomic,strong) NSArray * keys;
@property(nonatomic,strong) NSMutableDictionary * data;

@end

@interface KKGeoLocationObject : NSObject<CLLocationManagerDelegate,KKObjectRecycle> {
    NSMutableArray * _observers;
    CLLocationManager * _manager;
}

@property(nonatomic,weak) KKApplication * app;

-(void) addObserverWithKeys:(NSArray *) keys data:(NSMutableDictionary *) data ;

-(void) startUpdateLocation;


@end

@implementation KKGeoLocationObject

-(void) addObserverWithKeys:(NSArray *) keys data:(NSMutableDictionary *) data  {
    KKGeoLocationObjectObserver * v = [[KKGeoLocationObjectObserver alloc] init];
    v.keys = keys;
    v.data = data;
    if(_observers == nil) {
        _observers = [[NSMutableArray alloc] initWithCapacity:4];
    }
    [_observers addObject:v];
    [self startUpdateLocation];
}

-(void) dealloc {
    [_manager setDelegate:nil];
    [_manager stopUpdatingLocation];
}

-(void) startUpdateLocation {
    if(_manager == nil) {
        _manager = [[CLLocationManager alloc] init];
        [_manager setDelegate:self];
        [_manager requestWhenInUseAuthorization];
        [_manager setPausesLocationUpdatesAutomatically:YES];
        [_manager setDesiredAccuracy:kCLLocationAccuracyBest];
    }
    [_manager startUpdatingLocation];
}

-(void) recycle {
    [_manager setDelegate:nil];
    [_manager stopUpdatingLocation];
    _manager = nil;
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if([locations count] >0 ) {
        CLLocation * loc = [locations objectAtIndex:0];
        
        CLLocationCoordinate2D coordinate = loc.coordinate;
        
        for(KKGeoLocationObjectObserver * v in _observers) {
            v.data[@"lat"] = @(coordinate.latitude);
            v.data[@"lng"] = @(coordinate.longitude);
            [self.app.observer set:v.keys value:v.data];
        }
        
        [manager stopUpdatingLocation];
        [_observers removeAllObjects];
    }
}

-(void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    for(KKGeoLocationObjectObserver * v in _observers) {
        v.data[@"errmsg"] = [error localizedDescription];
        v.data[@"errno"] = @(300);
        [self.app.observer set:v.keys value:v.data];
    }
    
    [manager stopUpdatingLocation];
    [_observers removeAllObjects];
    
}

@end

@implementation KKGeoLocationObjectObserver

@end

@implementation KKGeoLocation

+(void) getLocation:(__weak KKApplication *) app keys:(NSArray *) keys data:(NSMutableDictionary *) data {
    
    if(app != nil) {
        
        if([CLLocationManager locationServicesEnabled]) {
            
            KKGeoLocationObject * v = (KKGeoLocationObject *) [app objectRecycleForKey:@"KKGeoLocationObject"];
            
            if(v == nil) {
                v = [[KKGeoLocationObject alloc] init];
                v.app = app;
                [app setObjectRecycle:v forKey:@"KKGeoLocationObject"];
            }
            
            [v addObserverWithKeys:keys data:data];
            
            
        } else {
            data[@"lat"] = @(0);
            data[@"lng"] = @(0);
            data[@"disabled"] = @(true);
            [app.observer set:keys value:data];
        }
    }
    
}

+(void) openlibs {
    
    [[KKProtocol main] addOpenApplication:^(KKApplication *app) {
    
        __weak KKApplication * a = app;
        
        [app.observer on:^(id value, NSArray *changedKeys, void *context) {
            
            if(value && [value isKindOfClass:[NSMutableDictionary class]]) {
                id keys = [value kk_getValue:@"keys"];
                id data = [value kk_getValue:@"data"];
                if([keys isKindOfClass:[NSArray class]]) {
                    if(data == nil || ![data isKindOfClass:[NSMutableDictionary class]]) {
                        data = [[NSMutableDictionary alloc] initWithCapacity:4];
                    }
                    [self getLocation:a keys:keys data:data];
                }
            }
            
        } keys:@[@"geo",@"location"] context:nil];
        
    }];
    
}

@end
