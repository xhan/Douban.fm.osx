//
//  douban_fmAppDelegate.h
//  douban.fm
//
//  Created by xhan on 10-7-6.
//  Copyright 2010 Baidu.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
@interface douban_fmAppDelegate : NSObject <NSApplicationDelegate,NSWindowDelegate> {
    NSWindow *window;
	WebView *webView;	
	NSView* splashView;
	NSTextFieldCell* notifyFieldCell;
	NSProgressIndicator* activityIndicator;
}

@property (nonatomic, retain) IBOutlet NSTextFieldCell *notifyFieldCell;
@property (nonatomic, retain) IBOutlet NSProgressIndicator *activityIndicator;

@property (nonatomic, retain) IBOutlet NSView *splashView;
@property (nonatomic, retain) IBOutlet WebView *webView;
@property (assign) IBOutlet NSWindow *window;


@end



/*
 # application load sequence
 ------------------------
 awake
 finish launching
 start loading
 title: 豆瓣电台
 finished loading
 title: 不眠 - 豆瓣电台
*/



