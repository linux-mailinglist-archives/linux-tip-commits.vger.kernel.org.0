Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF6D3E553E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 10:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238224AbhHJIb0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 04:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbhHJIbZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 04:31:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31361C061796;
        Tue, 10 Aug 2021 01:31:03 -0700 (PDT)
Date:   Tue, 10 Aug 2021 08:30:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628584259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hzWrZsLkMsPSeowdHiTK7nFPonyx8zo4sT9uM8rR0Fs=;
        b=SkPxlxIzZmkaha7IFf36qyDFPoOtr67UMy5LCjLN23yHZ7AG8Nd6rAYMkPOOHGqUquVSdl
        OhZ9yEsMxagBOxl25DN+gByF50sIW9EA77OlNSP3n3g/Gg4tAZZwk9FvbObpsW7oEH8Rvp
        Km+e2pjGC2X1oqPNG8OV2c+xCv6Bk78JQNC1hbjhi/qfv/BdnOJdv2zjJiAo3nhUGV/9yn
        dqsdupeacKsd5Y3Whfm5iws464lafjHUsBnEoB4XNknGG1NnchcMnkVBZuSog5c/44hkOR
        q/hWqbfOqfHUOb9fGf15kKBVIcEpbfJ/KREIffy8m35nbjHPNnx+ukjZExSw0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628584259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hzWrZsLkMsPSeowdHiTK7nFPonyx8zo4sT9uM8rR0Fs=;
        b=RKQaOLxWbzhdYzm9YJ62eJAth92aST/FnwLRNXIdmHaQJEPPpjl6TNAYELbdadl6+jkyuu
        7C8vCUn02DSOFzCA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/libstub: arm64: Relax 2M alignment again for
 relocatable kernels
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162858425836.395.15945689610631319871.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     3a262423755b83a5f85009ace415d6e7f572dfe8
Gitweb:        https://git.kernel.org/tip/3a262423755b83a5f85009ace415d6e7f572dfe8
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 22 Jul 2021 12:10:31 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 03 Aug 2021 07:43:02 +02:00

efi/libstub: arm64: Relax 2M alignment again for relocatable kernels

Commit 82046702e288 ("efi/libstub/arm64: Replace 'preferred' offset with
alignment check") simplified the way the stub moves the kernel image
around in memory before booting it, given that a relocatable image does
not need to be copied to a 2M aligned offset if it was loaded on a 64k
boundary by EFI.

Commit d32de9130f6c ("efi/arm64: libstub: Deal gracefully with
EFI_RNG_PROTOCOL failure") inadvertently defeated this logic by
overriding the value of efi_nokaslr if EFI_RNG_PROTOCOL is not
available, which was mistaken by the loader logic as an explicit request
on the part of the user to disable KASLR and any associated relocation
of an Image not loaded on a 2M boundary.

So let's reinstate this functionality, by capturing the value of
efi_nokaslr at function entry to choose the minimum alignment.

Fixes: d32de9130f6c ("efi/arm64: libstub: Deal gracefully with EFI_RNG_PROTOCOL failure")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 28 ++++++++++------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 3698c1c..6f214c9 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -79,18 +79,6 @@ static bool check_image_region(u64 base, u64 size)
 	return ret;
 }
 
-/*
- * Although relocatable kernels can fix up the misalignment with respect to
- * MIN_KIMG_ALIGN, the resulting virtual text addresses are subtly out of
- * sync with those recorded in the vmlinux when kaslr is disabled but the
- * image required relocation anyway. Therefore retain 2M alignment unless
- * KASLR is in use.
- */
-static u64 min_kimg_align(void)
-{
-	return efi_nokaslr ? MIN_KIMG_ALIGN : EFI_KIMG_ALIGN;
-}
-
 efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 unsigned long *image_size,
 				 unsigned long *reserve_addr,
@@ -101,6 +89,16 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	unsigned long kernel_size, kernel_memsize = 0;
 	u32 phys_seed = 0;
 
+	/*
+	 * Although relocatable kernels can fix up the misalignment with
+	 * respect to MIN_KIMG_ALIGN, the resulting virtual text addresses are
+	 * subtly out of sync with those recorded in the vmlinux when kaslr is
+	 * disabled but the image required relocation anyway. Therefore retain
+	 * 2M alignment if KASLR was explicitly disabled, even if it was not
+	 * going to be activated to begin with.
+	 */
+	u64 min_kimg_align = efi_nokaslr ? MIN_KIMG_ALIGN : EFI_KIMG_ALIGN;
+
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		if (!efi_nokaslr) {
 			status = efi_get_random_bytes(sizeof(phys_seed),
@@ -130,7 +128,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		 * If KASLR is enabled, and we have some randomness available,
 		 * locate the kernel at a randomized offset in physical memory.
 		 */
-		status = efi_random_alloc(*reserve_size, min_kimg_align(),
+		status = efi_random_alloc(*reserve_size, min_kimg_align,
 					  reserve_addr, phys_seed);
 	} else {
 		status = EFI_OUT_OF_RESOURCES;
@@ -139,7 +137,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	if (status != EFI_SUCCESS) {
 		if (!check_image_region((u64)_text, kernel_memsize)) {
 			efi_err("FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region\n");
-		} else if (IS_ALIGNED((u64)_text, min_kimg_align())) {
+		} else if (IS_ALIGNED((u64)_text, min_kimg_align)) {
 			/*
 			 * Just execute from wherever we were loaded by the
 			 * UEFI PE/COFF loader if the alignment is suitable.
@@ -150,7 +148,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		}
 
 		status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
-						    ULONG_MAX, min_kimg_align());
+						    ULONG_MAX, min_kimg_align);
 
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to relocate kernel\n");
