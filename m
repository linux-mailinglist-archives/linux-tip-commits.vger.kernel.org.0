Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1612CC692
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 20:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbgLBTXy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 14:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731046AbgLBTXy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 14:23:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9961C0613D4;
        Wed,  2 Dec 2020 11:23:13 -0800 (PST)
Date:   Wed, 02 Dec 2020 19:23:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606936992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2uYSbI4ZrX/oqDz1/qeQFW85NAzMp5fhWbgXeAc7gtg=;
        b=aiX4WKGkJgQA6LZzBOLkUGss6JO72UKE3Yf+SBzlMC4QDt8+c0MfZOKy6Zms3DPNp2rBGS
        ixy11QcNZegWFaPN/90Z9jbcwkfjpa2izo2XKNrYEkf67NMzXjTLk2fKxXh3erartBY6JR
        PQIEQbBm+kyL/vB6cIc/YbB3qI+33+SQLBRCXVGt5ts1Kpy7Ka4ZezltipD9Boe3FTyCc5
        9vjZjSZX85OmqtMT65Yb5/u+cTGSs3k6cqQtjeYwWWNKYUc34UjbTOyl8M6qoMQwkNFaY7
        +/xbRJ1Fk50zpO2pw4wQWWDYvKBb5oad75z0HmuiswPNT+WVbU8FLSeja7tTKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606936992;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2uYSbI4ZrX/oqDz1/qeQFW85NAzMp5fhWbgXeAc7gtg=;
        b=67rsERRmjgEQp67OI28NHad90Sg+K2+1j+rbBaeOHUrs1Bo9in6xrQtkLM3T6AF9XDhBcY
        sXmHNrRlkkHL3SAQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] sched/vtime: Consolidate IRQ time accounting
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201202115732.27827-4-frederic@kernel.org>
References: <20201202115732.27827-4-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <160693699155.3364.7611985849129250624.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8a6a5920d3286eb0eae9f36a4ec4fc9df511eccb
Gitweb:        https://git.kernel.org/tip/8a6a5920d3286eb0eae9f36a4ec4fc9df511eccb
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 02 Dec 2020 12:57:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 20:20:05 +01:00

sched/vtime: Consolidate IRQ time accounting

The 3 architectures implementing CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
all have their own version of irq time accounting that dispatch the
cputime to the appropriate index: hardirq, softirq, system, idle,
guest... from an all-in-one function.

Instead of having these ad-hoc versions, move the cputime destination
dispatch decision to the core code and leave only the actual per-index
cputime accounting to the architecture.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201202115732.27827-4-frederic@kernel.org

---
 arch/ia64/kernel/time.c    | 20 +++++++++----
 arch/powerpc/kernel/time.c | 56 ++++++++++++++++++++++++++-----------
 arch/s390/kernel/vtime.c   | 45 +++++++++++++++++++++---------
 include/linux/vtime.h      | 16 ++++-------
 kernel/sched/cputime.c     | 13 ++++++---
 5 files changed, 102 insertions(+), 48 deletions(-)

diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index 7abc5f3..733e0e3 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -138,12 +138,8 @@ void vtime_account_kernel(struct task_struct *tsk)
 	struct thread_info *ti = task_thread_info(tsk);
 	__u64 stime = vtime_delta(tsk);
 
-	if ((tsk->flags & PF_VCPU) && !irq_count())
+	if (tsk->flags & PF_VCPU)
 		ti->gtime += stime;
-	else if (hardirq_count())
-		ti->hardirq_time += stime;
-	else if (in_serving_softirq())
-		ti->softirq_time += stime;
 	else
 		ti->stime += stime;
 }
@@ -156,6 +152,20 @@ void vtime_account_idle(struct task_struct *tsk)
 	ti->idle_time += vtime_delta(tsk);
 }
 
