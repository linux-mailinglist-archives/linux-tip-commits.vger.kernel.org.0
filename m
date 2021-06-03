Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8740F39A9A6
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jun 2021 20:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhFCSDm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Jun 2021 14:03:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47994 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhFCSDl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Jun 2021 14:03:41 -0400
Date:   Thu, 03 Jun 2021 18:01:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622743306;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=reATOpn4TXZ939pAVyG79/jskmMCt9M+3Qq2ZyXo/TE=;
        b=ow90GZDNX3XIqw/9+edPw+QabA8JdBc1+6AQt8jv75bhSRfvJhWllKi2fkckTYbLd9y/E5
        31kVXWHaYt13VpYJq3biJ8wBlndCIDnpHj3HXUHqUUYygzFQ71TlXtRbGRnMYKXFMofc00
        /xo6GTQMiyXxRkryrd60J71dOfCB5hg0A/K4nAxCYdCrsGPMNvAPagwO+jFGSXZnycq5na
        H6TgKg19ZXPB7nSO93vEr4WX+OF7v5iQ+ZHGQCdnCBAW4LkeTN2kIH70TEBkRF1mvhYw0r
        yS9ON90SxDaoZviHzjekhZRF5bFh27XJUvd6V4m2fXIj0C+D4awqSZcumO5KDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622743306;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=reATOpn4TXZ939pAVyG79/jskmMCt9M+3Qq2ZyXo/TE=;
        b=GeTR7GVjDTmmHW9u8vKXLQMc/5AhaavST1lW4cwQ2fhtFYFn2AWkv6VrRGZk0+m3CuhSct
        GIHFy8mA6RFWvLBg==
From:   "tip-bot2 for Mike Rapoport" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/setup: Always reserve the first 1M of RAM
Cc:     Mike Rapoport <rppt@linux.ibm.com>, Borislav Petkov <bp@suse.de>,
        Hugh Dickins <hughd@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210601075354.5149-2-rppt@kernel.org>
References: <20210601075354.5149-2-rppt@kernel.org>
MIME-Version: 1.0
Message-ID: <162274330352.29796.17521974349959809425.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f1d4d47c5851b348b7713007e152bc68b94d728b
Gitweb:        https://git.kernel.org/tip/f1d4d47c5851b348b7713007e152bc68b94d728b
Author:        Mike Rapoport <rppt@linux.ibm.com>
AuthorDate:    Tue, 01 Jun 2021 10:53:52 +03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 03 Jun 2021 19:57:55 +02:00

x86/setup: Always reserve the first 1M of RAM

There are BIOSes that are known to corrupt the memory under 1M, or more
precisely under 640K because the memory above 640K is anyway reserved
for the EGA/VGA frame buffer and BIOS.

To prevent usage of the memory that will be potentially clobbered by the
kernel, the beginning of the memory is always reserved. The exact size
of the reserved area is determined by CONFIG_X86_RESERVE_LOW build time
and the "reservelow=" command line option. The reserved range may be
from 4K to 640K with the default of 64K. There are also configurations
that reserve the entire 1M range, like machines with SandyBridge graphic
devices or systems that enable crash kernel.

In addition to the potentially clobbered memory, EBDA of unknown size may
be as low as 128K and the memory above that EBDA start is also reserved
early.

It would have been possible to reserve the entire range under 1M unless for
the real mode trampoline that must reside in that area.

To accommodate placement of the real mode trampoline and keep the memory
safe from being clobbered by BIOS, reserve the first 64K of RAM before
memory allocations are possible and then, after the real mode trampoline
is allocated, reserve the entire range from 0 to 1M.

Update trim_snb_memory() and reserve_real_mode() to avoid redundant
reservations of the same memory range.

Also make sure the memory under 1M is not getting freed by
efi_free_boot_services().

 [ bp: Massage commit message and comments. ]

Fixes: a799c2bd29d1 ("x86/setup: Consolidate early memory reservations")
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Hugh Dickins <hughd@google.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=213177
Link: https://lkml.kernel.org/r/20210601075354.5149-2-rppt@kernel.org
---
 arch/x86/kernel/setup.c        | 35 +++++++++++++++++++--------------
 arch/x86/platform/efi/quirks.c | 12 +++++++++++-
 arch/x86/realmode/init.c       | 14 +++++++------
 3 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index ff653d6..1e72062 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -638,11 +638,11 @@ static void __init trim_snb_memory(void)
 	 * them from accessing certain memory ranges, namely anything below
 	 * 1M and in the pages listed in bad_pages[] above.
 	 *
