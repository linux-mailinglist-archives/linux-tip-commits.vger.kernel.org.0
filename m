Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9472D31D7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Dec 2020 19:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbgLHSNN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 8 Dec 2020 13:13:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40492 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbgLHSNN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 8 Dec 2020 13:13:13 -0500
Date:   Tue, 08 Dec 2020 18:12:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607451150;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xsOLQ9Y+5JZt3k24y9BQmHDJk+C56opPtHsHl8GEVg4=;
        b=wrr0CObYcxYP1NmCTxMWhVMwj/xk0mydNWK2ZGViLkc4JBwZbAU5LcZQhhGJ5BmjLsEMOy
        EHI8krv/ieW7AA4Zghb4QessuvnQBF8lFumEoHWcGmC7pPj7/ei7/0Wr0CU0ghuuDVx4dH
        tCO0XZ5Vtzw2wKB75Px7p7sfpP4XbVPw3/5jDJvrgOUD4vuKSJJVJ3a9/CfWhHveK8XW1C
        uHfqK2Qm9iMUOTzc6gRvDmOLOAsdMCafbAIcRUAQSvlxapoZLyc7JCCtG8SKmiVDMv758/
        nTR284eTomEEE/lJwPvKiKpRtnZL5KTHiyWuD/+ZLtclJxqYdFiiqJVd9d+GMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607451150;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xsOLQ9Y+5JZt3k24y9BQmHDJk+C56opPtHsHl8GEVg4=;
        b=zeGO0CQW49uQTKC0HYdVbO+DMBX6rLDDo7GYJdrjX56913W4hJUsC/wNO31IrsDjDguHYb
        pj1FryR949q3uPAg==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/amd: Remove dead code for TSEG region remapping
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201127171324.1846019-1-nivedita@alum.mit.edu>
References: <20201127171324.1846019-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <160745114956.3364.12729288651743353490.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     262bd5724afdefd4c48a260d6100e78cc43ee06b
Gitweb:        https://git.kernel.org/tip/262bd5724afdefd4c48a260d6100e78cc43ee06b
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Fri, 27 Nov 2020 12:13:24 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 08 Dec 2020 18:45:21 +01:00

x86/cpu/amd: Remove dead code for TSEG region remapping

Commit

  26bfa5f89486 ("x86, amd: Cleanup init_amd")

moved the code that remaps the TSEG region using 4k pages from
init_amd() to bsp_init_amd().

However, bsp_init_amd() is executed well before the direct mapping is
actually created:

  setup_arch()
    -> early_cpu_init()
      -> early_identify_cpu()
        -> this_cpu->c_bsp_init()
	  -> bsp_init_amd()
    ...
    -> init_mem_mapping()

So the change effectively disabled the 4k remapping, because
pfn_range_is_mapped() is always false at this point.

It has been over six years since the commit, and no-one seems to have
noticed this, so just remove the code. The original code was also
incomplete, since it doesn't check how large the TSEG address range
actually is, so it might remap only part of it in any case.

Hygon has copied the incorrect version, so the code has never run on it
since the cpu support was added two years ago. Remove it from there as
well.

Committer notes:

This workaround is incomplete anyway:

1. The code must check MSRC001_0113.TValid (SMM TSeg Mask MSR) first, to
check whether the TSeg address range is enabled.

2. The code must check whether the range is not 2M aligned - if it is,
there's nothing to work around.

3. In all the BIOSes tested, the TSeg range is in a e820 reserved area
and those are not mapped anymore, after

  66520ebc2df3 ("x86, mm: Only direct map addresses that are marked as E820_RAM")

which means, there's nothing to be worked around either.

So let's rip it out.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201127171324.1846019-1-nivedita@alum.mit.edu
---
 arch/x86/kernel/cpu/amd.c   | 21 ---------------------
 arch/x86/kernel/cpu/hygon.c | 20 --------------------
 2 files changed, 41 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 1f71c76..f8ca66f 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -23,7 +23,6 @@
 
 #ifdef CONFIG_X86_64
 # include <asm/mmconfig.h>
-# include <asm/set_memory.h>
 #endif
 
 #include "cpu.h"
@@ -509,26 +508,6 @@ static void early_init_amd_mc(struct cpuinfo_x86 *c)
 
 static void bsp_init_amd(struct cpuinfo_x86 *c)
 {
-
-#ifdef CONFIG_X86_64
-	if (c->x86 >= 0xf) {
-		unsigned long long tseg;
-
-		/*
-		 * Split up direct mapping around the TSEG SMM area.
-		 * Don't do it for gbpages because there seems very little
-		 * benefit in doing so.
-		 */
-		if (!rdmsrl_safe(MSR_K8_TSEG_ADDR, &tseg)) {
-			unsigned long pfn = tseg >> PAGE_SHIFT;
-
-			pr_debug("tseg: %010llx\n", tseg);
-			if (pfn_range_is_mapped(pfn, pfn + 1))
-				set_memory_4k((unsigned long)__va(tseg), 1);
-		}
-	}
-#endif
-
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
 
 		if (c->x86 > 0x10 ||
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index dc0840a..ae59115 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -14,9 +14,6 @@
 #include <asm/cacheinfo.h>
 #include <asm/spec-ctrl.h>
 #include <asm/delay.h>
-#ifdef CONFIG_X86_64
-# include <asm/set_memory.h>
-#endif
 
 #include "cpu.h"
 
@@ -203,23 +200,6 @@ static void early_init_hygon_mc(struct cpuinfo_x86 *c)
 
 static void bsp_init_hygon(struct cpuinfo_x86 *c)
 {
-#ifdef CONFIG_X86_64
-	unsigned long long tseg;
-
-	/*
-	 * Split up direct mapping around the TSEG SMM area.
-	 * Don't do it for gbpages because there seems very little
-	 * benefit in doing so.
-	 */
-	if (!rdmsrl_safe(MSR_K8_TSEG_ADDR, &tseg)) {
-		unsigned long pfn = tseg >> PAGE_SHIFT;
-
-		pr_debug("tseg: %010llx\n", tseg);
-		if (pfn_range_is_mapped(pfn, pfn + 1))
-			set_memory_4k((unsigned long)__va(tseg), 1);
-	}
-#endif
-
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
 		u64 val;
 
