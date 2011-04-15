
@interface GridView : UIView {
	int cols;
	int width;
	int margin;
}

@property (nonatomic, assign) int cols;
@property (nonatomic, assign) int width;
@property (nonatomic, assign) int margin;

- (id)initWithCols:(int)cols_ width:(int)width_ margin:(int)margin_;

@end