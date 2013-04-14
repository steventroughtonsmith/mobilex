
void __mm__MXLog (SEL slcr,NSString *format, ...) {
    if (format == nil) {
        printf("nil\n");
        return;
    }
    // Get a reference to the arguments that follow the format parameter
    va_list argList;
    va_start(argList, format);
    // Perform format string argument substitution, reinstate %% escapes, then print
    NSString *s = [[NSString alloc] initWithFormat:format arguments:argList];
	NSString *sel = NSStringFromSelector(slcr);
	
	NSUInteger loc = [sel rangeOfString:@":"].location;
	
	
	if (loc == NSNotFound)
		printf("[%s]: %s\n", [sel UTF8String],[[s stringByReplacingOccurrencesOfString:@"%%" withString:@"%%%%"] UTF8String]);
	else
		printf("[%s]: %s\n", [[sel substringToIndex:loc] UTF8String],[[s stringByReplacingOccurrencesOfString:@"%%" withString:@"%%%%"] UTF8String]);
	
    [s release];
    va_end(argList);
}

void __mm__MXLogfn (const char* fn,NSString *format, ...) {
    if (format == nil) {
        printf("nil\n");
        return;
    }
    // Get a reference to the arguments that follow the format parameter
    va_list argList;
    va_start(argList, format);
    // Perform format string argument substitution, reinstate %% escapes, then print
    NSString *s = [[NSString alloc] initWithFormat:format arguments:argList];
	
    printf("[%s]: %s\n", fn,[[s stringByReplacingOccurrencesOfString:@"%%" withString:@"%%%%"] UTF8String]);
    [s release];
    va_end(argList);
}

static NSString *_indentString;

void MSUnindent()
{
	[_indentString autorelease];
	
	if ([_indentString length] != 0)
	{
		_indentString = [_indentString substringToIndex:[_indentString length] - 2];
	}
	else
	{
		_indentString = @"";
	}
	
	[_indentString retain];
}	

void MSIndent()
{
	[_indentString autorelease];
	
	_indentString = [_indentString stringByAppendingString:@"  "];
	[_indentString retain];
}

void MSLog (NSString *format, ...) {
    if (format == nil) {
        printf("nil\n");
        return;
    }
	
	if (_indentString == nil)
		_indentString = @"";
	
    // Get a reference to the arguments that follow the format parameter
    va_list argList;
    va_start(argList, format);
    // Perform format string argument substitution, reinstate %% escapes, then print
    NSString *s = [[NSString alloc] initWithFormat:format arguments:argList];
	
    printf("%s%s\n",[_indentString UTF8String],[[s stringByReplacingOccurrencesOfString:@"%%" withString:@"%%%%"] UTF8String]);
    [s release];
    va_end(argList);
}