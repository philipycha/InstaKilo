//
//  CollectionViewController.m
//  InstaKilo
//
//  Created by Philip Ha on 2016-09-21.
//  Copyright © 2016 Philip Ha. All rights reserved.
//

#import "CollectionViewController.h"
#import "Photo.h"
#import "CustomCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"

@interface CollectionViewController () <UICollectionViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray <Photo*>           *photoArray;

@property (nonatomic) UICollectionViewFlowLayout                *compactLayout;
@property (nonatomic) UICollectionViewFlowLayout                *largeLayout;

@property (nonatomic) NSMutableSet                              *locationCategories;
@property (nonatomic) NSMutableSet                              *subjectCategories;

@property (nonatomic) NSArray                                   *locationArray;
@property (nonatomic) NSArray                                   *subjectArray;

@property (nonatomic) NSArray                            *locationKeyArray;
@property (nonatomic) NSArray                            *subjectKeyArray;

@property (nonatomic) NSMutableArray                            *nYArray;
@property (nonatomic) NSMutableArray                            *uSAArray;

@property (nonatomic) NSMutableArray                            *logoArray;
@property (nonatomic) NSMutableArray                            *teamArray;

@property (nonatomic) NSDictionary                              *locationDict;
@property (nonatomic) NSDictionary                              *subjectDict;

@property (nonatomic) int                                       selectedState;


-(void)sortBySubject;
-(void)sortByLocation;

@end


@implementation CollectionViewController

//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.selectedState = 0;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(longPressGestureRecognized:)];
    
    [self.collectionView addGestureRecognizer:longPress];
    
    
    self.largeLayout = [[UICollectionViewFlowLayout alloc] init];
    self.largeLayout.itemSize = CGSizeMake(125, 125);
    self.largeLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.largeLayout.minimumInteritemSpacing = 10;
    self.largeLayout.minimumLineSpacing = 10;
    self.largeLayout.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 50);
    
    
    self.compactLayout = [[UICollectionViewFlowLayout alloc] init];
    self.compactLayout.itemSize = CGSizeMake(75, 75);
    self.compactLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.compactLayout.minimumLineSpacing = 5;
    self.compactLayout.minimumInteritemSpacing = 5;
    
    
    self.collectionView.collectionViewLayout = self.largeLayout;
 
    Photo *photo1 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"knicks1.jpeg"] Location:@"New York" Subject:@"Logo"];
    Photo *photo2 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"knicks2.jpg"] Location:@"USA" Subject:@"Logo"];
    Photo *photo3 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"knicks3.png"] Location:@"USA" Subject:@"Team"];
    Photo *photo4 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"knicks4.jpg"] Location:@"New York" Subject:@"Logo"];
    Photo *photo5 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"knicks5.png"] Location:@"New York" Subject:@"Team"];
    Photo *photo6 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"knicks6.jpeg"] Location:@"USA" Subject:@"Logo"];
    Photo *photo7 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"knicks7.jpeg"] Location:@"New York" Subject:@"Logo"];
    Photo *photo8 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"knicks8.jpg"] Location:@"New York" Subject:@"Team"];
    Photo *photo9 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"knicks9.jpg"] Location:@"USA" Subject:@"Team"];
    Photo *photo10 = [[Photo alloc] initWithImage:[UIImage imageNamed:@"knicks10.jpeg"] Location:@"New York" Subject:@"Logo"];
    
    self.photoArray = [[NSMutableArray alloc] initWithObjects:photo1, photo2, photo3, photo4, photo5, photo6, photo7, photo8, photo9, photo10, nil];
    
    
    [self.collectionView reloadData];
    
    self.locationCategories = [[NSMutableSet alloc] init];
    self.subjectCategories = [[NSMutableSet alloc] init];
    
    for (Photo* photo in self.photoArray) {
        
        [self.locationCategories addObject:photo.location];
    }
    
    
    for (Photo* photo in self.photoArray) {
        
        [self.subjectCategories setByAddingObject:photo.subject];
        
    }
    
    
    
    self.nYArray = [[NSMutableArray alloc] init];
    self.uSAArray = [[NSMutableArray alloc] init];
    
    //Make Array of Images for LOCATION: NEW YORK AND USA PHOTOS
    
    
    //givea  number system to it.. because sets dont have orders ... but collectionview reuqires u to have ordered sections
    self.locationArray = [self.locationCategories allObjects];
    
    
    
    
    //we take the photos, and we segrate them into the different catorgeoires
    for ( Photo *photo in _photoArray){
        
        if(photo.location == self.locationArray[0]){
            
            [_nYArray addObject:photo];
            
        } else if (photo.location == self.locationArray[1]){
            
            [_uSAArray addObject:photo];
        }
    }
    

    
    self.logoArray = [[NSMutableArray alloc] init];
    self.teamArray = [[NSMutableArray alloc] init];
    
    //Make Array of Images for SUBJECT: LOGO + TEAM
    
    self.subjectArray = [self.subjectCategories allObjects];
    
    for (Photo *logoPhoto in self.subjectArray) {
        
        [self.logoArray addObject:logoPhoto];
        
    }
    
    for (Photo *teamPhoto in self.subjectArray) {
        
        [self.teamArray addObject:teamPhoto];
        
    }

    //MAKE DICTIONARY
 
    self.locationDict = [[NSDictionary alloc] initWithObjectsAndKeys: self.nYArray, @"New York", self.uSAArray, @"USA",
    nil];
    
    self.subjectDict = [[NSDictionary alloc] initWithObjectsAndKeys: self.teamArray, @"Team", self.logoArray, @"Logo", nil];
    
    self.locationKeyArray = [[NSArray alloc] init];
    self.subjectKeyArray = [[NSArray alloc] init];
    
    self.locationKeyArray = [self.locationDict allKeys];
    self.subjectKeyArray = [self.subjectDict allKeys];
}

