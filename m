Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B66415B68
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Sep 2021 11:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240222AbhIWJwQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 23 Sep 2021 05:52:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33376 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbhIWJwP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 23 Sep 2021 05:52:15 -0400
Date:   Thu, 23 Sep 2021 09:50:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632390642;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4LIGTXUtJ8rbfo6EEIvZlo8xLwxJXlE9D6bX4WK1McQ=;
        b=crSsnaj8fV4CJxCVqC6K6H4SFQZNDaK01OkwwhSIlzmxxTb6YadieF6HZw8O0HNvzk8Yd2
        iRsXYyD4Mz+blrvklIQOKIakaT0VnJPYVEeXjtpL+85j/1I7UqikNgG53CZ9Egn0SX2VKm
        0P8sHhP062ipeXgSSmqzzDb5FPSabA/u1GfFaz+9YhcLHkR6R9TuJM+eI8PKK+rqfgUuPq
        hRjY6fM/75uvtfaN8HELlsZLiTRP6gVN2I1hIHlD6hbljgzoDyQbqJhgd12iwdIyGskuZ2
        iOTBuzYYz/Q3yza+QxmVSei8vwBVzLPt/XOEDP/4TocfUfSqU+RtTP7vby9pcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632390642;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4LIGTXUtJ8rbfo6EEIvZlo8xLwxJXlE9D6bX4WK1McQ=;
        b=9Qf1ksTxLdP8jUbYuI9rL+mfBItQ97sq9FCyYi2pjzkhplEi63sQwRLJE6Vvn1kzSQBlwe
        tV5peYfjs9e0mpAQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Get rid of the ->quirk_no_way_out() indirect call
Cc:     Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210922165101.18951-5-bp@alien8.de>
References: <20210922165101.18951-5-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163239064200.25758.9257752647179158299.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     cc466666ab0920acfa879326ed9f7ef555323261
Gitweb:        https://git.kernel.org/tip/cc466666ab0920acfa879326ed9f7ef555323261
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Thu, 02 Sep 2021 20:23:00 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 23 Sep 2021 11:34:49 +02:00

x86/mce: Get rid of the ->quirk_no_way_out() indirect call

Use a flag setting to call the only quirk function for that.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20210922165101.18951-5-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/core.c     | 64 ++++++++++++++---------------
 arch/x86/kernel/cpu/mce/internal.h |  5 +-
 2 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 8e766b2..50a3e45 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -121,8 +121,6 @@ mce_banks_t mce_banks_ce_disabled;
 static struct work_struct mce_work;
 static struct irq_work mce_irq_work;
 
-static void (*quirk_no_way_out)(int bank, struct mce *m, struct pt_regs *regs);
-
 /*
  * CPU/chipset specific EDAC code can register a notifier call here to print
  * MCE errors in a human-readable form.
@@ -815,6 +813,34 @@ clear_it:
 EXPORT_SYMBOL_GPL(machine_check_poll);
 
 /*
+ * During IFU recovery Sandy Bridge -EP4S processors set the RIPV and
+ * EIPV bits in MCG_STATUS to zero on the affected logical processor (SDM
+ * Vol 3B Table 15-20). But this confuses both the code that determines
+ * whether the machine check occurred in kernel or user mode, and also
+ * the severity assessment code. Pretend that EIPV was set, and take the
+ * ip/cs values from the pt_regs that mce_gather_info() ignored earlier.
+ */
+static void quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
+{
+	if (bank != 0)
+		return;
+	if ((m->mcgstatus & (MCG_STATUS_EIPV|MCG_STATUS_RIPV)) != 0)
+		return;
+	if ((m->status & (MCI_STATUS_OVER|MCI_STATUS_UC|
+		          MCI_STATUS_EN|MCI_STATUS_MISCV|MCI_STATUS_ADDRV|
+			  MCI_STATUS_PCC|MCI_STATUS_S|MCI_STATUS_AR|
+			  MCACOD)) !=
+			 (MCI_STATUS_UC|MCI_STATUS_EN|
+			  MCI_STATUS_MISCV|MCI_STATUS_ADDRV|MCI_STATUS_S|
+			  MCI_STATUS_AR|MCACOD_INSTR))
+		return;
+
+	m->mcgstatus |= MCG_STATUS_EIPV;
+	m->ip = regs->ip;
+	m->cs = regs->cs;
+}
+
+/*
  * Do a quick check if any of the events requires a panic.
  * This decides if we keep the events around or clear them.
  */
@@ -830,8 +856,8 @@ static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 			continue;
 
 		__set_bit(i, validp);
-		if (quirk_no_way_out)
-			quirk_no_way_out(i, m, regs);
+		if (mce_flags.snb_ifu_quirk)
+			quirk_sandybridge_ifu(i, m, regs);
 
 		m->bank = i;
 		if (mce_severity(m, regs, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
@@ -1714,34 +1740,6 @@ static void __mcheck_cpu_check_banks(void)
 	}
 }
 
-/*
- * During IFU recovery Sandy Bridge -EP4S processors set the RIPV and
- * EIPV bits in MCG_STATUS to zero on the affected logical processor (SDM
- * Vol 3B Table 15-20). But this confuses both the code that determines
- * whether the machine check occurred in kernel or user mode, and also
- * the severity assessment code. Pretend that EIPV was set, and take the
- * ip/cs values from the pt_regs that mce_gather_info() ignored earlier.
- */
-static void quirk_sandybridge_ifu(int bank, struct mce *m, struct pt_regs *regs)
-{
-	if (bank != 0)
-		return;
-	if ((m->mcgstatus & (MCG_STATUS_EIPV|MCG_STATUS_RIPV)) != 0)
-		return;
-	if ((m->status & (MCI_STATUS_OVER|MCI_STATUS_UC|
-		          MCI_STATUS_EN|MCI_STATUS_MISCV|MCI_STATUS_ADDRV|
-			  MCI_STATUS_PCC|MCI_STATUS_S|MCI_STATUS_AR|
-			  MCACOD)) !=
-			 (MCI_STATUS_UC|MCI_STATUS_EN|
-			  MCI_STATUS_MISCV|MCI_STATUS_ADDRV|MCI_STATUS_S|
-			  MCI_STATUS_AR|MCACOD_INSTR))
-		return;
-
-	m->mcgstatus |= MCG_STATUS_EIPV;
-	m->ip = regs->ip;
-	m->cs = regs->cs;
-}
-
 /* Add per CPU specific workarounds here */
 static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 {
@@ -1815,7 +1813,7 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 			cfg->bootlog = 0;
 
 		if (c->x86 == 6 && c->x86_model == 45)
-			quirk_no_way_out = quirk_sandybridge_ifu;
+			mce_flags.snb_ifu_quirk = 1;
 	}
 
 	if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 1ad7b4b..2186554 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -167,7 +167,10 @@ struct mce_vendor_flags {
 	/* Centaur Winchip C6-style MCA */
 	winchip			: 1,
 
-	__reserved_0		: 58;
+	/* SandyBridge IFU quirk */
+	snb_ifu_quirk		: 1,
+
+	__reserved_0		: 57;
 };
 
 extern struct mce_vendor_flags mce_flags;
