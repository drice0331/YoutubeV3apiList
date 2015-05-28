//
//  YoutubeTableViewController.m
//  YoutubeV3List
//
//  Created by David Rice on 5/27/15.
//  Copyright (c) 2015 ricecodes. All rights reserved.
//

#import "YoutubeTableViewController.h"
#import "APIKeyAndConstants.h"
#import "YoutubeDetailController.h"

@interface YoutubeTableViewController ()
{
    NSMutableArray *videos;
}
@end

@implementation YoutubeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor clearColor];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@&key=%@", @"https://www.googleapis.com/youtube/v3/", kParts, kPlaylistID, kAPIKey];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    NSString *jsonString = [[NSString alloc] initWithData: data encoding:NSUTF8StringEncoding];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUnicodeStringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingAllowFragments error:nil];
    
    //NSDictionary *feed = [[NSDictionary alloc] initWithDictionary:[jsonDict valueForKey:@"feed"]];
    videos = [NSMutableArray arrayWithArray:[jsonDict valueForKey:@"items"]];
    [self.tableView reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return videos.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *video = [videos[indexPath.row] valueForKey:@"snippet"];
    
    NSString *title = [video valueForKeyPath:@"title"];
    
    NSDictionary *thumbnails = [video valueForKey:@"thumbnails"];
    NSDictionary *thumbnailData = [thumbnails valueForKey:@"default"];
    NSString *thumbnailImage = [thumbnailData valueForKeyPath:@"url"];
    
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.text = title;
    
    NSURL *url = [[NSURL alloc] initWithString:thumbnailImage];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
    cell.imageView.image = [UIImage imageWithData:imageData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    NSDictionary *video = [videos[indexPath.row] valueForKey:@"snippet"];
    
    NSDictionary *content = [video valueForKey:@"resourceId"];
    NSString *videoId = [content valueForKeyPath:@"videoId"];
    NSString *url = [NSString stringWithFormat:@"%@%@", baseVideoURL, videoId];
    
    //NSDictionary *content2 = [video valueForKeyPath:@"media$group.media$player"][0];
    //NSString *shareurl = [content2 valueForKeyPath:@"url"];
    
    YoutubeDetailController *detailViewController = [segue destinationViewController];
    detailViewController.url = url;
    //detailViewController.shareurl = shareurl;
    
}

@end
