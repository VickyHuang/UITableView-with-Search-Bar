//
//  MasterViewController.m
//  searchBar
//
//  Created by Vicky on 13/10/17.
//  Copyright (c) 2013年 yourway. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@end

@implementation MasterViewController

-(NSMutableArray *)objects
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    return _objects;
}

-(NSMutableArray *)results
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    return _results;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

// Add some objects to our array.
    [self.objects addObject:@"Youtube"];
    [self.objects addObject:@"Google"];
    [self.objects addObject:@"Yahoo"];
    [self.objects addObject:@"FaceBook"];
    [self.objects addObject:@"Flicker"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 老公加的
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSLog(@"%@", searchString);
    
    // 搜尋 並且過濾
    for (NSString *menu in self.objects) {
        
        // 忽略大小寫
        NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
        // 定義搜尋長度
        NSRange productNameRange = NSMakeRange(0, menu.length);
        NSRange foundRange = [menu rangeOfString:searchString options:searchOptions range:productNameRange];
        // 是否找到
        if (foundRange.length > 0)
        {
            // 找到就加入搜尋結果
            [self.results addObject:menu];
        }
    }

    
    return YES;
}



-(void)searchThroughData
{
    self.results = nil;
    
    NSPredicate *resultsPredicate = [NSPredicate predicateWithFormat:@"SELF contains [search] %@",self.searchBar.text];
    self.results = [[self.objects filteredArrayUsingPredicate:resultsPredicate] mutableCopy];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchThroughData];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return self.objects.count;
    }else{
        // 暫時先註解 <<老公加的>>
//        [self searchThroughData];
        return self.results.count;
    }
    // Return the number of rows in the section.
    //ureturn self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPaths
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    //cell.textLabel.text = self.objects [indexPath.row];
    
    if (tableView == self.tableView) {
        cell.textLabel.text = self.objects[indexPaths.row];
    }else{
        cell.textLabel.text = self.results[indexPaths.row];
    }
    
    
    // Configure the cell...
    //cell.textLabel.text = self.objects[indexPath.row];
    
    return cell;
}

// 老公加的
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
//    NSLog(@"%@", tableView);
    // 傳遞值 到 DetailViewController
    if (tableView == self.tableView) {
        // 故事板已經處理了
    }
    else {
        // 搜尋結果必須自行處理
        DetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
        
        // 將搜尋過後  並且被點選的項目  帶到 DetailViewController
        vc.detailLabelContents = self.results[indexPath.row];
        
        // 進入 DetailViewController 畫面
        [self.navigationController pushViewController:vc animated:YES];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSString * object = nil;
        NSIndexPath * indexPath = nil;
        
        indexPath = [self.tableView indexPathForSelectedRow];
        object = self.objects [indexPath.row];
        
        [[segue destinationViewController] setDetailLabelContents:object];
    }
}

@end
