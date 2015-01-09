//
//  CSArticlePartViewController.m
//  reuters-wider
//
//  Created by Sylvain Reucherand on 07/12/2014.
//  Copyright (c) 2014 Gobelins. All rights reserved.,
//

#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>

#import "CSArticlePartViewController.h"
#import "CSAbstractArticleViewCellTableViewCell.h"
#import "CSPartBlockTableViewCell.h"
#import "CSInArticleGlossaryDefinition.h"
#import "CSScrollViewNavigationControl.h"
#import "CSStickyMenu.h"
#import "CSArticleSummaryTransition.h"
#import "CSSummaryViewController.h"
#import "CSProgressionBarView.h"
#import "CSNightModeLayer.h"

@interface CSArticlePartViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UIScrollViewDelegate, AVCaptureVideoDataOutputSampleBufferDelegate, CSAbstractArticleViewCellTableViewCellDelegate, CSStickyMenuDelegate> {
    BOOL _definitionOpened;
    BOOL _isSwitchedToNightMode;
    
    AVCaptureSession *_session;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewRightConstraint;
@property (weak, nonatomic) IBOutlet CSProgressionBarView *progressionBarView;

@property (assign, nonatomic) CGFloat progression;

@property (strong, nonatomic) CSArticleSummaryTransition *transition;
@property (strong, nonatomic) CSInArticleGlossaryDefinition *definitionView;
@property (strong, nonatomic) CSScrollViewNavigationControl *topNavigationControl;
@property (strong, nonatomic) CSStickyMenu *stickyMenu;
@property (strong, nonatomic) NSMutableDictionary *cells;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@property (strong, nonatomic) NSMutableDictionary *cellsStates;

@end

@implementation CSArticlePartViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        _definitionOpened = NO;
        _isSwitchedToNightMode = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readModeNeedsUpdate:) name:@"readModeUpdateNotification" object:nil];
        
        if (![[CSGlobalData sharedInstance] hasUserAlreadyReceiveNightLayer]) {
            [self setupAVCapture];
        }
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.transition = [[CSArticleSummaryTransition alloc] init];
    self.transition.sourceViewController = self;
    
    self.definitionView = [[[NSBundle mainBundle] loadNibNamed:@"CSInArticleGlossaryDefinition" owner:self options:nil] lastObject];
    self.definitionView.frame = (CGRect){.origin=self.definitionView.frame.origin, .size=CGSizeMake(CGRectGetWidth(self.view.frame)*0.55, self.definitionView.frame.size.height)};
    
    [self.view insertSubview:self.definitionView belowSubview:self.progressionBarView];
    
    self.cells = [[NSMutableDictionary alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CSPartBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSPartBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSMetaBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSMetaBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSTeasingBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSTeasingBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSParagraphBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSParagraphBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSStatementBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSStatementBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSSubtitleBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSSubtitleBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSFigureBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSFigureBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSAsideBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSAsideBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSPovBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSPovBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSKeywordsBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSKeywordsBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSTransitionBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSTransitionBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSKeyfiguresBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSKeyfiguresBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSImageBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSImageBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSInterviewBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSInterviewBlockCellID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CSImplicationBlockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CSImplicationBlockCellID"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnTableView:)];
    self.tapGestureRecognizer.delegate = self;
    
    [self.view addGestureRecognizer:self.tapGestureRecognizer];
    
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeOnView:)];
    
    [self.view addGestureRecognizer:swipeGestureRecognizer];
    
    self.topNavigationControl = [[CSScrollViewNavigationControl alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 60) scrollView:self.tableView];
    
    self.topNavigationControl.backgroundColor = WHITE_COLOR;
    
    [self.topNavigationControl setLabelText:@"Home"];
    [self.topNavigationControl addTarget:self action:@selector(scrollViewDidPullForTransition:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:self.topNavigationControl];
    
    self.stickyMenu = [[[NSBundle mainBundle] loadNibNamed:@"CSStickyMenu" owner:self options:nil] lastObject];
    
    [self.stickyMenu.titleButton setTitle:@"Home" forState:UIControlStateNormal];
    self.stickyMenu.scrollView = self.tableView;
    self.stickyMenu.delegate = self;
    
    [self.view addSubview:self.stickyMenu];
    
    self.progression = [[CSArticleData sharedInstance] getProgressionOfArticle:2];
    
    [self.tableView setContentOffset:CGPointMake(0, self.progression * (self.tableView.contentSize.height - CGRectGetHeight(self.tableView.frame))) animated:NO];
    
    self.cellsStates = [[NSMutableDictionary alloc] init];
    
    NSString *mode = [[CSArticleData sharedInstance] getReadModeOfArticle:2];
    
    _isSwitchedToNightMode = [mode isEqualToString:@"night"] ? YES : NO;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"readModeUpdateNotification" object:self userInfo:@{@"mode": mode}];
}