-	 * To avoid these pages being ever accessed by SNB gfx devices
-	 * reserve all memory below the 1 MB mark and bad_pages that have
-	 * not already been reserved at boot time.
+	 * To avoid these pages being ever accessed by SNB gfx devices reserve
+	 * bad_pages that have not already been reserved at boot time.
+	 * All memory below the 1 MB mark is anyway reserved later during
+	 * setup_arch(), so there is no need to reserve it here.
 	 */
-	memblock_reserve(0, 1<<20);
 
 	for (i = 0; i < ARRAY_SIZE(bad_pages); i++) {
 		if (memblock_reserve(bad_pages[i], PAGE_SIZE))
@@ -734,14 +734,14 @@ static void __init early_reserve_memory(void)
 	 * The first 4Kb of memory is a BIOS owned area, but generally it is
 	 * not listed as such in the E820 table.
 	 *
-	 * Reserve the first memory page and typically some additional
-	 * memory (64KiB by default) since some BIOSes are known to corrupt
-	 * low memory. See the Kconfig help text for X86_RESERVE_LOW.
+	 * Reserve the first 64K of memory since some BIOSes are known to
+	 * corrupt low memory. After the real mode trampoline is allocated the
+	 * rest of the memory below 640k is reserved.
 	 *
 	 * In addition, make sure page 0 is always reserved because on
 	 * systems with L1TF its contents can be leaked to user processes.
 	 */
-	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
+	memblock_reserve(0, SZ_64K);
 
 	early_reserve_initrd();
 
@@ -752,6 +752,7 @@ static void __init early_reserve_memory(void)
 
 	reserve_ibft_region();
 	reserve_bios_regions();
+	trim_snb_memory();
 }
 
 /*
@@ -1082,14 +1083,20 @@ void __init setup_arch(char **cmdline_p)
 			(max_pfn_mapped<<PAGE_SHIFT) - 1);
 #endif
 
-	reserve_real_mode();
-
 	/*
-	 * Reserving memory causing GPU hangs on Sandy Bridge integrated
-	 * graphics devices should be done after we allocated memory under
-	 * 1M for the real mode trampoline.
+	 * Find free memory for the real mode trampoline and place it
+	 * there.
+	 * If there is not enough free memory under 1M, on EFI-enabled
+	 * systems there will be additional attempt to reclaim the memory
+	 * for the real mode trampoline at efi_free_boot_services().
+	 *
+	 * Unconditionally reserve the entire first 1M of RAM because
+	 * BIOSes are know to corrupt low memory and several
+	 * hundred kilobytes are not worth complex detection what memory gets
+	 * clobbered. Moreover, on machines with SandyBridge graphics or in
+	 * setups that use crashkernel the entire 1M is reserved anyway.
 	 */
-	trim_snb_memory();
+	reserve_real_mode();
 
 	init_mem_mapping();
 
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 7850111..b15ebfe 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -450,6 +450,18 @@ void __init efi_free_boot_services(void)
 			size -= rm_size;
 		}
 
+		/*
+		 * Don't free memory under 1M for two reasons:
+		 * - BIOS might clobber it
+		 * - Crash kernel needs it to be reserved
+		 */
+		if (start + size < SZ_1M)
+			continue;
+		if (start < SZ_1M) {
+			size -= (SZ_1M - start);
+			start = SZ_1M;
+		}
+
 		memblock_free_late(start, size);
 	}
 
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 2e1c1be..6534c92 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -29,14 +29,16 @@ void __init reserve_real_mode(void)
 
 	/* Has to be under 1M so we can execute real-mode AP code. */
 	mem = memblock_find_in_range(0, 1<<20, size, PAGE_SIZE);
-	if (!mem) {
+	if (!mem)
 		pr_info("No sub-1M memory is available for the trampoline\n");
-		return;
-	}
+	else
+		set_real_mode_mem(mem);
 
-	memblock_reserve(mem, size);
-	set_real_mode_mem(mem);
-	crash_reserve_low_1M();
+	/*
+	 * Unconditionally reserve the entire fisrt 1M, see comment in
+	 * setup_arch().
+	 */
+	memblock_reserve(0, SZ_1M);
 }
 
 static void sme_sev_setup_real_mode(struct trampoline_header *th)
