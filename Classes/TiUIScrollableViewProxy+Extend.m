//
//  TiUIScrollableViewProxy+Extend.m
//  VerticalScrollableView
//
//  Created by Kazuyuki Tanimura on 5/12/14.
//
//

#import "TiUIScrollableViewProxy+Extend.h"

@implementation TiUIScrollableViewProxy (Extend)

-(void)shiftView:(id)args
{
  if ([viewProxies count] == 0)
  {
    return;
  }
  
  [self lockViewsForWriting];
  TiViewProxy * doomedView;
  doomedView = [viewProxies objectAtIndex:0];

  [doomedView setParent:nil];
  TiThreadPerformOnMainThread(^{[doomedView detachView];}, NO);
  [self forgetProxy:doomedView];
  [viewProxies removeObject:doomedView];
  [self unlockViews];
  int index = [TiUtils intValue:[self valueForUndefinedKey:@"currentPage"]];
  if (index > 0) {
    index--;
  }
  TiThreadPerformOnMainThread(^{
    [((TiUIScrollableView*)self.view) setCurrentPage_:NUMINT(index)];
  }, NO);
}

@end
