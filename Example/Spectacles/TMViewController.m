#import <Spectacles/TMPodspec.h>
#import "TMViewController.h"

@interface TMViewController ()

@property (nonatomic) UILabel *label;

@end

@implementation TMViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    TMPodspec *spec = [[TMPodspec alloc] initWithFileURL:
                       [[NSBundle mainBundle] URLForResource:@"Spectacles.podspec" withExtension:@"json"]];
    
    self.label = [[UILabel alloc] init];
    self.label.numberOfLines = 0;
    self.label.lineBreakMode = NSLineBreakByWordWrapping;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text = [NSString stringWithFormat:@"This sample uses %@ version %@ (%@), learn more at %@",
                       spec.name, spec.version, spec.summary, spec.homepageURL];
    
    [self.view addSubview:self.label];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.label.frame = self.view.bounds;
}

@end
