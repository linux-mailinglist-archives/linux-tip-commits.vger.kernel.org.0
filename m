Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94EE285C44
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 12:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgJGKC7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 06:02:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42490 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgJGKCz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 06:02:55 -0400
Date:   Wed, 07 Oct 2020 10:02:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602064970;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=riLdBaO95GUtY+rIYHaE/OtFG3gC2cFpto4ZfTkEp8M=;
        b=LTkNV99psj4qDzH3cdwPdgeMheu+i5niiYF5/GVBtczns+Kabmsjwm9wtAS8y4c1D5WXMS
        L2mqIDKxFANoFm+s32F7zDV9L0OkyAw7ct4xOsj9UbZbUNoTZdlbgQXGnrKFhiI924KJ4o
        coN2PNBV1bIZOogKEIHpDnWgFibZUv86ya/cvDZsxLefwrpvB+wAsDWhbW42eU1RQUjxIY
        DNqmr7qCqNsdtT78WXDockQN4ZLjIdypBSFq+AyaktgqN/fUAlGyZwORzPIOofpQe+qZfH
        OufFYOGiNKygZSwrcNprXu58IQNFTyxTUik6LtitIKIlSbzXGW9GqByLUntKew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602064970;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=riLdBaO95GUtY+rIYHaE/OtFG3gC2cFpto4ZfTkEp8M=;
        b=7twofwbmqgSHhm9jKTCFNBh4xW0GacN6HqtbWYs8y1bRn/qV++EWQMcB7Xw5PoMPGQSF2B
        TXm2kiWUPd6UWrAw==
From:   "tip-bot2 for Youquan Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Pass pointer to saved pt_regs to severity
 calculation routines
Cc:     Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201006210910.21062-2-tony.luck@intel.com>
References: <20201006210910.21062-2-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <160206497010.7002.2644133691361653911.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     41ce0564bfe2e129d56730418d8c0a9f9f2d31b5
Gitweb:        https://git.kernel.org/tip/41ce0564bfe2e129d56730418d8c0a9f9f2d31b5
Author:        Youquan Song <youquan.song@intel.com>
AuthorDate:    Tue, 06 Oct 2020 14:09:05 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 07 Oct 2020 10:51:42 +02:00

x86/mce: Pass pointer to saved pt_regs to severity calculation routines

New recovery features require additional information about processor
state when a machine check occurred. Pass pt_regs down to the routines
that need it.

No functional change.

Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201006210910.21062-2-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/core.c     | 14 +++++++-------
 arch/x86/kernel/cpu/mce/internal.h |  3 ++-
 arch/x86/kernel/cpu/mce/severity.c | 14 ++++++++------
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b5b70f4..2d6caf0 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -807,7 +807,7 @@ log_it:
 			goto clear_it;
 
 		mce_read_aux(&m, i);
-		m.severity = mce_severity(&m, mca_cfg.tolerant, NULL, false);
+		m.severity = mce_severity(&m, NULL, mca_cfg.tolerant, NULL, false);
 		/*
 		 * Don't get the IP here because it's unlikely to
 		 * have anything to do with the actual error location.
@@ -856,7 +856,7 @@ static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 			quirk_no_way_out(i, m, regs);
 
 		m->bank = i;
-		if (mce_severity(m, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
+		if (mce_severity(m, regs, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
 			mce_read_aux(m, i);
 			*msg = tmp;
 			return 1;
@@ -956,7 +956,7 @@ static void mce_reign(void)
 	 */
 	if (m && global_worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
 		/* call mce_severity() to get "msg" for panic */
-		mce_severity(m, mca_cfg.tolerant, &msg, true);
+		mce_severity(m, NULL, mca_cfg.tolerant, &msg, true);
 		mce_panic("Fatal machine check", m, msg);
 	}
 
@@ -1167,7 +1167,7 @@ static noinstr bool mce_check_crashing_cpu(void)
 	return false;
 }
 
