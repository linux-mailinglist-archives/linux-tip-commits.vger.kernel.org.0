Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5ED7455E28
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Nov 2021 15:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhKROhz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Nov 2021 09:37:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39270 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbhKROhv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Nov 2021 09:37:51 -0500
Date:   Thu, 18 Nov 2021 14:34:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637246090;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0+9ZxI6rrW6S5dBvGcZdGFUmHBNl/6rVf4LP3WZWBA=;
        b=xZGu7NaCLfkdHl/FBDjXQo4bvWH8sCG+ZVBgFVzwdlEyU0ChAuaGjh3dE5mSx6G4Bdm9Z0
        Wmu93J0fij2ugj7lZ+8Isk7wCPxkBW1kjJARC6IKgpnX6OJueQJ+S2f0X/+aC5lUsc8B9W
        ltJm6x9k0REDYQ/+N/F7+D9hKxKuGbnYmp1wfl215zM87tzoLgG2ZDXSuJxRsn2qypGglB
        nsCayEObmeOtK6HzLWo+50R+kvi8/gPn/pgyx9PKgA2u8AKUquMu1yAf75h2OsAiMLjCkq
        kp4fMbiRr7+SbVWHMxxLUTUTn+x1zcMR3rspziPHYkCmOLCbBnKtFb62/1yD8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637246090;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0+9ZxI6rrW6S5dBvGcZdGFUmHBNl/6rVf4LP3WZWBA=;
        b=MPDxNC0b+Of7zbnkoIWHvUP4+b83EGVg+IkMBSPM8m1sdmvsGCPi2BwtP4MW8PYWUh09OG
        HpBegOtDa4wWQ7Ag==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Protect perf_guest_cbs with RCU
Cc:     Sean Christopherson <seanjc@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211111020738.2512932-2-seanjc@google.com>
References: <20211111020738.2512932-2-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <163724608893.11128.11338922499355839017.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ff083a2d972f56bebfd82409ca62e5dfce950961
Gitweb:        https://git.kernel.org/tip/ff083a2d972f56bebfd82409ca62e5dfce950961
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 11 Nov 2021 02:07:22 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Nov 2021 14:49:06 +01:00

perf: Protect perf_guest_cbs with RCU

Protect perf_guest_cbs with RCU to fix multiple possible errors.  Luckily,
all paths that read perf_guest_cbs already require RCU protection, e.g. to
protect the callback chains, so only the direct perf_guest_cbs touchpoints
need to be modified.

Bug #1 is a simple lack of WRITE_ONCE/READ_ONCE behavior to ensure
perf_guest_cbs isn't reloaded between a !NULL check and a dereference.
Fixed via the READ_ONCE() in rcu_dereference().

Bug #2 is that on weakly-ordered architectures, updates to the callbacks
themselves are not guaranteed to be visible before the pointer is made
visible to readers.  Fixed by the smp_store_release() in
rcu_assign_pointer() when the new pointer is non-NULL.

Bug #3 is that, because the callbacks are global, it's possible for
readers to run in parallel with an unregisters, and thus a module
implementing the callbacks can be unloaded while readers are in flight,
resulting in a use-after-free.  Fixed by a synchronize_rcu() call when
unregistering callbacks.

Bug #1 escaped notice because it's extremely unlikely a compiler will
reload perf_guest_cbs in this sequence.  perf_guest_cbs does get reloaded
for future derefs, e.g. for ->is_user_mode(), but the ->is_in_guest()
guard all but guarantees the consumer will win the race, e.g. to nullify
perf_guest_cbs, KVM has to completely exit the guest and teardown down
all VMs before KVM start its module unload / unregister sequence.  This
also makes it all but impossible to encounter bug #3.

Bug #2 has not been a problem because all architectures that register
callbacks are strongly ordered and/or have a static set of callbacks.

