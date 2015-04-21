#import "InterfaceController.h"


@interface InterfaceController()
{
    NSArray *bars;
    NSArray *color_bars;
    NSArray *colors;
    int barIndex;
    float animationDuration;
}
//These are our black masks
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * bar1;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * bar2;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * bar3;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * bar4;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * bar5;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * bar6;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * bar7;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * bar8;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * bar9;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * bar10;

//These are our colored bars
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * color_bar1;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * color_bar2;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * color_bar3;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * color_bar4;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * color_bar5;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * color_bar6;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * color_bar7;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * color_bar8;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * color_bar9;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup * color_bar10;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    barIndex = 0;
    animationDuration = 1.0;
    //Create an Array of bars
    bars = @[self.bar1, self.bar2,self.bar3,self.bar4,self.bar5,self.bar6,self.bar7,self.bar8,self.bar9,self.bar10];
    
    //Create an Array of color_bars
    color_bars = @[self.color_bar1, self.color_bar2,self.color_bar3,self.color_bar4,self.color_bar5,self.color_bar6,self.color_bar7,self.color_bar8,self.color_bar9,self.color_bar10];
    
    //Generate some colors to make the bars
    colors = [self createBarColors:10];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    //Animate the bars when the page is displayed
    [self animateNextBar];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

-(void)animateNextBar
{
    //Set the background image for animating
    [bars[barIndex] setBackgroundImageNamed:@"black_bar_"];
    
    //Animate the bar to a random position from 0-30
    [bars[barIndex] startAnimatingWithImagesInRange:NSMakeRange(0, arc4random_uniform(30))
                                           duration: animationDuration
                                        repeatCount: 1];
    
    //Set the color of the bar
    [color_bars[barIndex] setBackgroundColor:colors[barIndex]];
    
    //Goto the next bar
    barIndex++;
    
    //If we are not at the last bar animate the next bar
    if(barIndex < 10){
        [self performSelector:@selector(animateNextBar) withObject:nil afterDelay:0.01];
    }
}

//Handy color generator
-(NSMutableArray*)createBarColors:(int)numColors
{
    NSMutableArray *colorsArr = [NSMutableArray array];
    
    float INCREMENT = 1.0/numColors;
    for (float hue = 0.0; hue < 1.0; hue += INCREMENT) {
        UIColor *color = [UIColor colorWithHue:hue
                                    saturation:1.0
                                    brightness:1.0
                                         alpha:1.0];
        [colorsArr addObject:color];
    }
    return colorsArr;
}


@end



