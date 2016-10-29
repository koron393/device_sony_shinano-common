#include <stdio.h>
#include <stdlib.h>
#include <sys/mount.h>

#include <cutils/klog.h>

#ifdef MR_DEVICE_HOOKS

#define INFO_DEV(fmt, ...) klog_write(6, "<6>%s: " fmt, "Mrom device hook", ##__VA_ARGS__)

static char ric_was_enabled = 0;

#if MR_DEVICE_HOOKS >= 1
int mrom_hook_after_android_mounts(const char *busybox_path, const char *base_path, int type)
{
	if (ric_was_enabled == '1')
	{
		FILE *fd = fopen("/sys/kernel/security/sony_ric/enable", "r");
		if (fd != NULL) {
			INFO_DEV("Re-enabling RIC (It was set before).\n");
			fwrite (&ric_was_enabled, 1, 1, fd);
			fclose(fd);
		}
	}
	return 0;
}
#endif

#if MR_DEVICE_HOOKS >= 2
void mrom_hook_before_fb_close(void) {}
#endif

#if MR_DEVICE_HOOKS >= 3
void tramp_hook_before_device_init(void)
{
	// Mount the securityfs for disabling sony_ric.
	// Otherwise, it is not possible to mount the data partition.
    mkdir("/sys/kernel", 0755);
    mkdir("/sys/kernel/security", 0755);
    mount("securityfs", "/sys/kernel/security", "securityfs", MS_NOSUID | MS_NODEV | MS_NOEXEC, NULL);

    char c = '0';
    char d = 0;
    FILE *fd = fopen("/sys/kernel/security/sony_ric/enable", "r");
    if (fd != NULL) {
    	// File exists: we can avoid further null checks.
    	fread(&ric_was_enabled, 1, 1, fd);
        fclose(fd);
    	INFO_DEV("RIC enabled?: %c.\n", ric_was_enabled);
    	if (ric_was_enabled == '1')
    	{
			INFO_DEV("Disabling RIC.\n");
			fd = fopen("/sys/kernel/security/sony_ric/enable", "w");
			fwrite (&c, 1, 1, fd);
			fclose(fd);
			fd = fopen("/sys/kernel/security/sony_ric/enable", "r");
			fread(&d, 1, 1, fd);
			INFO_DEV("RIC still enabled?: %c.\n", d);
			fclose(fd);
    	}
    }
}
#endif

#endif
