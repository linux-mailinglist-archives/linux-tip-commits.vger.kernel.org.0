Return-Path: <linux-tip-commits+bounces-4387-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1EFA68B2C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396A73B803C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7087C26562D;
	Wed, 19 Mar 2025 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fD4SwSdR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JcB1WFwy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0019D261376;
	Wed, 19 Mar 2025 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382249; cv=none; b=XAr8Lu6NRANmHCqy25HQ9W41/6k/JsKZF1sKGNVAkOdESuPMTvV9xy/1GZPWJjaa0Qaz1sadR2uD9bVuZ1p92EUrxWsKItPsq893G+9/GQGctTqxcJCE7tNSbZD4RlUbVOaT6sQHOJdy312yFOw/r5sf90npSKsO+SkFEHxBL6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382249; c=relaxed/simple;
	bh=Vbp7T1d4UNA8r06T/7Z+PRXErqvfyBXPrUg5DeJqd7Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ObU+m6VaoK+gkjLLx7GacbRv1z+esJDQGkN5b6CYItVhGs8Y1O9KT8Hp4jCD8SaKkIg43lgUbDEuW9CikzUtnQxLcRBWA31uOAB+q9SfEPw1L1MzTMfKftzZTYiSRxFmWi4ip7eFNlk/J3yBH6iRU3gWDE4S9M2kZ41yS6z4+L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fD4SwSdR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JcB1WFwy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:04:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKEDgfpOeLjdHDAA0TNG3Sp8Y6iabSXJ3/VLTS0OlTc=;
	b=fD4SwSdRF97tcaFUbNTksPbv00dymY8P8MNqOicBpoKVjCOKVDaS8L28LhHzFJnPMaYZ/o
	wnTKpB//gAtcKzCOqf8dFtDe9VuRX0kxcjDVZbea1cyJHfDus4lEt1u9lFggnFDVolmYUZ
	GLqmDSUErTyrogbqqOJ9vvzSd32EGhDiJ64EwzoJSkUKYlBmZyZH4DlBfil9/3zzeSC/zW
	0RDRabGXJrmv0exCZLosamcxPhfkl5d2wi0IzG54vvsBzZT82HAO7KGkuzmj1T7mkMi0Vm
	hfbXDavmfCLOFyei78aDektnAed7edBmgHJdvs/fVVAWQ2M+y/gr4hXhZgf0yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKEDgfpOeLjdHDAA0TNG3Sp8Y6iabSXJ3/VLTS0OlTc=;
	b=JcB1WFwy+xJz3XU2fCY35UvoLPZ9pxnUSC2XOMctqe+1Zv3sl+gbUr6dXpx9Y80mtwD6ww
	J6ABSSn27nimUbAA==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/mm: Enable broadcast TLB invalidation for
 multi-threaded processes
Cc: Rik van Riel <riel@surriel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250226030129.530345-11-riel@surriel.com>
References: <20250226030129.530345-11-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238224350.14745.3932740736739097467.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     4afeb0ed1753ebcad93ee3b45427ce85e9c8ec40
Gitweb:        https://git.kernel.org/tip/4afeb0ed1753ebcad93ee3b45427ce85e9c8ec40
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Tue, 25 Feb 2025 22:00:45 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:12:29 +01:00

x86/mm: Enable broadcast TLB invalidation for multi-threaded processes

There is not enough room in the 12-bit ASID address space to hand out
broadcast ASIDs to every process. Only hand out broadcast ASIDs to processes
when they are observed to be simultaneously running on 4 or more CPUs.

This also allows single threaded process to continue using the cheaper, local
TLB invalidation instructions like INVLPGB.

Due to the structure of flush_tlb_mm_range(), the INVLPGB flushing is done in
a generically named broadcast_tlb_flush() function which can later also be
used for Intel RAR.

Combined with the removal of unnecessary lru_add_drain calls() (see
https://lore.kernel.org/r/20241219153253.3da9e8aa@fangorn) this results in
a nice performance boost for the will-it-scale tlb_flush2_threads test on an
AMD Milan system with 36 cores:

  - vanilla kernel:           527k loops/second
  - lru_add_drain removal:    731k loops/second
  - only INVLPGB:             527k loops/second
  - lru_add_drain + INVLPGB: 1157k loops/second

Profiling with only the INVLPGB changes showed while TLB invalidation went
down from 40% of the total CPU time to only around 4% of CPU time, the
contention simply moved to the LRU lock.

Fixing both at the same time about doubles the number of iterations per second
from this case.

Comparing will-it-scale tlb_flush2_threads with several different numbers of
threads on a 72 CPU AMD Milan shows similar results. The number represents the
total number of loops per second across all the threads:

  threads	tip		INVLPGB

  1		315k		304k
  2		423k		424k
  4		644k		1032k
  8		652k		1267k
  16		737k		1368k
  32		759k		1199k
  64		636k		1094k
  72		609k		993k

1 and 2 thread performance is similar with and without INVLPGB, because
INVLPGB is only used on processes using 4 or more CPUs simultaneously.

The number is the median across 5 runs.

Some numbers closer to real world performance can be found at Phoronix, thanks
to Michael:

https://www.phoronix.com/news/AMD-INVLPGB-Linux-Benefits

  [ bp:
   - Massage
   - :%s/\<static_cpu_has\>/cpu_feature_enabled/cgi
   - :%s/\<clear_asid_transition\>/mm_clear_asid_transition/cgi
   - Fold in a 0day bot fix: https://lore.kernel.org/oe-kbuild-all/202503040000.GtiWUsBm-lkp@intel.com
   ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
Link: https://lore.kernel.org/r/20250226030129.530345-11-riel@surriel.com
---
 arch/x86/include/asm/tlbflush.h |   6 ++-
 arch/x86/mm/tlb.c               | 104 ++++++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index e6c3be0..7cad283 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -280,6 +280,11 @@ static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid)
 	smp_store_release(&mm->context.global_asid, asid);
 }
 
