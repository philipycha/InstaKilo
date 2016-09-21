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

@interface CollectionViewController () <UICollectionViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray                    *photoArray;

@property (nonatomic) UICollectionViewFlowLayout                *compactLayout;
@property (nonatomic) UICollectionViewFlowLayout                *largeLayout;

@end


@implementation CollectionViewController

//static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.largeLayout = [[UICollectionViewFlowLayout alloc] init];
    self.largeLayout.itemSize = CGSizeMake(100, 100);
    self.largeLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.largeLayout.minimumInteritemSpacing = 15;
    self.largeLayout.minimumLineSpacing = 10;
    self.largeLayout.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 50);
    
    //    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.compactLayout = [[UICollectionViewFlowLayout alloc] init];
    self.compactLayout.itemSize = CGSizeMake(50, 50);
    self.compactLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.compactLayout.minimumLineSpacing = 5;
    self.compactLayout.minimumInteritemSpacing = 5;
    
    //    self.smallLayout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame), 25);
    
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
    
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
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
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    Photo *photo = self.photoArray[indexPath.item];

    cell.cellImageView.image = photo.image;
    
    
    // Configure the cell
    
    return cell;
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
