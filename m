Return-Path: <linux-tip-commits+bounces-6719-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5171B9DF46
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 10:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718823B4027
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 08:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9479526A1B5;
	Thu, 25 Sep 2025 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n1NU69Ps";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8k6jLspY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419FB2367BF;
	Thu, 25 Sep 2025 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758787309; cv=none; b=Gzq0CgDERuhDG8k5/mg1621FKKMyM6h8Ns+udrAXv8GdfRv5Di4d3BuzJs6iuwTkeGu/z0Rjt3DVj8OCn7RkvWmqvYgp7YdtYL+jBq7gpFBPZvF0NtvSnXBIPSq5MKiHAM4ZCR8Ttc79cM0XMbY7sJwIpgAFVFlrBl1YuZSTIL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758787309; c=relaxed/simple;
	bh=cfNcRUlx7ysCulwQIAmluQeCn6H/wss14eLgXqFGCMM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eIuptFdBgkHoaY3EbmwtWQ1bNIr7dsf1A/bzaePNblfAAocPQxehhrqh89GfUocVW1ElwxZWHD0onysuZZgPZ1eZkP25xmYFlJqNLaB+YMYgo8H4dbdXiT703OtLRtYl9REE+wp+263GdO9kTojEPCTAwvaFo6/UNoJRobSdQBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n1NU69Ps; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8k6jLspY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 08:01:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758787305;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpAnOOQdSxJeFByq0H+4XB1Z5U8YencxNmj4nFw5PUY=;
	b=n1NU69PsR4lfgjZvX0yfYeGc7IKPhW17Q8tRfiUnGKyZ/YoZvhYPZXWEJB4IpnJftnxtXu
	n1fzJ4o6E5mmUSgqlTQj78oVvITr+ZCytqGOpaBsXUhAoytiEMXcgqzW1M3WEjTZ0/UgY9
	n7KTuMXeiqROwry1btjQ7qmBRayGMs/oRAN02w9sSTyB7cxg/l0PzXiteRcIMaizH7T/aT
	ynB6Fse6CBKDOmsZoejkY0qzYc3cug2PdhDwgyhttZl3eeg88sa5EmVnjNidO+4IXkurq6
	G/bvhNHIahpLJXc5wlWOMgaJLIThuZ1B6XweSukBz/fqdUKdcA6TOvuaF1gL7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758787305;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpAnOOQdSxJeFByq0H+4XB1Z5U8YencxNmj4nFw5PUY=;
	b=8k6jLspYp021KsglHEFHuJImatlyokJBVUMbpGOB7g3d08spB4KVTom20kklqAqUV2qwPM
	gPzR7b+bCN0w+OBA==
From: "tip-bot2 for Menglong Dong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Make migrate_{en,dis}able() inline
Cc: Menglong Dong <dongml2@chinatelecom.cn>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250917060916.462278-4-dongml2@chinatelecom.cn>
References: <20250917060916.462278-4-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175878730376.709179.17451225747099918958.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     378b7708194fff77c9020392067329931c3fcc04
Gitweb:        https://git.kernel.org/tip/378b7708194fff77c9020392067329931c3=
fcc04
Author:        Menglong Dong <menglong8.dong@gmail.com>
AuthorDate:    Wed, 17 Sep 2025 14:09:15 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 25 Sep 2025 09:57:16 +02:00

sched: Make migrate_{en,dis}able() inline

For now, migrate_enable and migrate_disable are global, which makes them
become hotspots in some case. Take BPF for example, the function calling
to migrate_enable and migrate_disable in BPF trampoline can introduce
significant overhead, and following is the 'perf top' of FENTRY's
benchmark (./tools/testing/selftests/bpf/bench trig-fentry):

  54.63% bpf_prog_2dcccf652aac1793_bench_trigger_fentry [k]
                 bpf_prog_2dcccf652aac1793_bench_trigger_fentry
  10.43% [kernel] [k] migrate_enable
  10.07% bpf_trampoline_6442517037 [k] bpf_trampoline_6442517037
  8.06% [kernel] [k] __bpf_prog_exit_recur
  4.11% libc.so.6 [.] syscall
  2.15% [kernel] [k] entry_SYSCALL_64
  1.48% [kernel] [k] memchr_inv
  1.32% [kernel] [k] fput
  1.16% [kernel] [k] _copy_to_user
  0.73% [kernel] [k] bpf_prog_test_run_raw_tp