- (void)setupAVCapture {
    _session = [[AVCaptureSession alloc] init];
    _session.sessionPreset = AVCaptureSessionPresetMedium;
    
    AVCaptureDevice *device = [self frontCamera];
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if (!error) {
        if ([device lockForConfiguration:&error]) {
            if ([device hasTorch] && [device isTorchModeSupported:AVCaptureTorchModeOn]) {
                [device setTorchMode:AVCaptureTorchModeOn];
            }
            [device unlockForConfiguration];
        }
        
        if ([_session canAddInput:input]) {
            [_session addInput:input];
        }
        
        AVCaptureVideoDataOutput *videoDataOutput = [AVCaptureVideoDataOutput new];
        
        [videoDataOutput setVideoSettings:@{(NSString *)kCVPixelBufferPixelFormatTypeKey:@(kCVPixelFormatType_32BGRA)}];
        [videoDataOutput setAlwaysDiscardsLateVideoFrames:YES];
        dispatch_queue_t videoDataOutputQueue = dispatch_queue_create("VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL);
        [videoDataOutput setSampleBufferDelegate:self queue:videoDataOutputQueue];
        
        if ([_session canAddOutput:videoDataOutput]) {
            [_session addOutput:videoDataOutput];
        }
        
        [_session startRunning];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_session) {
        [_session startRunning];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //[self stopSession];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self stopSession];
    
    _session = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[CSArticleData sharedInstance] getBlocksOfArticle:2] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSBlockModel *block = [[[CSArticleData sharedInstance] getBlocksOfArticle:2] objectAtIndex:indexPath.row];
    
    CSAbstractArticleViewCellTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[self cellIdentifierForBlockType:block.type] forIndexPath:indexPath];
    
    cell.tableView = tableView;
    cell.indexPath = indexPath;
    cell.delegate = self;
    
    [cell hydrateWithContentData:(NSDictionary *)block forState:[self.cellsStates objectForKey:[NSString stringWithFormat:@"%i:%i", (int)indexPath.section, (int)indexPath.row]]];
    
    _isSwitchedToNightMode ? [cell switchToNightMode] : [cell switchToNormalMode];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSBlockModel *block = [[[CSArticleData sharedInstance] getBlocksOfArticle:2] objectAtIndex:indexPath.row];
    NSString *identifier = [self cellIdentifierForBlockType:block.type];
    CSAbstractArticleViewCellTableViewCell *cell = [self.cells objectForKey:identifier];
    
    if ([block.type isEqualToString:@"part"] || [block.type isEqualToString:@"transition"]) {
        return CGRectGetHeight(self.view.frame);
    }
    
    if (nil == cell) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
        
        [self.cells setObject:cell forKey:identifier];
    }
    
    [cell hydrateWithContentData:(NSDictionary *)block forState:[self.cellsStates objectForKey:[NSString stringWithFormat:@"%i:%i", (int)indexPath.section, (int)indexPath.row]]];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    cell.bounds = CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame) - cell.marginRight, CGRectGetHeight(cell.bounds));
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return size.height + 1;
}

#pragma mark - Identifier and block type match

- (NSString *)cellClassForBlockType:(NSString *)type {
    NSString *class = [NSString stringWithFormat:@"CS%@BlockTableViewCell", [type capitalizedString]];
    
    return class;
}

- (NSString *)cellIdentifierForBlockType:(NSString *)type {
    NSString *identifier = [NSString stringWithFormat:@"CS%@BlockCellID", [type capitalizedString]];
    
    return identifier;
}

