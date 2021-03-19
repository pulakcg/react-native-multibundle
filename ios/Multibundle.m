#import "Multibundle.h"
#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>

@implementation Multibundle

RCT_EXPORT_MODULE(Multibundle)

@synthesize bridge = _bridge;

RCT_EXPORT_METHOD(loadBundle:(NSString *)bundleName
    bundleId:(nonnull NSNumber *)bundleId
    resolver:(RCTPromiseResolveBlock)resolve
    rejecter:(RCTPromiseRejectBlock)reject)
{
    RCTBridge *bridge = _bridge;

    @try
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];  
        NSString *str = [documentsDirectory stringByAppendingFormat:@"/%@.ios.bundle",bundleName];
        if([bundleName isEqual:@"index"] || [bundleName isEqual:@"host"])
        {
            str = [documentsDirectory stringByAppendingFormat:@"/%@.ios.bundle",bundleName];
        }
        else{
            str = [documentsDirectory stringByAppendingFormat:@"/bundle%@/%@.ios.bundle",bundleName,bundleName];
        }
        
        [bridge registerSegmentWithId:[bundleId unsignedIntegerValue] path:str];

        resolve(nil);
        
    } @catch (NSException * exception)
    {
        reject(@"error", @"error", nil);
    }
}

@end
