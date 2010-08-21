//
//  douban_fmAppDelegate.m
//  douban.fm
//
//  Created by xhan on 10-7-6.
//  Copyright 2010 Baidu.com. All rights reserved.
//

#import "douban_fmAppDelegate.h"

@implementation douban_fmAppDelegate

@synthesize notifyFieldCell;
@synthesize activityIndicator;

@synthesize splashView;
@synthesize webView;
@synthesize window;


#pragma mark -
#pragma mark life cycle

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[webView setFrameLoadDelegate:self];
	[webView setResourceLoadDelegate:self];
	[webView setMainFrameURL:@"http://douban.fm/radio"];
	
	[activityIndicator startAnimation:nil];	
}

	 
- (void)dealloc {
	[notifyFieldCell release], notifyFieldCell = nil;
	[activityIndicator release], activityIndicator = nil;
	[splashView release], splashView = nil;
	[webView release], webView = nil;
	[super dealloc];
}


#pragma mark -
#pragma mark Delegates


- (void)webView:(WebView *)sender didReceiveTitle:(NSString *)title forFrame:(WebFrame *)frame 
{
	[window setTitle:title];
}

- (void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame
{
//	NSLog(@"start loading");
}

- (void)webView:(WebView *)sender didFailProvisionalLoadWithError:(NSError *)error forFrame:(WebFrame *)frame
{
//	NSLog(@"opps, load failed");
	[notifyFieldCell setStringValue:@"Douban is sleeping, call me later!"];
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
	//NSLog(@"finished loading");	
	[self performSelector:@selector(removeSplashView) withObject:nil afterDelay:1];	
}


- (void)removeSplashView
{
	[activityIndicator stopAnimation:nil];
	[splashView removeFromSuperview];	
}


@end







