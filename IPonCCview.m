#import "IPonCCview.h"

#include <ifaddrs.h>
#include <arpa/inet.h>


@implementation IPonCCview

-(IPonCCview *) init {
    self = [super init];
    self.amExpanded = NO;
    self.amTransitioning = NO;
    return self;
}

-(void)loadView {
    [super loadView];
    UILabel *txtLabel;
    txtLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, [self view].bounds.size.width-20, [self view].bounds.size.height-20)];
    txtLabel.textColor = [UIColor whiteColor];
    txtLabel.textAlignment = NSTextAlignmentCenter;

    if ( self.amTransitioning ){
        txtLabel.text = @"";
    } else if ( self.amExpanded ){
        NSDictionary *ifsAndAdrs = [self ipAddressList];
        __block NSMutableString *adrStr = [NSMutableString stringWithString:@""];
        [ifsAndAdrs enumerateKeysAndObjectsUsingBlock:^(NSString *ifn, NSArray *adrs, BOOL *stop){
            [adrStr appendFormat:@"%@%@", [adrStr length] > 0 ? @"\n\n" : @"", ifn];
            [adrs enumerateObjectsUsingBlock:^(NSString *adr, NSUInteger idx, BOOL *stap){
                [adrStr appendFormat:@"\n%@", adr];
            }];
        }];
        txtLabel.text = [NSString stringWithString:adrStr];
        txtLabel.numberOfLines = 0;
        txtLabel.clipsToBounds = NO;
//        txtLabel.adjustsFontSizeToFitWidth = YES; // doesn't work like that for the UILabel, I guess only if thw 1st line was the longest...
//        txtLabel.minimumScaleFactor = 0.2; // doesn't work like that for the UILabel
    } else {
        txtLabel.text = @"IP";
    }
    
    [self.view addSubview:txtLabel];
}

// so it gets the "IP" text there right away
- (void)willBecomeActive {
    [self loadView];
}

//// TODO: where to get the device screen size... 320x400 might not be good for smaller/older devices, and stupidly small for Pluses & iPads
- (CGFloat)preferredExpandedContentHeight {
    return 400;
}
- (CGFloat)preferredExpandedContentWidth {
    return 320;
}

- (BOOL)providesOwnPlatter {
    return NO;
}
- (void)didTransitionToExpandedContentMode:(BOOL)didTransition {
    self.amExpanded = didTransition;
    self.amTransitioning = NO;
    [self loadView]; // reload it here
}

// need to clear it before it transitions, else the previous content will flicker for a moment there
- (void)willTransitionToExpandedContentMode:(BOOL)willTransition {
    self.amTransitioning = YES;
    [self loadView];
    self.amExpanded = willTransition;
}

// See https://stackoverflow.com/questions/6807788/how-to-get-ip-address-of-iphone-programmatically
- (NSDictionary *)ipAddressList {

    // I want to show the ipv4 addresses 1st, so populate 2 separate dicts and combine later
    NSMutableDictionary *adrs4 = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *adrs6 = [[NSMutableDictionary alloc] init];
    
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        NSString *ifName;
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if((temp_addr->ifa_addr) && ((temp_addr->ifa_addr->sa_family == AF_INET) || (temp_addr->ifa_addr->sa_family == AF_INET6))) {
                ifName = [NSString stringWithUTF8String:temp_addr->ifa_name];
                if ([ifName hasPrefix:@"en"]){
                    ifName = @"WiFi";
                } else if ([ifName hasPrefix:@"pdp_ip"]) {
                    ifName = @"Cellular";
                } else if ([ifName hasPrefix:@"utun"] && ![ifName isEqualToString:@"utun0"]){ // I dunno, utun0 is some xyz.members.btmm.icloud.com thing
                    ifName = @"VPN";
                } else {
                    ifName = @"";
                }
                if (![ifName isEqualToString:@""]){
                    if (temp_addr->ifa_addr->sa_family == AF_INET){
                        if ( [adrs4 objectForKey:ifName] == NULL ){
                            [adrs4 setObject:[[NSMutableArray alloc] init] forKey:ifName];
                        }
                        // Get NSString from C String
                        [[adrs4 objectForKey:ifName] addObject:[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]];
                    } else {
                        if ( [adrs6 objectForKey:ifName] == NULL ){
                            [adrs6 setObject:[[NSMutableArray alloc] init] forKey:ifName];
                        }
                  // See https://stackoverflow.com/questions/33125710/how-to-get-ipv6-interface-address-using-getifaddr-function/33127330#33127330
                        char addr[39];
                        struct sockaddr_in6 *in6 = (struct sockaddr_in6*) temp_addr->ifa_addr;
                        inet_ntop(AF_INET6, &in6->sin6_addr, addr, sizeof(addr));
                        [[adrs6 objectForKey:ifName] addObject: [NSString stringWithUTF8String:addr]];
                    }
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    
    NSMutableDictionary *finalAddrs = [[NSMutableDictionary alloc] init];
    
    // IPv4 addresses 1st
    [adrs4 enumerateKeysAndObjectsUsingBlock:^(NSString *ifn, NSArray *adrs, BOOL *stop){
        [finalAddrs setObject:adrs forKey:ifn];
    }];
    // IPv6 addresses 2nd
    [adrs6 enumerateKeysAndObjectsUsingBlock:^(NSString *ifn, NSArray *adrs, BOOL *stop){
        [finalAddrs setObject: [finalAddrs objectForKey:ifn] == nil ? adrs : [[finalAddrs objectForKey:ifn] arrayByAddingObjectsFromArray:adrs] forKey:ifn];
    }];
    
    return [NSDictionary dictionaryWithDictionary:finalAddrs];
    
} // - (NSDictionary *)ipAddressList {

@end
