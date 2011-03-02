//
//  ORServiceClient.m
//
//  Copyright (c) 2010, Luna Park
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without 
//  modification, are permitted provided that the following conditions are met:
//
//  * Redistributions of source code must retain the above copyright notice, 
//    this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//  * Neither the name of the organization nor the names of its contributors
//    may be used to endorse or promote products derived from this software 
//    without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
//  POSSIBILITY OF SUCH DAMAGE.
//

#import "ORServiceClient.h"
#import "LPServiceRequest.h"
#import "NSString+SBJSON.h"
#import "ORComment.h"
#import "ORConstants.h"
#import "ORRadar.h"
#import "ORServiceError.h"
#import <Foundation/NSArray.h>
#import <Foundation/NSError.h>
#import <Foundation/NSData.h>
#import <Foundation/NSDate.h>
#import <Foundation/NSDictionary.h>
#import <Foundation/NSString.h>
#import <Foundation/NSURL.h>
#import <Foundation/NSURLConnection.h>
#import <Foundation/NSURLError.h>
#import <Foundation/NSURLRequest.h>
#import <Foundation/NSURLResponse.h>


#pragma mark -
#pragma mark Constants
#pragma mark -

@interface ORServiceClient (Private)

// Web Service Callbacks
- (void)commentCountDidFinishWithResult:(NSNumber *)aResult;
- (void)commentsForPageDidFinishWithResult:(NSArray *)aResult;
- (void)postRadarDidFinishWithResult:(NSDictionary *)aResult;
- (void)radarCountDidFinishWithResult:(NSNumber *)aResult;
- (void)radarForNumberDidFinishWithResult:(NSDictionary *)aResult;
- (void)radarsForPageDidFinishWithResult:(NSArray *)aResult;
- (void)radarsForUserNameDidFinishWithResult:(NSArray *)aResult;
- (void)radarNumbersForPageDidFinishWithResult:(NSArray *)aResult;
- (void)searchForStringDidFinishWithResult:(NSArray *)aResult;
- (void)testDidFinishWithResult:(NSDictionary *)aResult;

// NSURLConnection Delegate
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;

@end

@implementation ORServiceClient (Private)

#pragma mark -
#pragma mark Web Service Callbacks

- (void)commentCountDidFinishWithResult:(NSNumber *)aResult
{
	if ([delegate respondsToSelector:@selector(serviceClient:didFinishWithNumber:)])
    {
        [delegate serviceClient:self didFinishWithNumber:aResult];
    }
}

- (void)commentsForPageDidFinishWithResult:(NSArray *)aResult
{
    NSMutableArray *comments = [NSMutableArray arrayWithCapacity:[aResult count]];
    for (NSDictionary *commentDictionary in aResult)
    {
        ORComment *comment = [[[ORComment alloc] initWithDictionary:commentDictionary] autorelease];
        if (comment)
        {
            [comments addObject:comment];
        }
    }

    if ([delegate respondsToSelector:@selector(serviceClient:didFinishWithComments:)])
    {
        [delegate serviceClient:self didFinishWithComments:comments];
    }
}

- (void)postRadarDidFinishWithResult:(NSDictionary *)aResult
{
    NSMutableArray *radars = [NSMutableArray arrayWithCapacity:[aResult count]];
    for (NSDictionary *radarDictionary in aResult)
    {
        ORRadar *radar = [[[ORRadar alloc] initWithDictionary:radarDictionary] autorelease];
        if (radar)
        {
            [radars addObject:radar];
        }
    }

    if ([delegate respondsToSelector:@selector(serviceClient:didFinishWithRadars:)])
    {
        [delegate serviceClient:self didFinishWithRadars:radars];
    }
}

- (void)radarCountDidFinishWithResult:(NSNumber *)aResult
{
    if ([delegate respondsToSelector:@selector(serviceClient:didFinishWithNumber:)])
    {
        [delegate serviceClient:self didFinishWithNumber:aResult];
    }
}

- (void)radarForNumberDidFinishWithResult:(NSDictionary *)aResult
{
    NSMutableArray *radars = [NSMutableArray array];
    if ([aResult count] > 0)
    {
        ORRadar *radar = [[[ORRadar alloc] initWithDictionary:aResult] autorelease];
        if (radar)
        {
            [radars addObject:radar];
        }
    }

    if ([delegate respondsToSelector:@selector(serviceClient:didFinishWithRadars:)])
    {
        [delegate serviceClient:self didFinishWithRadars:radars];
    }
}

