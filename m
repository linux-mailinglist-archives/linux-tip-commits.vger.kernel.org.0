Return-Path: <linux-tip-commits+bounces-4931-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48175A8733F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 20:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41AF916EE14
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D601F4629;
	Sun, 13 Apr 2025 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CPD9KNqP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5nLgt/94"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683511EE02F;
	Sun, 13 Apr 2025 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570578; cv=none; b=RJjkcD/QSimOPJg4xdoJhVQ4bBhnlhcU2g8dqCDYLEWvzod7Xi6PjjNhUgdNbDflrOujPvJzERGtZ34JFXuLwCVv/OTCylVI+ubPCphAH8Si++U46aDDwPvaEBmF4UXnlyexa+n+xms7b1TaPLma+aMgCP/e9b0raz/pzxu3kvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570578; c=relaxed/simple;
	bh=KC4al3wpSN24AXUB38r5MTqSy7BHXnfuHV8TWXhxJIs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=FrbbW4XOsdBu44kCHe80QmBBsUjwnHSiFIfgMEFdMLleqAt7p1eF6vOFTwxOUkPVElEYjmst8uE2tPzH9OOMb4DxR+Eg1xRDpK04OgJkojGodNz8QP4bWNoX0FqcDiMWhfJlJFh9fOrZNU0bvxsak6LRZxI5uHo4jKkPHXP/kVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CPD9KNqP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5nLgt/94; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570574;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=h47AI0XbIhWrQZqYFm4NEYcJ6Nv51byVbUq1GVfG8gg=;
	b=CPD9KNqPte/BzCFcwgchqJbzgu6T/WDamx1Qy86os7LC8ZNYtCEmIwxpxj9Hj8R2GhCcv5
	ffRsw83558P7qVXX7iJHzfAe5m4vluRvn+6zq5AqQECwaDfjFGs0YcBoQuySHSr2cFDwRm
	NZ/L3QJ60DSg7atYQYrur+EyTQjltBw0aH/8LliwHmdjmY7CdktVyLzMeXSPrIz15MUCOh
	y5VB4kLj86UYi1eDPvNhaVEuOO8qo6A6/Gs/4MTgJZEuu4tdzc6qhPCrSM+9jbg4BaWRaU
	On79XhAt8SXx946y2EAVprXdVYmVIf4w5D6/UKraZsQ5qmcrwuApTv3ePfnuSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570574;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=h47AI0XbIhWrQZqYFm4NEYcJ6Nv51byVbUq1GVfG8gg=;
	b=5nLgt/940OXcxXLyQ5wNx6kTDNKnyEz+LQezlFI8oChUWBQ0PySFG9NuOAhAHp95K5OuQ4
	OD1tVBBcrFSKhCAw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] x86/msr: Rename 'mce_rdmsrl()' to 'mce_rdmsrq()'
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juergen Gross <jgross@suse.com>, Dave Hansen <dave.hansen@intel.com>,
 Xin Li <xin@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174457057329.31282.15364097720031409754.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     ebe29309c4d2821d5fdccd5393eba9c77540e260
Gitweb:        https://git.kernel.org/tip/ebe29309c4d2821d5fdccd5393eba9c77540e260
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 22:29:02 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 11:59:09 +02:00

x86/msr: Rename 'mce_rdmsrl()' to 'mce_rdmsrq()'

Suggested-by: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/kernel/cpu/mce/core.c     | 32 ++++++++++++++---------------
 arch/x86/kernel/cpu/mce/internal.h |  2 +-
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index c274024..765b799 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -388,7 +388,7 @@ void ex_handler_msr_mce(struct pt_regs *regs, bool wrmsr)
 }
 
 /* MSR access wrappers used for error injection */
