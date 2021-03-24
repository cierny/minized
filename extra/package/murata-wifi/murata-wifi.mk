################################################################################
#
# murata-wifi
#
################################################################################
MURATA_WIFI_VERSION = battra
MURATA_WIFI_VERSION_NVRAM = battra
MURATA_WIFI_VERSION_BT_PATCH = morty-battra
MURATA_WIFI_SITE = $(call github,murata-wireless,cyw-fmac-fw,$(MURATA_WIFI_VERSION))
MURATA_WIFI_EXTRA_DOWNLOADS = \
	$(call github,murata-wireless,cyw-fmac-nvram,$(MURATA_WIFI_VERSION_NVRAM))/cyw-fmac-nvram-$(MURATA_WIFI_VERSION_NVRAM).tar.gz \
	$(call github,murata-wireless,cyw-bt-patch,$(MURATA_WIFI_VERSION_BT_PATCH))/cyw-bt-patch-$(MURATA_WIFI_VERSION_BT_PATCH).tar.gz
MURATA_WIFI_LICENSE = PROPRIETARY
MURATA_WIFI_LICENSE_FILES = LICENCE.cypress
MURATA_WIFI_REDISTRIBUTE = NO

define MURATA_WIFI_EXTRACT_NVRAM_PATCH
	$(foreach tar,$(notdir $(MURATA_WIFI_EXTRA_DOWNLOADS)), \
		$(call suitable-extractor,$(tar)) $(MURATA_WIFI_DL_DIR)/$(tar) | \
		$(TAR) --strip-components=1 -C $(@D) $(TAR_OPTIONS) -
	)
endef
MURATA_WIFI_POST_EXTRACT_HOOKS += MURATA_WIFI_EXTRACT_NVRAM_PATCH

MURATA_WIFI_FILES_y += \
	brcmfmac43430-sdio.bin \
	brcmfmac43430-sdio.1DX.clm_blob \
	brcmfmac43430-sdio.1DX.txt \
	CYW43430A1.1DX.hcd

# Helper that assumes filename with model has two dots (CHIP.MODEL.EXT),
# but filename without model has only single dot (CHIP.EXT).
murata-wifi-strip-model = $(shell echo -n $(1) | sed 's/\..*\./\./')

# Helper that strips model name and renames Bluetooth patch files to the ones
# expected by Linux kernel.
murata-wifi-file-rename = $(call murata-wifi-strip-model,$(patsubst CYW%,BCM%,$(f)))

define MURATA_WIFI_INSTALL_TARGET_CMDS
	$(foreach f,$(MURATA_WIFI_FILES_y), \
		$(INSTALL) -m 0644 -D $(@D)/$(f) \
			$(TARGET_DIR)/lib/firmware/brcm/$(call murata-wifi-file-rename,$(f))
	)
	ln -sfn brcmfmac43430-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430-sdio.xlnx,zynq-7000.txt
endef

$(eval $(generic-package))
