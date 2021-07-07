//
//  ViewController.m
//  IOS_MAOverlay
//
//  Created by zhang jb on 2021/7/6.
//

#import "ViewController.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "CustomMovingAnnotation.h"


//导航栏/工具栏/状态栏高度
#define kNavigationBarH 44
#define kStatusBarH [[UIApplication sharedApplication] statusBarFrame].size.height//顶部状态栏高度
#define kToolBarH (kStatusBarH > 20? 83 : 49)//底部工具栏高度
#define kNoToolBarX (kStatusBarH > 20? 34 : 0)//底部iPhoneX的适配高度
#define kNavgationH (kStatusBarH > 20? 88 : 64)//顶部导航栏高度

//屏幕适配
#define kWidth(R) (R)*(KScreenW)/375.0
#define kHeight(R) kWidth(R)
//屏幕宽高
#define KScreenHp [[UIScreen mainScreen] bounds].size.height*1.0 // 屏幕高度
#define KScreenWp [[UIScreen mainScreen] bounds].size.width*1.0 // 屏幕宽度

#define KScreenH MAX(KScreenHp,KScreenWp) // 屏幕高度
#define KScreenW MIN(KScreenHp,KScreenWp)// 屏幕宽度


static CLLocationCoordinate2D s_coords[] =
{
    { 22.570014 ,113.180562},
    { 22.571001 ,113.180369},
    { 22.571718 ,113.180213},
    { 22.572360 ,113.180071},
    { 22.573087, 113.179906},
    { 22.573468, 113.179824},
    { 22.573646 ,113.179786},
    { 22.573782, 113.179742},
    { 22.573676, 113.179725},
    { 22.573543 ,113.179753},
    { 22.573319 ,113.179811},
    { 22.573190 ,113.179843},
    { 22.572651, 113.179977},
    { 22.572297, 113.180060},
    { 22.571741, 113.180179},
    { 22.571093 ,113.180317},
    { 22.570350, 113.180477},
    { 22.569539 ,113.180621},
    { 22.568686 ,113.180772},
    { 22.567906, 113.180913},
    { 22.567071, 113.181049},
    { 22.566715 ,113.181091},
    { 22.566233 ,113.181145},
    { 22.565915 ,113.181180},
    { 22.565458, 113.181222},
    { 22.565199, 113.181253},
    { 22.565016, 113.181288},
    { 22.565202 ,113.181315},
    { 22.565353 ,113.181296},
    { 22.565546, 113.181270},
    { 22.566381, 113.181156},
    { 22.566808, 113.181097},
    { 22.567525, 113.180994},
    { 22.568617 ,113.180792},
    { 22.569211 ,113.180692},
    { 22.570110 ,113.180531},
    { 22.570903, 113.180377},
    { 22.571593 ,113.180223},
    { 22.572167 ,113.180106},
    { 22.572729, 113.180001},
    { 22.573155 ,113.179906},
    { 22.573327, 113.179867},
    { 22.573569 ,113.179802},
    { 22.573672 ,113.179745},
    { 22.573443 ,113.179783},
    { 22.573248, 113.179833},
    { 22.573019, 113.179888},
    { 22.572764, 113.179948},
    { 22.572489 ,113.180014},
    { 22.572094 ,113.180097},
    { 22.571561 ,113.180215},
    { 22.571331 ,113.180270},
    { 22.570725, 113.180406},
    { 22.570473 ,113.180457},
    { 22.570069 ,113.180535},
    { 22.569299 ,113.180663},
    { 22.568900 ,113.180731},
    { 22.568296 ,113.180842},
    { 22.567338 ,113.181011},
    { 22.566928 ,113.181076},
    { 22.566774, 113.181098},
    { 22.566730 ,113.181104},
    { 22.566357 ,113.181159},
    { 22.565826, 113.181217},
    { 22.565311, 113.181268},
    { 22.565064 ,113.181297},
    { 22.564939 ,113.181311},
    { 22.564614 ,113.181335},
    { 22.565198 ,113.181292},
    { 22.565595, 113.181241},
    { 22.565936 ,113.181202},
    { 22.566826 ,113.181090},
    { 22.567345 ,113.181021},
    { 22.568781 ,113.180769},
    { 22.569390 ,113.180665},
    { 22.569959 ,113.180567},
    { 22.571193 ,113.180319},
    { 22.571633 ,113.180218},
    { 22.572251, 113.180085},
    { 22.572802 ,113.179951},
    { 22.573216, 113.179874},
    { 22.573363 ,113.179846},
    { 22.573341 ,113.179794},
    { 22.572830 ,113.179923},
    { 22.572460, 113.180019},
    { 22.572083 ,113.180099},
    { 22.571691 ,113.180182},
    { 22.571218 ,113.180290},
    { 22.570596 ,113.180431},
    { 22.569872, 113.180567},
    { 22.569095, 113.180703},
    { 22.568278, 113.180849},
    { 22.567417, 113.181001},
    { 22.566542, 113.181121},
    { 22.565751 ,113.181210},
    { 22.565333 ,113.181260},
    { 22.565053 ,113.181296},
    { 22.564792 ,113.181331},
    { 22.564804 ,113.181227},
    { 22.565456 ,113.181119},
    { 22.565876 ,113.181065},
    { 22.566299 ,113.181014},
    { 22.566580 ,113.180979},
    { 22.567151 ,113.180907},
    { 22.567599, 113.180847},
    { 22.567912 ,113.180787},
    { 22.568472 ,113.180694},
    { 22.568554 ,113.180681},
    { 22.568646 ,113.180577},
    { 22.568589 ,113.180451},
    { 22.568538 ,113.180309},
    { 22.568618 ,113.180200},
    { 22.568872 ,113.180133},
    { 22.569277 ,113.180075},
    { 22.569821 ,113.179979},
    { 22.570304, 113.179896},
    { 22.570560, 113.179843},
    { 22.570945 ,113.179782},
    { 22.571159, 113.179725},
    { 22.571227, 113.179542},
    { 22.571232, 113.179472},
    { 22.571151 ,113.179411},
    { 22.571215 ,113.179544},
    { 22.571337 ,113.179659},
    { 22.571819, 113.179576},
    { 22.572383 ,113.179479},
    { 22.572907 ,113.179378},
    { 22.573236, 113.179315},
    { 22.573805 ,113.179196},
    { 22.574145 ,113.179110},
    { 22.574287 ,113.179077},
    { 22.574430 ,113.179104},
    { 22.574478 ,113.179189},
    { 22.574519 ,113.179403},
    { 22.574540 ,113.179519},
    { 22.574634 ,113.179523},
    { 22.574783 ,113.179485},
    { 22.574622 ,113.179512},
    { 22.574530 ,113.179440},
    { 22.574504 ,113.179305},
    { 22.574486 ,113.179212},
    { 22.574265 ,113.179102},
    { 22.573938 ,113.179187},
    { 22.573717 ,113.179241},
    { 22.573388 ,113.179309},
    { 22.573047 ,113.179384},
    { 22.572643 ,113.179457},
    { 22.572255, 113.179524},
    { 22.571880 ,113.179588},
    { 22.571646 ,113.179629},
    { 22.571193 ,113.179710},
    { 22.570732 ,113.179790},
    { 22.570389 ,113.179845},
    { 22.569676 ,113.179959},
    { 22.569381 ,113.180006},
    { 22.569099 ,113.180046},
    { 22.568814 ,113.180105},
    { 22.568721 ,113.180128},
    { 22.568601 ,113.180176},
    { 22.568531 ,113.180262},
    { 22.568560 ,113.180366},
    { 22.568595 ,113.180484},
    { 22.568631 ,113.180587},
    { 22.568461 ,113.180677},
    { 22.567913 ,113.180779},
    { 22.567574 ,113.180838},
    { 22.566830 ,113.180938},
    { 22.566233 ,113.181012},
    { 22.565850 ,113.181058},
    { 22.565241 ,113.181132},
    { 22.565037, 113.181158},
    { 22.564862 ,113.181177},
    { 22.564787, 113.181279},
    { 22.564932, 113.181329},
    { 22.565014, 113.181322},
    { 22.565160 ,113.181307},
    { 22.565278, 113.181293},
    { 22.565514, 113.181271},
    { 22.565713 ,113.181249},
    { 22.566298, 113.181180},
    { 22.566835 ,113.181107},
    { 22.567424, 113.181023},
    { 22.567836 ,113.180955},
    { 22.568701 ,113.180803},
    { 22.569379 ,113.180684},
    { 22.570076 ,113.180563},
    { 22.570780, 113.180422},
    { 22.571487, 113.180269},
    { 22.572173 ,113.180124},
    { 22.572729 ,113.180005},
    { 22.573121, 113.179913},
    { 22.573370, 113.179859},
    { 22.573552 ,113.179821},
    { 22.573658 ,113.179799},
    { 22.573577 ,113.179757},
    { 22.573361, 113.179810},
    { 22.573167 ,113.179853},
    { 22.573024 ,113.179885},
    { 22.572707 ,113.179959},
    { 22.572446 ,113.180020},
    { 22.572257 ,113.180060},
    { 22.571956 ,113.180119},
    { 22.571521, 113.180209},
    { 22.571167 ,113.180285},
    { 22.570777 ,113.180369},
    { 22.570350 ,113.180463},
    { 22.569882 ,113.180549},
    { 22.569375 ,113.180636},
    { 22.568834, 113.180733},
    { 22.568267 ,113.180835},
    { 22.567681, 113.180936},
    { 22.566454 ,113.181108},
    { 22.565819 ,113.181176},
    { 22.565307 ,113.181230},
    { 22.565009 ,113.181258},
    { 22.564856, 113.181290},
    { 22.565058 ,113.181319},
    { 22.565389 ,113.181283},
    { 22.565682, 113.181251},
    { 22.566016 ,113.181214},
    { 22.566392 ,113.181169},
    { 22.566871, 113.181101},
    { 22.567234, 113.181043},
    { 22.568218 ,113.180872},
    { 22.569287, 113.180701},
    { 22.569732, 113.180625},
    { 22.570647 ,113.180454},
    { 22.571362 ,113.180299},
    { 22.572091, 113.180141},
    { 22.572766 ,113.179992},
    { 22.573288 ,113.179873},
    { 22.573574 ,113.179809},
    { 22.573737 ,113.179773},
    { 22.573677 ,113.179729},
    { 22.573347 ,113.179809},
    { 22.572802, 113.179936},
    { 22.572148 ,113.180086},
    { 22.571561 ,113.180215},
    { 22.571027 ,113.180324},
    { 22.570386 ,113.180463},
    { 22.569648 ,113.180597},
    { 22.568845 ,113.180738},
    { 22.568003 ,113.180891},
    {22.567132, 113.181034},
    {22.566317, 113.181133},
    {22.565879, 113.181179},
    {22.565257 ,113.181242},
    {22.564982, 113.181267},
    {22.565167, 113.181305},
    {22.565637, 113.181251},
    {22.566116, 113.181191},
    {22.566481, 113.181143},
    {22.567284 ,113.181043},
    {22.568614 ,113.180818},
    {22.569087 ,113.180734},
    {22.570090 ,113.180560},
    {22.570881 ,113.180401},
    {22.571443 ,113.180277},
    {22.572583, 113.180027},
    {22.573201 ,113.179889},
    {22.573541 ,113.179810},
    {22.573727 ,113.179771},
    {22.573720 ,113.179724},
    {22.573638 ,113.179739},
    {22.573193 ,113.179840},
    {22.572841 ,113.179928},
    {22.572005 ,113.180119},
    {22.570621 ,113.180415},
    {22.570379 ,113.180465},
    {22.570135 ,113.180513},
    {22.569134 ,113.180694},
    { 22.568347 ,113.180835},
    { 22.567805 ,113.180930},
    { 22.566696 ,113.181097},
    {22.565866 ,113.181198},
    {22.565448 ,113.181245},
    {22.564996 ,113.181301},
    { 22.564809 ,113.181323},
    { 22.564918 ,113.181185},
    { 22.565094 ,113.181166},
    { 22.565714 ,113.181093},
    { 22.566268 ,113.181026},
    { 22.566823 ,113.180958},
    { 22.567169 ,113.180915},
    { 22.567868 ,113.180805},
    { 22.568298 ,113.180728},
    { 22.568547 ,113.180688},
    {22.568639 ,113.180655},
    {22.568620 ,113.180576},
    {22.568595 ,113.180469},
    {22.568565 ,113.180390},
    {22.568663 ,113.180195},
    {22.568723 ,113.180184},
    {22.568900 ,113.180126},
    {22.569212 ,113.180078},
    {22.569500 ,113.180034},
    {22.570009 ,113.179949},
    {22.570644 ,113.179844},
    {22.570994 ,113.179787},
    {22.571143 ,113.179763},
    {22.571607 ,113.179676},
    {22.571993 ,113.179606},
    {22.572431 ,113.179520},
    {22.572832 ,113.179441},
    {22.573180 ,113.179367},
    {22.573508, 113.179299},
    {22.573793, 113.179236},
    {22.574028, 113.179174},
    {22.574185 ,113.179140},
    {22.574295 ,113.179116},
    {22.574374, 113.179103},
    {22.574463 ,113.179191},
    {22.574500 ,113.179362},
    {22.574523 ,113.179482},
    {22.574561 ,113.179534},
    {22.574640 ,113.179523},
    {22.574739 ,113.179492},
    {22.574827, 113.179477},
    {22.574644, 113.179512},
    {22.574576 ,113.179524},
    {22.574484 ,113.179347},
    {22.574482 ,113.179260},
    {22.574463, 113.179160},
    {22.574263 ,113.179090},
    {22.574116 ,113.179131},
    {22.573658 ,113.179242},
    {22.573306 ,113.179318},
    {22.573063 ,113.179371},
    {22.572557, 113.179476},
    {22.572153, 113.179557},
    {22.571879, 113.179610},
    {22.571362 ,113.179704},
    {22.571009, 113.179747},
    {22.570805, 113.179772},
    {22.570323 ,113.179882},
    {22.569940 ,113.179938},
    {22.569724 ,113.179977},
    {22.569204, 113.180063},
    {22.568903, 113.180111},
    {22.568743 ,113.180150},
    {22.568625, 113.180190},
    {22.568549, 113.180284},
    {22.568580 ,113.180401},
    {22.568610 ,113.180515},
    {22.568634 ,113.180603},
    {22.568370 ,113.180702},
    {22.567980, 113.180772},
    {22.567650, 113.180835},
    {22.567501 ,113.180864},
    {22.567404, 113.180869},
    {22.567636 ,113.180852},
    {22.568223 ,113.180739},
    {22.568433 ,113.180706},
    {22.568586 ,113.180674},
    {22.568589, 113.180560},
    {22.568577, 113.180485},
    {22.568534 ,113.180351},
    {22.568551 ,113.180245},
    {22.568820 ,113.180139},
    {22.569196 ,113.180076},
    {22.569510 ,113.180022},
    {22.570107 ,113.179915},
    {22.570916 ,113.179772},
    {22.571289 ,113.179705},
    {22.571568, 113.179655},
    {22.571925 ,113.179596},
    {22.572743 ,113.179437},
    {22.573009 ,113.179386},
    {22.573505 ,113.179291},
    {22.573838 ,113.179213},
    {22.574092 ,113.179159},
    {22.574266 ,113.179122},
    {22.574560 ,113.179048},
    {22.574917, 113.178909},
    {22.575039 ,113.178866},
    {22.575180 ,113.178858},
    {22.575342, 113.178870},
    {22.575515, 113.179176},
    {22.575669 ,113.179185},
    {22.576070 ,113.179105},
    {22.577289 ,113.178834},
    {22.577907 ,113.178694},
    {22.578435 ,113.178574},
    {22.578699 ,113.178468},
    {22.578542 ,113.177899},
    {22.578337 ,113.177519},
    {22.578305 ,113.177413},
    {22.578363 ,113.177316},
    {22.578958 ,113.176922},
    {22.579429 ,113.176668},
    {22.579827 ,113.176525},
    {22.580050 ,113.176417},
    {22.580063 ,113.175639},
    {22.579769 ,113.174758},
    {22.579586 ,113.174257},
    {22.579316 ,113.173438},
    {22.578747 ,113.171764},
    {22.578507 ,113.171034},
    {22.578381 ,113.170622}
};

