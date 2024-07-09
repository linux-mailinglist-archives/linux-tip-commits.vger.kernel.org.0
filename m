Return-Path: <linux-tip-commits+bounces-1641-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A8492B896
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 13:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46B81C21DAD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 11:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA8415B987;
	Tue,  9 Jul 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G5pRBcR9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FxIVJt+3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4E5158D86;
	Tue,  9 Jul 2024 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525322; cv=none; b=rk27wIPWiP8H/myk2G/Ik4h6Qfp2PlOHTMKEQG+29P8EcR7FprAPAdTKKQbY04Nz3FqlvbxKqx461llBcq46CShBe4UtJM3Nv8gI1PLoVDEKRNiXxgyDEVtNcJq48/vawkahm90zryCvs0/+NvcojTpRerWPFk9qjrsB7WEKWII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525322; c=relaxed/simple;
	bh=34YPX9XzwO4EHMu07MdboyVNUafO1XyPsXl2NbI9pD4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pKRpeW1hER2TdLMJSqo/1bEbylj1/asSdQii79Maj2pbIu6Wd+e6tyQMhdhBPd1Q2arPqOVOOXv020iDnM1NRFOd8BdHhKXUtCZvi3o1VUxMAGY/AmwuzAkz4ijhoudXVnDhjD2uVAvoztzZHIFSMLJPL6NqfqiAK1IIAuay5Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G5pRBcR9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FxIVJt+3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Jul 2024 11:41:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720525318;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua6Bmhm+mVQkCYaAkVg/CQPEojHfy+lyGZp8YGQvo2k=;
	b=G5pRBcR9UOt1LJGXfhmn65ATj5MyzMtDwPQwlkHQGwcSOKW6Ee8xEyoQx9vXAiLIq5jXBY
	zrVkm4eDlWBWEw5x9PvLrmbTnhprLHEAtuLNTbDWTiNRuiYLSotpst1DTl1QKysvWwqBqF
	kp1jYIu8jcXaBBV60NaHMKWRNeEIgO3OdOgG/u5mxhO+vMj7ah9R6bLAs7WLznNxk4ezVc
	jS3kNUVedi8l8ID4wwQ0RYmxRNPatpje/6xeUwtSoMSqZjW4T7HUGo0NsTsXxAXNXdvAv8
	h5sQVKT+MZjWfTNTchp0OCiXp2ERkgbwXg2iJ7ZDBENSVM23oeFjkBoAjtXROg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720525318;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua6Bmhm+mVQkCYaAkVg/CQPEojHfy+lyGZp8YGQvo2k=;
	b=FxIVJt+3BdDV0YIz6yXSeRfqCmzRCEV9cN1t6C0CnKnJwQP3N3z18goK5t4D2K6yKIzG4d
	GYIlaTCI+KCL0kAA==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf: Move swevent_htable::recursion into task_struct.
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Marco Elver <elver@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240704170424.1466941-6-bigeasy@linutronix.de>
References: <20240704170424.1466941-6-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172052531792.2215.11892809563137740104.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0d40a6d83e3e6751f1107ba33587262d937c969f
Gitweb:        https://git.kernel.org/tip/0d40a6d83e3e6751f1107ba33587262d937c969f
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 04 Jul 2024 19:03:39 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 09 Jul 2024 13:26:36 +02:00

perf: Move swevent_htable::recursion into task_struct.

The swevent_htable::recursion counter is used to avoid creating an
swevent while an event is processed to avoid recursion. The counter is
per-CPU and preemption must be disabled to have a stable counter.
perf_pending_task() disables preemption to access the counter and then
signal. This is problematic on PREEMPT_RT because sending a signal uses
a spinlock_t which must not be acquired in atomic on PREEMPT_RT because
it becomes a sleeping lock.

The atomic context can be avoided by moving the counter into the
task_struct. There is a 4 byte hole between futex_state (usually always
on) and the following perf pointer (perf_event_ctxp). After the
recursion lost some weight it fits perfectly.

Move swevent_htable::recursion into task_struct.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/20240704170424.1466941-6-bigeasy@linutronix.de
---
 include/linux/perf_event.h |  6 ------
 include/linux/sched.h      |  7 +++++++
 kernel/events/core.c       | 13 +++----------
 kernel/events/internal.h   |  2 +-
 4 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ea0d824..99a7ea1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -970,12 +970,6 @@ struct perf_event_context {
 	local_t				nr_pending;
 };
 
-/*
- * Number of contexts where an event can trigger:
- *	task, softirq, hardirq, nmi.
- */
-#define PERF_NR_CONTEXTS	4
-
 struct perf_cpu_pmu_context {
 	struct perf_event_pmu_context	epc;
 	struct perf_event_pmu_context	*task_epc;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac..afb1087 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -734,6 +734,12 @@ enum perf_event_task_context {
 	perf_nr_task_contexts,
 };
 
+/*
+ * Number of contexts where an event can trigger:
+ *      task, softirq, hardirq, nmi.
+ */
+#define PERF_NR_CONTEXTS	4
+
 struct wake_q_node {
 	struct wake_q_node *next;
 };
@@ -1256,6 +1262,7 @@ struct task_struct {
 	unsigned int			futex_state;
 #endif
 #ifdef CONFIG_PERF_EVENTS
+	u8				perf_recursion[PERF_NR_CONTEXTS];
 	struct perf_event_context	*perf_event_ctxp;
 	struct mutex			perf_event_mutex;
 	struct list_head		perf_event_list;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 53e2750..b523225 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9763,11 +9763,7 @@ struct swevent_htable {
 	struct swevent_hlist		*swevent_hlist;
 	struct mutex			hlist_mutex;
 	int				hlist_refcount;
-
-	/* Recursion avoidance in each contexts */
-	u8				recursion[PERF_NR_CONTEXTS];
 };
-
 static DEFINE_PER_CPU(struct swevent_htable, swevent_htable);
 
 /*
@@ -9965,17 +9961,13 @@ DEFINE_PER_CPU(struct pt_regs, __perf_regs[4]);
 
 int perf_swevent_get_recursion_context(void)
 {
-	struct swevent_htable *swhash = this_cpu_ptr(&swevent_htable);
-
-	return get_recursion_context(swhash->recursion);
+	return get_recursion_context(current->perf_recursion);
 }
 EXPORT_SYMBOL_GPL(perf_swevent_get_recursion_context);
 
 void perf_swevent_put_recursion_context(int rctx)
 {
-	struct swevent_htable *swhash = this_cpu_ptr(&swevent_htable);
-
-	put_recursion_context(swhash->recursion, rctx);
+	put_recursion_context(current->perf_recursion, rctx);
 }
 
 void ___perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)
@@ -13642,6 +13634,7 @@ int perf_event_init_task(struct task_struct *child, u64 clone_flags)
 {
 	int ret;
 
+	memset(child->perf_recursion, 0, sizeof(child->perf_recursion));
 	child->perf_event_ctxp = NULL;
 	mutex_init(&child->perf_event_mutex);
 	INIT_LIST_HEAD(&child->perf_event_list);
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 7f06b79..4515144 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -221,7 +221,7 @@ static inline int get_recursion_context(u8 *recursion)
 	return rctx;
 }
 
-static inline void put_recursion_context(u8 *recursion, int rctx)
+static inline void put_recursion_context(u8 *recursion, unsigned char rctx)
 {
 	barrier();
 	recursion[rctx]--;

