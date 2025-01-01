Return-Path: <linux-tip-commits+bounces-3160-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5839FF3E4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 12:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3803A2C2C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 11:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CACC1E284B;
	Wed,  1 Jan 2025 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ZaIA7p4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cgo4pHU6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827F81E22FB;
	Wed,  1 Jan 2025 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735731860; cv=none; b=MdC7swq29lentVoXlZkglaw9Saju4Z0bfFBUrsl/vPeB8rhl7jDzh8uZ+6kSmfzZoVYylcSA0awrWWbfGu5leRAFS5Jr0FnxEykxyeeLQ45sn2bJbXT516ELzew5Kflkx4pllGRFl52G4yWv3XnovFuZXexp4oFPlXr+p4rell0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735731860; c=relaxed/simple;
	bh=ydBEVmJGBeO/qhS1pOhqCQV1vTWUOA6v+AjB7205/BU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sCgz7jXJi03Qi++BRb7NR3U1Md74GcZEe9NtmOsiuGIqtHQIvs9IwO+FdIklFSxryadiAGkCsX31UmLHwoG3uID0lvQJK6l+zowPnGei8opYhJl2w053OqJTr9ISeZj7yl0CJtfJOkPGbB+OSLcueqxG/qOby+HxPORMts40dQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ZaIA7p4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cgo4pHU6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 01 Jan 2025 11:44:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735731850;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLavU2m1vwp96bIZmMevlOfg+nxOTAv1eZV0mEXV2r0=;
	b=1ZaIA7p4aaWYpQUEAsCtuwXwtOoVXbNBakp12lilOgQdbKpcu7GvnonEElNYUjOHm5pQ2b
	L2nPuFap/GM1TRt7QDXNjS/C0tzPacoe/NPI7Q39orO/MERVzEL/RWViEDrseJSeL2QsYZ
	laAduQqxtlBZ3Q72JZEhLZVoJlw1iMlX2tWwtCLTmC8A5bY3udFS5GlByWEPIg42NgbrcQ
	6MR7n1DxLbsk78HJVyJdhQXqxIwDTbiyuoq/5jRToCdIfyV+jTlTbCdpTpGptP+lWZ0xvQ
	fE35vYRBLlO3JilxK+uKzP8mREEN5vC9NydvawnCPoBSWqbynYuqch9khbX7Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735731850;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLavU2m1vwp96bIZmMevlOfg+nxOTAv1eZV0mEXV2r0=;
	b=cgo4pHU61druQisq/VAV3W1jyDc4teRpmcHHH3aTC6hC8Q8NA4ATY7BI9bhUkC+VWjfFH/
	jdsRWS89g2v/vBCw==
From: "tip-bot2 for Qiuxu Zhuo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Make several functions return bool
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241212140103.66964-2-qiuxu.zhuo@intel.com>
References: <20241212140103.66964-2-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173573184993.399.15797829535415251509.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     c845cb8dbd2e1a804babfd13648026c3a7cfbc0b
Gitweb:        https://git.kernel.org/tip/c845cb8dbd2e1a804babfd13648026c3a7cfbc0b
Author:        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
AuthorDate:    Thu, 12 Dec 2024 22:00:57 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 30 Dec 2024 19:05:50 +01:00

x86/mce: Make several functions return bool

Make several functions that return 0 or 1 return a boolean value for
better readability.

No functional changes are intended.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/r/20241212140103.66964-2-qiuxu.zhuo@intel.com
---
 arch/x86/include/asm/mce.h      |  4 ++--
 arch/x86/kernel/cpu/mce/amd.c   | 10 +++++-----
 arch/x86/kernel/cpu/mce/core.c  | 22 +++++++++++-----------
 arch/x86/kernel/cpu/mce/intel.c |  9 +++++----
 4 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 4543cf2..ea9ca76 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -276,7 +276,7 @@ static inline void cmci_rediscover(void) {}
 static inline void cmci_recheck(void) {}
 #endif
 
-int mce_available(struct cpuinfo_x86 *c);
+bool mce_available(struct cpuinfo_x86 *c);
 bool mce_is_memory_error(struct mce *m);
 bool mce_is_correctable(struct mce *m);
 bool mce_usable_address(struct mce *m);