@interface ViewController ()<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;

///车头方向跟随转动
@property (nonatomic, strong) PausableMovingAnnotation *car1;


///全轨迹overlay
@property (nonatomic, strong) MAPolyline *fullTraceLine;

@property (nonatomic, strong) MAMultiPointOverlay *overlay ; //海量地图点


@property (nonatomic, assign) int passedTraceCoordIndex;

@property (nonatomic, strong) NSArray *distanceArray;
@property (nonatomic, assign) double sumDistance;

@property (nonatomic, weak) MAAnnotationView *car1View;

@property (nonatomic, strong) NSMutableArray *carsArray;


@property(nonatomic,strong)UIButton *zoomBtn1;//地图放大

@property(nonatomic,strong)UIButton *zoomBtn2;//地图缩小

@property (nonatomic,assign)float zoomlevel;//地图缩放等级
@end

@implementation ViewController

#pragma mark - Map Delegate
- (void)mapInitComplete:(MAMapView *)mapView {
    
    [self initPath];
    
    [self  showCoordinate];
    //中心点
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(22.570014 ,113.180562);
    //地图level
    self.mapView.zoomLevel = 14;  //地图level 13～14 时有长线出现 其他不会
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if (annotation == self.car1 || [self.carsArray containsObject:annotation])
    {
        NSString *pointReuseIndetifier = @"pointReuseIndetifier1";
        @autoreleasepool{
            MAAnnotationView *annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
            if(!annotationView) {
                annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
                
                annotationView.canShowCallout = YES;
                
                UIImage *imge  =  [UIImage imageNamed:@"m_r1"];
                annotationView.image =  imge;
                
                if(annotation == self.car1) {
                    self.car1View = annotationView;
                }
            }
            return annotationView;
            
        }
     }
    else if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if(!annotationView) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            
            annotationView.canShowCallout = YES;
            
            UIImage *imge  =  [UIImage imageNamed:@"car"];
            annotationView.image =  imge;
            
         
        }
        
        return annotationView;
        
    }
    else if([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        NSString *pointReuseIndetifier = @"pointReuseIndetifier3";
        MAAnnotationView *annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            annotationView.canShowCallout = YES;
        }
        if ([annotation.title isEqualToString:@"route"]) {
            annotationView.enabled = NO;
            annotationView.image = [UIImage imageNamed:@"trackingPoints"];
        }
        [self.car1View.superview bringSubviewToFront:self.car1View];
        return annotationView;
    }
    return nil;
}