+void vtime_account_softirq(struct task_struct *tsk)
+{
+	struct thread_info *ti = task_thread_info(tsk);
+
+	ti->softirq_time += vtime_delta(tsk);
+}
+
+void vtime_account_hardirq(struct task_struct *tsk)
+{
+	struct thread_info *ti = task_thread_info(tsk);
+
+	ti->hardirq_time += vtime_delta(tsk);
+}
+
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
 
 static irqreturn_t
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 74efe46..cf3f8db 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -311,12 +311,11 @@ static unsigned long vtime_delta_scaled(struct cpu_accounting_data *acct,
 	return stime_scaled;
 }
 
-static unsigned long vtime_delta(struct task_struct *tsk,
+static unsigned long vtime_delta(struct cpu_accounting_data *acct,
 				 unsigned long *stime_scaled,
 				 unsigned long *steal_time)
 {
 	unsigned long now, stime;
-	struct cpu_accounting_data *acct = get_accounting(tsk);
 
 	WARN_ON_ONCE(!irqs_disabled());
 
@@ -331,29 +330,30 @@ static unsigned long vtime_delta(struct task_struct *tsk,
 	return stime;
 }
 
+static void vtime_delta_kernel(struct cpu_accounting_data *acct,
+			       unsigned long *stime, unsigned long *stime_scaled)
+{
+	unsigned long steal_time;
+
+	*stime = vtime_delta(acct, stime_scaled, &steal_time);
+	*stime -= min(*stime, steal_time);
+	acct->steal_time += steal_time;
+}
+
 void vtime_account_kernel(struct task_struct *tsk)
 {
-	unsigned long stime, stime_scaled, steal_time;
 	struct cpu_accounting_data *acct = get_accounting(tsk);
+	unsigned long stime, stime_scaled;
 
-	stime = vtime_delta(tsk, &stime_scaled, &steal_time);
-
-	stime -= min(stime, steal_time);
-	acct->steal_time += steal_time;
+	vtime_delta_kernel(acct, &stime, &stime_scaled);
 
-	if ((tsk->flags & PF_VCPU) && !irq_count()) {
+	if (tsk->flags & PF_VCPU) {
 		acct->gtime += stime;
 #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
 		acct->utime_scaled += stime_scaled;
 #endif
 	} else {
-		if (hardirq_count())
-			acct->hardirq_time += stime;
-		else if (in_serving_softirq())
-			acct->softirq_time += stime;
-		else
-			acct->stime += stime;
-
+		acct->stime += stime;
 #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
 		acct->stime_scaled += stime_scaled;
 #endif
@@ -366,10 +366,34 @@ void vtime_account_idle(struct task_struct *tsk)
 	unsigned long stime, stime_scaled, steal_time;
 	struct cpu_accounting_data *acct = get_accounting(tsk);
 
-	stime = vtime_delta(tsk, &stime_scaled, &steal_time);
+	stime = vtime_delta(acct, &stime_scaled, &steal_time);
 	acct->idle_time += stime + steal_time;
 }
 
+static void vtime_account_irq_field(struct cpu_accounting_data *acct,
+				    unsigned long *field)
+{
+	unsigned long stime, stime_scaled;
+
+	vtime_delta_kernel(acct, &stime, &stime_scaled);
+	*field += stime;
+#ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
+	acct->stime_scaled += stime_scaled;
+#endif
+}
+
+void vtime_account_softirq(struct task_struct *tsk)
+{
+	struct cpu_accounting_data *acct = get_accounting(tsk);
+	vtime_account_irq_field(acct, &acct->softirq_time);
+}
+
+void vtime_account_hardirq(struct task_struct *tsk)
+{
+	struct cpu_accounting_data *acct = get_accounting(tsk);
+	vtime_account_irq_field(acct, &acct->hardirq_time);
+}
+
 static void vtime_flush_scaled(struct task_struct *tsk,
 			       struct cpu_accounting_data *acct)
 {
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index ebd8e56..5aaa2ca 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -222,31 +222,50 @@ void vtime_flush(struct task_struct *tsk)
 	S390_lowcore.avg_steal_timer = avg_steal;
 }
 
+static u64 vtime_delta(void)
+{
+	u64 timer = S390_lowcore.last_update_timer;
+
+	S390_lowcore.last_update_timer = get_vtimer();
+
+	return timer - S390_lowcore.last_update_timer;
+}
+
 /*
  * Update process times based on virtual cpu times stored by entry.S
  * to the lowcore fields user_timer, system_timer & steal_clock.
  */
 void vtime_account_kernel(struct task_struct *tsk)
 {
-	u64 timer;
-
-	timer = S390_lowcore.last_update_timer;
-	S390_lowcore.last_update_timer = get_vtimer();
-	timer -= S390_lowcore.last_update_timer;
+	u64 delta = vtime_delta();
 
-	if ((tsk->flags & PF_VCPU) && (irq_count() == 0))
-		S390_lowcore.guest_timer += timer;
-	else if (hardirq_count())
-		S390_lowcore.hardirq_timer += timer;
-	else if (in_serving_softirq())
-		S390_lowcore.softirq_timer += timer;
+	if (tsk->flags & PF_VCPU)
+		S390_lowcore.guest_timer += delta;
 	else
-		S390_lowcore.system_timer += timer;
+		S390_lowcore.system_timer += delta;
 
-	virt_timer_forward(timer);
+	virt_timer_forward(delta);
 }
 EXPORT_SYMBOL_GPL(vtime_account_kernel);
 
+void vtime_account_softirq(struct task_struct *tsk)
+{
+	u64 delta = vtime_delta();
+
+	S390_lowcore.softirq_timer += delta;
+
+	virt_timer_forward(delta);
+}
+
+void vtime_account_hardirq(struct task_struct *tsk)
+{
+	u64 delta = vtime_delta();
+
+	S390_lowcore.hardirq_timer += delta;
+
+	virt_timer_forward(delta);
+}
+
 /*
  * Sorted add to a list. List is linear searched until first bigger
  * element is found.
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 2cdeca0..6c98674 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -83,16 +83,12 @@ static inline void vtime_init_idle(struct task_struct *tsk, int cpu) { }
 #endif
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
-extern void vtime_account_irq_enter(struct task_struct *tsk);
-static inline void vtime_account_irq_exit(struct task_struct *tsk)
-{
-	/* On hard|softirq exit we always account to hard|softirq cputime */
-	vtime_account_kernel(tsk);
-}
+extern void vtime_account_irq(struct task_struct *tsk);
+extern void vtime_account_softirq(struct task_struct *tsk);
+extern void vtime_account_hardirq(struct task_struct *tsk);
 extern void vtime_flush(struct task_struct *tsk);
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
-static inline void vtime_account_irq_enter(struct task_struct *tsk) { }
-static inline void vtime_account_irq_exit(struct task_struct *tsk) { }
+static inline void vtime_account_irq(struct task_struct *tsk) { }
 static inline void vtime_flush(struct task_struct *tsk) { }
 #endif
 
@@ -105,13 +101,13 @@ static inline void irqtime_account_irq(struct task_struct *tsk) { }
 
 static inline void account_irq_enter_time(struct task_struct *tsk)
 {
-	vtime_account_irq_enter(tsk);
+	vtime_account_irq(tsk);
 	irqtime_account_irq(tsk);
 }
 
 static inline void account_irq_exit_time(struct task_struct *tsk)
 {
-	vtime_account_irq_exit(tsk);
+	vtime_account_irq(tsk);
 	irqtime_account_irq(tsk);
 }
 
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 2783162..02163d4 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -417,13 +417,18 @@ void vtime_task_switch(struct task_struct *prev)
 }
 # endif
 
-void vtime_account_irq_enter(struct task_struct *tsk)
+void vtime_account_irq(struct task_struct *tsk)
 {
-	if (!IS_ENABLED(CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE) &&
-	    !in_interrupt() && is_idle_task(tsk))
+	if (hardirq_count()) {
+		vtime_account_hardirq(tsk);
+	} else if (in_serving_softirq()) {
+		vtime_account_softirq(tsk);
+	} else if (!IS_ENABLED(CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE) &&
+		   is_idle_task(tsk)) {
 		vtime_account_idle(tsk);
-	else
+	} else {
 		vtime_account_kernel(tsk);
+	}
 }
 
 void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
