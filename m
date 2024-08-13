Return-Path: <linux-tip-commits+bounces-2042-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289B3950D7B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 22:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C38B1C21900
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 20:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157941A3BAC;
	Tue, 13 Aug 2024 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sJhg1jir";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uYPq5k3q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D154A953;
	Tue, 13 Aug 2024 20:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723579409; cv=none; b=M6pv00dRaStHNpy43GyzRO2RnhhGaJGWGwUoN4rM3Mao5kma2HlOKRrCB+T7gz79lvChheLyhFf1/Drat/1iL5RYSDqUpMEshtlIaZlTD1WqMu2x1nIRED4lFQLvq9olWkGQvW1Zt3SqpYj8IPbMrEfRaT2i8/R/EgCxXKJc92k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723579409; c=relaxed/simple;
	bh=j4Rl5dwmzBAE8rsXPrzl+AyjmQT3LBZPtT4nr+bWkXQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OVkguJvSgkXULakijGdrfKRGp1Ubo5+1YMazLtDmuLAZ7ZybVF//asaBre3YbE6Fgh6zVUQ1zg03ydzMG6a+PdANXfmhUFoidCHb9Roxg/Os4IZg4x4PStSEMOFopS66UBp5au1CvWMR6rMxfSFxAmMPH7VekBKUnzqrbF+g2S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sJhg1jir; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uYPq5k3q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Aug 2024 20:03:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723579405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUbDTg6GBkmIIUXvz96p508+q5Wr+osrDqkyrMZmpD8=;
	b=sJhg1jircI/uIEE6xnCu0X5KKLVn8Hl6gdD3s6hpO7MZLdhrOOwTi97kNZFMH7b4MptRfJ
	FhRlkB8+5CX8HPWg3LxQIAOFlAFT3X7zQ6TMT1nmsJFRUF8s95ziYBPy2h+Hhk+qBsxVId
	kQg4avht4001XjoH2dM9wWrQIAqjlPoZ9aGKsdPEVwIANmdIG6Xite4L5aCk/Xz8M4fZ1g
	5aZPt81ZoJyp4cjJWciFm0ptLJBy06d/HSlX1QKUuTactB4NAvTqkBiDM1StAGt+ZfN5Fq
	DhyparLf0jJV6NAK4L8NJCN35oHpFa8CPVPTkdQGvaaYFHRHXUY9yIGeeSxK0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723579405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUbDTg6GBkmIIUXvz96p508+q5Wr+osrDqkyrMZmpD8=;
	b=uYPq5k3qstWx5hQ4nX7loqz75WBTurWYFvdWrnwcBtpu1HM17cQfqLOGHBzQ1opEV0sqkf
	qYs+PxF4VMVNwVBw==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Enable FRED right after init_mem_mapping()
Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Xin Li (Intel)" <xin@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240709154048.3543361-4-xin@zytor.com>
References: <20240709154048.3543361-4-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172357940456.2215.3119070109667388257.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     a97756cbec448032f84b5bbfe4e101478d1e01e0
Gitweb:        https://git.kernel.org/tip/a97756cbec448032f84b5bbfe4e101478d1e01e0
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Tue, 09 Jul 2024 08:40:48 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Aug 2024 21:59:21 +02:00

x86/fred: Enable FRED right after init_mem_mapping()

On 64-bit init_mem_mapping() relies on the minimal page fault handler
provided by the early IDT mechanism. The real page fault handler is
installed right afterwards into the IDT.

This is problematic on CPUs which have X86_FEATURE_FRED set because the
real page fault handler retrieves the faulting address from the FRED
exception stack frame and not from CR2, but that does obviously not work
when FRED is not yet enabled in the CPU.

To prevent this enable FRED right after init_mem_mapping() without
interrupt stacks. Those are enabled later in trap_init() after the CPU
entry area is set up.

[ tglx: Encapsulate the FRED details ]

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Reported-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240709154048.3543361-4-xin@zytor.com
---
 arch/x86/include/asm/processor.h |  3 ++-
 arch/x86/kernel/cpu/common.c     | 15 +++++++++++++--
 arch/x86/kernel/setup.c          |  7 ++++++-
 arch/x86/kernel/smpboot.c        |  2 +-
 arch/x86/kernel/traps.c          |  2 +-
 5 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a75a07f..399f7d1 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -582,7 +582,8 @@ extern void switch_gdt_and_percpu_base(int);
 extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
 extern void cpu_init(void);
-extern void cpu_init_exception_handling(void);
+extern void cpu_init_exception_handling(bool boot_cpu);
+extern void cpu_init_replace_early_idt(void);
 extern void cr4_init(void);
 
 extern void set_task_blockstep(struct task_struct *task, bool on);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 6de12b3..a4735d9 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2176,7 +2176,7 @@ static inline void tss_setup_io_bitmap(struct tss_struct *tss)
  * Setup everything needed to handle exceptions from the IDT, including the IST
  * exceptions which use paranoid_entry().
  */
-void cpu_init_exception_handling(void)
+void cpu_init_exception_handling(bool boot_cpu)
 {
 	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
 	int cpu = raw_smp_processor_id();
@@ -2196,13 +2196,24 @@ void cpu_init_exception_handling(void)
 	setup_ghcb();
 
 	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
-		cpu_init_fred_exceptions();
+		/* The boot CPU has enabled FRED during early boot */
+		if (!boot_cpu)
+			cpu_init_fred_exceptions();
+
 		cpu_init_fred_rsps();
 	} else {
 		load_current_idt();
 	}
 }
 
+void __init cpu_init_replace_early_idt(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		cpu_init_fred_exceptions();
+	else
+		idt_setup_early_pf();
+}
+
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
  * initialized (naturally) in the bootstrap process, such as the GDT.  We
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 6129dc2..f1fea50 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1039,7 +1039,12 @@ void __init setup_arch(char **cmdline_p)
 
 	init_mem_mapping();
 
-	idt_setup_early_pf();
+	/*
+	 * init_mem_mapping() relies on the early IDT page fault handling.
+	 * Now either enable FRED or install the real page fault handler
+	 * for 64-bit in the IDT.
+	 */
+	cpu_init_replace_early_idt();
 
 	/*
 	 * Update mmu_cr4_features (and, indirectly, trampoline_cr4_features)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0c35207..dc4fff8 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -246,7 +246,7 @@ static void notrace start_secondary(void *unused)
 		__flush_tlb_all();
 	}
 
-	cpu_init_exception_handling();
+	cpu_init_exception_handling(false);
 
 	/*
 	 * Load the microcode before reaching the AP alive synchronization
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 6afb41e..197d588 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1411,7 +1411,7 @@ void __init trap_init(void)
 	sev_es_init_vc_handling();
 
 	/* Initialize TSS before setting up traps so ISTs work */
-	cpu_init_exception_handling();
+	cpu_init_exception_handling(true);
 
 	/* Setup traps as cpu_init() might #GP */
 	if (!cpu_feature_enabled(X86_FEATURE_FRED))

