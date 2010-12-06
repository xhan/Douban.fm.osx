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

- (id)init{
	if (self = [super init]) {

//		[[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObject:@"zh_CN"] forKey:@"AppleLanguages"];

	}
	return self;
	
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[webView setFrameLoadDelegate:self];

	[webView setShouldUpdateWhileOffscreen:NO];
	[webView setMainFrameURL:@"http://douban.fm/radio"];
	
	[activityIndicator startAnimation:nil];	

	self.window.delegate = self;

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
	return;
	
	// some great posts about communicate between cocoa and javascript(html)
	// http://zonble.net/archives/2010_09/1369.php
	// http://zonble.net/archives/2010_09/1385.php
	// http://zonble.net/archives/2010_09/1403.php
	WebScriptObject* logs = [[webView windowScriptObject] valueForKeyPath:@"logs"];
	NSUInteger count = [[logs valueForKey:@"length"] integerValue];
//	NSMutableArray *a = [NSMutableArray array];
	for (NSUInteger i = 0; i < count; i++) {
		NSString *item = [logs webScriptValueAtIndex:i];
		NSLog(@"item:%@", item);
	}
	
	
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



- (void)windowWillMiniaturize:(NSNotification *)notification
{

}
- (void)windowDidDeminiaturize:(NSNotification *)notification
{
	//refrest webView
	[self.webView setHidden:YES];
	[self.webView setHidden:NO];

}

- (void)windowDidMiniaturize:(NSNotification *)notification
{
	
}

@end