- (void)radarsForPageDidFinishWithResult:(NSArray *)aResult
{
    NSMutableArray *radars = [NSMutableArray arrayWithCapacity:[aResult count]];
    for (NSDictionary *radarDictionary in aResult)
    {
        ORRadar *radar = [[[ORRadar alloc] initWithDictionary:radarDictionary] autorelease];
        if (radar)
        {
            [radars addObject:radar];
        }
    }

    if ([delegate respondsToSelector:@selector(serviceClient:didFinishWithRadars:)])
    {
        [delegate serviceClient:self didFinishWithRadars:radars];
    }
}

- (void)radarNumbersForPageDidFinishWithResult:(NSArray *)aResult
{
    NSMutableArray *radarNumbers = [NSMutableArray arrayWithCapacity:[aResult count]];
    for (NSString *radarNumberString in aResult)
    {
        NSNumber *radarNumber = [NSDecimalNumber decimalNumberWithString:radarNumberString];
        if (radarNumber)
        {
            [radarNumbers addObject:radarNumber];
        }
    }

    if ([delegate respondsToSelector:@selector(serviceClient:didFinishWithRadarNumbers:)])
    {
        [delegate serviceClient:self didFinishWithRadarNumbers:radarNumbers];
    }
}

- (void)radarsForUserNameDidFinishWithResult:(NSArray *)aResult
{
    NSMutableArray *radars = [NSMutableArray arrayWithCapacity:[aResult count]];
    for (NSDictionary *radarDictionary in aResult)
    {
        ORRadar *radar = [[[ORRadar alloc] initWithDictionary:radarDictionary] autorelease];
        if (radar)
        {
            [radars addObject:radar];
        }
    }

    if ([delegate respondsToSelector:@selector(serviceClient:didFinishWithRadars:)])
    {
        [delegate serviceClient:self didFinishWithRadars:radars];
    }
}

- (void)searchForStringDidFinishWithResult:(NSArray *)aResult
{
    NSMutableArray *radars = [NSMutableArray arrayWithCapacity:[aResult count]];
    for (NSDictionary *radarDictionary in aResult)
    {
        ORRadar *radar = [[[ORRadar alloc] initWithDictionary:radarDictionary] autorelease];
        if (radar)
        {
            [radars addObject:radar];
        }
    }

    if ([delegate respondsToSelector:@selector(serviceClient:didFinishWithRadars:)])
    {
        [delegate serviceClient:self didFinishWithRadars:radars];
    }
}

- (void)testDidFinishWithResult:(NSDictionary *)aResult
{
    if ([delegate respondsToSelector:@selector(serviceClient:didFinishWithResult:)])
    {
        [delegate serviceClient:self didFinishWithResult:aResult];
    }
}

#pragma mark -
#pragma mark NSURLConnection Delegate

- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
{
#ifdef CONFIGURATION_DEBUG
    NSLog(@"[%@ connectionDidFinishLoading:]", [self className]);
#endif

    LPServiceRequest *serviceRequest = [self requestForConnection:connection];
    if (serviceRequest != nil)
    {
        NSString *responseDataString =
            [[[NSString alloc] initWithData:[serviceRequest receivedData]
                                   encoding:NSUTF8StringEncoding] autorelease];
        NSDictionary *responseDictionary = [responseDataString JSONValue];

        // Check for error
        id errorObject = [responseDictionary objectForKey:@"error"];
        if (errorObject && [errorObject isKindOfClass:[NSString class]])
        {
            NSString *errorDescription = (NSString *)errorObject;
            NSError *error =
                [NSError errorWithDomain:ORServiceClientErrorDomain
                                    code:ORServiceClientErrorCodeUnknown
                                userInfo:[NSDictionary dictionaryWithObject:errorDescription forKey:NSLocalizedDescriptionKey]];
            if ([delegate respondsToSelector:@selector(serviceClient:didFailWithError:)])
            {
                [delegate serviceClient:self didFailWithError:error];
            }
        }

        // Check for result
        id result = [responseDictionary objectForKey:@"result"];
        if(result == [NSNull null])
        {
            result = nil;
        }

        id target = [serviceRequest target];
        SEL selector = [serviceRequest selector];
        [target performSelector:selector withObject:result withObject:nil];
    }

    [super connectionDidFinishLoading:connection];
}

#pragma mark -

@end

@implementation ORServiceClient

@synthesize authorizationToken;

#pragma mark -
#pragma mark Initialization

- (id)init
{
    if (!(self = [super init]))
    {
        return nil;
    }

    return self;
}

#pragma mark -
#pragma mark Deallocation

- (void)dealloc
{
    [authorizationToken release];
    authorizationToken = nil;

    [super dealloc];
}

#pragma mark -
#pragma mark Web Services

- (void)commentCount
{
    NSString *requestURLString = [NSString stringWithFormat:@"%@/api/comment/count", ORBaseURLString];
    [self createConnectionWithURL:[NSURL URLWithString:requestURLString]
                           target:self
                         selector:@selector(commentCountDidFinishWithResult:)];
}

