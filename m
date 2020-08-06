Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E923DD91
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Aug 2020 19:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbgHFRLP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 Aug 2020 13:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbgHFRKM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 Aug 2020 13:10:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E41AC061756;
        Thu,  6 Aug 2020 10:10:12 -0700 (PDT)
Date:   Thu, 06 Aug 2020 17:10:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596733810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+gF51AHiKQFl7hxR7OgTYQ6FP7pdmHlCFI0G/5ZYzH4=;
        b=3+jjPumHstPAUuHszokE80GOLGNYprTrFfSGN/BNl8GLtVDRqu+IHfsOTBRC/cZOjnQR5N
        8XZcKZ1rtInUXJCiYS8oWnI3CzRUVv+E7V/nSDGo0D8OSCBR0O5see0z3hmz0V6YmsCi1B
        ZnCbHWJLp+5LcAaxJOSg6KmuYpfSSAPmriPP7xcslPOJF5Ort024O4fATE8UozxjfGocxb
        4gntjprvnWHRrR922VHkghQfIZE0aqYXbtknFdEZRaF5yht6sGBI5LKj9noW1MELG4t01m
        JFoj++uLwydk+ZFLnh3Y5Jndmfp2rRTHbmhHoD3fC3aVjAGrkvsG6RVA5fKDLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596733810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+gF51AHiKQFl7hxR7OgTYQ6FP7pdmHlCFI0G/5ZYzH4=;
        b=hyqFUROIfdH/aWsVT8nBc5LRMYaGdljxbpaam28xiR4zGOX+rzQPkQ1G86BM/2Y29v/FBP
        UTjYApxohsnipyBg==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] Revert "x86/mm/64: Do not sync vmalloc/ioremap mappings"
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159673380949.3192.14983535678351816282.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f17506e2f14bfa8a6a2de9b8b6a3ccc6b6f7c9b6
Gitweb:        https://git.kernel.org/tip/f17506e2f14bfa8a6a2de9b8b6a3ccc6b6f7c9b6
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 06 Aug 2020 15:11:03 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Aug 2020 15:11:03 +02:00

Revert "x86/mm/64: Do not sync vmalloc/ioremap mappings"

This reverts commit 8bb9bf242d1fee925636353807c511d54fde8986.

Jason reported that this causes a new oops in process_one_work(),
and bisected it to this commit.

Linus suspects that it was caused by missing pagetable synchronization:

> > BUG: unable to handle page fault for address: ffffe8ffffd00608
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 0 P4D 0
>
> Yeah, missing page table because it wasn't copied.
>
> Presumably because that kthread is using the active_mm of some random
> user space process that didn't get sync'ed.
>
> And the sync_global_pgds() may have ended up being sufficient
> synchronization with whoever allocated thigns, even if it wasn't about
> the TLB contents themselves.
>
> So apparently the "the page-table pages are all pre-allocated now" is
> simply not true.

Revert the commit for now.

Reported-by: "Jason A. Donenfeld" <Jason@zx2c4.com>
Analyzed-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgtable_64_types.h | 2 ++
 arch/x86/mm/init_64.c                   | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 52e5f5f..8f63efb 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -159,4 +159,6 @@ extern unsigned int ptrs_per_p4d;
 
 #define PGD_KERNEL_START	((PAGE_SIZE / 2) / sizeof(pgd_t))
 
+#define ARCH_PAGE_TABLE_SYNC_MASK	(pgtable_l5_enabled() ?	PGTBL_PGD_MODIFIED : PGTBL_P4D_MODIFIED)
+
 #endif /* _ASM_X86_PGTABLE_64_DEFS_H */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index e65b96f..3f4e29a 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -217,6 +217,11 @@ static void sync_global_pgds(unsigned long start, unsigned long end)
 		sync_global_pgds_l4(start, end);
 }
 
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
+{
+	sync_global_pgds(start, end);
+}
+
 /*
  * NOTE: This function is marked __ref because it calls __init function
  * (alloc_bootmem_pages). It's safe to do it ONLY when after_bootmem == 0.
