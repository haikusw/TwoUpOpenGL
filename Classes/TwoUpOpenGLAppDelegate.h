//
//  TwoUpOpenGLAppDelegate.h
//  TwoUpOpenGL
//
//  Created by Douglass Turner on 6/6/10.
//  Copyright Elastic Image Software LLC 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EAGLView;

@interface TwoUpOpenGLAppDelegate : NSObject <UIApplicationDelegate> {
	
    UIWindow *m_window;
    EAGLView *m_upperView;
    EAGLView *m_lowerView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet EAGLView *upperView;
@property (nonatomic, retain) IBOutlet EAGLView *lowerView;

@end