-(void)sortByLocation{
    
    [self.photoArray sortUsingDescriptors:
     @[
       [NSSortDescriptor sortDescriptorWithKey:@"location" ascending:YES],
       [NSSortDescriptor sortDescriptorWithKey:@"subject" ascending:YES]
       ]];
    
    [self.collectionView reloadData];
}

-(void)sortBySubject{
    
    [self.photoArray sortUsingDescriptors:
     @[
       [NSSortDescriptor sortDescriptorWithKey:@"subject" ascending:YES],
       [NSSortDescriptor sortDescriptorWithKey:@"location" ascending:YES]
       ]];
    
    [self.collectionView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if (self.selectedState == 0){
        
        return self.locationKeyArray.count;
        
    } else {
        
        return self.subjectKeyArray.count;
        
    }
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.selectedState == 0){
        
        
        NSString *key = _locationKeyArray[section];
        
        NSMutableArray *array = [_locationDict objectForKey:key];
        
        return array.count;
        
        
        
    } else {
        
        NSString *key = _subjectKeyArray[section];
        
        NSMutableArray *array = [_subjectDict objectForKey:key];
        
        return array.count;
        
        
    }
    
    
}
 
    
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
//    Photo *photo = self.photoArray[indexPath.item];
//
//    cell.cellImageView.image = photo.image;
//    
//    
//    // Configure the cell
//
    
    NSMutableArray *array = [[NSMutableArray alloc ] init];
    
    if (self.selectedState == 0){
        
        NSString *key = _locationKeyArray[indexPath.section];
        
        array = [_locationDict objectForKey:key];
        
        
    } else {
        
        NSString *key = _subjectKeyArray[indexPath.section];
        
        array = [_subjectDict objectForKey:key];
        
    }

    
    Photo *photo = array[indexPath.item];
    
    cell.cellImageView.image = photo.image;
    
    return cell;
    
    
    
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath{
    
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        
        HeaderCollectionReusableView *headerTitle = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerTitle" forIndexPath:indexPath];
        
        if (self.selectedState == 0){
            
            headerTitle.headerLabel.text = [NSString stringWithFormat:@"%@", self.locationKeyArray[indexPath.section]];
            
        } else {
            
            headerTitle.headerLabel.text = [NSString stringWithFormat:@"%@", self.subjectKeyArray[indexPath.section]];
            
        }

        return headerTitle;
        
    }
    
    return nil;
    
#pragma mark - LONG PRESS MOVING IMAGE
    
}
- (IBAction)longPressGestureRecognized:(id)sender {
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
    
    static UIView       *snapshot = nil;
    static NSIndexPath  *sourceIndexPath = nil;
    
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                sourceIndexPath = indexPath;
                
                UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
                
                // Take a snapshot of the selected row using helper method.
                snapshot = [self customSnapshotFromView:cell];
                
                // Add the snapshot as subview, centered at cell's center...
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [self.collectionView addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    // Offset for gesture location.
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.25, 1.25);
                    snapshot.alpha = 0.98;
                    
                    // Fade out.
                    cell.alpha = 0.0;
                    
                } completion:^(BOOL finished) {
                    
                    cell.hidden = YES;
                    
                }];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            CGPoint center = snapshot.center;
            center.y = location.y;
            snapshot.center = center;
            
            // Is destination valid and is it different from source?
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                
                // ... update data source.
                [self.photoArray exchangeObjectAtIndex:indexPath.item withObjectAtIndex:sourceIndexPath.item];
                
                // ... move the rows.
                [self.collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
            }
            break;
        }
        default: {
            // Clean up.
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.5;
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                
                // Undo fade out.
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
                
            }];
            break;
        }
    }
    
    
}


- (UIView *)customSnapshotFromView:(UIView *)inputView {
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.7;
    
    return snapshot;
    
}

- (IBAction)pressedSortButton:(UIBarButtonItem *)sender {
    
    
    UICollectionViewLayout *nextLayout;
    
    if (self.collectionView.collectionViewLayout == self.largeLayout) {
        nextLayout = self.compactLayout;
    } else {
        nextLayout = self.largeLayout;
    }
    
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView setCollectionViewLayout:nextLayout animated:YES];
    
    
}

- (IBAction)segmentedSortPressed:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            
            [self sortByLocation];
            _selectedState = 0;
            break;
        case 1:
            
            [self sortBySubject];
            _selectedState = 1;
            
            break;
    }
    
    [self.collectionView reloadData];
    
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
