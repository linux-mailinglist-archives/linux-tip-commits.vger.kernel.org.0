Return-Path: <linux-tip-commits+bounces-3157-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 453129FF3E0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 12:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7905318820D7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 11:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3B41E2317;
	Wed,  1 Jan 2025 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J9AmJFMH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1rFXZsDH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BEC14F9C4;
	Wed,  1 Jan 2025 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735731858; cv=none; b=nqX5mPodxE5yjPBAd3dUM9R0YF3gFpifkAKj1J0HPdqac4keCKPRS2MrkPf85hiaeaTZZ2XHtcedtlxynjgGxNSOBZ2VTpvf3tiwm6GiyJX54M90KteqCNhWzH0exJFiOM2XUaCf6r3IOk9agnJMUd6KiNvlJllx2QIqj3i51Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735731858; c=relaxed/simple;
	bh=e9XIL4PWLKET755KE7AIJRDtgC9Cnc/V67d5vtdbV9I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G5Vfa5utcAHB2CsQGhzB3DJFpkh/G19rryeW1qn6A02JWTLd3woSHCmYFz/mJ+4qGaOmOJnk/gwTOHOj/hR7H960mamXlynNdtZ0DJdg67+L1XVIPsNgOSJ6T8irQNzippqEoz9dMnOwYMLrj/zPNtzGYvwYb5CxHhRDzt1DQvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J9AmJFMH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1rFXZsDH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 01 Jan 2025 11:44:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735731849;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSxudBYaPaZ94VzKH6Jd4cDSb7pjx7Q3Y/ixwFem4hg=;
	b=J9AmJFMH7QGVk6BkmsdnEfvO4G8HnwmF7uhuhD92ning3drP604SBcp55DJqGzbtXtCgqJ
	ixUlBKKOSUW8XF2/KAKRo90tVyOURgvTZIu6RWQbvvqi7rRh0KpqFvqPz0X48rXZRGp0q9
	/dkA1qebPiuPeQCiwouMgYXBnS/YLKfebMSX7VjswU7xatN1C1HRj989HJW/xuyQnPbqzR
	OS5rKuF5mDO5owroItA5AuD3pvxkMUOsbo9R3yGW/Bom1iZej0CKN1uI2KQxe2/kyO2661
	HPmgkvVLIyJ6LKS65bhPiX6X9Fe7sh6d/Z2p0RWsz/ynCbeFJZpSTjSEjZhC1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735731849;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSxudBYaPaZ94VzKH6Jd4cDSb7pjx7Q3Y/ixwFem4hg=;
	b=1rFXZsDH6/+DkxC7F7LOygtWzdKU6eQ73BCnn2TR6ln6KrT7fIPLnPRJlZHuNQgkpkCrUg
	vNl9bYUVvfQGTrBw==
From: "tip-bot2 for Qiuxu Zhuo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Make four functions return bool
Cc: Thomas Gleixner <tglx@linutronix.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Sohil Mehta <sohil.mehta@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241212140103.66964-4-qiuxu.zhuo@intel.com>
References: <20241212140103.66964-4-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173573184883.399.13047165826750734423.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     c46945c9cac8437a674edb9d8fbe71511fb4acee
Gitweb:        https://git.kernel.org/tip/c46945c9cac8437a674edb9d8fbe71511fb4acee
Author:        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
AuthorDate:    Thu, 12 Dec 2024 22:00:59 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 30 Dec 2024 22:06:36 +01:00

x86/mce: Make four functions return bool

Make those functions whose callers only care about success or failure return
a boolean value for better readability. Also, update the call sites
accordingly as the polarities of all the return values have been flipped.

No functional changes.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/r/20241212140103.66964-4-qiuxu.zhuo@intel.com
---
 arch/x86/kernel/cpu/mce/core.c     | 12 ++++++------
 arch/x86/kernel/cpu/mce/genpool.c  | 29 ++++++++++++++---------------
 arch/x86/kernel/cpu/mce/internal.h |  4 ++--
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 167965b..ce6fe5e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -151,7 +151,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(injectm);
 
 void mce_log(struct mce_hw_err *err)
 {
-	if (!mce_gen_pool_add(err))
+	if (mce_gen_pool_add(err))
 		irq_work_queue(&mce_irq_work);
 }
 EXPORT_SYMBOL_GPL(mce_log);