- (MAPolylineRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    if(overlay == self.fullTraceLine) {
        MAPolylineRenderer *polylineView = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth   = 6.f;
        polylineView.strokeColor = [UIColor colorWithRed:0 green:0.47 blue:1.0 alpha:0.9];
        
        return polylineView;
    } else if ([overlay isKindOfClass:[MAMultiPointOverlay class]]){
        
        
        MAMultiPointOverlayRenderer * renderer = [[MAMultiPointOverlayRenderer alloc] initWithMultiPointOverlay:overlay];
        ///设置图片
        renderer.icon = [UIImage imageNamed:@"trackingPoints"];
        ///设置锚点
        renderer.anchor = CGPointMake(0.5,0.5);
        //renderer.delegate = self;
        return renderer;
        
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    NSLog(@"cooridnate :%f, %f", view.annotation.coordinate.latitude, view.annotation.coordinate.longitude);
}

#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    
    [self initBtn];
    
  
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}



- (void)initBtn {
    //地图缩放按钮
    self.zoomBtn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.zoomBtn1.font=[UIFont systemFontOfSize:40];
    [self.zoomBtn1 setTitle:@"+" forState:UIControlStateNormal];
    self.zoomBtn1.frame = CGRectMake(KScreenW-60,KScreenH-200, 50, 50);
   
    self.zoomBtn1.tintColor=[UIColor grayColor];
    [self.zoomBtn1 setBackgroundColor:[UIColor whiteColor]];
    self.zoomBtn1.alpha=0.8;
    self.zoomBtn1.layer.borderWidth = 1;
    self.zoomBtn1.layer.borderColor = [UIColor grayColor].CGColor;
    
    [self.zoomBtn1 addTarget:self action:@selector(setZoomBtn1) forControlEvents:UIControlEventTouchUpInside];
    
    //地图缩放按钮
    self.zoomBtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.zoomBtn2.font=[UIFont systemFontOfSize:50];
    [self.zoomBtn2 setTitle:@"-" forState:UIControlStateNormal];

    self.zoomBtn2.frame = CGRectMake(KScreenW-60,KScreenH-150, 50, 50);
    self.zoomBtn2.tintColor=[UIColor grayColor];
    [self.zoomBtn2 setBackgroundColor:[UIColor whiteColor]];
    self.zoomBtn2.alpha=0.8;
    self.zoomBtn2.layer.borderWidth = 1;
    self.zoomBtn2.layer.borderColor = [UIColor grayColor].CGColor;
    [self.zoomBtn2 addTarget:self action:@selector(setZoomBtn2) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.zoomBtn1];
    [self.view addSubview:self.zoomBtn2];
   
}


