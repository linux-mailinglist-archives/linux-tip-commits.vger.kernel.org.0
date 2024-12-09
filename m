Return-Path: <linux-tip-commits+bounces-3044-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 883379E9999
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 15:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784CA1886AD0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 14:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2681F0E58;
	Mon,  9 Dec 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H+OJHjoS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xfUhVMKJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1931BEF83;
	Mon,  9 Dec 2024 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756123; cv=none; b=ERFqsvdBP4tSttG4bKILiCkKTVrNyYQt6M/8J6FmfUwFc2BJpVOLfQGQudnFXDh9Q3TE44iiTOSDvH4hBAnPyppIQh2wuDDpcW8BmZkpIPn3ueJ0Ksjw+NGWdT1sCthy4Z5MGJdqFzyTPqqjXTRPhtT80b9NjWii5Q+lBmrooMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756123; c=relaxed/simple;
	bh=GfxwCj9nLHUcMAf9ER4BX/HwbGidbA2C0IsYfcsfrEs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DLjadDeQMTZS30yOKQ00RLHOYWL5FkozZ/nEB53F/cCeReFtPlWedZ2h387Sm8dr+2gzTThc9C8LSd/Op5ttr5p4/m+8hybUEqJV3A8sD3r+sYyb5vhWfHPK0a3/KaRk0vXvQE7dFo4UEwzYB1rOrWhZr9e9RBrFLdtt/X/EGWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H+OJHjoS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xfUhVMKJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 14:55:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733756118;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mw0YcXqG5DReOzXyqEfOKBCAFyZIx19Iorv11JZgW+c=;
	b=H+OJHjoSRy3870xni04Uq7AVyHhXbxzMk3pzA4BfMCAnnghXXha8Vp9st8P988aN5XIIrQ
	Ur/CcbbJFSdnXRszCUzoIRl+xSjkx2bGOHceAqaCwaZcvd1T6Ev+MhNuyrdPHl+w+r8Pu/
	anBEtjKRpCHfSzkOCnMq5Q/ysi2Xh+wEVWbzS+ewjnAFcWAAc4VFIBzwcrF1tWKoBl6BC+
	Ip3PYKfICeiUHFjFvHwFZiecV8Gv1T4gwEK9jXmjJQqd9bDiVQHnPkzbcqiOO1bhF2Sz4+
	J/+5+GI5MANouO+nWOvmk2/53QQkz8fjMaRssId+lcUPL9cU8op/qCq1fnkQ+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733756118;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mw0YcXqG5DReOzXyqEfOKBCAFyZIx19Iorv11JZgW+c=;
	b=xfUhVMKJYzRIFfvGtRBKRFgXAZGKrPLwKnon+aSc8ldbpTCeWDRpcyh6NJ/AiCq8P9xgys
	nlNEIkNqsyDSdNCQ==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: Reuse return_instances between multiple
 uretprobes within task
Cc: Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241206002417.3295533-5-andrii@kernel.org>
References: <20241206002417.3295533-5-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173375611788.412.1476064732724623709.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8622e45b5da17e777e0e45f16296072494452318
Gitweb:        https://git.kernel.org/tip/8622e45b5da17e777e0e45f162960724944=
52318
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Thu, 05 Dec 2024 16:24:17 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Dec 2024 15:50:30 +01:00

uprobes: Reuse return_instances between multiple uretprobes within task

Instead of constantly allocating and freeing very short-lived
struct return_instance, reuse it as much as possible within current
task. For that, store a linked list of reusable return_instances within
current->utask.

The only complication is that ri_timer() might be still processing such
return_instance. And so while the main uretprobe processing logic might
be already done with return_instance and would be OK to immediately
reuse it for the next uretprobe instance, it's not correct to
unconditionally reuse it just like that.

Instead we make sure that ri_timer() can't possibly be processing it by
using seqcount_t, with ri_timer() being "a writer", while
free_ret_instance() being "a reader". If, after we unlink return
instance from utask->return_instances list, we know that ri_timer()
hasn't gotten to processing utask->return_instances yet, then we can be
sure that immediate return_instance reuse is OK, and so we put it
onto utask->ri_pool for future (potentially, almost immediate) reuse.