- (void)openDefinitionWithUrl:(NSURL *)url {
    _definitionOpened = YES;
    
    [self.stickyMenu disable];
    
    CSDefinitionModel *definition = [[CSArticleData sharedInstance] getDefinitionAtIndex:[[[url.relativeString componentsSeparatedByString:@"/"] lastObject] integerValue] ofArticle:2];
    
    [self.definitionView hydrateWithTitle:definition.title andText:definition.text];
    
    [self.tableView.layer removeAllAnimations];
    [self.tableView setScrollEnabled:NO];
    
    [self.definitionView.layer removeAllAnimations];
    
    UIColor *color = _isSwitchedToNightMode ? WHITE_COLOR : DARK_BLUE;
    
    [self.definitionView.gradientIndicatorView clearAnimation];
    [self.definitionView.gradientIndicatorView interpolateBetweenColor:[UIColor clearColor] andColor:color withProgression:0];
    [self.definitionView.gradientIndicatorView animateWidthDuration:0.35 delay:0.35 timingFunction:CSTweenEaseInOutExpo completion:nil];
    
    self.tableViewLeftConstraint.constant = -CGRectGetWidth(self.view.frame)*0.65;
    self.tableViewRightConstraint.constant = CGRectGetWidth(self.view.frame)*0.65;
    
    [UIView animateWithDuration:0.85 delay:0 options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        [self.tableView layoutIfNeeded];
        self.definitionView.frame = CGRectOffset(self.definitionView .frame, -CGRectGetWidth(self.view.frame)*0.65, 0);
    } completion:nil];
}

- (void)closeDefinition {
    if (!_definitionOpened) {
        return;
    }
    
    _definitionOpened = NO;
    
    [self.stickyMenu enable];
    
    [self.tableView removeGestureRecognizer:self.tapGestureRecognizer];
    [self.tableView.layer removeAllAnimations];
    [self.tableView setScrollEnabled:YES];
    
    [self.definitionView.layer removeAllAnimations];
    
    self.tableViewLeftConstraint.constant = 0;
    self.tableViewRightConstraint.constant = 0;
    
    [UIView animateWithDuration:0.85 delay:0 options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState) animations:^{
        [self.tableView layoutIfNeeded];
        self.definitionView.frame = CGRectOffset(self.definitionView.frame, CGRectGetWidth(self.view.frame)*0.65, 0);
    } completion:nil];
}

#pragma mark - UIControl events

- (void)scrollViewDidPullForTransition:(UIControl *)UIControl {
    if ([self.topNavigationControl isEqual:UIControl]) {
        [self unwindToHome];
    }
}

#pragma mark - Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {    
    [self.topNavigationControl containingScrollViewDidScroll];
    
    [self.stickyMenu close];
    
    if (self.tableView.contentOffset.y >= 0) {
        self.progression = self.tableView.contentOffset.y/(self.tableView.contentSize.height - CGRectGetHeight(self.tableView.frame));
        self.progressionBarView.progression = self.progression;
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [self.topNavigationControl containingScrollViewDidEndDragging];
}

#pragma mark - Gesture delegate

- (void)didTapOnTableView:(UITapGestureRecognizer *)recognizer {
    if (_definitionOpened) {
        [self closeDefinition];
    } else {
        [self.stickyMenu toggle];
    }
}

- (void)didSwipeOnView:(UISwipeGestureRecognizer *)recognizer {
    [self closeDefinition];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - Cell delegate

- (void)tableViewCell:(CSAbstractArticleViewCellTableViewCell *)cell rowNeedsPersistentState:(NSNumber *)state {
    [self.cellsStates setValue:state forKey:[NSString stringWithFormat:@"%i:%i", (int)cell.indexPath.section, (int)cell.indexPath.row]];
}

- (void)didSelectLinkWithURL:(NSURL *)url atPoint:(NSValue *)point {
    if (_definitionOpened) {
        [self closeDefinition];
        
        return;
    }
    
    CGFloat location = [point CGPointValue].y - CGRectGetHeight(self.tableView.frame)/2;
    
    [self.tableView setEasingFunction:easeOutExpo forKeyPath:@"center"];
    [self.definitionView setEasingFunction:easeOutExpo forKeyPath:@"frame"];
    
    [self.definitionView setFrameForPoint:CGPointMake(CGRectGetWidth(self.view.frame)*1.05, CGRectGetHeight(self.tableView.frame)/2)];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.contentOffset = CGPointMake(0, location);
    } completion:^(BOOL finished) {
        if (finished) {
            [self openDefinitionWithUrl:url];
        }
    }];
}

