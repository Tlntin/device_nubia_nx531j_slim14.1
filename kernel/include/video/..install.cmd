cmd_usr/include/video/.install := /bin/sh /Volumes/android/lineage/kernel/nubia/msm8996/scripts/headers_install.sh ./usr/include/video /Volumes/android/lineage/kernel/nubia/msm8996/include/uapi/video edid.h msm_hdmi_hdcp_mgr.h msm_hdmi_modes.h sisfb.h uvesafb.h; /bin/sh /Volumes/android/lineage/kernel/nubia/msm8996/scripts/headers_install.sh ./usr/include/video /Volumes/android/lineage/kernel/nubia/msm8996/include/video ; /bin/sh /Volumes/android/lineage/kernel/nubia/msm8996/scripts/headers_install.sh ./usr/include/video ./include/generated/uapi/video ; for F in ; do echo "\#include <asm-generic/$$F>" > ./usr/include/video/$$F; done; touch usr/include/video/.install