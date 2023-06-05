Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257A9722852
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jun 2023 16:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjFEOIy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jun 2023 10:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjFEOIe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jun 2023 10:08:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A4CE4C;
        Mon,  5 Jun 2023 07:08:18 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:08:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cDON3ScUHT/B0x/87QzfCiMQovLHH10/LQHfrlEgwg0=;
        b=mIaUQd4h3ykuwxMUAhQmLpjOurhrmAccv8qZJEOeHmiN8vXRS/gQ08E3ch9CP/VVuCn9Yu
        MOAKMjuYQQEjJ8ilDk1AJ3Lyo8KqgPq6l43F4B6SQhNkR9QTba1bdQHzYSFGdokG7VmTH7
        e1UtmarDM2dCNRZKexVAD7JPWWq3GkoO1AQqMaWJmnc796qo874XTjmYZ1k2LbuCFNQGQ6
        Dn7PuaGug1FyJ9MlxRBuaXerQEmFgZkuR0JjQ62nTUjEitgbNghJHb6kcMCQnUosUKXqvi
        wWLXSaWsEjts06bu2/6LelHn3oqI536C537LqN/uMTJtWVgIep9Fry+zEoEgnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cDON3ScUHT/B0x/87QzfCiMQovLHH10/LQHfrlEgwg0=;
        b=crsNi+udyM7rOMQja+o+mhlSIgiW+bpCYUJMQo83fnxpZH9uBzGNVHiJgI0+4tQgPHMA/q
        TtwaRJzZCgyU0tCg==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/mtrr: Replace vendor tests in MTRR code
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230502120931.20719-7-jgross@suse.com>
References: <20230502120931.20719-7-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <168597409624.404.1244779098535793498.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mtrr branch of tip:

Commit-ID:     03409069520974361ffb510c725305239b78b39f
Gitweb:        https://git.kernel.org/tip/03409069520974361ffb510c725305239b78b39f
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 02 May 2023 14:09:21 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 01 Jun 2023 15:04:32 +02:00

x86/mtrr: Replace vendor tests in MTRR code

Modern CPUs all share the same MTRR interface implemented via
generic_mtrr_ops.

At several places in MTRR code this generic interface is deduced via
is_cpu(INTEL) tests, which is only working due to X86_VENDOR_INTEL
being 0 (the is_cpu() macro is testing mtrr_if->vendor, which isn't
explicitly set in generic_mtrr_ops).

Test the generic CPU feature X86_FEATURE_MTRR instead.

The only other place where the .vendor member of struct mtrr_ops is
being used is in set_num_var_ranges(), where depending on the vendor
the number of MTRR registers is determined. This can easily be changed
by replacing .vendor with the static number of MTRR registers.

It should be noted that the test "is_cpu(HYGON)" wasn't ever returning
true, as there is no struct mtrr_ops with that vendor information.

