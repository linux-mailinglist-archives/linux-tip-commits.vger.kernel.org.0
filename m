Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FC932B0A2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Mar 2021 04:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352299AbhCCDjN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Mar 2021 22:39:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36100 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577832AbhCBJ4Q (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Mar 2021 04:56:16 -0500
Date:   Tue, 02 Mar 2021 09:54:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614678888;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49p7cA7i8tse/kWOKzTPD7pxrB3gUqx0zwBBz6irmA4=;
        b=cuB5L2nK8i90W6GGH+L1tmLnohk+9TL+sf/uXBEzL0mzpiUniFwRqIidsTINufoQQmiztn
        bxd8CCw3EBJ1vIX6nDAC7Bo9pelUD43PvamuUxGbxc4JUPC4mViBUIHSEO+1eVeGM5EaCf
        yUdFWRZ+ZLyNRTAVQq84BgQ7fSBk0yi0BVAPESAJCRvQtWTykdbfrvXyQbYzt7YNXftjNG
        3O8Cw2wboGv2x5Pk8qqaDSVd/hedp3jDHmKZN6taXY4b4iVAyfimvE3XOkYdPgo75GmkD4
        oY9sOQRgRgfshiUYd7j1kHLvMYSybHrBWC0XJ6DD6dWVQSk0+yYV9RGkpHRaeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614678888;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49p7cA7i8tse/kWOKzTPD7pxrB3gUqx0zwBBz6irmA4=;
        b=qI63oQEfcMb8eSFdqh1NK+FPTfzpvpHsffwnmSMGoFzUN7NfRkecAZJGKJbbGGY5vs4vrp
        eDxd/DmYu6ovB1DQ==
From:   "tip-bot2 for Nadav Amit" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/tlb: Open-code on_each_cpu_cond_mask() for
 tlb_is_not_lazy()
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210220231712.2475218-4-namit@vmware.com>
References: <20210220231712.2475218-4-namit@vmware.com>
MIME-Version: 1.0
Message-ID: <161467888821.20312.12386170191227269746.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     bc51e8e6f9c387d8dda1d8dea2b8856d0ade4101
Gitweb:        https://git.kernel.org/tip/bc51e8e6f9c387d8dda1d8dea2b8856d0ade4101
Author:        Nadav Amit <namit@vmware.com>
AuthorDate:    Sat, 20 Feb 2021 15:17:06 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Mar 2021 08:01:37 +01:00

x86/mm/tlb: Open-code on_each_cpu_cond_mask() for tlb_is_not_lazy()

Open-code on_each_cpu_cond_mask() in native_flush_tlb_others() to
optimize the code. Open-coding eliminates the need for the indirect branch
that is used to call is_lazy(), and in CPUs that are vulnerable to
Spectre v2, it eliminates the retpoline. In addition, it allows to use a
preallocated cpumask to compute the CPUs that should be.

This would later allow us not to adapt on_each_cpu_cond_mask() to
support local and remote functions.

Note that calling tlb_is_not_lazy() for every CPU that needs to be
flushed, as done in native_flush_tlb_multi() might look ugly, but it is
equivalent to what is currently done in on_each_cpu_cond_mask().
Actually, native_flush_tlb_multi() does it more efficiently since it
avoids using an indirect branch for the matter.

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20210220231712.2475218-4-namit@vmware.com
---
 arch/x86/mm/tlb.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index bf12371..07b6701 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -788,11 +788,13 @@ done:
 			nr_invalidate);
 }
 
-static bool tlb_is_not_lazy(int cpu, void *data)
+static bool tlb_is_not_lazy(int cpu)
 {
 	return !per_cpu(cpu_tlbstate.is_lazy, cpu);
 }
 
+static DEFINE_PER_CPU(cpumask_t, flush_tlb_mask);
+
 STATIC_NOPV void native_flush_tlb_others(const struct cpumask *cpumask,
 					 const struct flush_tlb_info *info)
 {
@@ -813,12 +815,37 @@ STATIC_NOPV void native_flush_tlb_others(const struct cpumask *cpumask,
 	 * up on the new contents of what used to be page tables, while
 	 * doing a speculative memory access.
 	 */
-	if (info->freed_tables)
+	if (info->freed_tables) {
 		smp_call_function_many(cpumask, flush_tlb_func,
 			       (void *)info, 1);
-	else
-		on_each_cpu_cond_mask(tlb_is_not_lazy, flush_tlb_func,
-				(void *)info, 1, cpumask);
+	} else {
+		/*
+		 * Although we could have used on_each_cpu_cond_mask(),
+		 * open-coding it has performance advantages, as it eliminates
+		 * the need for indirect calls or retpolines. In addition, it
+		 * allows to use a designated cpumask for evaluating the
+		 * condition, instead of allocating one.
+		 *
+		 * This code works under the assumption that there are no nested
+		 * TLB flushes, an assumption that is already made in
+		 * flush_tlb_mm_range().
+		 *
+		 * cond_cpumask is logically a stack-local variable, but it is
+		 * more efficient to have it off the stack and not to allocate
+		 * it on demand. Preemption is disabled and this code is
+		 * non-reentrant.
+		 */
+		struct cpumask *cond_cpumask = this_cpu_ptr(&flush_tlb_mask);
+		int cpu;
+
+		cpumask_clear(cond_cpumask);
+
+		for_each_cpu(cpu, cpumask) {
+			if (tlb_is_not_lazy(cpu))
+				__cpumask_set_cpu(cpu, cond_cpumask);
+		}
+		smp_call_function_many(cond_cpumask, flush_tlb_func, (void *)info, 1);
+	}
 }
 
 void flush_tlb_others(const struct cpumask *cpumask,