-noinstr u64 mce_rdmsrl(u32 msr)
+noinstr u64 mce_rdmsrq(u32 msr)
 {
 	DECLARE_ARGS(val, low, high);
 
@@ -444,7 +444,7 @@ static noinstr void mce_wrmsrl(u32 msr, u64 v)
 	low  = (u32)v;
 	high = (u32)(v >> 32);
 
-	/* See comment in mce_rdmsrl() */
+	/* See comment in mce_rdmsrq() */
 	asm volatile("1: wrmsr\n"
 		     "2:\n"
 		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR_IN_MCE)
@@ -468,7 +468,7 @@ static noinstr void mce_gather_info(struct mce_hw_err *err, struct pt_regs *regs
 	instrumentation_end();
 
 	m = &err->m;
-	m->mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
+	m->mcgstatus = mce_rdmsrq(MSR_IA32_MCG_STATUS);
 	if (regs) {
 		/*
 		 * Get the address of the instruction at the time of
@@ -488,7 +488,7 @@ static noinstr void mce_gather_info(struct mce_hw_err *err, struct pt_regs *regs
 		}
 		/* Use accurate RIP reporting if available. */
 		if (mca_cfg.rip_msr)
-			m->ip = mce_rdmsrl(mca_cfg.rip_msr);
+			m->ip = mce_rdmsrq(mca_cfg.rip_msr);
 	}
 }
 
@@ -684,10 +684,10 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 	struct mce *m = &err->m;
 
 	if (m->status & MCI_STATUS_MISCV)
-		m->misc = mce_rdmsrl(mca_msr_reg(i, MCA_MISC));
+		m->misc = mce_rdmsrq(mca_msr_reg(i, MCA_MISC));
 
 	if (m->status & MCI_STATUS_ADDRV) {
-		m->addr = mce_rdmsrl(mca_msr_reg(i, MCA_ADDR));
+		m->addr = mce_rdmsrq(mca_msr_reg(i, MCA_ADDR));
 
 		/*
 		 * Mask the reported address by the reported granularity.
@@ -702,12 +702,12 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 	}
 
 	if (mce_flags.smca) {
-		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
+		m->ipid = mce_rdmsrq(MSR_AMD64_SMCA_MCx_IPID(i));
 
 		if (m->status & MCI_STATUS_SYNDV) {
-			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
-			err->vendor.amd.synd1 = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND1(i));
-			err->vendor.amd.synd2 = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND2(i));
+			m->synd = mce_rdmsrq(MSR_AMD64_SMCA_MCx_SYND(i));
+			err->vendor.amd.synd1 = mce_rdmsrq(MSR_AMD64_SMCA_MCx_SYND1(i));
+			err->vendor.amd.synd2 = mce_rdmsrq(MSR_AMD64_SMCA_MCx_SYND2(i));
 		}
 	}
 }
@@ -753,7 +753,7 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		m->bank = i;
 
 		barrier();
-		m->status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
+		m->status = mce_rdmsrq(mca_msr_reg(i, MCA_STATUS));
 
 		/*
 		 * Update storm tracking here, before checking for the
@@ -887,8 +887,8 @@ quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
  */
 static noinstr bool quirk_skylake_repmov(void)
 {
-	u64 mcgstatus   = mce_rdmsrl(MSR_IA32_MCG_STATUS);
-	u64 misc_enable = mce_rdmsrl(MSR_IA32_MISC_ENABLE);
+	u64 mcgstatus   = mce_rdmsrq(MSR_IA32_MCG_STATUS);
+	u64 misc_enable = mce_rdmsrq(MSR_IA32_MISC_ENABLE);
 	u64 mc1_status;
 
 	/*
@@ -899,7 +899,7 @@ static noinstr bool quirk_skylake_repmov(void)
 	    !(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING))
 		return false;
 
-	mc1_status = mce_rdmsrl(MSR_IA32_MCx_STATUS(1));
+	mc1_status = mce_rdmsrq(MSR_IA32_MCx_STATUS(1));
 
 	/* Check for a software-recoverable data fetch error. */
 	if ((mc1_status &
@@ -955,7 +955,7 @@ static __always_inline int mce_no_way_out(struct mce_hw_err *err, char **msg, un
 	int i;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
-		m->status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
+		m->status = mce_rdmsrq(mca_msr_reg(i, MCA_STATUS));
 		if (!(m->status & MCI_STATUS_VAL))
 			continue;
 
@@ -1335,7 +1335,7 @@ __mc_scan_banks(struct mce_hw_err *err, struct pt_regs *regs,
 		m->addr = 0;
 		m->bank = i;
 
-		m->status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
+		m->status = mce_rdmsrq(mca_msr_reg(i, MCA_STATUS));
 		if (!(m->status & MCI_STATUS_VAL))
 			continue;
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 95a504e..b5ba598 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -312,7 +312,7 @@ static __always_inline void pentium_machine_check(struct pt_regs *regs) {}
 static __always_inline void winchip_machine_check(struct pt_regs *regs) {}
 #endif
 
-noinstr u64 mce_rdmsrl(u32 msr);
+noinstr u64 mce_rdmsrq(u32 msr);
 
 static __always_inline u32 mca_msr_reg(int bank, enum mca_msr reg)
 {

