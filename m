Return-Path: <linux-tip-commits+bounces-4635-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A21A7A222
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 13:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2068F16E727
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 11:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE8A1F63CD;
	Thu,  3 Apr 2025 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gnm0oEtk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q7ILPjwm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E923597B;
	Thu,  3 Apr 2025 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743680887; cv=none; b=boGvnSiIaDOnDKOIoZYXd7JtJDnGcmumjquhdJWrN1/gQR2DfTr/4GI6d48x+3DewfsrK6tne5GL6Hhzc1d1j6u8Eh5kf+SoRWSuFD+UBbg9BrKBLHrJ2jW4QtfyIvhVwWehdhp/s3HHX05rXwVgnkE44Hy14qHLB1bSMG0e2gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743680887; c=relaxed/simple;
	bh=ggW3lyvMe1bWuHnE3AMIXxLY7h5nNcg/fnMxfgTH500=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZuTfZ8k+kRcDN1MXXYs4VUMqFXOvJbuW63JWB+hsLgyKRBX4LEQSizfZrcxO8Cx32DPH/A6IJKVWBOaLCh0zVG7cKhoL38DSeTn05hZO9zfxboizwWLZhpN/5Stguj9IEy7dzhgleYP/RU7ffLF/wjC5HtJ/JKz4xCV5A+Cv+ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gnm0oEtk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q7ILPjwm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 11:48:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743680882;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJVglrlTxtuulj7SgqjYpnjNjxD9NxeRelAx2kNse5Y=;
	b=gnm0oEtkJLhmvObAhS0sudee6EjSEjQbBeEm2cjDj5zJR/ROi90wau2ghxOrduniaRTAYJ
	nArmBIkA9Nhpgvlz2CgUFc2l2c2O3Kok/q5cmHajvIeqnPSBJJ1qMOTYpCdbJrjv1P/Wgf
	W6UF+qqIItsJiYuetWlqy6MN9bEk11BNAEnnMxZ9Q7/0n8LVFwhaQXKUOz5OvsGeQsPD66
	kmgK8qf+vlYNYxfBqZTmNS2e+joBthRQbpmHAv4dMfoaf0GYGUzwqDYoshcsJqRwmDoctk
	wG/zkyK/ReWCs1vsfoR2Pjeh9Eo+TiWrcBDc2mJQ5x09cTChC1K0TeADzWhUZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743680882;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SJVglrlTxtuulj7SgqjYpnjNjxD9NxeRelAx2kNse5Y=;
	b=Q7ILPjwm+3RwsFEzFC1b3IU0HuxG0e95IQfLHM7Al1OcRw3lgrhLTEosreKzeajYnKTwJ0
	eg8FzwaYeExuDWAQ==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/tlb: Simplify choose_new_asid() and generate better code
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Uros Bizjak <ubizjak@gmail.com>, Rik van Riel <riel@surriel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250403085623.20824-1-bp@kernel.org>
References: <20250403085623.20824-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174368088082.14745.4983728465451468180.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     2fb34b1566a386913b291d04f91ba6f6e6a5bb99
Gitweb:        https://git.kernel.org/tip/2fb34b1566a386913b291d04f91ba6f6e6a5bb99
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 03 Apr 2025 10:56:23 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 03 Apr 2025 13:35:37 +02:00

x86/tlb: Simplify choose_new_asid() and generate better code

Have it return the two things it does return:

 - a new ASID and
 - the need to flush the TLB or not,

in a struct which fits in a single 32-bit register and whack the IO
parameters.

Beyond being easier to read, this also helps the compiler generate
better, more compact code:

  # arch/x86/mm/tlb.o:

  text     data      bss      dec      hex  filename
  9341      753      516    10610     2972  tlb.o.before
  9213      753      516    10482     28f2  tlb.o.after

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250403085623.20824-1-bp@kernel.org
---
 arch/x86/mm/tlb.c | 63 ++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e459d97..d00ae21 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -215,16 +215,20 @@ static void clear_asid_other(void)
 
 atomic64_t last_mm_ctx_id = ATOMIC64_INIT(1);
 
+struct new_asid {
+	unsigned int asid	: 16;
+	unsigned int need_flush : 1;
+};
 
