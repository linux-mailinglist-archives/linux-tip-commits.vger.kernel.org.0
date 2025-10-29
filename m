Return-Path: <linux-tip-commits+bounces-7035-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6151CC1966D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 161D74E3B82
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 09:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9650C2512FC;
	Wed, 29 Oct 2025 09:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qOdlCiFo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pM76xRKp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEB0223DF6;
	Wed, 29 Oct 2025 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730573; cv=none; b=K0GuVn/NSPSzLp2PCmEp0qwI3z8DP7xBvx4JQ619oJEI3fQ1Bou+2EFNrayPjrkzgzX/wTp29v1vkRJtmksYTJNQLVhtxZcNR0nCFeHNSOcvJlruIAPiBTZcKQLbJ6cJNQiq3BEzvIbs6JWsvf6DEsOT4IGIo1mAuRJkxNWAhbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730573; c=relaxed/simple;
	bh=CHFGh7xrm1s6z1qFOOXMEGkLVph6xj2MAy8oBMtx3DQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cUe3cQ3zMoe2Uzim7TX71JC/Xrt8fXe9X01a3wEPcpL1F1I0OfKLVy6fMlXtTMh/DSh/yPNDp5pWlJH+Z8k/DW6lLoAxIx0Bz6rT9qxpaSjS1tb9YiFWYbW0+5wsfaq9c9hrVjfVwG8wJGX2u3k28FPdo+4r2StmUwMFfHn+2Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qOdlCiFo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pM76xRKp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 09:36:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761730568;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1djE5S+G3WnenKKATIXY6Xk5fC+blQx6ShFVItsSK0=;
	b=qOdlCiFo9xLgxXq5rzOVYrCUlQTXGsLtmv8sJk1ZOZyKRzviZcbwSdxE4WayRe4jb1fujX
	8xp76BiE8b7kYmwPiQ+r1bOmmGDo+rxT3jL38NZJm94gvM2HPlctgeg6hQtceaBcPbkUGZ
	0O+AP4IhEKZFN68fs7eKL1WF2BSXSG8kYqXgylpRN+jy3vtEcpQClzMIAWumELZi27U36Y
	xMXH4t0bMQZ+TJMCNvSNyO56P6DaKqyM7M9imKreD8QY6jyHASSfZEyVwU+jHY4/l3Lx6k
	xLj4Z1xNrbFDnMm4w65i3H+7R160xnHHZQJHmh2oSrwUf/IW2NyeHS5FRO1cpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761730568;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1djE5S+G3WnenKKATIXY6Xk5fC+blQx6ShFVItsSK0=;
	b=pM76xRKpdTObSOPmNYGr9XteeTxmi5OGSe6LTMdiYiI+M1C2JDFC/Cxg23/mflNlfhPGTo
	YFxYLMyARY1Go+CA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Support deferred user unwind
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251023150002.GR4067720@noisy.programming.kicks-ass.net>
References: <20251023150002.GR4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173056623.2601451.17637048270139232619.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c69993ecdd4dfde2b7da08b022052a33b203da07
Gitweb:        https://git.kernel.org/tip/c69993ecdd4dfde2b7da08b022052a33b20=
3da07
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Oct 2025 15:17:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 10:29:58 +01:00

perf: Support deferred user unwind

Add support for deferred userspace unwind to perf.

Where perf currently relies on in-place stack unwinding; from NMI
context and all that. This moves the userspace part of the unwind to
right before the return-to-userspace.

This has two distinct benefits, the biggest is that it moves the
unwind to a faultable context. It becomes possible to fault in debug
info (.eh_frame, SFrame etc.) that might not otherwise be readily
available. And secondly, it de-duplicates the user callchain where
multiple samples happen during the same kernel entry.

To facilitate this the perf interface is extended with a new record
type:

  PERF_RECORD_CALLCHAIN_DEFERRED

and two new attribute flags:

  perf_event_attr::defer_callchain - to request the user unwind be deferred
  perf_event_attr::defer_output    - to request PERF_RECORD_CALLCHAIN_DEFERRE=
