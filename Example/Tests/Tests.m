@import XCTest;
@import Foundation;

#import "TMPodspec.h"
#import "TMAuthor.h"

@interface SpectaclesTest : XCTestCase

@property (nonatomic) TMPodspec *spec;
@property (nonatomic) TMAuthor *bryanIrace;
@property (nonatomic) TMAuthor *matthewBischoff;
@property (nonatomic) TMAuthor *samGiddins;


@end

@implementation SpectaclesTest

- (void)setUp {
    self.spec = [[TMPodspec alloc] initWithFileURL:
                 [[NSBundle bundleForClass:[self class]] URLForResource:@"Sample.podspec" withExtension:@"json"]];
    
    self.bryanIrace = [[TMAuthor alloc] initWithName:@"Bryan Irace" emailAddress:@"bryan@irace.me"];
    self.matthewBischoff = [[TMAuthor alloc] initWithName:@"Matthew Bischoff" emailAddress:nil];
    self.samGiddins = [[TMAuthor alloc] initWithName:@"Sam Giddins" emailAddress:nil];
}

- (void)testSpecName {
    XCTAssertEqualObjects(self.spec.name, @"Sample");
}

- (void)testSpecVersion {
    XCTAssertEqualObjects(self.spec.version, @"1.3.4");
}

- (void)testSpecLibraryVersion {
    XCTAssertEqual(self.spec.libraryVersion.majorVersion, 1);
    XCTAssertEqual(self.spec.libraryVersion.minorVersion, 3);
    XCTAssertEqual(self.spec.libraryVersion.patchVersion, 4);
    
    XCTAssertFalse(self.spec.libraryVersion.prereleaseVersion);
    XCTAssertNil(self.spec.libraryVersion.prereleaseVersionIdentifier);
}

- (void)testPrereleaseVersion {
    TMPodspec *spec = [[TMPodspec alloc] initWithData:[[self class] JSONDataForDictionary:@{@"version": @"1.4.7-beta3"}]];

    XCTAssertEqual(spec.libraryVersion.majorVersion, 1);
    XCTAssertEqual(spec.libraryVersion.minorVersion, 4);
    XCTAssertEqual(spec.libraryVersion.patchVersion, 7);
    
    XCTAssertTrue(spec.libraryVersion.isPrereleaseVersion);
    XCTAssertEqualObjects(spec.libraryVersion.prereleaseVersionIdentifier, @"beta3");
}

- (void)testShortVersion {
    TMPodspec *spec = [[TMPodspec alloc] initWithData:[[self class] JSONDataForDictionary:@{@"version": @"1"}]];
    
    XCTAssertEqual(spec.libraryVersion.majorVersion, 1);
    XCTAssertEqual(spec.libraryVersion.minorVersion, 0);
    XCTAssertEqual(spec.libraryVersion.patchVersion, 0);
    
    XCTAssertFalse(spec.libraryVersion.isPrereleaseVersion);
    XCTAssertNil(spec.libraryVersion.prereleaseVersionIdentifier);
}

- (void)testShortBetaVersion {
    TMPodspec *spec = [[TMPodspec alloc] initWithData:[[self class] JSONDataForDictionary:@{@"version": @"1-beta74"}]];
    
    XCTAssertEqual(spec.libraryVersion.majorVersion, 1);
    XCTAssertEqual(spec.libraryVersion.minorVersion, 0);
    XCTAssertEqual(spec.libraryVersion.patchVersion, 0);
    
    XCTAssertTrue(spec.libraryVersion.isPrereleaseVersion);
    XCTAssertEqualObjects(spec.libraryVersion.prereleaseVersionIdentifier, @"beta74");
}

- (void)testSpecAuthors {
    XCTAssertEqualObjects(self.spec.authors, @[self.bryanIrace]);
}

- (void)testAuthorAsString {
    TMPodspec *authorAsStringSpec = [[TMPodspec alloc] initWithData:[[self class] JSONDataForDictionary:@{@"author": self.matthewBischoff.name}]];
    
    XCTAssertEqualObjects(authorAsStringSpec.authors, @[self.matthewBischoff]);
}

- (void)testAuthorAsArray {
    NSData *data = [[self class] JSONDataForDictionary:@{@"authors": @[self.matthewBischoff.name, self.samGiddins.name]}];
    TMPodspec *authorAsStringSpec = [[TMPodspec alloc] initWithData:data];
    
    NSArray *authors = @[self.matthewBischoff, self.samGiddins];
    XCTAssertEqualObjects(authorAsStringSpec.authors, authors);
}

- (void)testAuthorAsDictionary {
    NSData *data = [[self class] JSONDataForDictionary:@{@"authors": @{self.bryanIrace.name: self.bryanIrace.emailAddress, self.matthewBischoff.name: [NSNull null]}}];
    TMPodspec *authorAsStringSpec = [[TMPodspec alloc] initWithData:data];
    
    NSArray *authors = @[self.bryanIrace, self.matthewBischoff];
    XCTAssertEqualObjects([NSSet setWithArray:authorAsStringSpec.authors], [NSSet setWithArray:authors]);
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
    XCTAssertEqual(self.spec.isDeprecated, YES);
}

- (void)testDeprecatedInFavorOf {
    XCTAssertEqualObjects(self.spec.podNameDeprecatedInFavorOf, @"BlogQuest");
}

- (void)testNilFileURLDoesNotThrowException {
    XCTAssertNoThrow([[TMPodspec alloc] initWithFileURL:nil]);
}

#pragma mark - Helpers

+ (NSData *)JSONDataForDictionary:(NSDictionary *)dictionary {
    return [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:nil];
}


@end