This change shows improvements both in single CPU performance (by
avoiding relatively expensive kmalloc/free combon) and in terms of
multi-CPU scalability, where you can see that per-CPU throughput doesn't
decline as steeply with increased number of CPUs (which were previously
attributed to kmalloc()/free() through profiling):

	BASELINE (latest perf/core)
	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
	uretprobe-nop         ( 1 cpus):    1.898 =C2=B1 0.002M/s  (  1.898M/s/cpu)
	uretprobe-nop         ( 2 cpus):    3.574 =C2=B1 0.011M/s  (  1.787M/s/cpu)
	uretprobe-nop         ( 3 cpus):    5.279 =C2=B1 0.066M/s  (  1.760M/s/cpu)
	uretprobe-nop         ( 4 cpus):    6.824 =C2=B1 0.047M/s  (  1.706M/s/cpu)
	uretprobe-nop         ( 5 cpus):    8.339 =C2=B1 0.060M/s  (  1.668M/s/cpu)
	uretprobe-nop         ( 6 cpus):    9.812 =C2=B1 0.047M/s  (  1.635M/s/cpu)
	uretprobe-nop         ( 7 cpus):   11.030 =C2=B1 0.048M/s  (  1.576M/s/cpu)
	uretprobe-nop         ( 8 cpus):   12.453 =C2=B1 0.126M/s  (  1.557M/s/cpu)
	uretprobe-nop         (10 cpus):   14.838 =C2=B1 0.044M/s  (  1.484M/s/cpu)
	uretprobe-nop         (12 cpus):   17.092 =C2=B1 0.115M/s  (  1.424M/s/cpu)
	uretprobe-nop         (14 cpus):   19.576 =C2=B1 0.022M/s  (  1.398M/s/cpu)
	uretprobe-nop         (16 cpus):   22.264 =C2=B1 0.015M/s  (  1.391M/s/cpu)
	uretprobe-nop         (24 cpus):   33.534 =C2=B1 0.078M/s  (  1.397M/s/cpu)
	uretprobe-nop         (32 cpus):   43.262 =C2=B1 0.127M/s  (  1.352M/s/cpu)
	uretprobe-nop         (40 cpus):   53.252 =C2=B1 0.080M/s  (  1.331M/s/cpu)
	uretprobe-nop         (48 cpus):   55.778 =C2=B1 0.045M/s  (  1.162M/s/cpu)
	uretprobe-nop         (56 cpus):   56.850 =C2=B1 0.227M/s  (  1.015M/s/cpu)
	uretprobe-nop         (64 cpus):   62.005 =C2=B1 0.077M/s  (  0.969M/s/cpu)
	uretprobe-nop         (72 cpus):   66.445 =C2=B1 0.236M/s  (  0.923M/s/cpu)
	uretprobe-nop         (80 cpus):   68.353 =C2=B1 0.180M/s  (  0.854M/s/cpu)

	THIS PATCHSET (on top of latest perf/core)
	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	uretprobe-nop         ( 1 cpus):    2.253 =C2=B1 0.004M/s  (  2.253M/s/cpu)
	uretprobe-nop         ( 2 cpus):    4.281 =C2=B1 0.003M/s  (  2.140M/s/cpu)
	uretprobe-nop         ( 3 cpus):    6.389 =C2=B1 0.027M/s  (  2.130M/s/cpu)
	uretprobe-nop         ( 4 cpus):    8.328 =C2=B1 0.005M/s  (  2.082M/s/cpu)
	uretprobe-nop         ( 5 cpus):   10.353 =C2=B1 0.001M/s  (  2.071M/s/cpu)
	uretprobe-nop         ( 6 cpus):   12.513 =C2=B1 0.010M/s  (  2.086M/s/cpu)
	uretprobe-nop         ( 7 cpus):   14.525 =C2=B1 0.017M/s  (  2.075M/s/cpu)
	uretprobe-nop         ( 8 cpus):   15.633 =C2=B1 0.013M/s  (  1.954M/s/cpu)
	uretprobe-nop         (10 cpus):   19.532 =C2=B1 0.011M/s  (  1.953M/s/cpu)
	uretprobe-nop         (12 cpus):   21.405 =C2=B1 0.009M/s  (  1.784M/s/cpu)
	uretprobe-nop         (14 cpus):   24.857 =C2=B1 0.020M/s  (  1.776M/s/cpu)
	uretprobe-nop         (16 cpus):   26.466 =C2=B1 0.018M/s  (  1.654M/s/cpu)
	uretprobe-nop         (24 cpus):   40.513 =C2=B1 0.222M/s  (  1.688M/s/cpu)
	uretprobe-nop         (32 cpus):   54.180 =C2=B1 0.074M/s  (  1.693M/s/cpu)
	uretprobe-nop         (40 cpus):   66.100 =C2=B1 0.082M/s  (  1.652M/s/cpu)
	uretprobe-nop         (48 cpus):   70.544 =C2=B1 0.068M/s  (  1.470M/s/cpu)
	uretprobe-nop         (56 cpus):   74.494 =C2=B1 0.055M/s  (  1.330M/s/cpu)
	uretprobe-nop         (64 cpus):   79.317 =C2=B1 0.029M/s  (  1.239M/s/cpu)
	uretprobe-nop         (72 cpus):   84.875 =C2=B1 0.020M/s  (  1.179M/s/cpu)
	uretprobe-nop         (80 cpus):   92.318 =C2=B1 0.224M/s  (  1.154M/s/cpu)

