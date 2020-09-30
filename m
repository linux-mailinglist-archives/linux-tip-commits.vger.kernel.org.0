Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D6227E02B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 07:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgI3FWe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 01:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgI3FWY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 01:22:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7945DC061755;
        Tue, 29 Sep 2020 22:22:24 -0700 (PDT)
Date:   Wed, 30 Sep 2020 05:22:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601443342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jy5b1wg3OghCmoWsYdbTHwTWU6JWlycf5iEZ71QbAkU=;
        b=hYa6+bWpE33ISj6KlNVPr4m9qM61S259A26A5ycZaV+E5jHasmSNk9/mhaX4PAD2cma4Fb
        iMBjXA2Zp9o+1GX6dP4zbQRVyMopChByDK5ON9JouDjYgDev33JKvt4CpM/4YijtqoupVV
        +cq2gVKPJjKzVLnG6YsFMAiux3ZpSycnutjcC+q2ursMsOdPGIvlg0UizOQVBihqrf/L6d
        ot1QVXj1dq//bJfnC6JKOehoFksf1LOlaMQJKJNxms0dKRQGGZEQg64nOaIJJla7d4L0P/
        0aaO9YJUTkSVmyG8ix6FP11LOJZ4tHlJbhi7hPzE9TzkjHg9ENE/spiyLshNiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601443342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jy5b1wg3OghCmoWsYdbTHwTWU6JWlycf5iEZ71QbAkU=;
        b=20TP8yG76hwNBifFlRzACf1ft/z3fenF/gm+3hraf0yno5pt2LWeCwR33DvcpdegBtHet1
        KGfIqovso8ioHjDw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: mokvar-table: fix some issues in new code
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Borislav Petkov <bp@suse.de>, Ard Biesheuvel <ardb@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160144334216.7002.203694548595798921.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     b89114cd018cffa5deb7def1844ce1891efd4f96
Gitweb:        https://git.kernel.org/tip/b89114cd018cffa5deb7def1844ce1891efd4f96
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 24 Sep 2020 17:58:22 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 29 Sep 2020 19:40:57 +02:00

efi: mokvar-table: fix some issues in new code

Fix a couple of issues in the new mokvar-table handling code, as
pointed out by Arvind and Boris:
- don't bother checking the end of the physical region against the start
  address of the mokvar table,
- ensure that we enter the loop with err = -EINVAL,
- replace size_t with unsigned long to appease pedantic type equality
  checks.

Reviewed-by: Arvind Sankar <nivedita@alum.mit.edu>
Reviewed-by: Lenny Szubowicz <lszubowi@redhat.com>
Tested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/mokvar-table.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
index b1cd498..72a9e17 100644
--- a/drivers/firmware/efi/mokvar-table.c
+++ b/drivers/firmware/efi/mokvar-table.c
@@ -98,15 +98,14 @@ static struct kobject *mokvar_kobj;
 void __init efi_mokvar_table_init(void)
 {
 	efi_memory_desc_t md;
-	u64 end_pa;
 	void *va = NULL;
-	size_t cur_offset = 0;
-	size_t offset_limit;
-	size_t map_size = 0;
-	size_t map_size_needed = 0;
-	size_t size;
+	unsigned long cur_offset = 0;
+	unsigned long offset_limit;
+	unsigned long map_size = 0;
+	unsigned long map_size_needed = 0;
+	unsigned long size;
 	struct efi_mokvar_table_entry *mokvar_entry;
-	int err = -EINVAL;
+	int err;
 
 	if (!efi_enabled(EFI_MEMMAP))
 		return;
@@ -122,18 +121,16 @@ void __init efi_mokvar_table_init(void)
 		pr_warn("EFI MOKvar config table is not within the EFI memory map\n");
 		return;
 	}
-	end_pa = efi_mem_desc_end(&md);
-	if (efi.mokvar_table >= end_pa) {
-		pr_err("EFI memory descriptor containing MOKvar config table is invalid\n");
-		return;
-	}
-	offset_limit = end_pa - efi.mokvar_table;
+
+	offset_limit = efi_mem_desc_end(&md) - efi.mokvar_table;
+
 	/*
 	 * Validate the MOK config table. Since there is no table header
 	 * from which we could get the total size of the MOK config table,
 	 * we compute the total size as we validate each variably sized
 	 * entry, remapping as necessary.
 	 */
+	err = -EINVAL;
 	while (cur_offset + sizeof(*mokvar_entry) <= offset_limit) {
 		mokvar_entry = va + cur_offset;
 		map_size_needed = cur_offset + sizeof(*mokvar_entry);
@@ -150,7 +147,7 @@ void __init efi_mokvar_table_init(void)
 				       offset_limit);
 			va = early_memremap(efi.mokvar_table, map_size);
 			if (!va) {
-				pr_err("Failed to map EFI MOKvar config table pa=0x%lx, size=%zu.\n",
+				pr_err("Failed to map EFI MOKvar config table pa=0x%lx, size=%lu.\n",
 				       efi.mokvar_table, map_size);
 				return;
 			}