D records

The existing PERF_RECORD_SAMPLE callchain section gets a new
context type:

  PERF_CONTEXT_USER_DEFERRED

After which will come a single entry, denoting the 'cookie' of the
deferred callchain that should be attached here, matching the 'cookie'
field of the above mentioned PERF_RECORD_CALLCHAIN_DEFERRED.

The 'defer_callchain' flag is expected on all events with
PERF_SAMPLE_CALLCHAIN. The 'defer_output' flag is expect on the event
responsible for collecting side-band events (like mmap, comm etc.).
Setting 'defer_output' on multiple events will get you duplicated
PERF_RECORD_CALLCHAIN_DEFERRED records.

Based on earlier patches by Josh and Steven.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251023150002.GR4067720@noisy.programming.kic=
ks-ass.net
---
 include/linux/perf_event.h            |  2 +-
 include/linux/unwind_deferred.h       | 12 +----
 include/linux/unwind_deferred_types.h | 13 ++++-
 include/uapi/linux/perf_event.h       | 21 ++++++-
 kernel/bpf/stackmap.c                 |  4 +-
 kernel/events/callchain.c             | 14 ++++-
 kernel/events/core.c                  | 78 +++++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h | 21 ++++++-
 8 files changed, 145 insertions(+), 20 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fd1d910..9870d76 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1720,7 +1720,7 @@ extern void perf_callchain_user(struct perf_callchain_e=
ntry_ctx *entry, struct p
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, st=
ruct pt_regs *regs);
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark);
+		   u32 max_stack, bool crosstask, bool add_mark, u64 defer_cookie);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index f4743c8..bc7ae7d 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -6,18 +6,6 @@
 #include <linux/unwind_user.h>
 #include <linux/unwind_deferred_types.h>
=20
-struct unwind_work;
-
-typedef void (*unwind_callback_t)(struct unwind_work *work,
-				  struct unwind_stacktrace *trace,
-				  u64 cookie);
-
-struct unwind_work {
-	struct list_head		list;
-	unwind_callback_t		func;
-	int				bit;
-};
-
 #ifdef CONFIG_UNWIND_USER
=20
 enum {
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_def=
erred_types.h
index 0a4c8dd..18fa393 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -39,4 +39,17 @@ struct unwind_task_info {
 	union unwind_task_id	id;
 };
=20
+struct unwind_work;
+struct unwind_stacktrace;
+
+typedef void (*unwind_callback_t)(struct unwind_work *work,
+				  struct unwind_stacktrace *trace,
+				  u64 cookie);
+
+struct unwind_work {
+	struct list_head		list;
+	unwind_callback_t		func;
+	int				bit;
+};
+
 #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 78a362b..d292f96 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -463,7 +463,9 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREA=
D */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				defer_callchain:  1, /* request PERF_RECORD_CALLCHAIN_DEFERRED records */
+				defer_output   :  1, /* output PERF_RECORD_CALLCHAIN_DEFERRED records */
+				__reserved_1   : 24;
=20
 	union {
 		__u32		wakeup_events;	  /* wake up every n events */
@@ -1239,6 +1241,22 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_AUX_OUTPUT_HW_ID		=3D 21,
=20
+	/*
+	 * This user callchain capture was deferred until shortly before
+	 * returning to user space.  Previous samples would have kernel
+	 * callchains only and they need to be stitched with this to make full
+	 * callchains.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				cookie;
+	 *	u64				nr;
+	 *	u64				ips[nr];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CALLCHAIN_DEFERRED		=3D 22,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
=20
@@ -1269,6 +1287,7 @@ enum perf_callchain_context {
 	PERF_CONTEXT_HV				=3D (__u64)-32,
 	PERF_CONTEXT_KERNEL			=3D (__u64)-128,
 	PERF_CONTEXT_USER			=3D (__u64)-512,
+	PERF_CONTEXT_USER_DEFERRED		=3D (__u64)-640,
=20
 	PERF_CONTEXT_GUEST			=3D (__u64)-2048,
 	PERF_CONTEXT_GUEST_KERNEL		=3D (__u64)-2176,
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 4d53cdd..8f1daca 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -315,7 +315,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struc=
t bpf_map *, map,
 		max_depth =3D sysctl_perf_event_max_stack;
=20
 	trace =3D get_perf_callchain(regs, kernel, user, max_depth,
-				   false, false);
+				   false, false, 0);
=20
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
@@ -452,7 +452,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct =
task_struct *task,
 		trace =3D get_callchain_entry_for_task(task, max_depth);
 	else
 		trace =3D get_perf_callchain(regs, kernel, user, max_depth,
-					   crosstask, false);
+					   crosstask, false, 0);
=20
 	if (unlikely(!trace) || trace->nr < skip) {
 		if (may_fault)
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 808c0d7..b9c7e00 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -218,7 +218,7 @@ static void fixup_uretprobe_trampoline_entries(struct per=
f_callchain_entry *entr
=20
 struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark)
+		   u32 max_stack, bool crosstask, bool add_mark, u64 defer_cookie)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
@@ -251,6 +251,18 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bo=
ol user,
 			regs =3D task_pt_regs(current);
 		}
=20
+		if (defer_cookie) {
+			/*
+			 * Foretell the coming of PERF_RECORD_CALLCHAIN_DEFERRED
+			 * which can be stitched to this one, and add
+			 * the cookie after it (it will be cut off when the
+			 * user stack is copied to the callchain).
+			 */
+			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER_DEFERRED);
+			perf_callchain_store_context(&ctx, defer_cookie);
+			goto exit_put;
+		}
+
 		if (add_mark)
 			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
