#ifeq ($(CONFIG_MEDIATEK_SOLUTION),y)
#ifneq ($(CONFIG_ARCH_MT6755),y)
#    include $(srctree)/drivers/misc/mediatek/Makefile.custom
#endif
#endif

ccflags-y += -I$(srctree)/drivers/misc/mediatek/base/power/$(MTK_PLATFORM)

obj-y += oz8806_battery.o
obj-y += parameter.o
obj-y += table.o
obj-y += oz8806_bmulib/