- (void)commentsForPage:(NSUInteger)page
{
    NSString *requestURLString = [NSString stringWithFormat:@"%@/api/comments?page=%lu", ORBaseURLString, page];
    [self createConnectionWithURL:[NSURL URLWithString:requestURLString]
                           target:self
                         selector:@selector(commentsForPageDidFinishWithResult:)];
}

- (void)postRadar:(ORRadar *)aRadar
{
    NSMutableString *encodedParameters = [NSMutableString string];

    if ([aRadar classification] != nil)
    {
        [encodedParameters appendFormat:@"classification=%@&", [[aRadar classification] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }

    if ([aRadar details] != nil)
    {
        [encodedParameters appendFormat:@"description=%@&", [[aRadar details] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }

    if ([aRadar number] != nil)
    {
        [encodedParameters appendFormat:@"number=%@&", [[[aRadar number] stringValue] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }

    if ([aRadar originated] != nil)
    {
        [encodedParameters appendFormat:@"originated=%@&", [[aRadar originated] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }

    if ([aRadar product] != nil)
    {
        [encodedParameters appendFormat:@"product=%@&", [[aRadar product] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }

    if ([aRadar productVersion] != nil)
    {
        [encodedParameters appendFormat:@"product_version=%@&", [[aRadar productVersion] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }

    if ([aRadar reproducible] != nil)
    {
        [encodedParameters appendFormat:@"reproducible=%@&", [[aRadar reproducible] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }

    if ([aRadar status] != nil)
    {
        [encodedParameters appendFormat:@"status=%@&", [[aRadar status] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }

    if ([aRadar title] != nil)
    {
        [encodedParameters appendFormat:@"title=%@&", [[aRadar title] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }

    NSString *requestURLString = [NSString stringWithFormat:@"%@/api/radar?auth=%@", ORBaseURLString, [self authorizationToken]];
    NSMutableURLRequest *aRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestURLString]];
    [aRequest setHTTPBody:[encodedParameters dataUsingEncoding:NSUTF8StringEncoding]];
    [aRequest setHTTPMethod:@"POST"];
    [self createConnectionWithURLRequest:aRequest
                                  target:self
                                selector:@selector(postRadarDidFinishWithResult:)];
}

- (void)radarCount
{
    NSString *requestURLString = [NSString stringWithFormat:@"%@/api/radar/count", ORBaseURLString];
    [self createConnectionWithURL:[NSURL URLWithString:requestURLString]
                           target:self
                         selector:@selector(radarCountDidFinishWithResult:)];
}

- (void)radarForNumber:(NSUInteger)aNumber
{
    NSString *requestURLString = [NSString stringWithFormat:@"%@/api/radar?number=%lu", ORBaseURLString, aNumber];
    [self createConnectionWithURL:[NSURL URLWithString:requestURLString]
                           target:self
                         selector:@selector(radarForNumberDidFinishWithResult:)];
}

- (void)radarNumbersForPage:(NSUInteger)page
{
    NSString *requestURLString = [NSString stringWithFormat:@"%@/api/radars/numbers?page=%lu", ORBaseURLString, page];
    [self createConnectionWithURL:[NSURL URLWithString:requestURLString]
                           target:self
                         selector:@selector(radarNumbersForPageDidFinishWithResult:)];
}

- (void)radarsForPage:(NSUInteger)aPage
{
    NSString *requestURLString = [NSString stringWithFormat:@"%@/api/radar?page=%lu", ORBaseURLString, aPage];
    [self createConnectionWithURL:[NSURL URLWithString:requestURLString]
                           target:self
                         selector:@selector(radarsForPageDidFinishWithResult:)];
}

- (void)radarsForUserName:(NSString *)anUserName page:(NSUInteger)aPage
{
    NSString *requestURLString = [NSString stringWithFormat:
        @"%@/api/radar?user=%@&page=%lu",
        ORBaseURLString,
        [anUserName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
        aPage];
    [self createConnectionWithURL:[NSURL URLWithString:requestURLString]
                           target:self
                         selector:@selector(radarsForUserNameDidFinishWithResult:)];
}

- (void)searchForString:(NSString *)aString page:(NSUInteger)aPage
{
    NSString *requestURLString =
        [NSString stringWithFormat:@"%@/api/search?query=%@&page=%lu",
            ORBaseURLString,
            [aString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
            aPage];
    [self createConnectionWithURL:[NSURL URLWithString:requestURLString]
                           target:self
                         selector:@selector(searchForStringDidFinishWithResult:)];
}

- (void)test
{
    NSString *requestURLString = [NSString stringWithFormat:@"%@/api/test", ORBaseURLString];
    [self createConnectionWithURL:[NSURL URLWithString:requestURLString]
                           target:self
                         selector:@selector(testDidFinishWithResult:)];
}

@end
