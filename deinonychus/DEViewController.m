//
//  DEViewController.m
//  deinonychus
//
//  Created by Jonathan Hunt on 3/13/14.
//  Copyright (c) 2014 Jonathan Hunt. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <GLKit/GLKView.h>

#import "DEViewController.h"
#import "GStreamerBackend.h"
#import "EaglUIView.h"


@interface DEViewController ()
@property (weak, nonatomic) IBOutlet UIButton *play;
@property (weak, nonatomic) IBOutlet UIButton *pause;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet EaglUIView *videoView;
@end


@implementation DEViewController
GStreamerBackend *gst_backend;

- (IBAction)play:(id)sender {
    NSLog(@"play pushed");
    [gst_backend play];
}

- (IBAction)pause:(id)sender {
    NSLog(@"Paused pushed");
    [gst_backend pause];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    gst_backend = [[GStreamerBackend alloc] init:self videoView:self.videoView];

//    NSLog([gst_backend getGStreamerVersion]);
    self.label.text = [NSString stringWithFormat:@"Welcome to%@!", [gst_backend getGStreamerVersion]];
    self.play.enabled = FALSE;
    self.pause.enabled = FALSE;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) gstreamerInitialized
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.play.enabled = TRUE;
        self.pause.enabled = TRUE;
        self.label.text = @"Ready";
        [gst_backend setUri:@"http://techslides.com/demos/sample-videos/small.webm"];
    });
}

-(void) gstreamerSetUIMessage:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.label.text = message;
    });
}

@end