@@ -296,7 +296,7 @@ enum mcp_flags {
 
 void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
 
-int mce_notify_irq(void);
+bool mce_notify_irq(void);
 
 DECLARE_PER_CPU(struct mce, injectm);
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6ca80ff..018874b 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -381,7 +381,7 @@ static bool lvt_interrupt_supported(unsigned int bank, u32 msr_high_bits)
 	return msr_high_bits & BIT(28);
 }
 
-static int lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
+static bool lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
 {
 	int msr = (hi & MASK_LVTOFF_HI) >> 20;
 
@@ -389,7 +389,7 @@ static int lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
 		pr_err(FW_BUG "cpu %d, failed to setup threshold interrupt "
 		       "for bank %d, block %d (MSR%08X=0x%x%08x)\n", b->cpu,
 		       b->bank, b->block, b->address, hi, lo);
-		return 0;
+		return false;
 	}
 
 	if (apic != msr) {
@@ -399,15 +399,15 @@ static int lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
 		 * was set is reserved. Return early here:
 		 */
 		if (mce_flags.smca)
-			return 0;
+			return false;
 
 		pr_err(FW_BUG "cpu %d, invalid threshold interrupt offset %d "
 		       "for bank %d, block %d (MSR%08X=0x%x%08x)\n",
 		       b->cpu, apic, b->bank, b->block, b->address, hi, lo);
-		return 0;
+		return false;
 	}
 
-	return 1;
+	return true;
 };
 
 /* Reprogram MCx_MISC MSR behind this threshold bank. */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7fb5556..167965b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -492,10 +492,10 @@ static noinstr void mce_gather_info(struct mce_hw_err *err, struct pt_regs *regs
 	}
 }
 
-int mce_available(struct cpuinfo_x86 *c)
+bool mce_available(struct cpuinfo_x86 *c)
 {
 	if (mca_cfg.disabled)
-		return 0;
+		return false;
 	return cpu_has(c, X86_FEATURE_MCE) && cpu_has(c, X86_FEATURE_MCA);
 }
 
@@ -1778,7 +1778,7 @@ static void mce_timer_delete_all(void)
  * Can be called from interrupt context, but not from machine check/NMI
  * context.
  */
-int mce_notify_irq(void)
+bool mce_notify_irq(void)
 {
 	/* Not more than two messages every minute */
 	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
@@ -1789,9 +1789,9 @@ int mce_notify_irq(void)
 		if (__ratelimit(&ratelimit))
 			pr_info(HW_ERR "Machine check events logged\n");
 
-		return 1;
+		return true;
 	}
-	return 0;
+	return false;
 }
 EXPORT_SYMBOL_GPL(mce_notify_irq);
 
@@ -2015,25 +2015,25 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 	return 0;
 }
 
-static int __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
+static bool __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
 {
 	if (c->x86 != 5)
-		return 0;
+		return false;
 
 	switch (c->x86_vendor) {
 	case X86_VENDOR_INTEL:
 		intel_p5_mcheck_init(c);
 		mce_flags.p5 = 1;
-		return 1;
+		return true;
 	case X86_VENDOR_CENTAUR:
 		winchip_mcheck_init(c);
 		mce_flags.winchip = 1;
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 
-	return 0;
+	return false;
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index b3cd2c6..f863df0 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -75,12 +75,12 @@ static u16 cmci_threshold[MAX_NR_BANKS];
  */
 #define CMCI_STORM_THRESHOLD	32749
 
-static int cmci_supported(int *banks)
+static bool cmci_supported(int *banks)
 {
 	u64 cap;
 
 	if (mca_cfg.cmci_disabled || mca_cfg.ignore_ce)
-		return 0;
+		return false;
 
 	/*
 	 * Vendor check is not strictly needed, but the initial
@@ -89,10 +89,11 @@ static int cmci_supported(int *banks)
 	 */
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
-		return 0;
+		return false;
 
 	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
-		return 0;
+		return false;
+
 	rdmsrl(MSR_IA32_MCG_CAP, cap);
 	*banks = min_t(unsigned, MAX_NR_BANKS, cap & MCG_BANKCNT_MASK);
 	return !!(cap & MCG_CMCI_P);