But with help, unloading kvm_intel can trigger bug #1 e.g. wrapping
perf_guest_cbs with READ_ONCE in perf_misc_flags() while spamming
kvm_intel module load/unload leads to:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] PREEMPT SMP
  CPU: 6 PID: 1825 Comm: stress Not tainted 5.14.0-rc2+ #459
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  RIP: 0010:perf_misc_flags+0x1c/0x70
  Call Trace:
   perf_prepare_sample+0x53/0x6b0
   perf_event_output_forward+0x67/0x160
   __perf_event_overflow+0x52/0xf0
   handle_pmi_common+0x207/0x300
   intel_pmu_handle_irq+0xcf/0x410
   perf_event_nmi_handler+0x28/0x50
   nmi_handle+0xc7/0x260
   default_do_nmi+0x6b/0x170
   exc_nmi+0x103/0x130
   asm_exc_nmi+0x76/0xbf

Fixes: 39447b386c84 ("perf: Enhance perf to allow for guest statistic collection from host")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20211111020738.2512932-2-seanjc@google.com
---
 arch/arm/kernel/perf_callchain.c   | 17 +++++++++++------
 arch/arm64/kernel/perf_callchain.c | 18 ++++++++++++------
 arch/csky/kernel/perf_callchain.c  |  6 ++++--
 arch/nds32/kernel/perf_event_cpu.c | 17 +++++++++++------
 arch/riscv/kernel/perf_callchain.c |  7 +++++--
 arch/x86/events/core.c             | 17 +++++++++++------
 arch/x86/events/intel/core.c       |  9 ++++++---
 include/linux/perf_event.h         | 13 ++++++++++++-
 kernel/events/core.c               | 13 ++++++++++---
 9 files changed, 82 insertions(+), 35 deletions(-)

