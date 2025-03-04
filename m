Return-Path: <linux-tip-commits+bounces-3850-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BD0A4D651
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0B418970A3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 08:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058AD1FCCED;
	Tue,  4 Mar 2025 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H0CmkhCL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6Ua/h/p4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026C01FC0FC;
	Tue,  4 Mar 2025 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076872; cv=none; b=FBi4HdkpiDtYHykeoc4yRFtcqPwjJTDxBh8yOFRdHxNl35rWD7K5M8Xm9iortxe0wr6z6g1yN/JiL9stESzu5DSmS+TN80so7Q+IPujHe0qALXyYKXHoUNMhcQqHR0WjBXPlgWv75nl4OGjl8eCT8tFdtGSTCK8DAThaCC+CJbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076872; c=relaxed/simple;
	bh=40dnRwFkElToBr3KaxSa3l1HJIBcpR2X9ZPrRlpgLL8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MOukvehiHdOXBilplqSNUAPJRLi/C39yDbu56OgVLdySEsDlhP+jAmvWjO2XFTtbdcbyqp2Ug6xIrP5uCXnXBDcsxmDo7XJ8hA7isumwoBc1BTUQr0p2VDFK6SPAsYGbIw/SkV3bLYR9o/cKNUp7RtgMgbpk2gqgnQtjIS2AA10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H0CmkhCL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6Ua/h/p4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:27:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741076869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=boOuo6vup+Ua8N8rJmk7VGRjOZBd09VtnSJoxp+olyc=;
	b=H0CmkhCLJSJK7YL6svwRJxPdLMvWrJxX7bbTkbq0cicLBAlDmSJEfveWvfIi/fhwySdcqU
	s9eZIG5r5G0FjmJ5bPXD9FK3JjHmepzj8OjYe+12PsPGFOreNhE7GijahyfLj6yXvFfSi1
	jVzkFMYzxcWr9VtYNifUl9WsyfzJ+J1U910oo0la+dV4UBQObjSv3TNKH1OslyYY+/FD8N
	AHQPRy39/qViJhXIlYe6RDfHb6INspftF9BDWJHe4+EGRTsyvKOjM76miaH3XYg5YiTuHk
	1pvTNz0nmxuLanFCFSoPdW0eVFGcccGnbPJU7ZThXmmOEmgSGgiGX5DJx3CU0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741076869;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=boOuo6vup+Ua8N8rJmk7VGRjOZBd09VtnSJoxp+olyc=;
	b=6Ua/h/p4G2U97mRzW4R26qJLw06QvG8CtcTUv4vafLXBWJTC8yS58LAuSDn4y8G1WZ3LEf
	RGtgleS9TT/SWHDg==
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
Message-ID: <174107686855.14745.14522514904877739770.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     d9d755ec42d0aca4796cdcbc2177ca6844867e99
Gitweb:        https://git.kernel.org/tip/d9d755ec42d0aca4796cdcbc2177ca6844867e99
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 03 Mar 2025 11:52:39 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 21:37:41 +01:00

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
index 4da927e..d20a9cc 100644
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
@@ -134,8 +135,8 @@ __visible void smp_call_function_single_interrupt(struct pt_regs *r);
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

