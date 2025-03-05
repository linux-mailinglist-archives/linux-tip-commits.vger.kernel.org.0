Return-Path: <linux-tip-commits+bounces-4014-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EC4A50DB8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 22:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7320C1894BE1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 21:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6786C2586C4;
	Wed,  5 Mar 2025 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W5Lg6XgE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d3tw+82/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412F7257AEE;
	Wed,  5 Mar 2025 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210588; cv=none; b=TU3cQRifZ393yNshqpYiv5uV1jY2iF/Seb7d1oIwmhHoRl1UhxMXUKPp3+/rsOIntDEsr6/jnItL9mrqfO8b4eEeVkA71csTfe12B6y40xCllzGbs02va3RqjEyrjEEAL80pcPRHZ5z2oXTWl9En9JMRAStpxj5MaOIUnt/Ou+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210588; c=relaxed/simple;
	bh=GEsqvE8u94XRr1X0/pd4noXU7XzCN+wCLf761EFYAYs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=frN9NGKUE/N+7gV3ubYOS8qHTcAXAdhBv7FvUZ8g/yWeu5DQSo/lxaFlQyXLYlLoPdBx653eCBsuH86Zo8Xlls5Oc4qDGbE7cPZxAjmeM9krT63uwSIOCHYIafs8j21w1lwQtgJsQLnTzXYX3B4xY09xdIelApzkGXf23JCDB6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W5Lg6XgE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d3tw+82/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Mar 2025 21:36:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741210584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVhVoHbKW/L1pRMz9wfAL0PFM9T0rdErJEoQoG8D7sY=;
	b=W5Lg6XgENdWAOSeFNGybyUgGVQDl2hBVbOnnXCdacYY77q0VtsG2WiidVkRExX5o22zlBt
	uXYDZ6vrenWRM3nAMCh7fXQyuqMTxTSdPpjE3GNQ0CtOAiDeGo5OlHj+047IvCe7jh10Ol
	pTc7JvKp4pv+tDRsAlVyDPfGO8u7iQIMFmhxc9Kxkfw6EyXjgdcXZP7lB00qA/+MK7AheW
	hg6dNA8Gyqo9QOfKHiExidyyYKdP5odA9dEmbKBbO/384vgGj4RsfWQlbnEHIot+ewTACT
	98L65kgO8KzedydT/1bHqdU9iej8Iic3sNp38ZZ/SQ+gkbmnUHnzzm+6NzQz8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741210584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVhVoHbKW/L1pRMz9wfAL0PFM9T0rdErJEoQoG8D7sY=;
	b=d3tw+82/72H7AXDxDrb4nbGwpn3jBMgX5dGX0V66zW0ZBxQJXrcVIQl3Jyh9optmAFcQ4/
	pq+yNr6JQGkUnZDA==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Enable broadcast TLB invalidation for
 multi-threaded processes
Cc: Rik van Riel <riel@surriel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nadav Amit <nadav.amit@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226030129.530345-11-riel@surriel.com>
References: <20250226030129.530345-11-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174121058305.14745.2469716058047698930.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     f37ff575b1fe47ff3eeccf751455b4ab05306008
Gitweb:        https://git.kernel.org/tip/f37ff575b1fe47ff3eeccf751455b4ab05306008
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Tue, 25 Feb 2025 22:00:45 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Mar 2025 22:18:10 +01:00

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

