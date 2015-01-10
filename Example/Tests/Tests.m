@import XCTest;
@import Foundation;

#import "TMPodspec.h"
#import "TMAuthor.h"

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

- (void)testSpecAuthors {
    XCTAssertEqualObjects(self.spec.authors, @[[[TMAuthor alloc] initWithName:@"Bryan Irace" emailAddress:@"bryan@irace.me"]]);
}

- (void)testSpecSocialMediaURL {
    XCTAssertEqualObjects(self.spec.socialMediaURL, [NSURL URLWithString:@"https://twitter.com/irace"]);
}

- (void)testDocsetURL {
    XCTAssertEqualObjects(self.spec.docsetURL, [NSURL URLWithString:@"https://github.com/irace/Sample/Docset.atom"]);
}

- (void)testSpecHomepageURL {
    XCTAssertEqualObjects(self.spec.homepageURL, [NSURL URLWithString:@"https://github.com/irace/Sample"]);
}

- (void)testSpecSummary {
    XCTAssertEqualObjects(self.spec.summary, @"A library with some functionality");
}

- (void)testSpecDescription {
    XCTAssertEqualObjects(self.spec.descriptionString, @"A library with some functionality…and some more.");
}

- (void)testScreenshots {
    NSArray *screenshotURLS =  @[[NSURL URLWithString:@"https://github.com/irace/Sample/Screenshot.gif"], [NSURL URLWithString:@"https://github.com/irace/Sample/Screenshot2.gif"]];
    XCTAssertEqualObjects(self.spec.screenshotURLs, screenshotURLS);
}

- (void)testDocumentationURL {
    XCTAssertEqualObjects(self.spec.documentationURL, [NSURL URLWithString:@"https://github.com/irace/Sample/Docs"]);
}

- (void)testPrepareCommand {
    XCTAssertEqualObjects(self.spec.prepareCommand, @"ruby build_files.rb");
}

- (void)testDeprecated {
    XCTAssertEqual(self.spec.deprecated, YES);
}

- (void)testDeprecatedInFavorOf {
    XCTAssertEqualObjects(self.spec.podNameDeprecatedInFavorOf, @"BlogQuest");
}

- (void)testNilFileURLDoesNotThrowException {
    XCTAssertNoThrow([[TMPodspec alloc] initWithFileURL:nil]);
}

@end
