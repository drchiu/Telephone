//
//  AKABRecord+Querying.m
//  Telephone
//
//  Copyright (c) 2008-2012 Alexei Kuznetsov. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//  1. Redistributions of source code must retain the above copyright notice,
//     this list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//     this list of conditions and the following disclaimer in the documentation
//     and/or other materials provided with the distribution.
//  3. Neither the name of the copyright holder nor the names of contributors
//     may be used to endorse or promote products derived from this software
//     without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
//  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
//  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE THE COPYRIGHT HOLDER
//  OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
//  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
//  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
//  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
//  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "AKABRecord+Querying.h"


@implementation ABRecord (AKRecordQueryingAdditions)

@dynamic ak_fullName;

- (NSString *)ak_fullName {
  NSString *firstName = [self valueForProperty:kABFirstNameProperty];
  NSString *lastName = [self valueForProperty:kABLastNameProperty];
  NSString *company = [self valueForProperty:kABOrganizationProperty];
  NSInteger personFlags = [[self valueForProperty:kABPersonFlags] integerValue];
  BOOL isPerson = (personFlags & kABShowAsMask) == kABShowAsPerson;
  BOOL isCompany = (personFlags & kABShowAsMask) == kABShowAsCompany;
  
  ABAddressBook *AB = [ABAddressBook sharedAddressBook];
  NSString *theString = nil;
  if (isPerson) {
    if ([firstName length] > 0 && [lastName length] > 0) {
      if ([AB defaultNameOrdering] == kABFirstNameFirst) {
        theString = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
      } else {
        theString = [NSString stringWithFormat:@"%@ %@", lastName, firstName];
      }
    } else if ([firstName length] > 0) {
      theString = firstName;
    } else if ([lastName length] > 0) {
      theString = lastName;
    }
    
  } else if (isCompany) {
    if ([company length] > 0) {
      theString = company;
    }
  }
  
  return theString;
}

@end
