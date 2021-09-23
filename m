Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC070415B69
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Sep 2021 11:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240234AbhIWJwR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 23 Sep 2021 05:52:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33384 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240232AbhIWJwQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 23 Sep 2021 05:52:16 -0400
Date:   Thu, 23 Sep 2021 09:50:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632390644;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6JqyePf2xykXEytNbArjQ7GOJCwVLwl9yvvOkXaaLqc=;
        b=y5EHsnisb3eyAjdrGmTV8A9MOlEgcM+8hMUa7RXFnuLpzr8Mt+H2fwTImqb7wIqWoVMkXg
        dyKiDJHydmpq27x6jYV+sOHP3CCFB+vp6pkLLnr98OgQVLu+tPSfMjup0LJEzZs0I3KDkI
        uzJ1UByKDLsWyC7lGORMS+3vbqN1NcG/UP4NqUKnyvzA3wSuszqB2naIYMN6C7kq/jmt3e
        Ibxjol0HcBkElyzgzncjFRYSi8pgxGZdhnbwskR5aR5Nmxagc7Tjrq86pnGLY3TLd6GolS
        xKOj4qA1Skhi6qXMD2oc/Tsu5SjREanam5k+SBnKTY2/U8CZJ6RIywZ3Kx/rzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632390644;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6JqyePf2xykXEytNbArjQ7GOJCwVLwl9yvvOkXaaLqc=;
        b=2U83y3OdImHL8aUwSdo/l850Lxk9LEltSDAev9BMW86bVfk65yaDlNiHWs+2qsT+Rgz3Am
        aS/sI4CNptbJGwBA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Get rid of msr_ops
Cc:     Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210922165101.18951-4-bp@alien8.de>
References: <20210922165101.18951-4-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163239064292.25758.9987153320990919293.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     8121b8f947be0033f567619be204639a50cad298
Gitweb:        https://git.kernel.org/tip/8121b8f947be0033f567619be204639a50cad298
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 02 Sep 2021 13:33:22 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 23 Sep 2021 11:20:20 +02:00

x86/mce: Get rid of msr_ops

Avoid having indirect calls and use a normal function which returns the
proper MSR address based on ->smca setting.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20210922165101.18951-4-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/amd.c      | 10 +--
 arch/x86/kernel/cpu/mce/core.c     | 95 +++++++++--------------------
 arch/x86/kernel/cpu/mce/internal.h | 12 ++--
 3 files changed, 42 insertions(+), 75 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 08831ac..27cacf5 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -526,7 +526,7 @@ static u32 get_block_address(u32 current_addr, u32 low, u32 high,
 	/* Fall back to method we used for older processors: */
 	switch (block) {
 	case 0:
-		addr = msr_ops.misc(bank);
+		addr = mca_msr_reg(bank, MCA_MISC);
 		break;
 	case 1:
 		offset = ((low & MASK_BLKPTR_LO) >> 21);
@@ -978,8 +978,8 @@ static void log_error_deferred(unsigned int bank)
 {
 	bool defrd;
 
-	defrd = _log_error_bank(bank, msr_ops.status(bank),
-					msr_ops.addr(bank), 0);
+	defrd = _log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS),
+				mca_msr_reg(bank, MCA_ADDR), 0);
 
 	if (!mce_flags.smca)
 		return;
@@ -1009,7 +1009,7 @@ static void amd_deferred_error_interrupt(void)
 
 static void log_error_thresholding(unsigned int bank, u64 misc)
 {
-	_log_error_bank(bank, msr_ops.status(bank), msr_ops.addr(bank), misc);
+	_log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS), mca_msr_reg(bank, MCA_ADDR), misc);
 }
 
 static void log_and_reset_block(struct threshold_block *block)
@@ -1397,7 +1397,7 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 		}
 	}
 