#pragma mark-绘制折线
-(void)initPath{
    
    [self.mapView removeAnnotation:self.car1];
   
    int count = (int)sizeof(s_coords) / sizeof(s_coords[0]);
    NSLog(@"%i",count);

    //计算路径路程
    double sum = 0;
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:count];
    for(int i = 0; i < count - 1; ++i) {
        CLLocation *begin = [[CLLocation alloc] initWithLatitude:s_coords[i].latitude longitude:s_coords[i].longitude];
        CLLocation *end = [[CLLocation alloc] initWithLatitude:s_coords[i+1].latitude longitude:s_coords[i+1].longitude];
        CLLocationDistance distance = [end distanceFromLocation:begin];
        [arr addObject:[NSNumber numberWithDouble:distance]];
        sum += distance;
    }
    
    self.distanceArray = arr;
    self.sumDistance = sum;
  

    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.fullTraceLine = [MAPolyline polylineWithCoordinates:s_coords count:count];
   
    [self.mapView addOverlay:self.fullTraceLine];
    

    self.car1 = [[PausableMovingAnnotation alloc] init];
    self.car1.title = @"Car1";
    [self.mapView addAnnotation:self.car1];
    [self.car1 setCoordinate:s_coords[0]];
    
    double speed_car1 = 1800.0 / 3.6;
    __weak typeof(self) weakSelf = self;
    
    [self.car1 addMoveAnimationWithKeyCoordinates:s_coords count:count withDuration:sum/speed_car1 withName:nil completeCallback:^(BOOL isFinished) {
        
        [weakSelf.car1 setCoordinate:CLLocationCoordinate2DMake(s_coords[0].latitude, s_coords[0].longitude)];
    }];
}
#pragma mark- 海量点绘制
-(void)showCoordinate{

    //创建MultiPointItems数组，
    NSMutableArray *items = [NSMutableArray array];
    int count = (int)sizeof(s_coords) / sizeof(s_coords[0]);
    for (int i = 0; i < count; i++)
    {
        @autoreleasepool {
            MAMultiPointItem *item = [[MAMultiPointItem alloc] init];
        
            item.coordinate = CLLocationCoordinate2DMake(s_coords[i].latitude, s_coords[i].longitude);
            
            [items addObject:item];
            
        }
    }
    //根据items创建海量点Overlay MultiPointOverlay
    self.overlay = [[MAMultiPointOverlay alloc] initWithMultiPointItems:items];

    ///把Overlay添加进mapView
    [self.mapView addOverlay:self.overlay];
    
}


//缩放地图方法

-(void)setZoomBtn1{
    float max=self.mapView.maxZoomLevel;
    if (self.zoomlevel<max) {
        self.zoomlevel++;
        [self.mapView setZoomLevel:self.zoomlevel  animated:NO];
    }
}
-(void)setZoomBtn2{
    
    float min=self.mapView.minZoomLevel;
    if (self.zoomlevel>min) {
        self.zoomlevel--;
        [self.mapView setZoomLevel:self.zoomlevel  animated:NO];
    }
}
/**
 * @brief 地图缩放结束后调用此接口
 * @param mapView       地图view
 * @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction{
    self.zoomlevel=self.mapView.zoomLevel;
    if(self.mapView.zoomLevel==self.mapView.minZoomLevel){
        self.zoomBtn2.enabled=NO;
    }else if(self.mapView.zoomLevel==self.mapView.maxZoomLevel){
        self.zoomBtn1.enabled=NO;
    }else{
        self.zoomBtn1.enabled=YES;
        self.zoomBtn2.enabled=YES;
    }
    
}



@end