=20
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7541f6f..f6a08c7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -56,6 +56,7 @@
 #include <linux/buildid.h>
 #include <linux/task_work.h>
 #include <linux/percpu-rwsem.h>
+#include <linux/unwind_deferred.h>
=20
 #include "internal.h"
=20
@@ -8200,6 +8201,8 @@ static u64 perf_get_page_size(unsigned long addr)
=20
 static struct perf_callchain_entry __empty_callchain =3D { .nr =3D 0, };
=20
+static struct unwind_work perf_unwind_work;
+
 struct perf_callchain_entry *
 perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
@@ -8208,8 +8211,11 @@ perf_callchain(struct perf_event *event, struct pt_reg=
s *regs)
 		!(current->flags & (PF_KTHREAD | PF_USER_WORKER));
 	/* Disallow cross-task user callchains. */
 	bool crosstask =3D event->ctx->task && event->ctx->task !=3D current;
+	bool defer_user =3D IS_ENABLED(CONFIG_UNWIND_USER) && user &&
+			  event->attr.defer_callchain;
 	const u32 max_stack =3D event->attr.sample_max_stack;
 	struct perf_callchain_entry *callchain;
+	u64 defer_cookie;
=20
 	if (!current->mm)
 		user =3D false;
@@ -8217,8 +8223,13 @@ perf_callchain(struct perf_event *event, struct pt_reg=
s *regs)
 	if (!kernel && !user)
 		return &__empty_callchain;
=20
-	callchain =3D get_perf_callchain(regs, kernel, user,
-				       max_stack, crosstask, true);
+	if (!(user && defer_user && !crosstask &&
+	      unwind_deferred_request(&perf_unwind_work, &defer_cookie) >=3D 0))
+		defer_cookie =3D 0;
+
+	callchain =3D get_perf_callchain(regs, kernel, user, max_stack,
+				       crosstask, true, defer_cookie);
+
 	return callchain ?: &__empty_callchain;
 }
=20
@@ -10003,6 +10014,66 @@ void perf_event_bpf_event(struct bpf_prog *prog,
 	perf_iterate_sb(perf_event_bpf_output, &bpf_event, NULL);
 }