+static inline void mm_clear_asid_transition(struct mm_struct *mm)
+{
+	WRITE_ONCE(mm->context.asid_transition, false);
+}
+
 static inline bool mm_in_asid_transition(struct mm_struct *mm)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
@@ -291,6 +296,7 @@ static inline bool mm_in_asid_transition(struct mm_struct *mm)
 static inline u16 mm_global_asid(struct mm_struct *mm) { return 0; }
 static inline void mm_init_global_asid(struct mm_struct *mm) { }
 static inline void mm_assign_global_asid(struct mm_struct *mm, u16 asid) { }
+static inline void mm_clear_asid_transition(struct mm_struct *mm) { }
 static inline bool mm_in_asid_transition(struct mm_struct *mm) { return false; }
 #endif /* CONFIG_BROADCAST_TLB_FLUSH */
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index b5681e6..0efd990 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -431,6 +431,105 @@ static bool mm_needs_global_asid(struct mm_struct *mm, u16 asid)
 }
 
 /*
+ * x86 has 4k ASIDs (2k when compiled with KPTI), but the largest x86
+ * systems have over 8k CPUs. Because of this potential ASID shortage,
+ * global ASIDs are handed out to processes that have frequent TLB
+ * flushes and are active on 4 or more CPUs simultaneously.
+ */
+static void consider_global_asid(struct mm_struct *mm)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		return;
+
+	/* Check every once in a while. */
+	if ((current->pid & 0x1f) != (jiffies & 0x1f))
+		return;
+
+	/*
+	 * Assign a global ASID if the process is active on
+	 * 4 or more CPUs simultaneously.
+	 */
+	if (mm_active_cpus_exceeds(mm, 3))
+		use_global_asid(mm);
+}
+
+static void finish_asid_transition(struct flush_tlb_info *info)
+{
+	struct mm_struct *mm = info->mm;
+	int bc_asid = mm_global_asid(mm);
+	int cpu;
+
+	if (!mm_in_asid_transition(mm))
+		return;
+
+	for_each_cpu(cpu, mm_cpumask(mm)) {
+		/*
+		 * The remote CPU is context switching. Wait for that to
+		 * finish, to catch the unlikely case of it switching to
+		 * the target mm with an out of date ASID.
+		 */
+		while (READ_ONCE(per_cpu(cpu_tlbstate.loaded_mm, cpu)) == LOADED_MM_SWITCHING)
+			cpu_relax();
+
+		if (READ_ONCE(per_cpu(cpu_tlbstate.loaded_mm, cpu)) != mm)
+			continue;
+
+		/*
+		 * If at least one CPU is not using the global ASID yet,
+		 * send a TLB flush IPI. The IPI should cause stragglers
+		 * to transition soon.
+		 *
+		 * This can race with the CPU switching to another task;
+		 * that results in a (harmless) extra IPI.
+		 */
+		if (READ_ONCE(per_cpu(cpu_tlbstate.loaded_mm_asid, cpu)) != bc_asid) {
+			flush_tlb_multi(mm_cpumask(info->mm), info);
+			return;
+		}
+	}
+
+	/* All the CPUs running this process are using the global ASID. */
+	mm_clear_asid_transition(mm);
+}
+
+static void broadcast_tlb_flush(struct flush_tlb_info *info)
+{
+	bool pmd = info->stride_shift == PMD_SHIFT;
+	unsigned long asid = mm_global_asid(info->mm);
+	unsigned long addr = info->start;
+
+	/*
+	 * TLB flushes with INVLPGB are kicked off asynchronously.
+	 * The inc_mm_tlb_gen() guarantees page table updates are done
+	 * before these TLB flushes happen.
+	 */
+	if (info->end == TLB_FLUSH_ALL) {
+		invlpgb_flush_single_pcid_nosync(kern_pcid(asid));
+		/* Do any CPUs supporting INVLPGB need PTI? */
+		if (cpu_feature_enabled(X86_FEATURE_PTI))
+			invlpgb_flush_single_pcid_nosync(user_pcid(asid));
+	} else do {
+		unsigned long nr = 1;
+
+		if (info->stride_shift <= PMD_SHIFT) {
+			nr = (info->end - addr) >> info->stride_shift;
+			nr = clamp_val(nr, 1, invlpgb_count_max);
+		}
+
+		invlpgb_flush_user_nr_nosync(kern_pcid(asid), addr, nr, pmd);
+		if (cpu_feature_enabled(X86_FEATURE_PTI))
+			invlpgb_flush_user_nr_nosync(user_pcid(asid), addr, nr, pmd);
+
+		addr += nr << info->stride_shift;
+	} while (addr < info->end);
+
+	finish_asid_transition(info);
+
+	/* Wait for the INVLPGBs kicked off above to finish. */
+	__tlbsync();
+}
+
+/*
  * Given an ASID, flush the corresponding user ASID.  We can delay this
  * until the next time we switch to it.
  *
@@ -1260,9 +1359,12 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 	 * a local TLB flush is needed. Optimize this use-case by calling
 	 * flush_tlb_func_local() directly in this case.
 	 */
-	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
+	if (mm_global_asid(mm)) {
+		broadcast_tlb_flush(info);
+	} else if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids) {
 		info->trim_cpumask = should_trim_cpumask(mm);
 		flush_tlb_multi(mm_cpumask(mm), info);
+		consider_global_asid(mm);
 	} else if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
 		lockdep_assert_irqs_enabled();
 		local_irq_disable();

