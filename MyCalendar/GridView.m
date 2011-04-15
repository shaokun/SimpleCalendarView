#import "GridView.h"

@implementation GridView

@synthesize cols, width, margin;

- (id)initWithCols:(int)cols_ width:(int)width_ margin:(int)margin_ {
	self = [super init];
	if (self == nil) return nil;
	
	cols = cols_;
	width = width_;
	margin = margin_;
	
	return self;
}

- (int)rows {
	return ceil(1.0 * self.subviews.count / cols);
}

- (void)layoutSubviews {
	self.frame = CGRectMake(self.frame.origin.x,
		self.frame.origin.y,
		cols * width + (cols + 1) * margin,
		self.rows * width + (self.rows + 1) * margin);

	for (UIView *view in self.subviews) {
		int index = [self.subviews indexOfObject:view];
		int y = index / cols;
		int x = index - y * cols;
		
		int xOrigin = width * x + margin * (x + 1);
		int yOrigin = width * y + margin * (y + 1);
		
		view.frame = CGRectMake(xOrigin, yOrigin, width, width);
	}
}

@end