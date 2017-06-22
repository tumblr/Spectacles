//
//  ExampleSwiftTests.swift
//  ExampleSwiftTests
//
//  Created by C4Q on 6/22/17.
//  Copyright © 2017 Liam Kane. All rights reserved.
//

import XCTest
import Spectacles
@testable import SpectaclesSwift

class ExampleSwiftTests: XCTestCase {
    
    var spec: TMPodspec!
    var bryanIrace: TMAuthor!
    var matthewBischoff: TMAuthor!
    var samGiddins: TMAuthor!
    
    override func setUp() {
        super.setUp()
        let jsonURL = Bundle.main.url(forResource: "Sample.podspec", withExtension: ".json")
        self.spec = TMPodspec(fileURL: jsonURL)!
        
        self.bryanIrace = TMAuthor(name: "Bryan Irace", emailAddress: "bryan@irace.me")
        self.matthewBischoff = TMAuthor(name: "Matthew Bischoff", emailAddress: nil)
        self.samGiddins = TMAuthor(name: "Sam Giddins", emailAddress: nil)
    }
    
    func testSpecName() {
        XCTAssertEqual(self.spec.name, "Sample")
    }
    
    func testSpecVersion() {
        XCTAssertEqual(self.spec.version, "1.3.4")
    }
    
    func testSpecLibraryVersion() {
        XCTAssertEqual(self.spec.libraryVersion.majorVersion, 1)
        XCTAssertEqual(self.spec.libraryVersion.minorVersion, 3)
        XCTAssertEqual(self.spec.libraryVersion.patchVersion, 4)
        
        XCTAssertFalse(self.spec.libraryVersion.isPrereleaseVersion)
        XCTAssertNil(self.spec.libraryVersion.prereleaseVersionIdentifier)
    }
    
    func testPrereleaseVersion() {
        let data = JSONDataForDictionary(["version": "1.4.7-beta3"])
        spec = TMPodspec(data: data)
        
        XCTAssertEqual(spec.libraryVersion.majorVersion, 1)
        XCTAssertEqual(spec.libraryVersion.minorVersion, 4)
        XCTAssertEqual(spec.libraryVersion.patchVersion, 7)
        
        XCTAssertTrue(spec.libraryVersion.isPrereleaseVersion)
        XCTAssertEqual(spec.libraryVersion.prereleaseVersionIdentifier, "beta3")
    }
    
    func testShortVersion() {
        let data = JSONDataForDictionary(["version": "1"])
        spec = TMPodspec(data: data)
        
        
        XCTAssertEqual(spec.libraryVersion.majorVersion, 1);
        XCTAssertEqual(spec.libraryVersion.minorVersion, 0);
        XCTAssertEqual(spec.libraryVersion.patchVersion, 0);
        
        XCTAssertFalse(spec.libraryVersion.isPrereleaseVersion);
        XCTAssertNil(spec.libraryVersion.prereleaseVersionIdentifier);
    }
    
    func testShortBetaVersion() {
        let data = JSONDataForDictionary(["version": "1-beta74"])
        spec = TMPodspec(data: data)
        
        XCTAssertEqual(spec.libraryVersion.majorVersion, 1)
        XCTAssertEqual(spec.libraryVersion.minorVersion, 0)
        XCTAssertEqual(spec.libraryVersion.patchVersion, 0)
        
        XCTAssertTrue(spec.libraryVersion.isPrereleaseVersion)
        XCTAssertEqual(spec.libraryVersion.prereleaseVersionIdentifier, "beta74")
    }
    
    func testSpecAuthors() {
        XCTAssertEqual(self.spec.authors, [self.bryanIrace]);
    }
    
    func testAuthorAsString() {
        let authorAsStringSpec = TMPodspec(data: JSONDataForDictionary (["author": self.matthewBischoff.name]))!
    
    
        XCTAssertEqual(authorAsStringSpec.authors, [self.matthewBischoff]);
    }
    
    func testAuthorAsArray() {
        let data = JSONDataForDictionary(["authors": [self.matthewBischoff.name, self.samGiddins.name]])
        let authorAsStringSpec = TMPodspec(data: data)!
    
        //This is a little strange, however this seems to me the most efficient way to unwrap the authors, which are currently optionals because of how I declared them up at the top. In production I imagine declaration to be done by injecting the properties into the class via the init, thus avoiding the optionals.
        
        let authors = [self.matthewBischoff, self.samGiddins].flatMap{ $0 }
        
        XCTAssertEqual(authorAsStringSpec.authors, authors)
    }
    
    func testAuthorAsDictionary() {
        let data = JSONDataForDictionary(["authors": [self.bryanIrace.name: self.bryanIrace.emailAddress, self.matthewBischoff.name: nil]])
        let authorAsStringSpec = TMPodspec(data:data)!
    
        let authors = [self.bryanIrace, self.matthewBischoff].flatMap{ $0 }
        
        XCTAssertEqual(Set<TMAuthor>(authorAsStringSpec.authors), Set<TMAuthor>(authors))
    }

    
    func testSpecSocialMediaURL() {
        XCTAssertEqual(self.spec.socialMediaURL, URL(string: "https://twitter.com/irace")!)
    }
    
    func testDocsetURL() {
        XCTAssertEqual(self.spec.docsetURL, URL(string: "https://github.com/irace/Sample/Docset.atom")!)
    }
    
    func testSpecHomepageURL() {
        XCTAssertEqual(self.spec.homepageURL, URL(string: "https://github.com/irace/Sample")!)
    }
    
    func testSpecSummary() {
        XCTAssertEqual(self.spec.summary, "A library with some functionality")
    }
    
    func testSpecDescription() {
        XCTAssertEqual(self.spec.descriptionString, "A library with some functionality…and some more.")
    }
    
    func testScreenshots() {
        let screenshotURLS = [URL(string: "https://github.com/irace/Sample/Screenshot.gif")!,
                              URL(string: "https://github.com/irace/Sample/Screenshot2.gif")!]
        XCTAssertEqual(self.spec.screenshotURLs, screenshotURLS);
    }
    
    func testDocumentationURL() {
        XCTAssertEqual(self.spec.documentationURL, URL(string: "https://github.com/irace/Sample/Docs"))
    }
    
    func testPrepareCommand() {
        XCTAssertEqual(self.spec.prepareCommand, "ruby build_files.rb");
    }
    
    func testDeprecated() {
        XCTAssertEqual(self.spec.isDeprecated, true);
    }
    
    func testDeprecatedInFavorOf() {
        XCTAssertEqual(self.spec.podNameDeprecatedInFavorOf, "BlogQuest");
    }
    
    func testNilFileURLDoesNotThrowException() {
        XCTAssertNoThrow(TMPodspec(fileURL: nil))
    }

    //Helper
    func JSONDataForDictionary(_ dictionary: [String: Any]) -> Data {
        let data = try! JSONSerialization.data(withJSONObject: dictionary, options: [])
        return data
    }

}


