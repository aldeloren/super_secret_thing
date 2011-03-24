#import "KGOTableViewController.h"
#import "KGODatePager.h"
#import "KGOScrollingTabstrip.h"
#import "CalendarDataManager.h"

@interface CalendarHomeViewController : KGOTableViewController <KGODatePagerDelegate,
KGOScrollingTabstripDelegate, CalendarDataManagerDelegate> {
    
    IBOutlet KGODatePager *_datePager;
    IBOutlet KGOScrollingTabstrip *_tabstrip;
    
    NSMutableArray *_groupTitles;
    NSInteger _currentGroupIndex;

    // the table will either be a plain, possibly sectioned list of events
    // or a grouped, unsectioned list of categories.
    NSArray *_currentSections;
    NSDictionary *_currentEventsBySection;

    NSArray *_currentCategories;
    
    CalendarDataManager *_dataManager;
}

@property(nonatomic, retain) NSString *searchTerms;

@end
