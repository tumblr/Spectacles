@import XCTest;
@import Foundation;
#import "TMPodspec.h"

@interface SpectaclesTest : XCTestCase

@property (nonatomic) TMPodspec *spec;

@end

@implementation SpectaclesTest

- (void)setUp {
    self.spec = [[TMPodspec alloc] initWithFileURL:
                 [[NSBundle bundleForClass:[self class]] URLForResource:@"Sample.podspec" withExtension:@"json"]];
}

- (void)testSpecName {
    XCTAssertEqualObjects(self.spec.name, @"Sample");
}

- (void)testSpecVersion {
    XCTAssertEqualObjects(self.spec.version, @"1.0.0");
}

- (void)testSpecSummary {
    XCTAssertEqualObjects(self.spec.summary, @"A library with some functionality");
}

- (void)testSpecHomepageURL {
    XCTAssertEqualObjects(self.spec.homepageURL, [NSURL URLWithString:@"https://github.com/irace/Sample"]);
}

@end