[ bp: Use mtrr_enabled() before doing mtrr_if-> accesses, esp. in
  mtrr_trim_uncached_memory() which gets called independently from
  whether mtrr_if is set or not. ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230502120931.20719-7-jgross@suse.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/mtrr/amd.c     |  2 +-
 arch/x86/kernel/cpu/mtrr/centaur.c |  2 +-
 arch/x86/kernel/cpu/mtrr/cleanup.c | 10 ++++++++--
 arch/x86/kernel/cpu/mtrr/cyrix.c   |  2 +-
 arch/x86/kernel/cpu/mtrr/generic.c |  2 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 28 ++++++++--------------------
 arch/x86/kernel/cpu/mtrr/mtrr.h    | 14 +++++++++++---
 7 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/amd.c b/arch/x86/kernel/cpu/mtrr/amd.c
index eff6ac6..ef3e8e4 100644
--- a/arch/x86/kernel/cpu/mtrr/amd.c
+++ b/arch/x86/kernel/cpu/mtrr/amd.c
@@ -110,7 +110,7 @@ amd_validate_add_page(unsigned long base, unsigned long size, unsigned int type)
 }
 
 const struct mtrr_ops amd_mtrr_ops = {
-	.vendor            = X86_VENDOR_AMD,
+	.var_regs          = 2,
 	.set               = amd_set_mtrr,
 	.get               = amd_get_mtrr,
 	.get_free_region   = generic_get_free_region,
diff --git a/arch/x86/kernel/cpu/mtrr/centaur.c b/arch/x86/kernel/cpu/mtrr/centaur.c
index b8a74ed..4466dde 100644
--- a/arch/x86/kernel/cpu/mtrr/centaur.c
+++ b/arch/x86/kernel/cpu/mtrr/centaur.c
@@ -112,7 +112,7 @@ centaur_validate_add_page(unsigned long base, unsigned long size, unsigned int t
 }
 
 const struct mtrr_ops centaur_mtrr_ops = {
-	.vendor            = X86_VENDOR_CENTAUR,
+	.var_regs          = 8,
 	.set               = centaur_set_mcr,
 	.get               = centaur_get_mcr,
 	.get_free_region   = centaur_get_free_region,
diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index ca2d567..ed5f84c 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -689,7 +689,10 @@ int __init mtrr_cleanup(void)
 	int index_good;
 	int i;
 
-	if (!is_cpu(INTEL) || enable_mtrr_cleanup < 1)
+	if (!mtrr_enabled())
+		return 0;
+
+	if (!cpu_feature_enabled(X86_FEATURE_MTRR) || enable_mtrr_cleanup < 1)
 		return 0;
 
 	rdmsr(MSR_MTRRdefType, def, dummy);
@@ -882,11 +885,14 @@ int __init mtrr_trim_uncached_memory(unsigned long end_pfn)
 	/* extra one for all 0 */
 	int num[MTRR_NUM_TYPES + 1];
 
+	if (!mtrr_enabled())
+		return 0;
+
 	/*
 	 * Make sure we only trim uncachable memory on machines that
 	 * support the Intel MTRR architecture:
 	 */
-	if (!is_cpu(INTEL) || disable_mtrr_trim)
+	if (!cpu_feature_enabled(X86_FEATURE_MTRR) || disable_mtrr_trim)
 		return 0;
 
 	rdmsr(MSR_MTRRdefType, def, dummy);
diff --git a/arch/x86/kernel/cpu/mtrr/cyrix.c b/arch/x86/kernel/cpu/mtrr/cyrix.c
index 173b9e0..238dad5 100644
--- a/arch/x86/kernel/cpu/mtrr/cyrix.c
+++ b/arch/x86/kernel/cpu/mtrr/cyrix.c
@@ -235,7 +235,7 @@ static void cyrix_set_arr(unsigned int reg, unsigned long base,
 }
 
 const struct mtrr_ops cyrix_mtrr_ops = {
-	.vendor            = X86_VENDOR_CYRIX,
+	.var_regs          = 8,
 	.set               = cyrix_set_arr,
 	.get               = cyrix_get_arr,
 	.get_free_region   = cyrix_get_free_region,
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index e81d832..4d8ca62 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -843,7 +843,7 @@ int generic_validate_add_page(unsigned long base, unsigned long size,
 	 * For Intel PPro stepping <= 7
 	 * must be 4 MiB aligned and not touch 0x70000000 -> 0x7003FFFF
 	 */
-	if (is_cpu(INTEL) && boot_cpu_data.x86 == 6 &&
+	if (mtrr_if == &generic_mtrr_ops && boot_cpu_data.x86 == 6 &&
 	    boot_cpu_data.x86_model == 1 &&
 	    boot_cpu_data.x86_stepping <= 7) {
 		if (base & ((1 << (22 - PAGE_SHIFT)) - 1)) {
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index be35a0b..85113af 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -59,10 +59,6 @@
 #define MTRR_TO_PHYS_WC_OFFSET 1000
 
 u32 num_var_ranges;
-static bool mtrr_enabled(void)
-{
-	return !!mtrr_if;
-}
 
 unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
 static DEFINE_MUTEX(mtrr_mutex);
@@ -103,21 +99,6 @@ static int have_wrcomb(void)
 	return mtrr_if->have_wrcomb ? mtrr_if->have_wrcomb() : 0;
 }
 
-/*  This function returns the number of variable MTRRs  */
-static void __init set_num_var_ranges(bool use_generic)
-{
-	unsigned long config = 0, dummy;
-
-	if (use_generic)
-		rdmsr(MSR_MTRRcap, config, dummy);
-	else if (is_cpu(AMD) || is_cpu(HYGON))
-		config = 2;
-	else if (is_cpu(CYRIX) || is_cpu(CENTAUR))
-		config = 8;
-
-	num_var_ranges = config & MTRR_CAP_VCNT;
-}
-
 static void __init init_table(void)
 {
 	int i, max;
@@ -627,6 +608,7 @@ void __init mtrr_bp_init(void)
 {
 	bool generic_mtrrs = cpu_feature_enabled(X86_FEATURE_MTRR);
 	const char *why = "(not available)";
+	unsigned long config, dummy;
 
 	phys_hi_rsvd = GENMASK(31, boot_cpu_data.x86_phys_bits - 32);
 
@@ -664,7 +646,13 @@ void __init mtrr_bp_init(void)
 	}
 
 	if (mtrr_enabled()) {
-		set_num_var_ranges(mtrr_if == &generic_mtrr_ops);
+		/* Get the number of variable MTRR ranges. */
+		if (mtrr_if == &generic_mtrr_ops)
+			rdmsr(MSR_MTRRcap, config, dummy);
+		else
+			config = mtrr_if->var_regs;
+		num_var_ranges = config & MTRR_CAP_VCNT;
+
 		init_table();
 		if (mtrr_if == &generic_mtrr_ops) {
 			/* BIOS may override */
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 59e8fb2..6f3312b 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -13,7 +13,7 @@
 extern unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
 
 struct mtrr_ops {
-	u32	vendor;
+	u32	var_regs;
 	void	(*set)(unsigned int reg, unsigned long base,
 		       unsigned long size, mtrr_type type);
 	void	(*get)(unsigned int reg, unsigned long *base,
@@ -53,8 +53,6 @@ bool get_mtrr_state(void);
 
 extern const struct mtrr_ops *mtrr_if;
 
-#define is_cpu(vnd)	(mtrr_if && mtrr_if->vendor == X86_VENDOR_##vnd)
-
 extern unsigned int num_var_ranges;
 extern u64 mtrr_tom2;
 extern struct mtrr_state_type mtrr_state;
@@ -71,3 +69,13 @@ extern const struct mtrr_ops centaur_mtrr_ops;
 
 extern int changed_by_mtrr_cleanup;
 extern int mtrr_cleanup(void);
+void generic_rebuild_map(void);
+
+/*
+ * Must be used by code which uses mtrr_if to call platform-specific
+ * MTRR manipulation functions.
+ */
+static inline bool mtrr_enabled(void)
+{
+	return !!mtrr_if;
+}
