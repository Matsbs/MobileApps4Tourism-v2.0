//
//  FavouritesViewController.m
//  MA4TV2
//
//  Created by Mats Sandvoll on 08.11.13.
//  Copyright (c) 2013 Mats Sandvoll. All rights reserved.
//

#import "FavouritesViewController.h"

@interface FavouritesViewController ()

@end

@implementation FavouritesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    DBManager *dbManager = [[DBManager alloc]init];
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbManager.databasePath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:@"TOURISM.db"]];
    
    self.favourites = [dbManager getAllFavourites];
    
    self.title = @"My Favourites";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStylePlain];
    self.tableView.rowHeight = 50;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
//    UIBarButtonItem *newButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newClicked:)] ;
//    UIBarButtonItem *delButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delClicked:)] ;
//    self.navigationItem.rightBarButtonItems = @[newButton,delButton];
    
    //If array contains any object
    if (self.favourites.count>0) {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
    
}

//- (void)addItemViewController:(NewTaskViewController *)controller didFinishEnteringItem:(Task *)item
//{
//    NSLog(@"This was returned from ViewControllerB %@",item.category.name);
//    [self.taskArray addObject:item];
//    [self.tableView reloadData];
//}
//
//- (void)removeItemViewController:(ViewNoteController *)controller didFinishEnteringItem:(Task *)item{
//    if([self.taskArray containsObject:item]){
//        [self.taskArray removeObject:item];
//    }
//    [self.tableView reloadData];
//}
//
//- (IBAction)newClicked:(id)sender {
//    NewTaskViewController *newTaskView = [[NewTaskViewController alloc] init];
//    newTaskView.delegate = self;
//    [self.navigationController pushViewController:newTaskView animated:YES];
//}

-(IBAction)delClicked:(id)sender{
    //Delete all tasks
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = self.favourites.count;
//    if(self.editing) {
//        count = count + 1;
//    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    //if (indexPath.row < self.favourites.count ) {
        //self.task= [self.taskArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [[self.favourites objectAtIndex:indexPath.row] name];
        //cell.imageView.image = [UIImage imageNamed:[[self.favourites objectAtIndex:indexPath.row] imagePath]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [cell setIndentationWidth:64];
        [cell setIndentationLevel:1];
        UIImageView *imgView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60,tableView.rowHeight-10)];
        imgView.backgroundColor=[UIColor clearColor];
        [imgView.layer setMasksToBounds:YES];
        [imgView setImage:[UIImage imageNamed:[(Favourite*)[self.favourites objectAtIndex:indexPath.row] imagePath]]];
        [cell.contentView addSubview:imgView];
    //}
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ((indexPath.row < self.favourites.count) && !self.editing) {
//        ViewNoteController *viewNote = [[ViewNoteController alloc] init];
//        viewNote.task = [self.taskArray objectAtIndex:indexPath.row];
//        viewNote.delegate = self;
        //[self.navigationController pushViewController:viewNote animated:YES];
    }else if ((indexPath.row == self.favourites.count) && self.editing){
//        NewTaskViewController *newTaskView = [[NewTaskViewController alloc] init];
//        newTaskView.delegate = self;
//        [self.navigationController pushViewController:newTaskView animated:YES];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.favourites.count ) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleInsert;
    }
}

-(void)setEditing:(BOOL)editing animated:(BOOL) animated {
    if(editing != self.editing ) {
        [super setEditing:editing animated:animated];
        [self.tableView setEditing:editing animated:animated];
        //NSArray *indexes =
        //[NSArray arrayWithObject:
         //[NSIndexPath indexPathForRow:self.favourites.count inSection:0]];
//        if (editing == YES ) {
//            //[self.tableView insertRowsAtIndexPaths:indexes
//                                  //withRowAnimation:UITableViewRowAnimationLeft];
//        } else {
//            [self.tableView deleteRowsAtIndexPaths:indexes
//                                  withRowAnimation:UITableViewRowAnimationLeft];
//        }
    }
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle) editing
 forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editing == UITableViewCellEditingStyleDelete ) {
        DBManager *dbManager = [[DBManager alloc]init];
        NSString *docsDir;
        NSArray *dirPaths;
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = dirPaths[0];
        dbManager.databasePath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:@"TOURISM.db"]];
        [dbManager deleteFavourite:[self.favourites objectAtIndex:indexPath.row]];
        NSLog(@"Deleted");
        
        
        [self.favourites removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationLeft];
        
        
        
        
    }else{
//        NewTaskViewController *newTaskView = [[NewTaskViewController alloc] init];
//        newTaskView.delegate = self;
//        [self.navigationController pushViewController:newTaskView animated:YES];
    }
}

@end