So in this commit, we make migrate_enable/migrate_disable inline to obtain
better performance. The struct rq is defined internally in
kernel/sched/sched.h, and the field "nr_pinned" is accessed in
migrate_enable/migrate_disable, which makes it hard to make them inline.

Alexei Starovoitov suggests to generate the offset of "nr_pinned" in [1],
so we can define the migrate_enable/migrate_disable in
include/linux/sched.h and access "this_rq()->nr_pinned" with
"(void *)this_rq() + RQ_nr_pinned".

The offset of "nr_pinned" is generated in include/generated/rq-offsets.h
by kernel/sched/rq-offsets.c.

Generally speaking, we move the definition of migrate_enable and
migrate_disable to include/linux/sched.h from kernel/sched/core.c. The
calling to __set_cpus_allowed_ptr() is leaved in ___migrate_enable().

The "struct rq" is not available in include/linux/sched.h, so we can't
access the "runqueues" with this_cpu_ptr(), as the compilation will fail
in this_cpu_ptr() -> raw_cpu_ptr() -> __verify_pcpu_ptr():
  typeof((ptr) + 0)

So we introduce the this_rq_raw() and access the runqueues with
arch_raw_cpu_ptr/PERCPU_PTR directly.

The variable "runqueues" is not visible in the kernel modules, and export
it is not a good idea. As Peter Zijlstra advised in [2], we define and
export migrate_enable/migrate_disable in kernel/sched/core.c too, and use
them for the modules.

Before this patch, the performance of BPF FENTRY is:

  fentry         :  113.030 =C2=B1 0.149M/s
  fentry         :  112.501 =C2=B1 0.187M/s
  fentry         :  112.828 =C2=B1 0.267M/s
  fentry         :  115.287 =C2=B1 0.241M/s

After this patch, the performance of BPF FENTRY increases to:

  fentry         :  143.644 =C2=B1 0.670M/s
  fentry         :  149.764 =C2=B1 0.362M/s
  fentry         :  149.642 =C2=B1 0.156M/s
  fentry         :  145.263 =C2=B1 0.221M/s

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/bpf/CAADnVQ+5sEDKHdsJY5ZsfGDO_1SEhhQWHrt2SMBG5S=
YyQ+jt7w@mail.gmail.com/ [1]
Link: https://lore.kernel.org/all/20250819123214.GH4067720@noisy.programming.=
kicks-ass.net/ [2]
---
 Kbuild                    |  13 +++-
 include/linux/preempt.h   |   3 +-
 include/linux/sched.h     | 113 +++++++++++++++++++++++++++++++++++++-
 kernel/bpf/verifier.c     |   1 +-
 kernel/sched/core.c       |  63 ++++-----------------
 kernel/sched/rq-offsets.c |  12 ++++-
 6 files changed, 152 insertions(+), 53 deletions(-)
 create mode 100644 kernel/sched/rq-offsets.c

diff --git a/Kbuild b/Kbuild
index f327ca8..13324b4 100644
--- a/Kbuild
+++ b/Kbuild
@@ -34,13 +34,24 @@ arch/$(SRCARCH)/kernel/asm-offsets.s: $(timeconst-file) $=
(bounds-file)
 $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
 	$(call filechk,offsets,__ASM_OFFSETS_H__)
=20
+# Generate rq-offsets.h
+
+rq-offsets-file :=3D include/generated/rq-offsets.h
+
+targets +=3D kernel/sched/rq-offsets.s
+
+kernel/sched/rq-offsets.s: $(offsets-file)
+
+$(rq-offsets-file): kernel/sched/rq-offsets.s FORCE
+	$(call filechk,offsets,__RQ_OFFSETS_H__)
+
 # Check for missing system calls
=20
 quiet_cmd_syscalls =3D CALL    $<
       cmd_syscalls =3D $(CONFIG_SHELL) $< $(CC) $(c_flags) $(missing_syscall=
s_flags)
=20
 PHONY +=3D missing-syscalls
-missing-syscalls: scripts/checksyscalls.sh $(offsets-file)
+missing-syscalls: scripts/checksyscalls.sh $(rq-offsets-file)
 	$(call cmd,syscalls)
