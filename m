Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D0E455E24
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Nov 2021 15:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhKROhx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Nov 2021 09:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbhKROhs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Nov 2021 09:37:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F22C06175A;
        Thu, 18 Nov 2021 06:34:48 -0800 (PST)
Date:   Thu, 18 Nov 2021 14:34:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637246087;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+fbbAtm1rglRh6S61+pIOwf8UKIATEq5YrJkI7qVP2M=;
        b=F7XrKEK+cgwViHyqJO88jhLGobYmn2JYTKWq6AZQS07SVvEoULurnLBz5x/lD/tITNHRm2
        ULbTyP29BWenncn89CqyGzj66/RLWLiKoju3yHkTKMSGFhGZhoEWTS4xIA4YT74dkHHnwi
        gCLHWVmXSZ5qhYHWZFJuBpo+ghWuhdRQH0hn4QSacYO/U22H60LaDKSn7i7AxnxOT6Kgrh
        F8VbO1LOjrr7HJujyfdZtkray+mehQbZO065SIPTzt8C6io5P9/I0LeU5CzAtmN/4r5BUh
        tawmhL5LUjaSyiIL8eSIXSdlspdEbt/qaQedVQBtEGM+cpeiwKxU19EWdy2IKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637246087;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+fbbAtm1rglRh6S61+pIOwf8UKIATEq5YrJkI7qVP2M=;
        b=oQcB0UzRjtP/ZG2qByiTlsncCA7td+Tq1mX4Tl+7aJ/gToSLERi0pepJlhAKm99ZNwOMdh
        Mcnvqkujh6FmX7Bw==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Drop dead and useless guest "support" from
 arm, csky, nds32 and riscv
Cc:     Sean Christopherson <seanjc@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211111020738.2512932-6-seanjc@google.com>
References: <20211111020738.2512932-6-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <163724608603.11128.4046784125119581710.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     84af21d850ee1ccc990df37dd47c13fdfe93be75
Gitweb:        https://git.kernel.org/tip/84af21d850ee1ccc990df37dd47c13fdfe93be75
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 11 Nov 2021 02:07:26 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Nov 2021 14:49:07 +01:00

perf: Drop dead and useless guest "support" from arm, csky, nds32 and riscv

Drop "support" for guest callbacks from architectures that don't implement
the guest callbacks.  Future patches will convert the callbacks to
static_call; rather than churn a bunch of arch code (that was presumably
copy+pasted from x86), remove it wholesale as it's useless and at best
wasting cycles.

A future patch will also add a Kconfig to force architcture to opt into
the callbacks to make it more difficult for uses "support" to sneak in in
the future.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20211111020738.2512932-6-seanjc@google.com
---
 arch/arm/kernel/perf_callchain.c   | 33 +++-------------------------
 arch/csky/kernel/perf_callchain.c  | 12 +----------
 arch/nds32/kernel/perf_event_cpu.c | 34 +++--------------------------
 arch/riscv/kernel/perf_callchain.c | 13 +-----------
 4 files changed, 8 insertions(+), 84 deletions(-)

