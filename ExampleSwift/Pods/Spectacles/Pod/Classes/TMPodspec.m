#import "TMPodspec.h"
#import "TMAuthor.h"
#import "TMLibraryVersion.h"

#pragma mark - Root Specification Keys

static NSString * const PodspecKeyName = @"name";
static NSString * const PodspecKeyVersion = @"version";
static NSString * const PodspecKeyAuthors = @"authors";
static NSString * const PodspecKeyAuthor = @"author";
static NSString * const PodspecKeySocialMediaURL = @"social_media_url";
static NSString * const PodspecKeyDocsetURL = @"docset_url";
static NSString * const PodspecKeyHomepageURL = @"homepage";
static NSString * const PodspecKeySource = @"source";
static NSString * const PodspecKeySummary = @"summary";
static NSString * const PodspecKeyDescription = @"description";
static NSString * const PodspecKeyScreenshots = @"screenshots";
static NSString * const PodspecKeyScreenshot = @"screenshot";
static NSString * const PodspecKeyDocumentationURL = @"documentation_url";
static NSString * const PodspecKeyPrepareCommand = @"prepare_command";
static NSString * const PodspecKeyDeprecated = @"deprecated";
static NSString * const PodspecKeyDeprecatedInFavorOf = @"deprecated_in_favor_of";

@interface TMPodspec ()

@property (nonatomic) NSDictionary *dictionary;

@end

@implementation TMPodspec

#pragma mark - Initialization

- (instancetype)initWithData:(NSData *)data {
    if (self = [super init]) {
        if (!data) {
            NSLog(@"No podspec data specified: %@", data);
            return nil;
        }
        
        NSError *error;
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        if (error) {
            NSLog(@"Error parsing podspec data (%@) as JSON: %@", data, error);
            return nil;
        }
        
        if (![object isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Podspec data (%@) must map to an `NSDictionary` type", data);
            return nil;
        }
        
        _dictionary = object;
    }
    
    return self;
}

- (instancetype)initWithFileURL:(NSURL *)fileURL {
    return [self initWithData:[NSData dataWithContentsOfURL:fileURL]];
}

- (instancetype)init {
    return [self initWithData:nil];
}

#pragma mark - Properties

- (NSString *)name {
    return [self stringForKey:PodspecKeyName];
}

- (NSString *)version {
    return [self stringForKey:PodspecKeyVersion];
}

- (TMLibraryVersion *)libraryVersion {
    if (self.version) {
        return [[TMLibraryVersion alloc] initWithString:self.version];
    }
    
    return nil;
}

- (NSArray *)authors {
    NSString *authorName = [self stringForKey:PodspecKeyAuthor];
    NSArray *authorNames = [self arrayForKey:PodspecKeyAuthors];
    NSDictionary *authorNamesAndAddresses = [self dictionaryForKey:PodspecKeyAuthors];
    
    NSMutableArray *authors = [NSMutableArray array];
    
    if (authorNamesAndAddresses) {
        [authorNamesAndAddresses enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
            NSString *name = [key isKindOfClass:[NSString class]] ? key : nil;
            NSString *emailAddress = [value isKindOfClass:[NSString class]] ? value : nil;
            
            if (key) {
                TMAuthor *author = [[TMAuthor alloc] initWithName:name emailAddress:emailAddress];
                [authors addObject:author];
            }
        }];
    }
    else if (authorNames) {
        for (id name in authorNames) {
            if ([name isKindOfClass:[NSString class]]) {
                TMAuthor *author = [[TMAuthor alloc] initWithName:(NSString *)name emailAddress:nil];
                [authors addObject:author];
            }
        }
    }
    else if (authorName) {
        TMAuthor *author = [[TMAuthor alloc] initWithName:authorName emailAddress:nil];
        [authors addObject:author];
    }
    else {
        return nil;
    }

    return authors;
}

- (NSURL *)socialMediaURL {
    return [NSURL URLWithString:[self stringForKey:PodspecKeySocialMediaURL]];
}

- (NSURL *)docsetURL {
    return [NSURL URLWithString:[self stringForKey:PodspecKeyDocsetURL]];
}

- (NSURL *)homepageURL {
    return [NSURL URLWithString:[self stringForKey:PodspecKeyHomepageURL]];
}

- (NSString *)summary {
    return [self stringForKey:PodspecKeySummary];
}

- (NSString *)descriptionString {
    return [self stringForKey:PodspecKeyDescription];
}

- (NSArray *)screenshotURLs {
    NSString *singleScreenshotURLString = [self stringForKey:PodspecKeyScreenshot];
    NSArray *multipleScreenshotURLStrings = [self arrayForKey:PodspecKeyScreenshots];

    NSMutableArray *screenshotURLs = [NSMutableArray array];
    
    if (multipleScreenshotURLStrings) {
        for (id screenshotURLValue in multipleScreenshotURLStrings) {
            if ([screenshotURLValue isKindOfClass:[NSString class]]) {
                NSURL *URL = [NSURL URLWithString:(NSString *)screenshotURLValue];
                if (URL) {
                    [screenshotURLs addObject:URL];
                }
            }
        }
    }
    else if (singleScreenshotURLString) {
        NSURL *URL = [NSURL URLWithString:singleScreenshotURLString];
        if (URL) {
            [screenshotURLs addObject:URL];
        }
    }
    
    return [screenshotURLs count] ? screenshotURLs : nil;
}

- (NSURL *)documentationURL {
    return [NSURL URLWithString:[self stringForKey:PodspecKeyDocumentationURL]];
}

- (NSString *)prepareCommand {
    return [self stringForKey:PodspecKeyPrepareCommand];
}

- (BOOL)isDeprecated {
    return [self boolForKey:PodspecKeyDeprecated];
}

- (NSString *)podNameDeprecatedInFavorOf {
    return [self stringForKey:PodspecKeyDeprecatedInFavorOf];
}

#pragma mark - Private

- (NSString *)stringForKey:(NSString *)key {
    return [self objectOfClass:[NSString class] forKey:key];
}

- (NSArray *)arrayForKey:(NSString *)key {
    return [self objectOfClass:[NSArray class] forKey:key];
}

- (NSDictionary *)dictionaryForKey:(NSString *)key {
    return [self objectOfClass:[NSDictionary class] forKey:key];
}

- (BOOL)boolForKey:(NSString *)key {
    return [[self objectOfClass:[NSNumber class] forKey:key] boolValue];
}

- (id)objectOfClass:(Class)class forKey:(NSString *)key {
    id object = [self.dictionary objectForKey:key];
    
    if ([object isKindOfClass:class]) {
        return object;
    }
    else {
        return nil;
    }
}

@end