For reference, with uprobe-nop we hit the following throughput:

	uprobe-nop            (80 cpus):  143.485 =C2=B1 0.035M/s  (  1.794M/s/cpu)

So now uretprobe stays a bit closer to that performance.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20241206002417.3295533-5-andrii@kernel.org
---
 include/linux/uprobes.h |  6 ++-
 kernel/events/uprobes.c | 83 +++++++++++++++++++++++++++++++++-------
 2 files changed, 75 insertions(+), 14 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 1d44997..b1df7d7 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -16,6 +16,7 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 #include <linux/timer.h>
+#include <linux/seqlock.h>
=20
 struct uprobe;
 struct vm_area_struct;
@@ -124,6 +125,10 @@ struct uprobe_task {
 	unsigned int			depth;
 	struct return_instance		*return_instances;
=20
+	struct return_instance		*ri_pool;
+	struct timer_list		ri_timer;
+	seqcount_t			ri_seqcount;
+
 	union {
 		struct {
 			struct arch_uprobe_task	autask;
@@ -137,7 +142,6 @@ struct uprobe_task {
 	};
=20
 	struct uprobe			*active_uprobe;
-	struct timer_list		ri_timer;
 	unsigned long			xol_vaddr;
=20
 	struct arch_uprobe              *auprobe;
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2345aeb..1af9502 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1888,8 +1888,34 @@ unsigned long uprobe_get_trap_addr(struct pt_regs *reg=
s)
 	return instruction_pointer(regs);
 }
=20
-static void free_ret_instance(struct return_instance *ri, bool cleanup_hprob=
e)
+static void ri_pool_push(struct uprobe_task *utask, struct return_instance *=
ri)
 {
+	ri->cons_cnt =3D 0;
+	ri->next =3D utask->ri_pool;
+	utask->ri_pool =3D ri;
+}
+
+static struct return_instance *ri_pool_pop(struct uprobe_task *utask)
+{
+	struct return_instance *ri =3D utask->ri_pool;
+
+	if (likely(ri))
+		utask->ri_pool =3D ri->next;
+
+	return ri;
+}
+
+static void ri_free(struct return_instance *ri)
+{
+	kfree(ri->extra_consumers);
+	kfree_rcu(ri, rcu);
+}
+
+static void free_ret_instance(struct uprobe_task *utask,
+			      struct return_instance *ri, bool cleanup_hprobe)
+{
+	unsigned seq;
+
 	if (cleanup_hprobe) {
 		enum hprobe_state hstate;
=20
@@ -1897,8 +1923,22 @@ static void free_ret_instance(struct return_instance *=
ri, bool cleanup_hprobe)
 		hprobe_finalize(&ri->hprobe, hstate);
 	}
=20
-	kfree(ri->extra_consumers);
-	kfree_rcu(ri, rcu);
+	/*
+	 * At this point return_instance is unlinked from utask's
+	 * return_instances list and this has become visible to ri_timer().
+	 * If seqcount now indicates that ri_timer's return instance
+	 * processing loop isn't active, we can return ri into the pool of
+	 * to-be-reused return instances for future uretprobes. If ri_timer()
+	 * happens to be running right now, though, we fallback to safety and
+	 * just perform RCU-delated freeing of ri.
+	 */
+	if (raw_seqcount_try_begin(&utask->ri_seqcount, seq)) {
+		/* immediate reuse of ri without RCU GP is OK */
+		ri_pool_push(utask, ri);
+	} else {
+		/* we might be racing with ri_timer(), so play it safe */
+		ri_free(ri);
+	}
 }
=20
 /*
@@ -1920,7 +1960,15 @@ void uprobe_free_utask(struct task_struct *t)
 	ri =3D utask->return_instances;
 	while (ri) {
 		ri_next =3D ri->next;
-		free_ret_instance(ri, true /* cleanup_hprobe */);
+		free_ret_instance(utask, ri, true /* cleanup_hprobe */);
+		ri =3D ri_next;
+	}
+
+	/* free_ret_instance() above might add to ri_pool, so this loop should come=
 last */
