//
//  MasterViewController.h
//  searchBar
//
//  Created by Vicky on 13/10/17.
//  Copyright (c) 2013年 yourway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate>


@property (nonatomic, strong) NSMutableArray * objects;
@property (nonatomic, strong) NSMutableArray *results;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar; // 不需要 連結

@end