diff --git a/arch/arm/kernel/perf_callchain.c b/arch/arm/kernel/perf_callchain.c
index 3b69a76..1626dfc 100644
--- a/arch/arm/kernel/perf_callchain.c
+++ b/arch/arm/kernel/perf_callchain.c
@@ -62,9 +62,10 @@ user_backtrace(struct frame_tail __user *tail,
 void
 perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
 {
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	struct frame_tail __user *tail;
 
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+	if (guest_cbs && guest_cbs->is_in_guest()) {
 		/* We don't support guest os callchain now */
 		return;
 	}
@@ -98,9 +99,10 @@ callchain_trace(struct stackframe *fr,
 void
 perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
 {
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	struct stackframe fr;
 
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+	if (guest_cbs && guest_cbs->is_in_guest()) {
 		/* We don't support guest os callchain now */
 		return;
 	}
@@ -111,18 +113,21 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 
 unsigned long perf_instruction_pointer(struct pt_regs *regs)
 {
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest())
-		return perf_guest_cbs->get_guest_ip();
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
+
+	if (guest_cbs && guest_cbs->is_in_guest())
+		return guest_cbs->get_guest_ip();
 
 	return instruction_pointer(regs);
 }
 
 unsigned long perf_misc_flags(struct pt_regs *regs)
 {
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	int misc = 0;
 
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
-		if (perf_guest_cbs->is_user_mode())
+	if (guest_cbs && guest_cbs->is_in_guest()) {
+		if (guest_cbs->is_user_mode())
 			misc |= PERF_RECORD_MISC_GUEST_USER;
 		else
 			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index 4a72c27..86d9f20 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -102,7 +102,9 @@ compat_user_backtrace(struct compat_frame_tail __user *tail,
 void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 			 struct pt_regs *regs)
 {
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
+
+	if (guest_cbs && guest_cbs->is_in_guest()) {
 		/* We don't support guest os callchain now */
 		return;
 	}
@@ -147,9 +149,10 @@ static bool callchain_trace(void *data, unsigned long pc)
 void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 			   struct pt_regs *regs)
 {
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	struct stackframe frame;
 
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+	if (guest_cbs && guest_cbs->is_in_guest()) {
 		/* We don't support guest os callchain now */
 		return;
 	}
@@ -160,18 +163,21 @@ void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 
 unsigned long perf_instruction_pointer(struct pt_regs *regs)
 {
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest())
-		return perf_guest_cbs->get_guest_ip();
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
+
+	if (guest_cbs && guest_cbs->is_in_guest())
+		return guest_cbs->get_guest_ip();
 
 	return instruction_pointer(regs);
 }
 
 unsigned long perf_misc_flags(struct pt_regs *regs)
 {
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	int misc = 0;
 
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
-		if (perf_guest_cbs->is_user_mode())
+	if (guest_cbs && guest_cbs->is_in_guest()) {
+		if (guest_cbs->is_user_mode())
 			misc |= PERF_RECORD_MISC_GUEST_USER;
 		else
 			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
diff --git a/arch/csky/kernel/perf_callchain.c b/arch/csky/kernel/perf_callchain.c
index ab55e98..35318a6 100644
--- a/arch/csky/kernel/perf_callchain.c
+++ b/arch/csky/kernel/perf_callchain.c
@@ -86,10 +86,11 @@ static unsigned long user_backtrace(struct perf_callchain_entry_ctx *entry,
 void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 			 struct pt_regs *regs)
 {
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	unsigned long fp = 0;
 
 	/* C-SKY does not support virtualization. */
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest())
+	if (guest_cbs && guest_cbs->is_in_guest())
 		return;
 
 	fp = regs->regs[4];
@@ -110,10 +111,11 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 			   struct pt_regs *regs)
 {
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	struct stackframe fr;
 
 	/* C-SKY does not support virtualization. */
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+	if (guest_cbs && guest_cbs->is_in_guest()) {
 		pr_warn("C-SKY does not support perf in guest mode!");
 		return;
 	}
diff --git a/arch/nds32/kernel/perf_event_cpu.c b/arch/nds32/kernel/perf_event_cpu.c
index 0ce6f9f..f387919 100644
--- a/arch/nds32/kernel/perf_event_cpu.c
+++ b/arch/nds32/kernel/perf_event_cpu.c
@@ -1363,6 +1363,7 @@ void
 perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 		    struct pt_regs *regs)
 {
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	unsigned long fp = 0;
 	unsigned long gp = 0;
 	unsigned long lp = 0;
@@ -1371,7 +1372,7 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 
 	leaf_fp = 0;
 
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+	if (guest_cbs && guest_cbs->is_in_guest()) {
 		/* We don't support guest os callchain now */
 		return;
 	}
@@ -1479,9 +1480,10 @@ void
 perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 		      struct pt_regs *regs)
 {
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	struct stackframe fr;
 
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+	if (guest_cbs && guest_cbs->is_in_guest()) {
 		/* We don't support guest os callchain now */
 		return;
 	}
@@ -1493,20 +1495,23 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 
 unsigned long perf_instruction_pointer(struct pt_regs *regs)
 {
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
+
 	/* However, NDS32 does not support virtualization */
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest())
-		return perf_guest_cbs->get_guest_ip();
+	if (guest_cbs && guest_cbs->is_in_guest())
+		return guest_cbs->get_guest_ip();
 
 	return instruction_pointer(regs);
 }
 
 unsigned long perf_misc_flags(struct pt_regs *regs)
 {
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	int misc = 0;
 
 	/* However, NDS32 does not support virtualization */
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
-		if (perf_guest_cbs->is_user_mode())
+	if (guest_cbs && guest_cbs->is_in_guest()) {
+		if (guest_cbs->is_user_mode())
 			misc |= PERF_RECORD_MISC_GUEST_USER;
 		else
 			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
index 0bb1854..8ecfc4c 100644
--- a/arch/riscv/kernel/perf_callchain.c
+++ b/arch/riscv/kernel/perf_callchain.c
@@ -56,10 +56,11 @@ static unsigned long user_backtrace(struct perf_callchain_entry_ctx *entry,
 void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 			 struct pt_regs *regs)
 {
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	unsigned long fp = 0;
 
 	/* RISC-V does not support perf in guest mode. */
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest())
+	if (guest_cbs && guest_cbs->is_in_guest())
 		return;
 
 	fp = regs->s0;
@@ -78,8 +79,10 @@ static bool fill_callchain(void *entry, unsigned long pc)
 void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 			   struct pt_regs *regs)
 {
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
+
 	/* RISC-V does not support perf in guest mode. */
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+	if (guest_cbs && guest_cbs->is_in_guest()) {
 		pr_warn("RISC-V does not support perf in guest mode!");
 		return;
 	}
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 38b2c77..32cec29 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2768,10 +2768,11 @@ static bool perf_hw_regs(struct pt_regs *regs)
 void
 perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
 {
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	struct unwind_state state;
 	unsigned long addr;
 
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+	if (guest_cbs && guest_cbs->is_in_guest()) {
 		/* TODO: We don't support guest os callchain now */
 		return;
 	}
@@ -2871,10 +2872,11 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 void
 perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
 {
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	struct stack_frame frame;
 	const struct stack_frame __user *fp;
 
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
+	if (guest_cbs && guest_cbs->is_in_guest()) {
 		/* TODO: We don't support guest os callchain now */
 		return;
 	}
@@ -2951,18 +2953,21 @@ static unsigned long code_segment_base(struct pt_regs *regs)
 
 unsigned long perf_instruction_pointer(struct pt_regs *regs)
 {
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest())
-		return perf_guest_cbs->get_guest_ip();
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
+
+	if (guest_cbs && guest_cbs->is_in_guest())
+		return guest_cbs->get_guest_ip();
 
 	return regs->ip + code_segment_base(regs);
 }
 
 unsigned long perf_misc_flags(struct pt_regs *regs)
 {
+	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
 	int misc = 0;
 
-	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
-		if (perf_guest_cbs->is_user_mode())
+	if (guest_cbs && guest_cbs->is_in_guest()) {
+		if (guest_cbs->is_user_mode())
 			misc |= PERF_RECORD_MISC_GUEST_USER;
 		else
 			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 42cf01e..2258e02 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2837,6 +2837,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 {
 	struct perf_sample_data data;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_guest_info_callbacks *guest_cbs;
 	int bit;
 	int handled = 0;
 	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
@@ -2903,9 +2904,11 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	 */
 	if (__test_and_clear_bit(GLOBAL_STATUS_TRACE_TOPAPMI_BIT, (unsigned long *)&status)) {
 		handled++;
-		if (unlikely(perf_guest_cbs && perf_guest_cbs->is_in_guest() &&
-			perf_guest_cbs->handle_intel_pt_intr))
-			perf_guest_cbs->handle_intel_pt_intr();
+
+		guest_cbs = perf_get_guest_cbs();
+		if (unlikely(guest_cbs && guest_cbs->is_in_guest() &&
+			     guest_cbs->handle_intel_pt_intr))
+			guest_cbs->handle_intel_pt_intr();
 		else
 			intel_pt_interrupt();
 	}
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0dcfd26..318c489 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1240,7 +1240,18 @@ extern void perf_event_bpf_event(struct bpf_prog *prog,
 				 enum perf_bpf_event_type type,
 				 u16 flags);
 
-extern struct perf_guest_info_callbacks *perf_guest_cbs;
+extern struct perf_guest_info_callbacks __rcu *perf_guest_cbs;
+static inline struct perf_guest_info_callbacks *perf_get_guest_cbs(void)
+{
+	/*
+	 * Callbacks are RCU-protected and must be READ_ONCE to avoid reloading
+	 * the callbacks between a !NULL check and dereferences, to ensure
+	 * pending stores/changes to the callback pointers are visible before a
+	 * non-NULL perf_guest_cbs is visible to readers, and to prevent a
+	 * module from unloading callbacks while readers are active.
+	 */
+	return rcu_dereference(perf_guest_cbs);
+}
 extern int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
 extern int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 523106a..c552e1b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6526,18 +6526,25 @@ static void perf_pending_event(struct irq_work *entry)
  * Later on, we might change it to a list if there is
  * another virtualization implementation supporting the callbacks.
  */
-struct perf_guest_info_callbacks *perf_guest_cbs;
+struct perf_guest_info_callbacks __rcu *perf_guest_cbs;
 
 int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 {
-	perf_guest_cbs = cbs;
+	if (WARN_ON_ONCE(rcu_access_pointer(perf_guest_cbs)))
+		return -EBUSY;
+
+	rcu_assign_pointer(perf_guest_cbs, cbs);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(perf_register_guest_info_callbacks);
 
 int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 {
-	perf_guest_cbs = NULL;
+	if (WARN_ON_ONCE(rcu_access_pointer(perf_guest_cbs) != cbs))
+		return -EINVAL;
+
+	rcu_assign_pointer(perf_guest_cbs, NULL);
+	synchronize_rcu();
 	return 0;
 }
 EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
