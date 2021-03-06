//
//  OpenRadar.h
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

#ifndef OPENRADAR_H
#define OPENRADAR_H

#if TARGET_OS_IPHONE

#import "ORComment.h"
#import "ORRadar.h"
#import "ORServiceClient.h"
#import "ORServiceError.h"

#else

#import <OpenRadar/ORComment.h>
#import <OpenRadar/ORRadar.h>
#import <OpenRadar/ORServiceClient.h>
#import <OpenRadar/ORServiceError.h>

#endif

#endif

/**
 * @mainpage OpenRadar.framework
 *
 * @section section_introduction Introduction
 *
 * OpenRadar.framework is an Objective-C framework for interacting with the 
 * Open Radar project at http://openradar.appspot.com
 *
 * @section section_requirements Requirements
 *
 * OpenRadar.framework targets Mac OS X 10.5.8+ and iOS 4.2+.
 *
 * @section section_acknowledgements Acknowledgements
 *
 * OpenRadar.framework interacts with Open Radar created by Tim Burks.
 *
 * http://openradar.appspot.com
 *
 * OpenRadar makes use of the following code:
 *
 * JSON framework created by Stig Brautaset.
 *
 * http://github.com/stig/json-framework
 *
 * GHUnit framework created by Gabriel Handford
 *
 * https://github.com/gabriel/gh-unit
 *
 */