=20
 # Check the manual modification of atomic headers
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 1fad1c8..92237c3 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -424,8 +424,6 @@ static inline void preempt_notifier_init(struct preempt_n=
otifier *notifier,
  *       work-conserving schedulers.
  *
  */
-extern void migrate_disable(void);
-extern void migrate_enable(void);
=20
 /**
  * preempt_disable_nested - Disable preemption inside a normally preempt dis=
abled section
@@ -471,7 +469,6 @@ static __always_inline void preempt_enable_nested(void)
=20
 DEFINE_LOCK_GUARD_0(preempt, preempt_disable(), preempt_enable())
 DEFINE_LOCK_GUARD_0(preempt_notrace, preempt_disable_notrace(), preempt_enab=
le_notrace())
-DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
=20
 #ifdef CONFIG_PREEMPT_DYNAMIC
=20
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 644a01b..d60ecac 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -49,6 +49,9 @@
 #include <linux/tracepoint-defs.h>
 #include <linux/unwind_deferred_types.h>
 #include <asm/kmap_size.h>
+#ifndef COMPILE_OFFSETS
+#include <generated/rq-offsets.h>
+#endif
=20
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -2317,4 +2320,114 @@ static __always_inline void alloc_tag_restore(struct =
alloc_tag *tag, struct allo
 #define alloc_tag_restore(_tag, _old)		do {} while (0)
 #endif
=20
+#ifndef MODULE
+#ifndef COMPILE_OFFSETS
+
+extern void ___migrate_enable(void);
+
+struct rq;
+DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+
+/*
+ * The "struct rq" is not available here, so we can't access the
+ * "runqueues" with this_cpu_ptr(), as the compilation will fail in
+ * this_cpu_ptr() -> raw_cpu_ptr() -> __verify_pcpu_ptr():
+ *   typeof((ptr) + 0)
+ *
+ * So use arch_raw_cpu_ptr()/PERCPU_PTR() directly here.
+ */
+#ifdef CONFIG_SMP
+#define this_rq_raw() arch_raw_cpu_ptr(&runqueues)
+#else
+#define this_rq_raw() PERCPU_PTR(&runqueues)
+#endif
+#define this_rq_pinned() (*(unsigned int *)((void *)this_rq_raw() + RQ_nr_pi=
nned))
+
+static inline void __migrate_enable(void)
+{
+	struct task_struct *p =3D current;
+
+#ifdef CONFIG_DEBUG_PREEMPT
+	/*
+	 * Check both overflow from migrate_disable() and superfluous
+	 * migrate_enable().
+	 */
+	if (WARN_ON_ONCE((s16)p->migration_disabled <=3D 0))
+		return;
+#endif
+
+	if (p->migration_disabled > 1) {
+		p->migration_disabled--;
+		return;
+	}
+
+	/*
+	 * Ensure stop_task runs either before or after this, and that
+	 * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
+	 */
+	guard(preempt)();
+	if (unlikely(p->cpus_ptr !=3D &p->cpus_mask))
+		___migrate_enable();
+	/*
+	 * Mustn't clear migration_disabled() until cpus_ptr points back at the
+	 * regular cpus_mask, otherwise things that race (eg.
+	 * select_fallback_rq) get confused.
+	 */
+	barrier();
+	p->migration_disabled =3D 0;
+	this_rq_pinned()--;
+}
+
+static inline void __migrate_disable(void)
+{
+	struct task_struct *p =3D current;
+
+	if (p->migration_disabled) {
+#ifdef CONFIG_DEBUG_PREEMPT
+		/*
+		 *Warn about overflow half-way through the range.
+		 */
+		WARN_ON_ONCE((s16)p->migration_disabled < 0);
+#endif
+		p->migration_disabled++;
+		return;
+	}
+
+	guard(preempt)();
+	this_rq_pinned()++;
+	p->migration_disabled =3D 1;
+}
+#else /* !COMPILE_OFFSETS */
+static inline void __migrate_disable(void) { }
+static inline void __migrate_enable(void) { }
+#endif /* !COMPILE_OFFSETS */
+
+/*
+ * So that it is possible to not export the runqueues variable, define and
+ * export migrate_enable/migrate_disable in kernel/sched/core.c too, and use
+ * them for the modules. The macro "INSTANTIATE_EXPORTED_MIGRATE_DISABLE" wi=
ll
+ * be defined in kernel/sched/core.c.
+ */
+#ifndef INSTANTIATE_EXPORTED_MIGRATE_DISABLE
+static inline void migrate_disable(void)
+{
+	__migrate_disable();
+}
+
+static inline void migrate_enable(void)
+{
+	__migrate_enable();
+}
+#else /* INSTANTIATE_EXPORTED_MIGRATE_DISABLE */
+extern void migrate_disable(void);
+extern void migrate_enable(void);
+#endif /* INSTANTIATE_EXPORTED_MIGRATE_DISABLE */
+
+#else /* MODULE */
+extern void migrate_disable(void);
+extern void migrate_enable(void);
+#endif /* MODULE */
+
+DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
+
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c4f69a9..de9078a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23855,6 +23855,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *=
log,
 BTF_SET_START(btf_id_deny)
 BTF_ID_UNUSED
 #ifdef CONFIG_SMP
