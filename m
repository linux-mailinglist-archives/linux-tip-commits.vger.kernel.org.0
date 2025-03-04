Return-Path: <linux-tip-commits+bounces-3975-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB138A4ED7C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C979816FA35
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC2927816C;
	Tue,  4 Mar 2025 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j72iX0IG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jhgQfCrH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0599252915;
	Tue,  4 Mar 2025 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116847; cv=none; b=r95j48Pg/z3Pz3rJK34oGLyJjX/E3OjYJ9mFiHUwKz2+74S8kFaK2Y0wMBlmIiiBdI5o+AFhIas4MWbyyYwZ6Z9z24VOWE6sKgwQudzVtp47vyowltN8ukSr1fQfm5IawAkJKIoP5B3ngOx3XYXszayWQDH0Wcu+aTRknSkvwZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116847; c=relaxed/simple;
	bh=RJ+HRrgToEmTgAw8rvsX1u04z3C/UIo/v3CBmaPyBa4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NMA63nVTiAdqRWxbLyrobexNLgZMPpuBcwcI3hgq5PUoXiVMasPAsXhdfqwglQtjg33MxnzLyiu8fEYx2Eu0U9I9hqp+bDD/g0Fy/JDA2zvUlN6XyCwPCeaVFKvfKPtncTCPFvb30LwGqOiWTK2bf7xvW3QOx7pV1R6wWFIQAz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j72iX0IG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jhgQfCrH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 19:34:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741116843;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwCxBLPm1LnujAAcxPVPhe0IEGAMGcUIn8FgA6iOT5w=;
	b=j72iX0IGbrZE5De3khbHwr0R7fCG+aSAPgpjzh0q5zO7Bn7kmZvo6uXH7FCTpaFzKV0T19
	Pe7SSNB1YBGxQysMv130N6Rcr0FYGuYML0FZsWTzLn1QMRAAFeLW4xsXZ/x6izlG7a7Aka
	+k1fz35qtBRZvBAshdvL/m/BilkV61YgollqYlaZ5/3lOoElbZaWAhZZKuxI433d28Asub
	VzkZqdnk53hyXJf8yukBB6e0QNCcJzcJJga3eC7qIO2sLmLyH3I8n0okscEPLRqSpl2G8P
	p672/CO3FS1L314uGkvKZtz0XmQcR0vLtzIvTREu7nsyjX0yTNhdD4WmJZscRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741116843;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwCxBLPm1LnujAAcxPVPhe0IEGAMGcUIn8FgA6iOT5w=;
	b=jhgQfCrHQIX2T7dOmHtEV8H7+KXmUrhHbHG9Q80WpDVPA7ThOYtrfUKTQiDTKrYQcyDNdW
	7hHX8LXgkd97BRBg==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/smp: Move cpu number to percpu hot section
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303165246.2175811-5-brgerst@gmail.com>
References: <20250303165246.2175811-5-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174111684287.14745.8121657235740368012.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     5cb5f5acb01749db1b878ea054a00aac13e59fdb
Gitweb:        https://git.kernel.org/tip/5cb5f5acb01749db1b878ea054a00aac13e59fdb
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:39 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 20:18:02 +01:00

x86/smp: Move cpu number to percpu hot section

No functional change.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250303165246.2175811-5-brgerst@gmail.com
---
 arch/x86/include/asm/current.h | 1 -
 arch/x86/include/asm/smp.h     | 7 ++++---
 arch/x86/kernel/setup_percpu.c | 5 ++++-
 kernel/bpf/verifier.c          | 4 ++--
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 46a736d..f988462 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -14,7 +14,6 @@ struct task_struct;
 
 struct pcpu_hot {
 	struct task_struct	*current_task;
-	int			cpu_number;
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 	u64			call_depth;
 #endif
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 76d7c01..bcfa002 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -6,7 +6,8 @@
 #include <linux/thread_info.h>
 
 #include <asm/cpumask.h>
-#include <asm/current.h>
+
+DECLARE_PER_CPU_CACHE_HOT(int, cpu_number);
 
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
@@ -132,8 +133,8 @@ __visible void smp_call_function_single_interrupt(struct pt_regs *r);
  * This function is needed by all SMP systems. It must _always_ be valid
  * from the initial startup.
  */
-#define raw_smp_processor_id()  this_cpu_read(pcpu_hot.cpu_number)
-#define __smp_processor_id() __this_cpu_read(pcpu_hot.cpu_number)
+#define raw_smp_processor_id()  this_cpu_read(cpu_number)
+#define __smp_processor_id() __this_cpu_read(cpu_number)
 
 static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 {
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 1e7be94..175afc3 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -23,6 +23,9 @@
 #include <asm/cpumask.h>
 #include <asm/cpu.h>
 
+DEFINE_PER_CPU_CACHE_HOT(int, cpu_number);
+EXPORT_PER_CPU_SYMBOL(cpu_number);
+
 DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
 EXPORT_PER_CPU_SYMBOL(this_cpu_off);
 
@@ -161,7 +164,7 @@ void __init setup_per_cpu_areas(void)
 	for_each_possible_cpu(cpu) {
 		per_cpu_offset(cpu) = delta + pcpu_unit_offsets[cpu];
 		per_cpu(this_cpu_off, cpu) = per_cpu_offset(cpu);
-		per_cpu(pcpu_hot.cpu_number, cpu) = cpu;
+		per_cpu(cpu_number, cpu) = cpu;
 		setup_percpu_segment(cpu);
 		/*
 		 * Copy data used in early init routines from the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f485951..6e604ca 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21702,12 +21702,12 @@ patch_map_ops_generic:
 		if (insn->imm == BPF_FUNC_get_smp_processor_id &&
 		    verifier_inlines_helper_call(env, insn->imm)) {
 			/* BPF_FUNC_get_smp_processor_id inlining is an
-			 * optimization, so if pcpu_hot.cpu_number is ever
+			 * optimization, so if cpu_number is ever
 			 * changed in some incompatible and hard to support
 			 * way, it's fine to back out this inlining logic
 			 */
 #ifdef CONFIG_SMP
-			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&pcpu_hot.cpu_number);
+			insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, (u32)(unsigned long)&cpu_number);
 			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 			insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
 			cnt = 3;

