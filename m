Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F09415B6D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Sep 2021 11:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240266AbhIWJwS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 23 Sep 2021 05:52:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33384 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240236AbhIWJwR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 23 Sep 2021 05:52:17 -0400
Date:   Thu, 23 Sep 2021 09:50:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632390645;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rywEwJu/6Villz17gwr6C1h0Nfgj1fyGX5QGAumGaU=;
        b=Kqks6I0wTMV2YmEwa0awQzL+CouPvu2frmg870QYX5ok9ZGkT0AtLmIyuIYQcVSi3db+SI
        zyDkxNbeUncaCi/I7KaU+T3Z7K5zBPMYXIWE+CAYcpNj+fIUjAaUP5u7yU3VF5uxh95gX9
        Aq0in5sunYljN9KrqIzIN3NpPlXoHHpf20yfwCn5pZQPQRP3bSNUrKfAFY8TGVXn5pawst
        fXENsoIx4YjM0KUJYan+DOQn5c7Fc4WREugMGsbYcWQcFLUGBhvJ+a6ZaKKTTdG2gFNVw8
        O4uK4ibtByysAHsAdrAuot5aAitNJ1XP3mHkE2fIVNP7i4ElJTLNBfOJ168wJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632390645;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rywEwJu/6Villz17gwr6C1h0Nfgj1fyGX5QGAumGaU=;
        b=yPpsGKkdXoRlxD3rG6/Srb7hF+TWPIQS2bPuNuITGipkf0y5/VWEK6d/rMluKVXv7QPJID
        m7EV9czLRh1bmVCQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Get rid of the mce_severity function pointer
Cc:     Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210922165101.18951-2-bp@alien8.de>
References: <20210922165101.18951-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163239064508.25758.9899050648241080401.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     631adc7b0bbaa1333fc39f0dca5e7584f51d86c9
Gitweb:        https://git.kernel.org/tip/631adc7b0bbaa1333fc39f0dca5e7584f51d86c9
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 01 Sep 2021 17:02:58 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 23 Sep 2021 11:03:51 +02:00

x86/mce: Get rid of the mce_severity function pointer

Turn it into a normal function which calls an AMD- or Intel-specific
variant depending on the CPU it runs on.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20210922165101.18951-2-bp@alien8.de
---
 arch/x86/include/asm/mce.h         |  2 --
 arch/x86/kernel/cpu/mce/core.c     |  1 -
 arch/x86/kernel/cpu/mce/internal.h |  3 +--
 arch/x86/kernel/cpu/mce/severity.c | 11 +++++------
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index da93215..258ef6d 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -205,14 +205,12 @@ struct cper_ia_proc_ctx;
 int mcheck_init(void);
 void mcheck_cpu_init(struct cpuinfo_x86 *c);
 void mcheck_cpu_clear(struct cpuinfo_x86 *c);
-void mcheck_vendor_init_severity(void);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 			       u64 lapic_id);
 #else
 static inline int mcheck_init(void) { return 0; }
 static inline void mcheck_cpu_init(struct cpuinfo_x86 *c) {}
 static inline void mcheck_cpu_clear(struct cpuinfo_x86 *c) {}
-static inline void mcheck_vendor_init_severity(void) {}
 static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 					     u64 lapic_id) { return -EINVAL; }
 #endif
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 69768fe..aaede7e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2233,7 +2233,6 @@ int __init mcheck_init(void)
 	mce_register_decode_chain(&early_nb);
 	mce_register_decode_chain(&mce_uc_nb);
 	mce_register_decode_chain(&mce_default_nb);
-	mcheck_vendor_init_severity();
 
 	INIT_WORK(&mce_work, mce_gen_pool_process);
 	init_irq_work(&mce_irq_work, mce_irq_work_cb);
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 88dcc79..09cb5ab 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -38,8 +38,7 @@ int mce_gen_pool_add(struct mce *mce);
 int mce_gen_pool_init(void);
 struct llist_node *mce_gen_pool_prepare_records(void);
 
-extern int (*mce_severity)(struct mce *a, struct pt_regs *regs,
-			   int tolerant, char **msg, bool is_excp);
+int mce_severity(struct mce *a, struct pt_regs *regs, int tolerant, char **msg, bool is_excp);
 struct dentry *mce_get_debugfs_dir(void);
 
 extern mce_banks_t mce_banks_ce_disabled;
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 17e6314..695570f 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -407,15 +407,14 @@ static int mce_severity_intel(struct mce *m, struct pt_regs *regs,
 	}
 }
 
-/* Default to mce_severity_intel */
-int (*mce_severity)(struct mce *m, struct pt_regs *regs, int tolerant, char **msg, bool is_excp) =
-		    mce_severity_intel;
-
-void __init mcheck_vendor_init_severity(void)
+int mce_severity(struct mce *m, struct pt_regs *regs, int tolerant, char **msg,
+		 bool is_excp)
 {
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
-		mce_severity = mce_severity_amd;
+		return mce_severity_amd(m, regs, tolerant, msg, is_excp);
+	else
+		return mce_severity_intel(m, regs, tolerant, msg, is_excp);
 }
 
 #ifdef CONFIG_DEBUG_FS
