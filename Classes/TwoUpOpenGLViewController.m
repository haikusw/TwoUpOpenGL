    //
//  TwoUpOpenGLViewController.m
//  TwoUpOpenGL
//
//  Created by Douglass Turner on 6/8/10.
//  Copyright 2010 Elastic Image Software LLC. All rights reserved.
//

#import "TwoUpOpenGLViewController.h"
#import "EAGLView.h"

@implementation TwoUpOpenGLViewController

@synthesize upperView = m_upperView;
@synthesize lowerView = m_lowerView;

- (void)dealloc {
	
    [m_upperView release]; m_upperView = nil; self.upperView = nil;
    [m_lowerView release]; m_lowerView = nil; self.lowerView = nil;
	
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil context:(EAGLContext*)context {
	
    if (self = [super initWithNibName:nibNameOrNil bundle:nil]) {
		
		m_context = context;
    }
	
    return self;
	
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	[self.upperView initialize:m_context];
	[self.lowerView initialize:m_context];
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
