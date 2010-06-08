//
//  TwoUpOpenGLAppDelegate.h
//  TwoUpOpenGL
//
//  Created by Douglass Turner on 6/6/10.
//  Copyright Elastic Image Software LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAGLView;
@class EAGLContext;
@class TwoUpOpenGLViewController;
@interface TwoUpOpenGLAppDelegate : NSObject <UIApplicationDelegate> {
	
    EAGLContext					*m_context;
	TwoUpOpenGLViewController	*m_viewController;
    UIWindow					*m_window;
}

@property (nonatomic, retain) EAGLContext				*context;
@property (nonatomic, retain) TwoUpOpenGLViewController	*viewController;
@property (nonatomic, retain) IBOutlet UIWindow			*window;

@end

