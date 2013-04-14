/*
 *  LibBsm stuff.
 *  Private API, eh?
 */

void audit_token_to_au32(
						 audit_token_t	 atoken,
						 uid_t		*auidp,
						 uid_t		*euidp,
						 gid_t		*egidp,
						 uid_t		*ruidp,
						 gid_t		*rgidp,
						 pid_t		*pidp,
						 au_asid_t	*asidp,
						 au_tid_t	*tidp);