+	ri =3D utask->ri_pool;
+	while (ri) {
+		ri_next =3D ri->next;
+		ri_free(ri);
 		ri =3D ri_next;
 	}
=20
@@ -1943,8 +1991,12 @@ static void ri_timer(struct timer_list *timer)
 	/* RCU protects return_instance from freeing. */
 	guard(rcu)();
=20
+	write_seqcount_begin(&utask->ri_seqcount);
+
 	for_each_ret_instance_rcu(ri, utask->return_instances)
 		hprobe_expire(&ri->hprobe, false);
+
+	write_seqcount_end(&utask->ri_seqcount);
 }
=20
 static struct uprobe_task *alloc_utask(void)
@@ -1956,6 +2008,7 @@ static struct uprobe_task *alloc_utask(void)
 		return NULL;
=20
 	timer_setup(&utask->ri_timer, ri_timer, 0);
+	seqcount_init(&utask->ri_seqcount);
=20
 	return utask;
 }
@@ -1975,10 +2028,14 @@ static struct uprobe_task *get_utask(void)
 	return current->utask;
 }
=20
-static struct return_instance *alloc_return_instance(void)
+static struct return_instance *alloc_return_instance(struct uprobe_task *uta=
sk)
 {
 	struct return_instance *ri;
=20
+	ri =3D ri_pool_pop(utask);
+	if (ri)
+		return ri;
+
 	ri =3D kzalloc(sizeof(*ri), GFP_KERNEL);
 	if (!ri)
 		return ZERO_SIZE_PTR;
@@ -2119,7 +2176,7 @@ static void cleanup_return_instances(struct uprobe_task=
 *utask, bool chained,
 		rcu_assign_pointer(utask->return_instances, ri_next);
 		utask->depth--;
=20
-		free_ret_instance(ri, true /* cleanup_hprobe */);
+		free_ret_instance(utask, ri, true /* cleanup_hprobe */);
 		ri =3D ri_next;
 	}
 }
@@ -2186,7 +2243,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, st=
ruct pt_regs *regs,
=20
 	return;
 free:
-	kfree(ri);
+	ri_free(ri);
 }
=20
 /* Prepare to single-step probed instruction out of line. */
@@ -2385,8 +2442,7 @@ static struct return_instance *push_consumer(struct ret=
urn_instance *ri, __u64 i
 	if (unlikely(ri->cons_cnt > 0)) {
 		ric =3D krealloc(ri->extra_consumers, sizeof(*ric) * ri->cons_cnt, GFP_KER=
NEL);
 		if (!ric) {
-			kfree(ri->extra_consumers);
-			kfree_rcu(ri, rcu);
+			ri_free(ri);
 			return ZERO_SIZE_PTR;
 		}
 		ri->extra_consumers =3D ric;
@@ -2428,8 +2484,9 @@ static void handler_chain(struct uprobe *uprobe, struct=
 pt_regs *regs)
 	struct uprobe_consumer *uc;
 	bool has_consumers =3D false, remove =3D true;
 	struct return_instance *ri =3D NULL;
+	struct uprobe_task *utask =3D current->utask;
=20
-	current->utask->auprobe =3D &uprobe->arch;
+	utask->auprobe =3D &uprobe->arch;
=20
 	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_tr=
ace_held()) {
 		bool session =3D uc->handler && uc->ret_handler;
@@ -2449,12 +2506,12 @@ static void handler_chain(struct uprobe *uprobe, stru=
ct pt_regs *regs)
 			continue;
=20
 		if (!ri)
-			ri =3D alloc_return_instance();
+			ri =3D alloc_return_instance(utask);
=20
 		if (session)
 			ri =3D push_consumer(ri, uc->id, cookie);
 	}
-	current->utask->auprobe =3D NULL;
+	utask->auprobe =3D NULL;
=20
 	if (!ZERO_OR_NULL_PTR(ri))
 		prepare_uretprobe(uprobe, regs, ri);
@@ -2554,7 +2611,7 @@ void uprobe_handle_trampoline(struct pt_regs *regs)
 			hprobe_finalize(&ri->hprobe, hstate);
=20
 			/* We already took care of hprobe, no need to waste more time on that. */
-			free_ret_instance(ri, false /* !cleanup_hprobe */);
+			free_ret_instance(utask, ri, false /* !cleanup_hprobe */);
 			ri =3D ri_next;
 		} while (ri !=3D next_chain);
 	} while (!valid);