diff --git a/arch/arm/kernel/perf_callchain.c b/arch/arm/kernel/perf_callchain.c
index 1626dfc..bc6b246 100644
--- a/arch/arm/kernel/perf_callchain.c
+++ b/arch/arm/kernel/perf_callchain.c
@@ -62,14 +62,8 @@ user_backtrace(struct frame_tail __user *tail,
 void
 perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
 {
-	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	struct frame_tail __user *tail;
 
-	if (guest_cbs && guest_cbs->is_in_guest()) {
-		/* We don't support guest os callchain now */
-		return;
-	}
-
 	perf_callchain_store(entry, regs->ARM_pc);
 
 	if (!current->mm)
@@ -99,44 +93,25 @@ callchain_trace(struct stackframe *fr,
 void
 perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
 {
-	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	struct stackframe fr;
 
-	if (guest_cbs && guest_cbs->is_in_guest()) {
-		/* We don't support guest os callchain now */
-		return;
-	}
-
 	arm_get_current_stackframe(regs, &fr);
 	walk_stackframe(&fr, callchain_trace, entry);
 }
 
 unsigned long perf_instruction_pointer(struct pt_regs *regs)
 {
-	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
-
-	if (guest_cbs && guest_cbs->is_in_guest())
-		return guest_cbs->get_guest_ip();
-
 	return instruction_pointer(regs);
 }
 
 unsigned long perf_misc_flags(struct pt_regs *regs)
 {
-	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	int misc = 0;
 
-	if (guest_cbs && guest_cbs->is_in_guest()) {
-		if (guest_cbs->is_user_mode())
-			misc |= PERF_RECORD_MISC_GUEST_USER;
-		else
-			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
-	} else {
-		if (user_mode(regs))
-			misc |= PERF_RECORD_MISC_USER;
-		else
-			misc |= PERF_RECORD_MISC_KERNEL;
-	}
+	if (user_mode(regs))
+		misc |= PERF_RECORD_MISC_USER;
+	else
+		misc |= PERF_RECORD_MISC_KERNEL;
 
 	return misc;
 }
diff --git a/arch/csky/kernel/perf_callchain.c b/arch/csky/kernel/perf_callchain.c
index 35318a6..92057de 100644
--- a/arch/csky/kernel/perf_callchain.c
+++ b/arch/csky/kernel/perf_callchain.c
@@ -86,13 +86,8 @@ static unsigned long user_backtrace(struct perf_callchain_entry_ctx *entry,
 void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 			 struct pt_regs *regs)
 {
-	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	unsigned long fp = 0;
 
-	/* C-SKY does not support virtualization. */
-	if (guest_cbs && guest_cbs->is_in_guest())
-		return;
-
 	fp = regs->regs[4];
 	perf_callchain_store(entry, regs->pc);
 
@@ -111,15 +106,8 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 			   struct pt_regs *regs)
 {
-	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	struct stackframe fr;
 
-	/* C-SKY does not support virtualization. */
-	if (guest_cbs && guest_cbs->is_in_guest()) {
-		pr_warn("C-SKY does not support perf in guest mode!");
-		return;
-	}
-
 	fr.fp = regs->regs[4];
 	fr.lr = regs->lr;
 	walk_stackframe(&fr, entry);
diff --git a/arch/nds32/kernel/perf_event_cpu.c b/arch/nds32/kernel/perf_event_cpu.c
index f387919..a78a879 100644
--- a/arch/nds32/kernel/perf_event_cpu.c
+++ b/arch/nds32/kernel/perf_event_cpu.c
@@ -1363,7 +1363,6 @@ void
 perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 		    struct pt_regs *regs)
 {
-	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	unsigned long fp = 0;
 	unsigned long gp = 0;
 	unsigned long lp = 0;
@@ -1372,11 +1371,6 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 
 	leaf_fp = 0;
 
-	if (guest_cbs && guest_cbs->is_in_guest()) {
-		/* We don't support guest os callchain now */
-		return;
-	}
-
 	perf_callchain_store(entry, regs->ipc);
 	fp = regs->fp;
 	gp = regs->gp;
@@ -1480,13 +1474,8 @@ void
 perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 		      struct pt_regs *regs)
 {
-	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	struct stackframe fr;
 
-	if (guest_cbs && guest_cbs->is_in_guest()) {
-		/* We don't support guest os callchain now */
-		return;
-	}
 	fr.fp = regs->fp;
 	fr.lp = regs->lp;
 	fr.sp = regs->sp;
@@ -1495,32 +1484,17 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 
 unsigned long perf_instruction_pointer(struct pt_regs *regs)
 {
-	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
-
-	/* However, NDS32 does not support virtualization */
-	if (guest_cbs && guest_cbs->is_in_guest())
-		return guest_cbs->get_guest_ip();
-
 	return instruction_pointer(regs);
 }
 
 unsigned long perf_misc_flags(struct pt_regs *regs)
 {
-	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	int misc = 0;
 
-	/* However, NDS32 does not support virtualization */
-	if (guest_cbs && guest_cbs->is_in_guest()) {
-		if (guest_cbs->is_user_mode())
-			misc |= PERF_RECORD_MISC_GUEST_USER;
-		else
-			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
-	} else {
-		if (user_mode(regs))
-			misc |= PERF_RECORD_MISC_USER;
-		else
-			misc |= PERF_RECORD_MISC_KERNEL;
-	}
+	if (user_mode(regs))
+		misc |= PERF_RECORD_MISC_USER;
+	else
+		misc |= PERF_RECORD_MISC_KERNEL;
 
 	return misc;
 }
diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
index 8ecfc4c..1fc075b 100644
--- a/arch/riscv/kernel/perf_callchain.c
+++ b/arch/riscv/kernel/perf_callchain.c
@@ -56,13 +56,8 @@ static unsigned long user_backtrace(struct perf_callchain_entry_ctx *entry,
 void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 			 struct pt_regs *regs)
 {
-	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	unsigned long fp = 0;
 
-	/* RISC-V does not support perf in guest mode. */
-	if (guest_cbs && guest_cbs->is_in_guest())
-		return;
-
 	fp = regs->s0;
 	perf_callchain_store(entry, regs->epc);
 
@@ -79,13 +74,5 @@ static bool fill_callchain(void *entry, unsigned long pc)
 void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 			   struct pt_regs *regs)
 {
-	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
-
-	/* RISC-V does not support perf in guest mode. */
-	if (guest_cbs && guest_cbs->is_in_guest()) {
-		pr_warn("RISC-V does not support perf in guest mode!");
-		return;
-	}
-
 	walk_stackframe(NULL, regs, fill_callchain, entry);
 }