+BTF_ID(func, ___migrate_enable)
 BTF_ID(func, migrate_disable)
 BTF_ID(func, migrate_enable)
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index feb750a..7f1e5cb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7,6 +7,8 @@
  *  Copyright (C) 1991-2002  Linus Torvalds
  *  Copyright (C) 1998-2024  Ingo Molnar, Red Hat
  */
+#define INSTANTIATE_EXPORTED_MIGRATE_DISABLE
+#include <linux/sched.h>
 #include <linux/highmem.h>
 #include <linux/hrtimer_api.h>
 #include <linux/ktime_api.h>
@@ -2381,28 +2383,7 @@ static void migrate_disable_switch(struct rq *rq, stru=
ct task_struct *p)
 	__do_set_cpus_allowed(p, &ac);
 }
=20
-void migrate_disable(void)
-{
-	struct task_struct *p =3D current;
-
-	if (p->migration_disabled) {
-#ifdef CONFIG_DEBUG_PREEMPT
-		/*
-		 *Warn about overflow half-way through the range.
-		 */
-		WARN_ON_ONCE((s16)p->migration_disabled < 0);
-#endif
-		p->migration_disabled++;
-		return;
-	}
-
-	guard(preempt)();
-	this_rq()->nr_pinned++;
-	p->migration_disabled =3D 1;
-}
-EXPORT_SYMBOL_GPL(migrate_disable);
-
-void migrate_enable(void)
+void ___migrate_enable(void)
 {
 	struct task_struct *p =3D current;
 	struct affinity_context ac =3D {
@@ -2410,35 +2391,19 @@ void migrate_enable(void)
 		.flags     =3D SCA_MIGRATE_ENABLE,
 	};
=20
-#ifdef CONFIG_DEBUG_PREEMPT
-	/*
-	 * Check both overflow from migrate_disable() and superfluous
-	 * migrate_enable().
-	 */
-	if (WARN_ON_ONCE((s16)p->migration_disabled <=3D 0))
-		return;
-#endif
+	__set_cpus_allowed_ptr(p, &ac);
+}
+EXPORT_SYMBOL_GPL(___migrate_enable);
=20
-	if (p->migration_disabled > 1) {
-		p->migration_disabled--;
-		return;
-	}
+void migrate_disable(void)
+{
+	__migrate_disable();
+}
+EXPORT_SYMBOL_GPL(migrate_disable);
=20
-	/*
-	 * Ensure stop_task runs either before or after this, and that
-	 * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
-	 */
-	guard(preempt)();
-	if (p->cpus_ptr !=3D &p->cpus_mask)
-		__set_cpus_allowed_ptr(p, &ac);
-	/*
-	 * Mustn't clear migration_disabled() until cpus_ptr points back at the
-	 * regular cpus_mask, otherwise things that race (eg.
-	 * select_fallback_rq) get confused.
-	 */
-	barrier();
-	p->migration_disabled =3D 0;
-	this_rq()->nr_pinned--;
+void migrate_enable(void)
+{
+	__migrate_enable();
 }
 EXPORT_SYMBOL_GPL(migrate_enable);
=20
diff --git a/kernel/sched/rq-offsets.c b/kernel/sched/rq-offsets.c
new file mode 100644
index 0000000..a23747b
--- /dev/null
+++ b/kernel/sched/rq-offsets.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#define COMPILE_OFFSETS
+#include <linux/kbuild.h>
+#include <linux/types.h>
+#include "sched.h"
+
+int main(void)
+{
+	DEFINE(RQ_nr_pinned, offsetof(struct rq, nr_pinned));
+
+	return 0;
+}