#pragma mark - Transition animations

- (void)openWith:(void (^)())completion {
    self.view.userInteractionEnabled = NO;
    
    [CSTween tweenFrom:CGRectGetMinY(self.view.frame) to:0 duration:1.4 timingFunction:CSTweenEaseInOutExpo updateBlock:^(CSTweenOperation *operation) {
        self.view.frame = (CGRect){.origin=CGPointMake(self.view.frame.origin.x, operation.value), .size=self.view.frame.size};
    } completeBlock:^(BOOL finished) {
        if (finished) {
            if (completion) {
                completion();
                
                self.view.userInteractionEnabled = YES;
            }
        }
    }];
}

- (void)closeWith:(void (^)())completion {
    self.view.userInteractionEnabled = NO;
    
    [CSTween tweenFrom:0 to:CGRectGetMaxY(self.view.frame) duration:1.4 timingFunction:CSTweenEaseInOutExpo updateBlock:^(CSTweenOperation *operation) {
        self.view.frame = (CGRect){.origin=CGPointMake(self.view.frame.origin.x, operation.value), .size=self.view.frame.size};
    } completeBlock:^(BOOL finished) {
        if (finished && completion) {
            completion();
        }
    }];
}

#pragma mark - StickyMenu delegate

- (void)backToTopButtonDidPress {
    [self.tableView setContentOffset:CGPointMake(self.tableView.contentOffset.x, 0) animated:YES];
}

- (void)titleButtonDidPress {
    [self unwindToHome];
}

- (void)nightModeButtonDidPress {
    _isSwitchedToNightMode = !_isSwitchedToNightMode;
    
    [[self.tableView visibleCells] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (_isSwitchedToNightMode) {
            [((CSAbstractArticleViewCellTableViewCell *) obj) switchToNightMode];
        } else {
            [((CSAbstractArticleViewCellTableViewCell *) obj) switchToNormalMode];
        }
    }];
    
    NSString *mode = _isSwitchedToNightMode ? @"night" : @"normal";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"readModeUpdateNotification" object:self userInfo:@{@"mode": mode}];
    
    if (_isSwitchedToNightMode) {
        [[CSArticleData sharedInstance] saveReadMode:@"night" ofArticle:2];
    } else {
        [[CSArticleData sharedInstance] saveReadMode:@"normal" ofArticle:2];
    }
}

#pragma mark - Switch read mode

- (void)readModeNeedsUpdate:(NSNotification *)sender {
    if ([[sender.userInfo objectForKey:@"mode"] isEqualToString:@"night"]) {
        self.view.backgroundColor = NIGHT_BLUE;
    } else {
        self.view.backgroundColor = WHITE_COLOR;
    }
}

#pragma mark - Navigation

- (void)unwindToHome {
    [[CSArticleData sharedInstance] saveProgression:self.progression ofArticle:2];
    
    [self performSegueWithIdentifier:@"unwindArticleToHomeSegueID" sender:self];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[CSSummaryViewController class]]) {
        CSSummaryViewController *destinationViewController = segue.destinationViewController;
        
        self.transition.destinationViewController = destinationViewController;
        
        destinationViewController.transitioningDelegate = self.transition;
        destinationViewController.progression = self.progression;
    }
}

#pragma mark - AV Session

- (AVCaptureDevice *)frontCamera {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    for (AVCaptureDevice *device in devices) {
        if ([device position] == AVCaptureDevicePositionFront) {
            return device;
        }
    }
    
    return nil;
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL, sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)metadataDict];
    
    CFRelease(metadataDict);
    
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    CGFloat brightnessValue = [[exifMetadata  objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    
    if (brightnessValue < 0) {
        [self lakeOffLuminosity];
    }
}

- (void)stopSession {
    if (!_session) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_session stopRunning];
    });
}

- (void)lakeOffLuminosity {
    if (!_session) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_session stopRunning];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            CSNightModeLayer *nightLayerView = [[[NSBundle mainBundle] loadNibNamed:@"CSNightModeLayer" owner:self options:nil] lastObject];
            
            nightLayerView.frame = self.view.frame;
            
            [self.view addSubview:nightLayerView];
            
            [nightLayerView animate];
            
            [[CSGlobalData sharedInstance] userDidReceiveNightLayer];
        });
    });
}

@end