-static void __mc_scan_banks(struct mce *m, struct mce *final,
+static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
 			    unsigned long *toclear, unsigned long *valid_banks,
 			    int no_way_out, int *worst)
 {
@@ -1202,7 +1202,7 @@ static void __mc_scan_banks(struct mce *m, struct mce *final,
 		/* Set taint even when machine check was not enabled. */
 		add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
 
-		severity = mce_severity(m, cfg->tolerant, NULL, true);
+		severity = mce_severity(m, regs, cfg->tolerant, NULL, true);
 
 		/*
 		 * When machine check was for corrected/deferred handler don't
@@ -1354,7 +1354,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		order = mce_start(&no_way_out);
 	}
 
-	__mc_scan_banks(&m, final, toclear, valid_banks, no_way_out, &worst);
+	__mc_scan_banks(&m, regs, final, toclear, valid_banks, no_way_out, &worst);
 
 	if (!no_way_out)
 		mce_clear_state(toclear);
@@ -1376,7 +1376,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		 * make sure we have the right "msg".
 		 */
 		if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
-			mce_severity(&m, cfg->tolerant, &msg, true);
+			mce_severity(&m, regs, cfg->tolerant, &msg, true);
 			mce_panic("Local fatal machine check!", &m, msg);
 		}
 	}
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index b122610..88dcc79 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -38,7 +38,8 @@ int mce_gen_pool_add(struct mce *mce);
 int mce_gen_pool_init(void);
 struct llist_node *mce_gen_pool_prepare_records(void);
 
-extern int (*mce_severity)(struct mce *a, int tolerant, char **msg, bool is_excp);
+extern int (*mce_severity)(struct mce *a, struct pt_regs *regs,
+			   int tolerant, char **msg, bool is_excp);
 struct dentry *mce_get_debugfs_dir(void);
 
 extern mce_banks_t mce_banks_ce_disabled;
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index e072246..0b072dc 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -223,7 +223,7 @@ static struct severity {
  * distinguish an exception taken in user from from one
  * taken in the kernel.
  */
-static int error_context(struct mce *m)
+static int error_context(struct mce *m, struct pt_regs *regs)
 {
 	if ((m->cs & 3) == 3)
 		return IN_USER;
@@ -267,9 +267,10 @@ static int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
  * See AMD Error Scope Hierarchy table in a newer BKDG. For example
  * 49125_15h_Models_30h-3Fh_BKDG.pdf, section "RAS Features"
  */
-static int mce_severity_amd(struct mce *m, int tolerant, char **msg, bool is_excp)
+static int mce_severity_amd(struct mce *m, struct pt_regs *regs, int tolerant,
+			    char **msg, bool is_excp)
 {
-	enum context ctx = error_context(m);
+	enum context ctx = error_context(m, regs);
 
 	/* Processor Context Corrupt, no need to fumble too much, die! */
 	if (m->status & MCI_STATUS_PCC)
@@ -319,10 +320,11 @@ static int mce_severity_amd(struct mce *m, int tolerant, char **msg, bool is_exc
 	return MCE_KEEP_SEVERITY;
 }
 
-static int mce_severity_intel(struct mce *m, int tolerant, char **msg, bool is_excp)
+static int mce_severity_intel(struct mce *m, struct pt_regs *regs,
+			      int tolerant, char **msg, bool is_excp)
 {
 	enum exception excp = (is_excp ? EXCP_CONTEXT : NO_EXCP);
-	enum context ctx = error_context(m);
+	enum context ctx = error_context(m, regs);
 	struct severity *s;
 
 	for (s = severities;; s++) {
@@ -356,7 +358,7 @@ static int mce_severity_intel(struct mce *m, int tolerant, char **msg, bool is_e
 }
 
 /* Default to mce_severity_intel */
-int (*mce_severity)(struct mce *m, int tolerant, char **msg, bool is_excp) =
+int (*mce_severity)(struct mce *m, struct pt_regs *regs, int tolerant, char **msg, bool is_excp) =
 		    mce_severity_intel;
 
 void __init mcheck_vendor_init_severity(void)
