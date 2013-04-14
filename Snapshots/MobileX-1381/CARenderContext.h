/* CoreAnimation - CARenderContext.h 
   Shared render server context methods
 */


/* This method gets a context by its Id,
   and sets it as the active context. All
   further context management functions will
   use this context until it is changed.
 */
void* CARenderContextById(unsigned contextId);

/* This method creates a new context with a dictionary.
   It returns a context id.
 */
unsigned CARenderContextNew(CFDictionaryRef* contextInfo);

/* Locking and unlocking */
void CARenderContextLock();
void CARenderContextUnlock();

/* Context information */
mach_port_t CARenderContextGetServerPort();
unsigned CARenderContextGetId();
int CARenderContextGetCommitSeed();

/* Context rendering */
void CARenderContextDestroy();
void CARenderContextInvalidateRect(CGRect invalidateRect);



