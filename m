Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2839A3AEB98
	for <lists+linux-tip-commits@lfdr.de>; Mon, 21 Jun 2021 16:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFUOog (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 21 Jun 2021 10:44:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45004 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhFUOod (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 21 Jun 2021 10:44:33 -0400
Date:   Mon, 21 Jun 2021 14:42:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624286538;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1jclmzBllcw8bzNFa8bMNF4hYdUQIOqaIoozcbdFGNU=;
        b=CluIbifbZxt3w3wsBlqxNf23zb8Gbc1Jwr4zujV920TTxAOgwYNS6Cue+9EAzOSD6ffRJD
        Coi6DrbxfE/g1iFSW06Bl6Nv+Qdpll2nAnN/8fv7zEM/gBiXnmD95meMSurbWbl1fF9EkT
        Um+IPl9EU9lv4BXDQQRJW7UN/zLcR0fKgrB6Iv4u4nWF+59oKl76ZAN+q+4tDuFdLCgidx
        WLc3LEiaYtfLwSi26OabaerZNodwiGYg+vuvAoXnTf+HpqqZwQBxliPCG2aYV0tRlNFiUI
        gY0H7+hvFYegkP93CeAnRmJEUZOvSBtrzMOsWojSYdYKAnWo+1bGCl+2bsewqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624286538;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1jclmzBllcw8bzNFa8bMNF4hYdUQIOqaIoozcbdFGNU=;
        b=vm2WrezaK/AhcPdC/zCFbVU6NM/5XP/7lMeiHNXxQmVoANtiFkEa2ZS0rjzdx3Ft9DlcWT
        xlOT0T6vmOOJNbDg==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Make sure IRQs are disabled while GHCB is active
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210618115409.22735-2-joro@8bytes.org>
References: <20210618115409.22735-2-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <162428653742.395.7127618778032460713.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     d187f217335dba2b49fc9002aab2004e04acddee
Gitweb:        https://git.kernel.org/tip/d187f217335dba2b49fc9002aab2004e04acddee
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Fri, 18 Jun 2021 13:54:08 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 21 Jun 2021 15:51:21 +02:00

x86/sev: Make sure IRQs are disabled while GHCB is active

The #VC handler only cares about IRQs being disabled while the GHCB is
active, as it must not be interrupted by something which could cause
another #VC while it holds the GHCB (NMI is the exception for which the
backup GHCB exits).

Make sure nothing interrupts the code path while the GHCB is active
by making sure that callers of __sev_{get,put}_ghcb() have disabled
interrupts upfront.

 [ bp: Massage commit message. ]

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210618115409.22735-2-joro@8bytes.org
---
 arch/x86/kernel/sev.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 8178db0..9f32cbb 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -12,7 +12,6 @@
 #include <linux/sched/debug.h>	/* For show_regs() */
 #include <linux/percpu-defs.h>
 #include <linux/mem_encrypt.h>
-#include <linux/lockdep.h>
 #include <linux/printk.h>
 #include <linux/mm_types.h>
 #include <linux/set_memory.h>
@@ -192,11 +191,19 @@ void noinstr __sev_es_ist_exit(void)
 	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *(unsigned long *)ist);
 }
 
-static __always_inline struct ghcb *sev_es_get_ghcb(struct ghcb_state *state)
+/*
+ * Nothing shall interrupt this code path while holding the per-CPU
+ * GHCB. The backup GHCB is only for NMIs interrupting this path.
+ *
+ * Callers must disable local interrupts around it.
+ */
+static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
 {
 	struct sev_es_runtime_data *data;
 	struct ghcb *ghcb;
 
+	WARN_ON(!irqs_disabled());
+
 	data = this_cpu_read(runtime_data);
 	ghcb = &data->ghcb_page;
 
@@ -213,7 +220,9 @@ static __always_inline struct ghcb *sev_es_get_ghcb(struct ghcb_state *state)
 			data->ghcb_active        = false;
 			data->backup_ghcb_active = false;
 
+			instrumentation_begin();
 			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
+			instrumentation_end();
 		}
 
 		/* Mark backup_ghcb active before writing to it */
@@ -486,11 +495,13 @@ static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt 
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
 
-static __always_inline void sev_es_put_ghcb(struct ghcb_state *state)
+static noinstr void __sev_put_ghcb(struct ghcb_state *state)
 {
 	struct sev_es_runtime_data *data;
 	struct ghcb *ghcb;
 
+	WARN_ON(!irqs_disabled());
+
 	data = this_cpu_read(runtime_data);
 	ghcb = &data->ghcb_page;
 
@@ -514,7 +525,7 @@ void noinstr __sev_es_nmi_complete(void)
 	struct ghcb_state state;
 	struct ghcb *ghcb;
 
-	ghcb = sev_es_get_ghcb(&state);
+	ghcb = __sev_get_ghcb(&state);
 
 	vc_ghcb_invalidate(ghcb);
 	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_NMI_COMPLETE);
@@ -524,7 +535,7 @@ void noinstr __sev_es_nmi_complete(void)
 	sev_es_wr_ghcb_msr(__pa_nodebug(ghcb));
 	VMGEXIT();
 
-	sev_es_put_ghcb(&state);
+	__sev_put_ghcb(&state);
 }
 
 static u64 get_jump_table_addr(void)
@@ -536,7 +547,7 @@ static u64 get_jump_table_addr(void)
 
 	local_irq_save(flags);
 
-	ghcb = sev_es_get_ghcb(&state);
+	ghcb = __sev_get_ghcb(&state);
 
 	vc_ghcb_invalidate(ghcb);
 	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_JUMP_TABLE);
@@ -550,7 +561,7 @@ static u64 get_jump_table_addr(void)
 	    ghcb_sw_exit_info_2_is_valid(ghcb))
 		ret = ghcb->save.sw_exit_info_2;
 
-	sev_es_put_ghcb(&state);
+	__sev_put_ghcb(&state);
 
 	local_irq_restore(flags);
 
@@ -675,7 +686,7 @@ static void sev_es_ap_hlt_loop(void)
 	struct ghcb_state state;
 	struct ghcb *ghcb;
 
-	ghcb = sev_es_get_ghcb(&state);
+	ghcb = __sev_get_ghcb(&state);
 
 	while (true) {
 		vc_ghcb_invalidate(ghcb);
@@ -692,7 +703,7 @@ static void sev_es_ap_hlt_loop(void)
 			break;
 	}
 
-	sev_es_put_ghcb(&state);
+	__sev_put_ghcb(&state);
 }
 
 /*
@@ -1351,7 +1362,6 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
 	}
 
 	irq_state = irqentry_nmi_enter(regs);
-	lockdep_assert_irqs_disabled();
 	instrumentation_begin();
 
 	/*
@@ -1360,7 +1370,7 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
 	 * keep the IRQs disabled to protect us against concurrent TLB flushes.
 	 */
 
-	ghcb = sev_es_get_ghcb(&state);
+	ghcb = __sev_get_ghcb(&state);
 
 	vc_ghcb_invalidate(ghcb);
 	result = vc_init_em_ctxt(&ctxt, regs, error_code);
@@ -1368,7 +1378,7 @@ DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
 	if (result == ES_OK)
 		result = vc_handle_exitcode(&ctxt, ghcb, error_code);
 
-	sev_es_put_ghcb(&state);
+	__sev_put_ghcb(&state);
 
 	/* Done - now check the result */
 	switch (result) {
