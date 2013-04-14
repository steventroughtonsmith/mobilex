#ifndef ___MXLOG___
#define ___MXLOG___

#ifdef __cplusplus
extern "C" {
#endif
	void __mm__MXLog (SEL slcr,NSString *format, ...) ;
	void __mm__MXLogfn (const char* fn,NSString *format, ...) ;
	
	void MSUnindent();
	void MSIndent();
	void MSLog (NSString *format, ...);
#ifdef __cplusplus
}
#endif


#define MXLog(fmt, ...) __mm__MXLogfn(__FUNCTION__,fmt, ##__VA_ARGS__)
#define MXSLog(fmt, ...) __mm__MXLog(_cmd,fmt, ##__VA_ARGS__)

#define print_line() printf("*** Run %d at %s\n",__LINE__,__FILE__)

#define fail() printf("*** Failure on line %d in file %s\n",__LINE__,__FILE__)
#define failmsg(x) printf("*** Failure on line %d in file %s: %s\n",__LINE__,__FILE__,x)

#endif

