################################################################################
#
# zynq-boot
#
################################################################################
ZYNQ_BOOT_VERSION = b64c4299aaa54091e1bc61bc9bd9d219230dae7a
ZYNQ_BOOT_SITE = $(call github,cambridgehackers,zynq-boot,$(ZYNQ_BOOT_VERSION))
ZYNQ_BOOT_DEPENDENCIES = linux
ZYNQ_BOOT_INSTALL_IMAGES = YES

define ZYNQ_BOOT_BUILD_CMDS
	$(TARGET_CC) -c -fno-unwind-tables -o $(@D)/clearreg.o $(@D)/clearreg.c 
endef

define ZYNQ_BOOT_INSTALL_IMAGES_CMDS
	cp $(@D)/clearreg.o ${BINARIES_DIR}
	cp $(@D)/zynq_linux_boot.lds ${BINARIES_DIR}
endef

$(eval $(generic-package))
