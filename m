Return-Path: <linux-tip-commits+bounces-6995-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED047C07F34
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 21:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBBDA4EB496
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 19:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F7A2BD034;
	Fri, 24 Oct 2025 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="asj41cun";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JMsIy8TC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AF0267386;
	Fri, 24 Oct 2025 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761335122; cv=none; b=dP1GgK/Lvap6uf46JO6qLw/nNYDtDNuXcksOnJkLfwCb0HndVkYRiiYUl6o3GYDqwEpY9VmQL4qqRwZ3ZZnFg/gphv5gXSzRVrXFx/En91A8z7Y+39Ypx270wKJHczlXe4+jZGYqBgOBCIX9f1PxCVqMqvDyXk23qJQS9bdHPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761335122; c=relaxed/simple;
	bh=8nFXK5nFENB05JkBLB4xY93q889Ty6mxyA+v2J653PM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IjmziyqM0zrTRORT2vGIqm5NLGMpRco2KExmKrrKrCnGRj+un5JYO1uiL1n56BYpoS5pBrXcpCkJ/fep0Xdc2eIb+UptV88URW7ieuhO7tI+ygYC4vOTiVjAUzsNgkJMjlNPjAqM+q/0Y8f6m1apFU3zKMb0Tcvrj45V6AOaDmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=asj41cun; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JMsIy8TC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 Oct 2025 19:45:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761335119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2NsyTE2+GfqF++Z+t8uD4oJ12+yHpiYRqmYfV30CpGA=;
	b=asj41cunbqQ5n6hYSaTaOlNw5nWJ/tzREafYJl75qekI696f41F5QJswem3sp0pwVnf1sd
	BIbZDDWWGCESsO8FyP9HJSmCH27vgy07pNObtbl6vu/hwDMo8VnixaB5uyz0w5qLkwMZwf
	9pWdFo0V+UPsVIUd3lWUZMcGIFb7ixP4T3uq14yaCSWCVHMMdxupDcvJgywoG5H8gLX2wg
	BHloh9HAhOR9pLXBuLfjhySpsIUypsmWPPnYcDa/oUuH8EaiHNrvKsQ7CPMIrrEvYAnFRI
	3iKZBMPJlJjYJR4BnGJyG34JDlc488/DVP42OAyo4nq0BSTQJTGIEXtJtE/Uiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761335119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2NsyTE2+GfqF++Z+t8uD4oJ12+yHpiYRqmYfV30CpGA=;
	b=JMsIy8TCNqUTQ7n+r+dvpfk0oDm5kfdflE+sq1cbnqdP34WsE7IHkM1RXn2t1egIS3gh8r
	9fZS/sEer+mcGiCg==
From: "tip-bot2 for Matthew Wilcox (Oracle)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] treewide: Remove in_irq()
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251024180654.1691095-1-willy@infradead.org>
References: <20251024180654.1691095-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176133511760.2601451.11756138328464524645.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/core branch of tip:

Commit-ID:     70e0a80a1f3580ccf5bc1f34dbb433c67d9d8d00
Gitweb:        https://git.kernel.org/tip/70e0a80a1f3580ccf5bc1f34dbb433c67d9=
d8d00
Author:        Matthew Wilcox (Oracle) <willy@infradead.org>
AuthorDate:    Fri, 24 Oct 2025 19:06:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Oct 2025 21:39:27 +02:00

treewide: Remove in_irq()

This old alias for in_hardirq() has been marked as deprecated since
2020; remove the stragglers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251024180654.1691095-1-willy@infradead.org
---
 drivers/bus/fsl-mc/mc-sys.c | 2 +-
 drivers/md/dm-vdo/logger.c  | 2 +-
 include/linux/lockdep.h     | 2 +-
 include/linux/preempt.h     | 2 --
 kernel/bpf/syscall.c        | 4 ++--
 kernel/time/timer.c         | 2 +-
 lib/locking-selftest.c      | 4 ++--
 7 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/fsl-mc/mc-sys.c b/drivers/bus/fsl-mc/mc-sys.c
index b22c59d..31037f4 100644
--- a/drivers/bus/fsl-mc/mc-sys.c
+++ b/drivers/bus/fsl-mc/mc-sys.c
@@ -248,7 +248,7 @@ int mc_send_command(struct fsl_mc_io *mc_io, struct fsl_m=
c_command *cmd)
 	enum mc_cmd_status status;
 	unsigned long irq_flags =3D 0;
