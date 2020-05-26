Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5041DA1CF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 May 2020 22:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgESUA2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 May 2020 16:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbgEST7I (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 May 2020 15:59:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC081C08C5C4;
        Tue, 19 May 2020 12:59:07 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8OD-0000BU-Pz; Tue, 19 May 2020 21:59:01 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 270751C085A;
        Tue, 19 May 2020 21:58:45 +0200 (CEST)
Date:   Tue, 19 May 2020 19:58:45 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/kvm: Restrict ASYNC_PF to user space
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134059.369802541@linutronix.de>
References: <20200505134059.369802541@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991832502.17951.15702715280553924621.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     3a7c8fafd1b42adea229fd204132f6a2fb3cd2d9
Gitweb:        https://git.kernel.org/tip/3a7c8fafd1b42adea229fd204132f6a2fb3cd2d9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 24 Apr 2020 09:57:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:53:58 +02:00

x86/kvm: Restrict ASYNC_PF to user space

The async page fault injection into kernel space creates more problems than
it solves. The host has absolutely no knowledge about the state of the
guest if the fault happens in CPL0. The only restriction for the host is
interrupt disabled state. If interrupts are enabled in the guest then the
exception can hit arbitrary code. The HALT based wait in non-preemotible
code is a hacky replacement for a proper hypercall.

For the ongoing work to restrict instrumentation and make the RCU idle
interaction well defined the required extra work for supporting async
pagefault in CPL0 is just not justified and creates complexity for a
dubious benefit.

The CPL3 injection is well defined and does not cause any issues as it is
more or less the same as a regular page fault from CPL3.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134059.369802541@linutronix.de


---
 arch/x86/kernel/kvm.c | 100 ++---------------------------------------
 1 file changed, 7 insertions(+), 93 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index c6a82f9..b3d9b0d 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -75,7 +75,6 @@ struct kvm_task_sleep_node {
 	struct swait_queue_head wq;
 	u32 token;
 	int cpu;
-	bool use_halt;
 };
 
 static struct kvm_task_sleep_head {
@@ -98,8 +97,7 @@ static struct kvm_task_sleep_node *_find_apf_task(struct kvm_task_sleep_head *b,
 	return NULL;
 }
 
-static bool kvm_async_pf_queue_task(u32 token, bool use_halt,
-				    struct kvm_task_sleep_node *n)
+static bool kvm_async_pf_queue_task(u32 token, struct kvm_task_sleep_node *n)
 {
 	u32 key = hash_32(token, KVM_TASK_SLEEP_HASHBITS);
 	struct kvm_task_sleep_head *b = &async_pf_sleepers[key];
@@ -117,7 +115,6 @@ static bool kvm_async_pf_queue_task(u32 token, bool use_halt,
 
 	n->token = token;
 	n->cpu = smp_processor_id();
-	n->use_halt = use_halt;
 	init_swait_queue_head(&n->wq);
 	hlist_add_head(&n->link, &b->list);
 	raw_spin_unlock(&b->lock);
@@ -138,7 +135,7 @@ void kvm_async_pf_task_wait_schedule(u32 token)
 
 	lockdep_assert_irqs_disabled();
 
-	if (!kvm_async_pf_queue_task(token, false, &n))
+	if (!kvm_async_pf_queue_task(token, &n))
 		return;
 
 	for (;;) {
@@ -154,91 +151,10 @@ void kvm_async_pf_task_wait_schedule(u32 token)
 }
 EXPORT_SYMBOL_GPL(kvm_async_pf_task_wait_schedule);
 
-/*
- * Invoked from the async page fault handler.
- */
-static void kvm_async_pf_task_wait_halt(u32 token)
-{
-	struct kvm_task_sleep_node n;
-
-	if (!kvm_async_pf_queue_task(token, true, &n))
-		return;
-
-	for (;;) {
-		if (hlist_unhashed(&n.link))
-			break;
-		/*
-		 * No point in doing anything about RCU here. Any RCU read
-		 * side critical section or RCU watching section can be
-		 * interrupted by VMEXITs and the host is free to keep the
-		 * vCPU scheduled out as long as it sees fit. This is not
-		 * any different just because of the halt induced voluntary
-		 * VMEXIT.
-		 *
-		 * Also the async page fault could have interrupted any RCU
-		 * watching context, so invoking rcu_irq_exit()/enter()
-		 * around this is not gaining anything.
-		 */
-		native_safe_halt();
-		local_irq_disable();
-	}
-}
-
-/* Invoked from the async page fault handler */
-static void kvm_async_pf_task_wait(u32 token, bool usermode)
-{
-	bool can_schedule;
-
-	/*
-	 * No need to check whether interrupts were disabled because the
-	 * host will (hopefully) only inject an async page fault into
-	 * interrupt enabled regions.
-	 *
-	 * If CONFIG_PREEMPTION is enabled then check whether the code
-	 * which triggered the page fault is preemptible. This covers user
-	 * mode as well because preempt_count() is obviously 0 there.
-	 *
-	 * The check for rcu_preempt_depth() is also required because
-	 * voluntary scheduling inside a rcu read locked section is not
-	 * allowed.
-	 *
-	 * The idle task is already covered by this because idle always
-	 * has a preempt count > 0.
-	 *
-	 * If CONFIG_PREEMPTION is disabled only allow scheduling when
-	 * coming from user mode as there is no indication whether the
-	 * context which triggered the page fault could schedule or not.
-	 */
-	if (IS_ENABLED(CONFIG_PREEMPTION))
-		can_schedule = preempt_count() + rcu_preempt_depth() == 0;
-	else
-		can_schedule = usermode;
-
-	/*
-	 * If the kernel context is allowed to schedule then RCU is
-	 * watching because no preemptible code in the kernel is inside RCU
-	 * idle state. So it can be treated like user mode. User mode is
-	 * safe because the #PF entry invoked enter_from_user_mode().
-	 *
-	 * For the non schedulable case invoke rcu_irq_enter() for
-	 * now. This will be moved out to the pagefault entry code later
-	 * and only invoked when really needed.
-	 */
-	if (can_schedule) {
-		kvm_async_pf_task_wait_schedule(token);
-	} else {
-		rcu_irq_enter();
-		kvm_async_pf_task_wait_halt(token);
-		rcu_irq_exit();
-	}
-}
-
 static void apf_task_wake_one(struct kvm_task_sleep_node *n)
 {
 	hlist_del_init(&n->link);
-	if (n->use_halt)
-		smp_send_reschedule(n->cpu);
-	else if (swq_has_sleeper(&n->wq))
+	if (swq_has_sleeper(&n->wq))
 		swake_up_one(&n->wq);
 }
 
@@ -337,8 +253,10 @@ bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 		panic("Host injected async #PF in interrupt disabled region\n");
 
 	if (reason == KVM_PV_REASON_PAGE_NOT_PRESENT) {
-		/* page is swapped out by the host. */
-		kvm_async_pf_task_wait(token, user_mode(regs));
+		if (unlikely(!(user_mode(regs))))
+			panic("Host injected async #PF in kernel mode\n");
+		/* Page is swapped out by the host. */
+		kvm_async_pf_task_wait_schedule(token);
 	} else {
 		rcu_irq_enter();
 		kvm_async_pf_task_wake(token);
@@ -397,10 +315,6 @@ static void kvm_guest_cpu_init(void)
 		WARN_ON_ONCE(!static_branch_likely(&kvm_async_pf_enabled));
 
 		pa = slow_virt_to_phys(this_cpu_ptr(&apf_reason));
-
-#ifdef CONFIG_PREEMPTION
-		pa |= KVM_ASYNC_PF_SEND_ALWAYS;
-#endif
 		pa |= KVM_ASYNC_PF_ENABLED;
 
 		if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_VMEXIT))
