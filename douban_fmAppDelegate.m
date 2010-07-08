//
//  douban_fmAppDelegate.m
//  douban.fm
//
//  Created by xhan on 10-7-6.
//  Copyright 2010 Baidu.com. All rights reserved.
//

#import "douban_fmAppDelegate.h"

@implementation douban_fmAppDelegate

@synthesize itemEnableDock;
@synthesize statusMenu;
@synthesize webView;
@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
//	NSLog(@"finish launching");
	[webView setFrameLoadDelegate:self];
	
	[webView setMainFrameURL:@"http://douban.fm/radio"];
	
	
	
}


- (void)awakeFromNib
{
	NSLog(@"awake");
//	[super awakeFromNib];
	
	/*
	 1. NSVariableStatusItemLength -Makes the status item length dynamic, adjusting to the width of its contents.
	 2. NSSquareStatusItemLength – Sets the status item length to the status bar thickness.

	 */
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain]; 
	[statusItem setMenu:statusMenu];
	[statusItem setTitle:@"*FM*"];
	/*
	 - (void)setImage:(NSImage *)image
	 -(void)setAlternateImage:(NSImage *)image
	 */
	
	[statusItem setHighlightMode:YES];
	[itemEnableDock setTarget:self];
	[itemEnableDock setAction:@selector(onItemEnableDockClick:)];
	
}

- (void)onItemEnableDockClick:(id)sender
{
	switch ([itemEnableDock state]) {
		case NSOnState:
		{
			[itemEnableDock setState:NSOffState];
			
			//NSApplicationPresentationOptions options = NSApplicationPresentationHideDock ;
			
			//[NSApp setPresentationOptions:options];
			
			//restart to make it works
			
//			showDockIcon = ![[[[NSBundle mainBundle] infoDictionary] objectForKey:@"LSUIElement"] boolValue];
			
//			[[NSUserDefaults standardUserDefaults] boolForKey:PREF_HIDE_DOCK_ICON]
		}
			break;
		case NSOffState:
		{
			[itemEnableDock setState:NSOnState];
			
			ProcessSerialNumber psn = { 0, kCurrentProcess }; 
			OSStatus returnCode = TransformProcessType(&psn, kProcessTransformToForegroundApplication);
			if( returnCode != 0) {
				NSLog(@"Could not bring the application to front. Error %d", returnCode);
			}
			
		}
			break;
	
		default:
			break;
	}
}
	 

- (void)dealloc {
	[itemEnableDock release], itemEnableDock = nil;
	[statusMenu release], statusMenu = nil;
	[webView release], webView = nil;
	[super dealloc];
}

#pragma mark Delegates
#pragma mark -



- (void)webView:(WebView *)sender didReceiveTitle:(NSString *)title forFrame:(WebFrame *)frame 
{
	//@" - 豆瓣电台" or 豆瓣电台
	[window setTitle:title]; 
	
}

- (void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame
{
	NSLog(@"start loading");
}

- (void)webView:(WebView *)sender didFailProvisionalLoadWithError:(NSError *)error forFrame:(WebFrame *)frame
{
	NSLog(@"opps, load failed");
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
	NSLog(@"finished loading");
	
}


@end



