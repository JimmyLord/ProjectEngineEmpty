//
// Copyright (c) 2015 Jimmy Lord http://www.flatheadgames.com
//
// This software is provided 'as-is', without any express or implied warranty.  In no event will the authors be held liable for any damages arising from the use of this software.
// Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
// 1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
// 2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
// 3. This notice may not be removed or altered from any source distribution.

#include "GameCommonHeader.h"
#import "MyOpenGLView.h"
#import <OpenGL/gl.h>

@implementation MyOpenGLView

static CVReturn MyDisplayLinkCallback(CVDisplayLinkRef displayLink, const CVTimeStamp* now,
                                      const CVTimeStamp* outputTime, CVOptionFlags flagsIn,
                                      CVOptionFlags* flagsOut, void* displayLinkContext)
{
    CVReturn result = [(__bridge MyOpenGLView*)displayLinkContext getFrameForTime:outputTime];
    return result;
}

- (id)initWithFrame:(NSRect)frameRect //pixelFormat:(NSOpenGLPixelFormat *)format
{
    // context setup
    NSOpenGLPixelFormatAttribute attribs[] =
    {
        //NSOpenGLPFADoubleBuffer,
        //NSOpenGLPFAAllowOfflineRenderers,
        //NSOpenGLPFAMultisample, 1,
        //NSOpenGLPFASampleBuffers, 1,
        //NSOpenGLPFASamples, 4,
        //NSOpenGLPFAColorSize, 32,
		//NSOpenGLPFAOpenGLProfile, NSOpenGLProfileVersion3_2Core,
        
        ////NSOpenGLPFAWindow,
        NSOpenGLPFAColorSize, 32,
		NSOpenGLPFADepthSize, 32,
        NSOpenGLPFAAccelerated,
        NSOpenGLPFADoubleBuffer,
        ////NSOpenGLPFASingleRenderer,
        0
    };
    
    NSOpenGLPixelFormat* format = [[NSOpenGLPixelFormat alloc] initWithAttributes:attribs];
    
    self = [super initWithFrame:frameRect pixelFormat:format];
    if( self )
    {
        // Synchronize buffer swaps with vertical refresh rate
        GLint swapInt = 1;
        [[self openGLContext] setValues:&swapInt forParameter:NSOpenGLCPSwapInterval];    

        // Create a display link capable of being used with all active displays
        CVDisplayLinkCreateWithActiveCGDisplays( &m_DisplayLink );
        
        // Set the renderer output callback function
        CVDisplayLinkSetOutputCallback( m_DisplayLink, &MyDisplayLinkCallback, (__bridge void*)self );
        
        // Set the display link for the current renderer
        CGLContextObj cglContext = (CGLContextObj)[[self openGLContext] CGLContextObj];
        CGLPixelFormatObj cglPixelFormat = (CGLPixelFormatObj)[[self pixelFormat] CGLPixelFormatObj];
        CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext( m_DisplayLink, cglContext, cglPixelFormat );
        
        // Activate the display link
        CVDisplayLinkStart( m_DisplayLink );
    }
    
    return self;            
}

- (CVReturn)getFrameForTime:(const CVTimeStamp*)outputTime
{
    double timepassed = 1.0 / (outputTime->rateScalar * (double)outputTime->videoTimeScale / (double)outputTime->videoRefreshPeriod);
    
    NSOpenGLContext* currentContext = [self openGLContext];
    [currentContext makeCurrentContext];
    
    // must lock GL context because display link is threaded
    CGLLockContext( (CGLContextObj)[currentContext CGLContextObj] );

    if( g_pGameCore == 0 )
    {
        g_pGameCore = MyNew GameEmptyReplaceMe;
        g_pGameCore->OnSurfaceCreated();
        g_pGameCore->OnSurfaceChanged( 0, 0, 400, 600 );
        g_pGameCore->OneTimeInit();
    }    

    int depth;
    glGetIntegerv(GL_DEPTH_BITS, &depth);
    //NSLog(@"%i bits depth", depth)

    if( g_pGameCore )
    {
        g_pGameCore->Tick( timepassed );
    
        if( g_pGameCore->IsReadyToRender() )
        {
            g_pGameCore->OnDrawFrameStart( 0 );
            g_pGameCore->OnDrawFrame( 0 );
            glFlush();
        }
    }
    
    [currentContext flushBuffer];
    
    CGLUnlockContext((CGLContextObj)[currentContext CGLContextObj]);
    
    return kCVReturnSuccess;
}

- (void)dealloc
{
    // Release the display link
    CVDisplayLinkRelease( m_DisplayLink );
    [super dealloc];
}

- (void)drawRect:(NSRect)rect
{
}

- (void)awakeFromNib
{
    //NSSize viewBounds = [self bounds].size;
    //float viewWidth = viewBounds.width;
    //float viewHeight = viewBounds.height;
    
    // activate the display link
    CVDisplayLinkStart( m_DisplayLink );
}