-static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
-			    u16 *new_asid, bool *need_flush)
+static struct new_asid choose_new_asid(struct mm_struct *next, u64 next_tlb_gen)
 {
+	struct new_asid ns;
 	u16 asid;
 
 	if (!static_cpu_has(X86_FEATURE_PCID)) {
-		*new_asid = 0;
-		*need_flush = true;
-		return;
+		ns.asid = 0;
+		ns.need_flush = 1;
+		return ns;
 	}
 
 	/*
@@ -235,9 +239,9 @@ static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
 		u16 global_asid = mm_global_asid(next);
 
 		if (global_asid) {
-			*new_asid = global_asid;
-			*need_flush = false;
-			return;
+			ns.asid = global_asid;
+			ns.need_flush = 0;
+			return ns;
 		}
 	}
 
@@ -249,22 +253,23 @@ static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
 		    next->context.ctx_id)
 			continue;
 
-		*new_asid = asid;
-		*need_flush = (this_cpu_read(cpu_tlbstate.ctxs[asid].tlb_gen) <
-			       next_tlb_gen);
-		return;
+		ns.asid = asid;
+		ns.need_flush = (this_cpu_read(cpu_tlbstate.ctxs[asid].tlb_gen) < next_tlb_gen);
+		return ns;
 	}
 
 	/*
 	 * We don't currently own an ASID slot on this CPU.
 	 * Allocate a slot.
 	 */
-	*new_asid = this_cpu_add_return(cpu_tlbstate.next_asid, 1) - 1;
-	if (*new_asid >= TLB_NR_DYN_ASIDS) {
-		*new_asid = 0;
+	ns.asid = this_cpu_add_return(cpu_tlbstate.next_asid, 1) - 1;
+	if (ns.asid >= TLB_NR_DYN_ASIDS) {
+		ns.asid = 0;
 		this_cpu_write(cpu_tlbstate.next_asid, 1);
 	}
-	*need_flush = true;
+	ns.need_flush = true;
+
+	return ns;
 }
 
 /*
@@ -781,9 +786,9 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
 	unsigned cpu = smp_processor_id();
 	unsigned long new_lam;
+	struct new_asid ns;
 	u64 next_tlb_gen;
-	bool need_flush;
-	u16 new_asid;
+
 
 	/* We don't want flush_tlb_func() to run concurrently with us. */
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
@@ -854,7 +859,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		/* Check if the current mm is transitioning to a global ASID */
 		if (mm_needs_global_asid(next, prev_asid)) {
 			next_tlb_gen = atomic64_read(&next->context.tlb_gen);
-			choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
+			ns = choose_new_asid(next, next_tlb_gen);
 			goto reload_tlb;
 		}
 
@@ -889,8 +894,8 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		 * TLB contents went out of date while we were in lazy
 		 * mode. Fall through to the TLB switching code below.
 		 */
-		new_asid = prev_asid;
-		need_flush = true;
+		ns.asid = prev_asid;
+		ns.need_flush = true;
 	} else {
 		/*
 		 * Apply process to process speculation vulnerability
@@ -918,21 +923,21 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
 
-		choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
+		ns = choose_new_asid(next, next_tlb_gen);
 	}
 
 reload_tlb:
 	new_lam = mm_lam_cr3_mask(next);
-	if (need_flush) {
-		VM_WARN_ON_ONCE(is_global_asid(new_asid));
-		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
-		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
-		load_new_mm_cr3(next->pgd, new_asid, new_lam, true);
+	if (ns.need_flush) {
+		VM_WARN_ON_ONCE(is_global_asid(ns.asid));
+		this_cpu_write(cpu_tlbstate.ctxs[ns.asid].ctx_id, next->context.ctx_id);
+		this_cpu_write(cpu_tlbstate.ctxs[ns.asid].tlb_gen, next_tlb_gen);
+		load_new_mm_cr3(next->pgd, ns.asid, new_lam, true);
 
 		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
 	} else {
 		/* The new ASID is already up to date. */
-		load_new_mm_cr3(next->pgd, new_asid, new_lam, false);
+		load_new_mm_cr3(next->pgd, ns.asid, new_lam, false);
 
 		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, 0);
 	}
@@ -941,7 +946,7 @@ reload_tlb:
 	barrier();
 
 	this_cpu_write(cpu_tlbstate.loaded_mm, next);
-	this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
+	this_cpu_write(cpu_tlbstate.loaded_mm_asid, ns.asid);
 	cpu_tlbstate_update_lam(new_lam, mm_untag_mask(next));
 
 	if (next != prev) {