-	err = allocate_threshold_blocks(cpu, b, bank, 0, msr_ops.misc(bank));
+	err = allocate_threshold_blocks(cpu, b, bank, 0, mca_msr_reg(bank, MCA_MISC));
 	if (err)
 		goto out_kobj;
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7aff9a5..8e766b2 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -176,53 +176,27 @@ void mce_unregister_decode_chain(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
 
-static inline u32 ctl_reg(int bank)
+u32 mca_msr_reg(int bank, enum mca_msr reg)
 {
-	return MSR_IA32_MCx_CTL(bank);
-}
-
-static inline u32 status_reg(int bank)
-{
-	return MSR_IA32_MCx_STATUS(bank);
-}
-
-static inline u32 addr_reg(int bank)
-{
-	return MSR_IA32_MCx_ADDR(bank);
-}
-
-static inline u32 misc_reg(int bank)
-{
-	return MSR_IA32_MCx_MISC(bank);
-}
-
-static inline u32 smca_ctl_reg(int bank)
-{
-	return MSR_AMD64_SMCA_MCx_CTL(bank);
-}
-
-static inline u32 smca_status_reg(int bank)
-{
-	return MSR_AMD64_SMCA_MCx_STATUS(bank);
-}
+	if (mce_flags.smca) {
+		switch (reg) {
+		case MCA_CTL:	 return MSR_AMD64_SMCA_MCx_CTL(bank);
+		case MCA_ADDR:	 return MSR_AMD64_SMCA_MCx_ADDR(bank);
+		case MCA_MISC:	 return MSR_AMD64_SMCA_MCx_MISC(bank);
+		case MCA_STATUS: return MSR_AMD64_SMCA_MCx_STATUS(bank);
+		}
+	}
 
-static inline u32 smca_addr_reg(int bank)
-{
-	return MSR_AMD64_SMCA_MCx_ADDR(bank);
-}
+	switch (reg) {
+	case MCA_CTL:	 return MSR_IA32_MCx_CTL(bank);
+	case MCA_ADDR:	 return MSR_IA32_MCx_ADDR(bank);
+	case MCA_MISC:	 return MSR_IA32_MCx_MISC(bank);
+	case MCA_STATUS: return MSR_IA32_MCx_STATUS(bank);
+	}
 
-static inline u32 smca_misc_reg(int bank)
-{
-	return MSR_AMD64_SMCA_MCx_MISC(bank);
+	return 0;
 }
 
-struct mca_msr_regs msr_ops = {
-	.ctl	= ctl_reg,
-	.status	= status_reg,
-	.addr	= addr_reg,
-	.misc	= misc_reg
-};
-
 static void __print_mce(struct mce *m)
 {
 	pr_emerg(HW_ERR "CPU %d: Machine Check%s: %Lx Bank %d: %016Lx\n",
@@ -362,11 +336,11 @@ static int msr_to_offset(u32 msr)
 
 	if (msr == mca_cfg.rip_msr)
 		return offsetof(struct mce, ip);
-	if (msr == msr_ops.status(bank))
+	if (msr == mca_msr_reg(bank, MCA_STATUS))
 		return offsetof(struct mce, status);
-	if (msr == msr_ops.addr(bank))
+	if (msr == mca_msr_reg(bank, MCA_ADDR))
 		return offsetof(struct mce, addr);
-	if (msr == msr_ops.misc(bank))
+	if (msr == mca_msr_reg(bank, MCA_MISC))
 		return offsetof(struct mce, misc);
 	if (msr == MSR_IA32_MCG_STATUS)
 		return offsetof(struct mce, mcgstatus);
@@ -685,10 +659,10 @@ static struct notifier_block mce_default_nb = {
 static void mce_read_aux(struct mce *m, int i)
 {
 	if (m->status & MCI_STATUS_MISCV)
-		m->misc = mce_rdmsrl(msr_ops.misc(i));
+		m->misc = mce_rdmsrl(mca_msr_reg(i, MCA_MISC));
 
 	if (m->status & MCI_STATUS_ADDRV) {
-		m->addr = mce_rdmsrl(msr_ops.addr(i));
+		m->addr = mce_rdmsrl(mca_msr_reg(i, MCA_ADDR));
 
 		/*
 		 * Mask the reported address by the reported granularity.
@@ -758,7 +732,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		m.bank = i;
 
 		barrier();
-		m.status = mce_rdmsrl(msr_ops.status(i));
+		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
 
 		/* If this entry is not valid, ignore it */
 		if (!(m.status & MCI_STATUS_VAL))
@@ -826,7 +800,7 @@ clear_it:
 		/*
 		 * Clear state for this bank.
 		 */
-		mce_wrmsrl(msr_ops.status(i), 0);
+		mce_wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
 	}
 
 	/*
@@ -851,7 +825,7 @@ static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 	int i;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
-		m->status = mce_rdmsrl(msr_ops.status(i));
+		m->status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
 		if (!(m->status & MCI_STATUS_VAL))
 			continue;
 
@@ -1144,7 +1118,7 @@ static void mce_clear_state(unsigned long *toclear)
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		if (test_bit(i, toclear))
-			mce_wrmsrl(msr_ops.status(i), 0);
+			mce_wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
 	}
 }
 
@@ -1203,7 +1177,7 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
 		m->addr = 0;
 		m->bank = i;
 
-		m->status = mce_rdmsrl(msr_ops.status(i));
+		m->status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
 		if (!(m->status & MCI_STATUS_VAL))
 			continue;
 
@@ -1708,8 +1682,8 @@ static void __mcheck_cpu_init_clear_banks(void)
 
 		if (!b->init)
 			continue;
-		wrmsrl(msr_ops.ctl(i), b->ctl);
-		wrmsrl(msr_ops.status(i), 0);
+		wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
+		wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
 	}
 }
 
@@ -1735,7 +1709,7 @@ static void __mcheck_cpu_check_banks(void)
 		if (!b->init)
 			continue;
 
-		rdmsrl(msr_ops.ctl(i), msrval);
+		rdmsrl(mca_msr_reg(i, MCA_CTL), msrval);
 		b->init = !!msrval;
 	}
 }
@@ -1894,13 +1868,6 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
 		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
 		mce_flags.amd_threshold	 = 1;
-
-		if (mce_flags.smca) {
-			msr_ops.ctl	= smca_ctl_reg;
-			msr_ops.status	= smca_status_reg;
-			msr_ops.addr	= smca_addr_reg;
-			msr_ops.misc	= smca_misc_reg;
-		}
 	}
 }
 
@@ -2254,7 +2221,7 @@ static void mce_disable_error_reporting(void)
 		struct mce_bank *b = &mce_banks[i];
 
 		if (b->init)
-			wrmsrl(msr_ops.ctl(i), 0);
+			wrmsrl(mca_msr_reg(i, MCA_CTL), 0);
 	}
 	return;
 }
@@ -2606,7 +2573,7 @@ static void mce_reenable_cpu(void)
 		struct mce_bank *b = &mce_banks[i];
 
 		if (b->init)
-			wrmsrl(msr_ops.ctl(i), b->ctl);
+			wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index d71d6c5..1ad7b4b 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -172,14 +172,14 @@ struct mce_vendor_flags {
 
 extern struct mce_vendor_flags mce_flags;
 
-struct mca_msr_regs {
-	u32 (*ctl)	(int bank);
-	u32 (*status)	(int bank);
-	u32 (*addr)	(int bank);
-	u32 (*misc)	(int bank);
+enum mca_msr {
+	MCA_CTL,
+	MCA_STATUS,
+	MCA_ADDR,
+	MCA_MISC,
 };
 
-extern struct mca_msr_regs msr_ops;
+u32 mca_msr_reg(int bank, enum mca_msr reg);
 
 /* Decide whether to add MCE record to MCE event pool or filter it out. */
 extern bool filter_mce(struct mce *m);
