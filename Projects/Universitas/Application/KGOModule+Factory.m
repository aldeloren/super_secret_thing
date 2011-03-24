#import "KGOModule+Factory.h"
#import "KGOModule.h"
#import "AboutModule.h"
#import "CalendarModule.h"
#import "ExternalURLModule.h"
#import "HomeModule.h"
#import "LoginModule.h"
#import "NewsModule.h"
#import	"MapModule.h"
#import "PeopleModule.h"
#import "SettingsModule.h"

@implementation KGOModule (Factory)

+ (KGOModule *)moduleWithDictionary:(NSDictionary *)args {
    KGOModule *module = nil;
    NSString *className = [args objectForKey:@"class"];
    
    if ([className isEqualToString:@"AboutModule"])
        module = [[[AboutModule alloc] initWithDictionary:args] autorelease];
    
    else if ([className isEqualToString:@"CalendarModule"])
        module = [[[CalendarModule alloc] initWithDictionary:args] autorelease];
    
    else if ([className isEqualToString:@"HomeModule"])
        module = [[[HomeModule alloc] initWithDictionary:args] autorelease];
    
    else if ([className isEqualToString:@"ExternalURLModule"])
        module = [[[ExternalURLModule alloc] initWithDictionary:args] autorelease];
    
    else if ([className isEqualToString:@"LoginModule"])
        module = [[[LoginModule alloc] initWithDictionary:args] autorelease];
    
    else if ([className isEqualToString:@"MapModule"])
        module = [[[MapModule alloc] initWithDictionary:args] autorelease];
    
    else if ([className isEqualToString:@"NewsModule"])
        module = [[[NewsModule alloc] initWithDictionary:args] autorelease];
    
    else if ([className isEqualToString:@"PeopleModule"])
        module = [[[PeopleModule alloc] initWithDictionary:args] autorelease];
    
    else if ([className isEqualToString:@"SettingsModule"])
        module = [[[SettingsModule alloc] initWithDictionary:args] autorelease];
    
    return module;
}

@end