- (void)update
{
    [super update];
    
//    if( g_pGameCore )
//    {
//        double timepassed = 1/60.0f; //self.timeSinceLastUpdate;
//        
//        
//        if( g_pGameCore->IsReadyToRender() )
//        {
//    //        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//            
//    //        [appDelegate killSplashScreen];
//            
//            //[self showLeaderboard];
//        }
//    }
}

- (void)reshape
{
    [super reshape];

    NSSize viewBounds = [self bounds].size;
    float viewWidth = viewBounds.width;
    float viewHeight = viewBounds.height;
    
    NSOpenGLContext* currentContext = [self openGLContext];
    [currentContext makeCurrentContext];
    
    // remember to lock the context before we touch it since display link is threaded
    CGLLockContext((CGLContextObj)[currentContext CGLContextObj]);
    
    // let the context know we've changed size
    [[self openGLContext] update];
    
    CGLUnlockContext((CGLContextObj)[currentContext CGLContextObj]);
    
    if( g_pGameCore )
        g_pGameCore->OnSurfaceChanged( 0, 0, viewWidth, viewHeight );
}

//@class NSOpenGLContext, NSOpenGLPixelFormat;
//
//@interface NSOpenGLView : NSView {
//@private
//NSOpenGLContext*     _openGLContext;
//NSOpenGLPixelFormat* _pixelFormat;
//NSInteger                _reserved1;
//NSInteger                _reserved2;
//NSInteger                _reserved3;
//}
//
//+ (NSOpenGLPixelFormat*)defaultPixelFormat;
//
//- (id)initWithFrame:(NSRect)frameRect pixelFormat:(NSOpenGLPixelFormat*)format;
//
//- (void)setOpenGLContext:(NSOpenGLContext*)context;
//- (NSOpenGLContext*)openGLContext;
//- (void)clearGLContext;
//
//- (void)update;		// moved or resized
//- (void)reshape;	// scrolled, moved or resized
//
//- (void)setPixelFormat:(NSOpenGLPixelFormat*)pixelFormat;
//- (NSOpenGLPixelFormat*)pixelFormat;
//
//- (void)prepareOpenGL;
//@end
//
//@interface NSView (NSOpenGLSurfaceResolution)
//
///* Specifies whether a given view instance wants, and is capable of correctly handling, an OpenGL backing surface (framebuffer) with resolution greater than 1 pixel per point.  This property is relevant only for views to which an NSOpenGLContext is bound (including, but not limited to, NSOpenGLViews); its value does not affect the behavior of other views, including CALayer-backed views (which may choose to render at a higher surface resolution independent of this property's value.  For compatibility, wantsBestResolutionOpenGLSurface defaults to NO, providing a 1 pixel per point framebuffer regardless of the backing scale factor for the display the view occupies.  (When the backing scale factor is > 1.0, the rendered surface contents are scaled up to the appropriate apparent size.)  Setting this property to YES for a given view gives AppKit permission to allocate a higher-resolution framebuffer when appropriate for the backing scale factor and target display.  AppKit may vary the surface resolution when the display mode is changed or the view is moved to a different display, but with this property set to YES it is capable of allocating a surface of greater than 1 pixel per point for the view.
// 
// To function correctly with wantsBestResolutionOpenGLSurface set to YES, a view must take care to perform correct conversions between view units and pixel units when needed.  For example: The common practice of passing the width and height of [self bounds] to glViewport() will yield incorrect results (partial instead of complete coverage of the render surface) at backing scale factors other than 1.0, since the parameters to glViewport() must be expressed in pixels.  Instead, use the dimensions of [self convertRectToBacking:[self bounds]], which are in appropriate (pixel) units.
// 
// This property is archived (keyed archiving required).
// 
// For testing purposes only, the effect of this property can be overridden globally for all views in a process, using the "NSSurfaceResolution" user default.  If NSSurfaceResolution is set to "Device", all views that have surfaces (including not only OpenGL surfaces, but layer tree render surfaces as well) will be opted into using the best resolution surface for the primary display the view is presented on.  This can be used to quickly assess whether an apps view's are ready for non-1x surfaces.  If NSSurfaceResolution is set to "1x", all views that have surfaces will be opted into using 1x (1 pixel per point) surfaces, independent of the display or backing scale factor.  If NSSurfaceResolution is set to any other value, or no value is present for it, then wantsBestResolutionOpenGLSurface will be consulted as described above for views that perform NSOpenGL rendering, and AppKit will separately determine the appropriate resolution for other surfaces, as also described above.
// */
//- (BOOL)wantsBestResolutionOpenGLSurface NS_AVAILABLE_MAC(10_7);
//- (void)setWantsBestResolutionOpenGLSurface:(BOOL)flag NS_AVAILABLE_MAC(10_7);

@end