=20
-	if (in_irq() && !(mc_io->flags & FSL_MC_IO_ATOMIC_CONTEXT_PORTAL))
+	if (in_hardirq() && !(mc_io->flags & FSL_MC_IO_ATOMIC_CONTEXT_PORTAL))
 		return -EINVAL;
=20
 	if (mc_io->flags & FSL_MC_IO_ATOMIC_CONTEXT_PORTAL)
diff --git a/drivers/md/dm-vdo/logger.c b/drivers/md/dm-vdo/logger.c
index 3f7dc2c..76a987c 100644
--- a/drivers/md/dm-vdo/logger.c
+++ b/drivers/md/dm-vdo/logger.c
@@ -34,7 +34,7 @@ static const char *get_current_interrupt_type(void)
 	if (in_nmi())
 		return "NMI";
=20
-	if (in_irq())
+	if (in_hardirq())
 		return "HI";
=20
 	if (in_softirq())
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 67964dc..dd63410 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -616,7 +616,7 @@ do {									\
 #define lockdep_assert_in_softirq()					\
 do {									\
 	WARN_ON_ONCE(__lockdep_enabled			&&		\
-		     (!in_softirq() || in_irq() || in_nmi()));		\
+		     (!in_softirq() || in_hardirq() || in_nmi()));	\
 } while (0)
=20
 extern void lockdep_assert_in_softirq_func(void);
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 1022021..d964f96 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -134,11 +134,9 @@ static __always_inline unsigned char interrupt_context_l=
evel(void)
=20
 /*
  * The following macros are deprecated and should not be used in new code:
- * in_irq()       - Obsolete version of in_hardirq()
  * in_softirq()   - We have BH disabled, or are processing softirqs
  * in_interrupt() - We're in NMI,IRQ,SoftIRQ context or have BH disabled
  */
-#define in_irq()		(hardirq_count())
 #define in_softirq()		(softirq_count())
 #define in_interrupt()		(irq_count())
=20
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8a12974..6cde6a4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2330,7 +2330,7 @@ static void bpf_audit_prog(const struct bpf_prog *prog,=
 unsigned int op)
 		return;
 	if (audit_enabled =3D=3D AUDIT_OFF)
 		return;
-	if (!in_irq() && !irqs_disabled())
+	if (!in_hardirq() && !irqs_disabled())
 		ctx =3D audit_context();
 	ab =3D audit_log_start(ctx, GFP_ATOMIC, AUDIT_BPF);
 	if (unlikely(!ab))
@@ -2428,7 +2428,7 @@ static void __bpf_prog_put(struct bpf_prog *prog)
 	struct bpf_prog_aux *aux =3D prog->aux;
=20
 	if (atomic64_dec_and_test(&aux->refcnt)) {
-		if (in_irq() || irqs_disabled()) {
+		if (in_hardirq() || irqs_disabled()) {
 			INIT_WORK(&aux->work, bpf_prog_put_deferred);
 			schedule_work(&aux->work);
 		} else {
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 553fa46..282a8e5 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2472,7 +2472,7 @@ void update_process_times(int user_tick)
 	run_local_timers();
 	rcu_sched_clock_irq(user_tick);
 #ifdef CONFIG_IRQ_WORK
-	if (in_irq())
+	if (in_hardirq())
 		irq_work_tick();
 #endif
 	sched_tick();
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index ed99344..d939403 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -202,7 +202,7 @@ static void init_shared_classes(void)
 	local_irq_disable();			\
 	__irq_enter();				\
 	lockdep_hardirq_threaded();		\
-	WARN_ON(!in_irq());
+	WARN_ON(!in_hardirq());
=20
 #define HARDIRQ_EXIT()				\
 	__irq_exit();				\
@@ -2512,7 +2512,7 @@ DEFINE_LOCK_GUARD_0(NOTTHREADED_HARDIRQ,
 	do {
 		local_irq_disable();
 		__irq_enter();
-		WARN_ON(!in_irq());
+		WARN_ON(!in_hardirq());
 	} while(0), HARDIRQ_EXIT())
 DEFINE_LOCK_GUARD_0(SOFTIRQ, SOFTIRQ_ENTER(), SOFTIRQ_EXIT())
=20

