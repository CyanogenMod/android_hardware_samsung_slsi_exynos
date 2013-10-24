LOCAL_PATH := $(call my-dir)

PLATFORM_DIR := $(TARGET_BOARD_PLATFORM)-insignal

OMX_NAME := exynos

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	csc_helper.c

LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)

ifneq ($(BOARD_USE_KHRONOS_OMX_HEADER),true)
LOCAL_C_INCLUDES += \
	frameworks/native/include/media/openmax
endif

LOCAL_C_INCLUDES += \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include \
	system/core/include \
	hardware/samsung_slsi/openmax/include/khronos \
	hardware/samsung_slsi/openmax/include/$(OMX_NAME) \
	hardware/samsung_slsi/$(PLATFORM_DIR)/include \
	$(LOCAL_PATH)/../include

LOCAL_ADDITIONAL_DEPENDENCIES := \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

LOCAL_CFLAGS := \
	-DUSE_SAMSUNG_COLORFORMAT \
	-DEXYNOS_OMX

LOCAL_MODULE := libcsc_helper
LOCAL_MODULE_TAGS := optional
LOCAL_STATIC_LIBRARIES := liblog

include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := \
	csc.c

LOCAL_C_INCLUDES := \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr/include \
	hardware/samsung_slsi/$(PLATFORM_DIR)/include \
	hardware/samsung_slsi/openmax/include/khronos \
	hardware/samsung_slsi/openmax/include/$(OMX_NAME) \
	$(LOCAL_PATH)/../libexynosutils

LOCAL_ADDITIONAL_DEPENDENCIES := \
	$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ/usr

LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)

LOCAL_CFLAGS :=

LOCAL_MODULE := libcsc

LOCAL_PRELINK_MODULE := false

LOCAL_ARM_MODE := arm

LOCAL_STATIC_LIBRARIES := libswconverter
LOCAL_WHOLE_STATIC_LIBRARIES := libcsc_helper
LOCAL_SHARED_LIBRARIES := liblog libexynosutils

LOCAL_CFLAGS += -DUSE_SAMSUNG_COLORFORMAT

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH)/../include
ifeq ($(TARGET_BOARD_PLATFORM),exynos5)
LOCAL_CFLAGS += -DENABLE_GSCALER
LOCAL_SHARED_LIBRARIES += libexynosgscaler
endif

LOCAL_CFLAGS += -DUSE_ION
LOCAL_SHARED_LIBRARIES += libion_exynos

LOCAL_CFLAGS += -DEXYNOS_OMX

include $(BUILD_SHARED_LIBRARY)
