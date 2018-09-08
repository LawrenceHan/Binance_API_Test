#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "POPAPIKit.h"

FOUNDATION_EXPORT double POPAPIKitVersionNumber;
FOUNDATION_EXPORT const unsigned char POPAPIKitVersionString[];