=20
+struct perf_callchain_deferred_event {
+	struct unwind_stacktrace *trace;
+	struct {
+		struct perf_event_header	header;
+		u64				cookie;
+		u64				nr;
+		u64				ips[];
+	} event;
+};
+
+static void perf_callchain_deferred_output(struct perf_event *event, void *d=
ata)
+{
+	struct perf_callchain_deferred_event *deferred_event =3D data;
+	struct perf_output_handle handle;
+	struct perf_sample_data sample;
+	int ret, size =3D deferred_event->event.header.size;
+
+	if (!event->attr.defer_output)
+		return;
+
+	/* XXX do we really need sample_id_all for this ??? */
+	perf_event_header__init_id(&deferred_event->event.header, &sample, event);
+
+	ret =3D perf_output_begin(&handle, &sample, event,
+				deferred_event->event.header.size);
+	if (ret)
+		goto out;
+
+	perf_output_put(&handle, deferred_event->event);
+	for (int i =3D 0; i < deferred_event->trace->nr; i++) {
+		u64 entry =3D deferred_event->trace->entries[i];
+		perf_output_put(&handle, entry);
+	}
+	perf_event__output_id_sample(event, &handle, &sample);
+
+	perf_output_end(&handle);
+out:
+	deferred_event->event.header.size =3D size;
+}
+
+static void perf_unwind_deferred_callback(struct unwind_work *work,
+					 struct unwind_stacktrace *trace, u64 cookie)
+{
+	struct perf_callchain_deferred_event deferred_event =3D {
+		.trace =3D trace,
+		.event =3D {
+			.header =3D {
+				.type =3D PERF_RECORD_CALLCHAIN_DEFERRED,
+				.misc =3D PERF_RECORD_MISC_USER,
+				.size =3D sizeof(deferred_event.event) +
+					(trace->nr * sizeof(u64)),
+			},
+			.cookie =3D cookie,
+			.nr =3D trace->nr,
+		},
+	};
+
+	perf_iterate_sb(perf_callchain_deferred_output, &deferred_event, NULL);
+}
+
 struct perf_text_poke_event {
 	const void		*old_bytes;
 	const void		*new_bytes;
@@ -14799,6 +14870,9 @@ void __init perf_event_init(void)
=20
 	idr_init(&pmu_idr);
=20
+	unwind_deferred_init(&perf_unwind_work,
+			     perf_unwind_deferred_callback);
+
 	perf_event_init_all_cpus();
 	init_srcu_struct(&pmus_srcu);
 	perf_pmu_register(&perf_swevent, "software", PERF_TYPE_SOFTWARE);
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux=
/perf_event.h
index 78a362b..d292f96 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -463,7 +463,9 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREA=
D */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				defer_callchain:  1, /* request PERF_RECORD_CALLCHAIN_DEFERRED records */
+				defer_output   :  1, /* output PERF_RECORD_CALLCHAIN_DEFERRED records */
+				__reserved_1   : 24;
=20
 	union {
 		__u32		wakeup_events;	  /* wake up every n events */
@@ -1239,6 +1241,22 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_AUX_OUTPUT_HW_ID		=3D 21,
=20
+	/*
+	 * This user callchain capture was deferred until shortly before
+	 * returning to user space.  Previous samples would have kernel
+	 * callchains only and they need to be stitched with this to make full
+	 * callchains.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				cookie;
+	 *	u64				nr;
+	 *	u64				ips[nr];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CALLCHAIN_DEFERRED		=3D 22,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
=20
@@ -1269,6 +1287,7 @@ enum perf_callchain_context {
 	PERF_CONTEXT_HV				=3D (__u64)-32,
 	PERF_CONTEXT_KERNEL			=3D (__u64)-128,
 	PERF_CONTEXT_USER			=3D (__u64)-512,
+	PERF_CONTEXT_USER_DEFERRED		=3D (__u64)-640,
=20
 	PERF_CONTEXT_GUEST			=3D (__u64)-2048,
 	PERF_CONTEXT_GUEST_KERNEL		=3D (__u64)-2176,

