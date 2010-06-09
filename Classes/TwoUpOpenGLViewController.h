//
//  TwoUpOpenGLViewController.h
//  TwoUpOpenGL
//
//  Created by Douglass Turner on 6/8/10.
//  Copyright 2010 Elastic Image Software LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EAGLContext;
@class EAGLView;
@interface TwoUpOpenGLViewController : UIViewController {

	EAGLContext *m_context;
	EAGLView *m_upperView;
	EAGLView *m_lowerView;
}

@property (nonatomic, retain) EAGLContext *context;
@property (nonatomic, retain) IBOutlet EAGLView *upperView;
@property (nonatomic, retain) IBOutlet EAGLView *lowerView;

- (id)initWithNibName:(NSString *)nibNameOrNil context:(EAGLContext*)context;

@end
