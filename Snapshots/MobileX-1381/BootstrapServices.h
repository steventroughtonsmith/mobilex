/*
 *  BootstrapServices.h
 *  Cut down verion of 'bootstrap.h'
 */

#ifndef ___BOOTSTRAP_SERVICES

#define ___BOOTSTRAP_SERVICES

#define	BOOTSTRAP_MAX_NAME_LEN			128
#define	BOOTSTRAP_MAX_CMD_LEN			512

typedef char name_t[BOOTSTRAP_MAX_NAME_LEN];
typedef char cmd_t[BOOTSTRAP_MAX_CMD_LEN];
typedef name_t *name_array_t;
typedef int bootstrap_status_t;
typedef bootstrap_status_t *bootstrap_status_array_t;
typedef unsigned int bootstrap_property_t;
typedef bootstrap_property_t * bootstrap_property_array_t;

typedef boolean_t *bool_array_t;

#define	BOOTSTRAP_MAX_LOOKUP_COUNT		20

#define	BOOTSTRAP_SUCCESS				0
#define	BOOTSTRAP_NOT_PRIVILEGED		1100
#define	BOOTSTRAP_NAME_IN_USE			1101
#define	BOOTSTRAP_UNKNOWN_SERVICE		1102
#define	BOOTSTRAP_SERVICE_ACTIVE		1103
#define	BOOTSTRAP_BAD_COUNT				1104
#define	BOOTSTRAP_NO_MEMORY				1105
#define BOOTSTRAP_NO_CHILDREN			1106

#define BOOTSTRAP_STATUS_INACTIVE		0
#define BOOTSTRAP_STATUS_ACTIVE			1
#define BOOTSTRAP_STATUS_ON_DEMAND		2

/*
 * After main() starts, it is safe to assume that this variable is always set.
 */
extern mach_port_t bootstrap_port;

/*
 * bootstrap_create_server()
 *
 * Declares a server that mach_init will re-spawn within the specified
 * bootstrap context.  The server is considered already "active"
 * (i.e. will not be re-spawned) until the returned server_port is
 * deallocated.
 *
 * In the meantime, services can be declared against the server,
 * by using the server_port as the privileged bootstrap target of
 * subsequent bootstrap_create_service() calls.
 *
 * When mach_init re-spawns the server, its task bootstrap port
 * is set to the privileged sever_port.  Through this special
 * bootstrap port, it can access all of parent bootstrap's context
 * (and all services are created in the parent's namespace). But
 * all additional service declarations (and declaration removals)
 * will be associated with this particular server.
 *
 * Only a holder of the server_port privilege bootstrap port can
 * check in or register over those services.  
 *
 * When all services associated with a server are deleted, and the server
 * exits, it will automatically be deleted itself.
 *
 * If the server is declared "on_demand," then a non-running server
 * will be re-launched on first use of one of the service ports
 * registered against it.  Otherwise, it will be re-launched
 * immediately upon exiting (whether any client is actively using
 * any of the service ports or not).
 *
 * Errors:	Returns appropriate kernel errors on rpc failure.
 *		Returns BOOTSTRAP_NOT_PRIVILEGED, bootstrap or uid invalid.
 */
kern_return_t bootstrap_create_server(
									  mach_port_t bp,
									  cmd_t server_cmd,
									  uid_t server_uid,
									  boolean_t on_demand,
									  mach_port_t *server_port);

/*
 * bootstrap_create_service()
 *
 * Creates a service named "service_name" and returns a send right to that
 * port in "service_port."  The port may later be checked in as if this
 * port were configured in the bootstrap configuration file.
 *
 * This API is deprecated. Please call bootstrap_check_in() instead.
 *
 * Errors:	Returns appropriate kernel errors on rpc failure.
 *		Returns BOOTSTRAP_SERVICE_ACTIVE, if service already exists.
 */
#ifdef AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_6
AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER_BUT_DEPRECATED_IN_MAC_OS_X_VERSION_10_6
#endif
kern_return_t
bootstrap_create_service(mach_port_t bp, name_t service_name, mach_port_t *sp);

/*
 * bootstrap_check_in()
 *
 * Returns the receive right for the service named by service_name. The
 * service must have previously been declared in this bootstrap context via
 * a call to bootstrap_create_service().  Attempts to check_in a service
 * which is already active are not allowed.
 *
 * If the service was declared as being associated with a server, the
 * check_in must come from the server's privileged port (server_port).
 *
 * Errors:	Returns appropriate kernel errors on rpc failure.
 *		Returns BOOTSTRAP_UNKNOWN_SERVICE, if service does not exist.
 *		Returns BOOTSTRAP_NOT_PRIVILEGED, if request directed to
 *			bootstrap port without privilege.
 *		Returns BOOTSTRAP_SERVICE_ACTIVE, if service has already been
 *			registered or checked-in.
 */
kern_return_t bootstrap_check_in(
								 mach_port_t bp,
								 const name_t service_name,
								 mach_port_t *sp);

/*
 * bootstrap_look_up()
 *
 * Returns a send right for the service port declared/registered under the
 * name service_name. The service is not guaranteed to be active.  Use the
 * bootstrap_status call to determine the status of the service.
 *
 * Errors:	Returns appropriate kernel errors on rpc failure.
 *		Returns BOOTSTRAP_UNKNOWN_SERVICE, if service does not exist.
 */
kern_return_t bootstrap_look_up(
								mach_port_t bp,
								const name_t service_name,
								mach_port_t *sp);

#endif