Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D6B3E553C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 10:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238220AbhHJIbZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 04:31:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41674 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbhHJIbY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 04:31:24 -0400
Date:   Tue, 10 Aug 2021 08:30:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628584259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gjqGur3HwGNl9x7u7xjD1SYsbWGypIOJ8fDKB3mnwLk=;
        b=eZH6gP+EiF3OcO1uovEpHFlHoCBo9l/PpflBxM/5pLZZZH2E8lP958bYXpL2cfpMnItph5
        p8qaDLbaqbsUAY06GQWcTkVEtcbyPPTJ9LAU/Fav+qFArLHgo65ln/hTRt8f21ZJCnDN+/
        7oJXCKJMmGx5q92HR6WwP6dz69aysoYAVD8BFq0FMRL0uKFCNsSIgEP+MZAWTFYOHgwZxo
        d9psjR2aWuyd14tDcoV2exA98rpRG5N/HgFm28BeNwTPaCNNYrPh5U1f4Hmo+GOPgBsRyC
        sgYEd7dcVQZvVE8zKNMwMfoootzPaXkUcN7vD3IT4SEq08f/lfQZH0257TX4SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628584259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gjqGur3HwGNl9x7u7xjD1SYsbWGypIOJ8fDKB3mnwLk=;
        b=TIFRTCiwhdjRUn7dgwYG0nNwqdqZcR3epMV7ZZxE0QsMO94eNoODZAM3YmKRHGa4X7sef4
        t7+al1pYmterUCBw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/libstub: arm64: Force Image reallocation if BSS
 was not reserved
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162858425887.395.2364950892793141234.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     5b94046efb4706b3429c9c8e7377bd8d1621d588
Gitweb:        https://git.kernel.org/tip/5b94046efb4706b3429c9c8e7377bd8d1621d588
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 26 Jul 2021 11:38:41 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 03 Aug 2021 07:41:53 +02:00

efi/libstub: arm64: Force Image reallocation if BSS was not reserved

Distro versions of GRUB replace the usual LoadImage/StartImage calls
used to load the kernel image with some local code that fails to honor
the allocation requirements described in the PE/COFF header, as it
does not account for the image's BSS section at all: it fails to
allocate space for it, and fails to zero initialize it.

Since the EFI stub itself is allocated in the .init segment, which is
in the middle of the image, its BSS section is not impacted by this,
and the main consequence of this omission is that the BSS section may
overlap with memory regions that are already used by the firmware.

So let's warn about this condition, and force image reallocation to
occur in this case, which works around the problem.

Fixes: 82046702e288 ("efi/libstub/arm64: Replace 'preferred' offset with alignment check")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c | 49 +++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 7bf0a7a..3698c1c 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -35,6 +35,51 @@ efi_status_t check_platform_features(void)
 }
 
 /*
+ * Distro versions of GRUB may ignore the BSS allocation entirely (i.e., fail
+ * to provide space, and fail to zero it). Check for this condition by double
+ * checking that the first and the last byte of the image are covered by the
+ * same EFI memory map entry.
+ */
+static bool check_image_region(u64 base, u64 size)
+{
+	unsigned long map_size, desc_size, buff_size;
+	efi_memory_desc_t *memory_map;
+	struct efi_boot_memmap map;
+	efi_status_t status;
+	bool ret = false;
+	int map_offset;
+
+	map.map =	&memory_map;
+	map.map_size =	&map_size;
+	map.desc_size =	&desc_size;
+	map.desc_ver =	NULL;
+	map.key_ptr =	NULL;
+	map.buff_size =	&buff_size;
+
+	status = efi_get_memory_map(&map);
+	if (status != EFI_SUCCESS)
+		return false;
+
+	for (map_offset = 0; map_offset < map_size; map_offset += desc_size) {
+		efi_memory_desc_t *md = (void *)memory_map + map_offset;
+		u64 end = md->phys_addr + md->num_pages * EFI_PAGE_SIZE;
+
+		/*
+		 * Find the region that covers base, and return whether
+		 * it covers base+size bytes.
+		 */
+		if (base >= md->phys_addr && base < end) {
+			ret = (base + size) <= end;
+			break;
+		}
+	}
+
+	efi_bs_call(free_pool, memory_map);
+
+	return ret;
+}
+
+/*
  * Although relocatable kernels can fix up the misalignment with respect to
  * MIN_KIMG_ALIGN, the resulting virtual text addresses are subtly out of
  * sync with those recorded in the vmlinux when kaslr is disabled but the
@@ -92,7 +137,9 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	}
 
 	if (status != EFI_SUCCESS) {
-		if (IS_ALIGNED((u64)_text, min_kimg_align())) {
+		if (!check_image_region((u64)_text, kernel_memsize)) {
+			efi_err("FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region\n");
+		} else if (IS_ALIGNED((u64)_text, min_kimg_align())) {
 			/*
 			 * Just execute from wherever we were loaded by the
 			 * UEFI PE/COFF loader if the alignment is suitable.
