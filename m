Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEDD26F836
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 10:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgIRIbB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 04:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgIRIbA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 04:31:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B108C061756;
        Fri, 18 Sep 2020 01:31:00 -0700 (PDT)
Date:   Fri, 18 Sep 2020 08:30:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600417858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/mcunFzNJQdQPDAaUzYs5jwokNApFri2HGO+Olz4SQA=;
        b=kc+b5ew9WvoLd1lHfEP5lZT5jCuCWMuvctIVilh2YrQpbeIR3hrYR8UIMqr76AweJkptmy
        4CE9MCH7OoGth/rlrvytgtOKy7ogVm0e9VeYBtrLSMvnQxJtLJjQMHOk9H9BlAisSJrJ87
        9H6rCnD5R1a6eIrrFLutj7YrGKAB8AAav1E4jiJHonWxhmWdCirjy0O7qYBSUCnQ5iIclk
        Uz8Uap/0kYDF6EicZJEobblFFkDILPr+cHXI7ZBCYHCcs8hIMwrsYcEWO/lzzQ82DhG5k6
        0WUI5QJpc9paZ9zE9FewyH9+2xptNtZMfa+jHBLFV4jcI9oBSYaIGdEh79Ld+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600417858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/mcunFzNJQdQPDAaUzYs5jwokNApFri2HGO+Olz4SQA=;
        b=n2zGrCZTvKE6Ekyh0ZZYXIgAL2vCkGSAPBo7btCggexhTFCrpY1U8MDqGkCCs0DZI9hy4p
        ao169DmHmJoI8vAg==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi/libstub: arm32: Base FDT and initrd placement on
 image address
Cc:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160041785785.15536.3575860337827667771.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     6208857b8f7ebdfe84e1be7573be4552a5896a0d
Gitweb:        https://git.kernel.org/tip/6208857b8f7ebdfe84e1be7573be4552a5896a0d
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 10 Sep 2020 17:09:45 +03:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 16 Sep 2020 18:53:42 +03:00

efi/libstub: arm32: Base FDT and initrd placement on image address

The way we use the base of DRAM in the EFI stub is problematic as it
is ill defined what the base of DRAM actually means. There are some
restrictions on the placement of FDT and initrd which are defined in
terms of dram_base, but given that the placement of the kernel in
memory is what defines these boundaries (as on ARM, this is where the
linear region starts), it is better to use the image address in these
cases, and disregard dram_base altogether.

Reviewed-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Tested-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h                | 23 ++++++++++------------
 arch/arm64/include/asm/efi.h              |  5 ++---
 drivers/firmware/efi/libstub/arm32-stub.c |  2 +-
 drivers/firmware/efi/libstub/efi-stub.c   |  4 ++--
 4 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 5dcf3c6..3ee4f43 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -66,25 +66,24 @@ static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
 #define MAX_UNCOMP_KERNEL_SIZE	SZ_32M
 
 /*
- * The kernel zImage should preferably be located between 32 MB and 128 MB
- * from the base of DRAM. The min address leaves space for a maximal size
- * uncompressed image, and the max address is due to how the zImage decompressor
- * picks a destination address.
+ * phys-to-virt patching requires that the physical to virtual offset fits
+ * into the immediate field of an add/sub instruction, which comes down to the
+ * 24 least significant bits being zero, and so the offset should be a multiple
+ * of 16 MB. Since PAGE_OFFSET itself is a multiple of 16 MB, the physical
+ * base should be aligned to 16 MB as well.
  */
-#define ZIMAGE_OFFSET_LIMIT	SZ_128M
-#define MIN_ZIMAGE_OFFSET	MAX_UNCOMP_KERNEL_SIZE
+#define EFI_PHYS_ALIGN		SZ_16M
 
-/* on ARM, the FDT should be located in the first 128 MB of RAM */
-static inline unsigned long efi_get_max_fdt_addr(unsigned long dram_base)
+/* on ARM, the FDT should be located in a lowmem region */
+static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
 {
-	return dram_base + ZIMAGE_OFFSET_LIMIT;
+	return round_down(image_addr, EFI_PHYS_ALIGN) + SZ_512M;
 }
 
 /* on ARM, the initrd should be loaded in a lowmem region */
-static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
-						    unsigned long image_addr)
+static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
 {
-	return dram_base + SZ_512M;
+	return round_down(image_addr, EFI_PHYS_ALIGN) + SZ_512M;
 }
 
 struct efi_arm_entry_state {
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index d4ab3f7..973b144 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -65,7 +65,7 @@ efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
 	(SEGMENT_ALIGN > THREAD_ALIGN ? SEGMENT_ALIGN : THREAD_ALIGN)
 
 /* on arm64, the FDT may be located anywhere in system RAM */
-static inline unsigned long efi_get_max_fdt_addr(unsigned long dram_base)
+static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
 {
 	return ULONG_MAX;
 }
@@ -80,8 +80,7 @@ static inline unsigned long efi_get_max_fdt_addr(unsigned long dram_base)
  * apply to other bootloaders, and are required for some kernel
  * configurations.
  */
-static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
-						    unsigned long image_addr)
+static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
 {
 	return (image_addr & ~(SZ_1G - 1UL)) + (1UL << (VA_BITS_MIN - 1));
 }
diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index d08e5d5..bcf770c 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -252,7 +252,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	efi_status_t status;
 
 	/* use a 16 MiB aligned base for the decompressed kernel */
-	kernel_base = round_up(dram_base, SZ_16M) + TEXT_OFFSET;
+	kernel_base = round_up(dram_base, EFI_PHYS_ALIGN) + TEXT_OFFSET;
 
 	/*
 	 * Note that some platforms (notably, the Raspberry Pi 2) put
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index a5a405d..65a0070 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -262,7 +262,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 		efi_info("Generating empty DTB\n");
 
 	if (!efi_noinitrd) {
-		max_addr = efi_get_max_initrd_addr(dram_base, image_addr);
+		max_addr = efi_get_max_initrd_addr(image_addr);
 		status = efi_load_initrd(image, &initrd_addr, &initrd_size,
 					 ULONG_MAX, max_addr);
 		if (status != EFI_SUCCESS)
@@ -306,7 +306,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	install_memreserve_table();
 
 	status = allocate_new_fdt_and_exit_boot(handle, &fdt_addr,
-						efi_get_max_fdt_addr(dram_base),
+						efi_get_max_fdt_addr(image_addr),
 						initrd_addr, initrd_size,
 						cmdline_ptr, fdt_addr, fdt_size);
 	if (status != EFI_SUCCESS)