@@ -1911,14 +1911,14 @@ static void __mcheck_cpu_check_banks(void)
 }
 
 /* Add per CPU specific workarounds here */
-static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
+static bool __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	struct mca_config *cfg = &mca_cfg;
 
 	if (c->x86_vendor == X86_VENDOR_UNKNOWN) {
 		pr_info("unknown CPU type - not enabling MCE support\n");
-		return -EOPNOTSUPP;
+		return false;
 	}
 
 	/* This should be disabled by the BIOS, but isn't always */
@@ -2012,7 +2012,7 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 	if (cfg->bootlog != 0)
 		cfg->panic_timeout = 30;
 
-	return 0;
+	return true;
 }
 
 static bool __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
@@ -2279,12 +2279,12 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
 	__mcheck_cpu_cap_init();
 
-	if (__mcheck_cpu_apply_quirks(c) < 0) {
+	if (!__mcheck_cpu_apply_quirks(c)) {
 		mca_cfg.disabled = 1;
 		return;
 	}
 
-	if (mce_gen_pool_init()) {
+	if (!mce_gen_pool_init()) {
 		mca_cfg.disabled = 1;
 		pr_emerg("Couldn't allocate MCE records pool!\n");
 		return;
diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
index d0be6dd..3ca9c00 100644
--- a/arch/x86/kernel/cpu/mce/genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -94,64 +94,63 @@ bool mce_gen_pool_empty(void)
 	return llist_empty(&mce_event_llist);
 }
 
-int mce_gen_pool_add(struct mce_hw_err *err)
+bool mce_gen_pool_add(struct mce_hw_err *err)
 {
 	struct mce_evt_llist *node;
 
 	if (filter_mce(&err->m))
-		return -EINVAL;
+		return false;
 
 	if (!mce_evt_pool)
-		return -EINVAL;
+		return false;
 
 	node = (void *)gen_pool_alloc(mce_evt_pool, sizeof(*node));
 	if (!node) {
 		pr_warn_ratelimited("MCE records pool full!\n");
-		return -ENOMEM;
+		return false;
 	}
 
 	memcpy(&node->err, err, sizeof(*err));
 	llist_add(&node->llnode, &mce_event_llist);
 
-	return 0;
+	return true;
 }
 
-static int mce_gen_pool_create(void)
+static bool mce_gen_pool_create(void)
 {
 	int mce_numrecords, mce_poolsz, order;
 	struct gen_pool *gpool;
-	int ret = -ENOMEM;
 	void *mce_pool;
 
 	order = order_base_2(sizeof(struct mce_evt_llist));
 	gpool = gen_pool_create(order, -1);
 	if (!gpool)
-		return ret;
+		return false;
 
 	mce_numrecords = max(MCE_MIN_ENTRIES, num_possible_cpus() * MCE_PER_CPU);
 	mce_poolsz = mce_numrecords * (1 << order);
 	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
 	if (!mce_pool) {
 		gen_pool_destroy(gpool);
-		return ret;
+		return false;
 	}
-	ret = gen_pool_add(gpool, (unsigned long)mce_pool, mce_poolsz, -1);
-	if (ret) {
+
+	if (gen_pool_add(gpool, (unsigned long)mce_pool, mce_poolsz, -1)) {
 		gen_pool_destroy(gpool);
 		kfree(mce_pool);
-		return ret;
+		return false;
 	}
 
 	mce_evt_pool = gpool;
 
-	return ret;
+	return true;
 }
 
-int mce_gen_pool_init(void)
+bool mce_gen_pool_init(void)
 {
 	/* Just init mce_gen_pool once. */
 	if (mce_evt_pool)
-		return 0;
+		return true;
 
 	return mce_gen_pool_create();
 }
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 84f8105..95a504e 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -31,8 +31,8 @@ struct mce_evt_llist {
 
 void mce_gen_pool_process(struct work_struct *__unused);
 bool mce_gen_pool_empty(void);
-int mce_gen_pool_add(struct mce_hw_err *err);
-int mce_gen_pool_init(void);
+bool mce_gen_pool_add(struct mce_hw_err *err);
+bool mce_gen_pool_init(void);
 struct llist_node *mce_gen_pool_prepare_records(void);
 
 int mce_severity(struct mce *a, struct pt_regs *regs, char **msg, bool is_excp);

