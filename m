Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27BF2DC55A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2019 14:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634007AbfJRMsq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Oct 2019 08:48:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56811 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633981AbfJRMsp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Oct 2019 08:48:45 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLRfu-00075q-KY; Fri, 18 Oct 2019 14:48:10 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2E8D21C0450;
        Fri, 18 Oct 2019 14:48:10 +0200 (CEST)
Date:   Fri, 18 Oct 2019 12:48:10 -0000
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf_event: Add support for LSM and SELinux checks
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        James Morris <jmorris@namei.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        rostedt@goodmis.org, Yonghong Song <yhs@fb.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>, jeffv@google.com,
        Jiri Olsa <jolsa@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>, primiano@google.com,
        Song Liu <songliubraving@fb.com>, rsavitski@google.com,
        Namhyung Kim <namhyung@kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191014170308.70668-1-joel@joelfernandes.org>
References: <20191014170308.70668-1-joel@joelfernandes.org>
MIME-Version: 1.0
Message-ID: <157140289006.29376.278808376543657730.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     da97e18458fb42d7c00fac5fd1c56a3896ec666e
Gitweb:        https://git.kernel.org/tip/da97e18458fb42d7c00fac5fd1c56a3896ec666e
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Mon, 14 Oct 2019 13:03:08 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 17 Oct 2019 21:31:55 +02:00

perf_event: Add support for LSM and SELinux checks

In current mainline, the degree of access to perf_event_open(2) system
call depends on the perf_event_paranoid sysctl.  This has a number of
limitations:

1. The sysctl is only a single value. Many types of accesses are controlled
   based on the single value thus making the control very limited and
   coarse grained.
2. The sysctl is global, so if the sysctl is changed, then that means
   all processes get access to perf_event_open(2) opening the door to
   security issues.

This patch adds LSM and SELinux access checking which will be used in
Android to access perf_event_open(2) for the purposes of attaching BPF
programs to tracepoints, perf profiling and other operations from
userspace. These operations are intended for production systems.

5 new LSM hooks are added:
1. perf_event_open: This controls access during the perf_event_open(2)
   syscall itself. The hook is called from all the places that the
   perf_event_paranoid sysctl is checked to keep it consistent with the
   systctl. The hook gets passed a 'type' argument which controls CPU,
   kernel and tracepoint accesses (in this context, CPU, kernel and
   tracepoint have the same semantics as the perf_event_paranoid sysctl).
   Additionally, I added an 'open' type which is similar to
   perf_event_paranoid sysctl == 3 patch carried in Android and several other
   distros but was rejected in mainline [1] in 2016.

2. perf_event_alloc: This allocates a new security object for the event
   which stores the current SID within the event. It will be useful when
   the perf event's FD is passed through IPC to another process which may
   try to read the FD. Appropriate security checks will limit access.

3. perf_event_free: Called when the event is closed.

4. perf_event_read: Called from the read(2) and mmap(2) syscalls for the event.

5. perf_event_write: Called from the ioctl(2) syscalls for the event.

[1] https://lwn.net/Articles/696240/

Since Peter had suggest LSM hooks in 2016 [1], I am adding his
Suggested-by tag below.

To use this patch, we set the perf_event_paranoid sysctl to -1 and then
apply selinux checking as appropriate (default deny everything, and then
add policy rules to give access to domains that need it). In the future
we can remove the perf_event_paranoid sysctl altogether.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: James Morris <jmorris@namei.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: rostedt@goodmis.org
Cc: Yonghong Song <yhs@fb.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: jeffv@google.com
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: primiano@google.com
Cc: Song Liu <songliubraving@fb.com>
Cc: rsavitski@google.com
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Matthew Garrett <matthewgarrett@google.com>
Link: https://lkml.kernel.org/r/20191014170308.70668-1-joel@joelfernandes.org
---
 arch/powerpc/perf/core-book3s.c     | 18 +++----
 arch/x86/events/intel/bts.c         |  8 +--
 arch/x86/events/intel/core.c        |  5 +-
 arch/x86/events/intel/p4.c          |  5 +-
 include/linux/lsm_hooks.h           | 15 ++++++-
 include/linux/perf_event.h          | 36 ++++++++++++---
 include/linux/security.h            | 38 ++++++++++++++-
 kernel/events/core.c                | 57 ++++++++++++++++++-----
 kernel/trace/trace_event_perf.c     | 15 ++++--
 security/security.c                 | 27 +++++++++++-
 security/selinux/hooks.c            | 69 ++++++++++++++++++++++++++++-
 security/selinux/include/classmap.h |  2 +-
 security/selinux/include/objsec.h   |  6 +-
 13 files changed, 261 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index ca92e01..4860462 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -96,7 +96,7 @@ static inline unsigned long perf_ip_adjust(struct pt_regs *regs)
 {
 	return 0;
 }
-static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp) { }
+static inline void perf_get_data_addr(struct perf_event *event, struct pt_regs *regs, u64 *addrp) { }
 static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 {
 	return 0;
@@ -127,7 +127,7 @@ static unsigned long ebb_switch_in(bool ebb, struct cpu_hw_events *cpuhw)
 static inline void power_pmu_bhrb_enable(struct perf_event *event) {}
 static inline void power_pmu_bhrb_disable(struct perf_event *event) {}
 static void power_pmu_sched_task(struct perf_event_context *ctx, bool sched_in) {}
-static inline void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw) {}
+static inline void power_pmu_bhrb_read(struct perf_event *event, struct cpu_hw_events *cpuhw) {}
 static void pmao_restore_workaround(bool ebb) { }
 #endif /* CONFIG_PPC32 */
 
@@ -179,7 +179,7 @@ static inline unsigned long perf_ip_adjust(struct pt_regs *regs)
  * pointed to by SIAR; this is indicated by the [POWER6_]MMCRA_SDSYNC, the
  * [POWER7P_]MMCRA_SDAR_VALID bit in MMCRA, or the SDAR_VALID bit in SIER.
  */
-static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
+static inline void perf_get_data_addr(struct perf_event *event, struct pt_regs *regs, u64 *addrp)
 {
 	unsigned long mmcra = regs->dsisr;
 	bool sdar_valid;
@@ -204,8 +204,7 @@ static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
 	if (!(mmcra & MMCRA_SAMPLE_ENABLE) || sdar_valid)
 		*addrp = mfspr(SPRN_SDAR);
 
-	if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN) &&
-		is_kernel_addr(mfspr(SPRN_SDAR)))
+	if (is_kernel_addr(mfspr(SPRN_SDAR)) && perf_allow_kernel(&event->attr) != 0)
 		*addrp = 0;
 }
 
@@ -444,7 +443,7 @@ static __u64 power_pmu_bhrb_to(u64 addr)
 }
 
 /* Processing BHRB entries */
-static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
+static void power_pmu_bhrb_read(struct perf_event *event, struct cpu_hw_events *cpuhw)
 {
 	u64 val;
 	u64 addr;
@@ -472,8 +471,7 @@ static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 			 * exporting it to userspace (avoid exposure of regions
 			 * where we could have speculative execution)
 			 */
-			if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN) &&
-				is_kernel_addr(addr))
+			if (is_kernel_addr(addr) && perf_allow_kernel(&event->attr) != 0)
 				continue;
 
 			/* Branches are read most recent first (ie. mfbhrb 0 is
@@ -2087,12 +2085,12 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 
 		if (event->attr.sample_type &
 		    (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR))
-			perf_get_data_addr(regs, &data.addr);
+			perf_get_data_addr(event, regs, &data.addr);
 
 		if (event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK) {
 			struct cpu_hw_events *cpuhw;
 			cpuhw = this_cpu_ptr(&cpu_hw_events);
-			power_pmu_bhrb_read(cpuhw);
+			power_pmu_bhrb_read(event, cpuhw);
 			data.br_stack = &cpuhw->bhrb_stack;
 		}
 
diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 5ee3fed..38de4a7 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -549,9 +549,11 @@ static int bts_event_init(struct perf_event *event)
 	 * Note that the default paranoia setting permits unprivileged
 	 * users to profile the kernel.
 	 */
-	if (event->attr.exclude_kernel && perf_paranoid_kernel() &&
-	    !capable(CAP_SYS_ADMIN))
-		return -EACCES;
+	if (event->attr.exclude_kernel) {
+		ret = perf_allow_kernel(&event->attr);
+		if (ret)
+			return ret;
+	}
 
 	if (x86_add_exclusive(x86_lbr_exclusive_bts))
 		return -EBUSY;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fcef678..bbf6588 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3315,8 +3315,9 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	if (x86_pmu.version < 3)
 		return -EINVAL;
 
-	if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
-		return -EACCES;
+	ret = perf_allow_cpu(&event->attr);
+	if (ret)
+		return ret;
 
 	event->hw.config |= ARCH_PERFMON_EVENTSEL_ANY;
 
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index dee579e..a4cc660 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -776,8 +776,9 @@ static int p4_validate_raw_event(struct perf_event *event)
 	 * the user needs special permissions to be able to use it
 	 */
 	if (p4_ht_active() && p4_event_bind_map[v].shared) {
-		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
-			return -EACCES;
+		v = perf_allow_cpu(&event->attr);
+		if (v)
+			return v;
 	}
 
 	/* ESCR EventMask bits may be invalid */
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a376324..20d8cf1 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1818,6 +1818,14 @@ union security_list_options {
 	void (*bpf_prog_free_security)(struct bpf_prog_aux *aux);
 #endif /* CONFIG_BPF_SYSCALL */
 	int (*locked_down)(enum lockdown_reason what);
+#ifdef CONFIG_PERF_EVENTS
+	int (*perf_event_open)(struct perf_event_attr *attr, int type);
+	int (*perf_event_alloc)(struct perf_event *event);
+	void (*perf_event_free)(struct perf_event *event);
+	int (*perf_event_read)(struct perf_event *event);
+	int (*perf_event_write)(struct perf_event *event);
+
+#endif
 };
 
 struct security_hook_heads {
@@ -2060,6 +2068,13 @@ struct security_hook_heads {
 	struct hlist_head bpf_prog_free_security;
 #endif /* CONFIG_BPF_SYSCALL */
 	struct hlist_head locked_down;
+#ifdef CONFIG_PERF_EVENTS
+	struct hlist_head perf_event_open;
+	struct hlist_head perf_event_alloc;
+	struct hlist_head perf_event_free;
+	struct hlist_head perf_event_read;
+	struct hlist_head perf_event_write;
+#endif
 } __randomize_layout;
 
 /*
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 61448c1..587ae4d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -56,6 +56,7 @@ struct perf_guest_info_callbacks {
 #include <linux/perf_regs.h>
 #include <linux/cgroup.h>
 #include <linux/refcount.h>
+#include <linux/security.h>
 #include <asm/local.h>
 
 struct perf_callchain_entry {
@@ -721,6 +722,9 @@ struct perf_event {
 	struct perf_cgroup		*cgrp; /* cgroup event is attach to */
 #endif
 
+#ifdef CONFIG_SECURITY
+	void *security;
+#endif
 	struct list_head		sb_list;
 #endif /* CONFIG_PERF_EVENTS */
 };
@@ -1241,19 +1245,41 @@ extern int perf_cpu_time_max_percent_handler(struct ctl_table *table, int write,
 int perf_event_max_stack_handler(struct ctl_table *table, int write,
 				 void __user *buffer, size_t *lenp, loff_t *ppos);
 
-static inline bool perf_paranoid_tracepoint_raw(void)
+/* Access to perf_event_open(2) syscall. */
+#define PERF_SECURITY_OPEN		0
+
+/* Finer grained perf_event_open(2) access control. */
+#define PERF_SECURITY_CPU		1
+#define PERF_SECURITY_KERNEL		2
+#define PERF_SECURITY_TRACEPOINT	3
+
+static inline int perf_is_paranoid(void)
 {
 	return sysctl_perf_event_paranoid > -1;
 }
 
-static inline bool perf_paranoid_cpu(void)
+static inline int perf_allow_kernel(struct perf_event_attr *attr)
 {
-	return sysctl_perf_event_paranoid > 0;
+	if (sysctl_perf_event_paranoid > 1 && !capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	return security_perf_event_open(attr, PERF_SECURITY_KERNEL);
 }
 
-static inline bool perf_paranoid_kernel(void)
+static inline int perf_allow_cpu(struct perf_event_attr *attr)
 {
-	return sysctl_perf_event_paranoid > 1;
+	if (sysctl_perf_event_paranoid > 0 && !capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	return security_perf_event_open(attr, PERF_SECURITY_CPU);
+}
+
+static inline int perf_allow_tracepoint(struct perf_event_attr *attr)
+{
+	if (sysctl_perf_event_paranoid > -1 && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return security_perf_event_open(attr, PERF_SECURITY_TRACEPOINT);
 }
 
 extern void perf_event_init(void);
diff --git a/include/linux/security.h b/include/linux/security.h
index a8d59d6..4df79ff 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1894,5 +1894,41 @@ static inline void security_bpf_prog_free(struct bpf_prog_aux *aux)
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_BPF_SYSCALL */
 
-#endif /* ! __LINUX_SECURITY_H */
+#ifdef CONFIG_PERF_EVENTS
+struct perf_event_attr;
+
+#ifdef CONFIG_SECURITY
+extern int security_perf_event_open(struct perf_event_attr *attr, int type);
+extern int security_perf_event_alloc(struct perf_event *event);
+extern void security_perf_event_free(struct perf_event *event);
+extern int security_perf_event_read(struct perf_event *event);
+extern int security_perf_event_write(struct perf_event *event);
+#else
+static inline int security_perf_event_open(struct perf_event_attr *attr,
+					   int type)
+{
+	return 0;
+}
+
+static inline int security_perf_event_alloc(struct perf_event *event)
+{
+	return 0;
+}
+
+static inline void security_perf_event_free(struct perf_event *event)
+{
+}
+
+static inline int security_perf_event_read(struct perf_event *event)
+{
+	return 0;
+}
 
+static inline int security_perf_event_write(struct perf_event *event)
+{
+	return 0;
+}
+#endif /* CONFIG_SECURITY */
+#endif /* CONFIG_PERF_EVENTS */
+
+#endif /* ! __LINUX_SECURITY_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9ec0b0b..f9a5d43 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4229,8 +4229,9 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 
 	if (!task) {
 		/* Must be root to operate on a CPU event: */
-		if (perf_paranoid_cpu() && !capable(CAP_SYS_ADMIN))
-			return ERR_PTR(-EACCES);
+		err = perf_allow_cpu(&event->attr);
+		if (err)
+			return ERR_PTR(err);
 
 		cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
 		ctx = &cpuctx->ctx;
@@ -4539,6 +4540,8 @@ static void _free_event(struct perf_event *event)
 
 	unaccount_event(event);
 
+	security_perf_event_free(event);
+
 	if (event->rb) {
 		/*
 		 * Can happen when we close an event with re-directed output.
@@ -4992,6 +4995,10 @@ perf_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	struct perf_event_context *ctx;
 	int ret;
 
+	ret = security_perf_event_read(event);
+	if (ret)
+		return ret;
+
 	ctx = perf_event_ctx_lock(event);
 	ret = __perf_read(event, buf, count);
 	perf_event_ctx_unlock(event, ctx);
@@ -5256,6 +5263,11 @@ static long perf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct perf_event_context *ctx;
 	long ret;
 
+	/* Treat ioctl like writes as it is likely a mutating operation. */
+	ret = security_perf_event_write(event);
+	if (ret)
+		return ret;
+
 	ctx = perf_event_ctx_lock(event);
 	ret = _perf_ioctl(event, cmd, arg);
 	perf_event_ctx_unlock(event, ctx);
@@ -5719,6 +5731,10 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
+	ret = security_perf_event_read(event);
+	if (ret)
+		return ret;
+
 	vma_size = vma->vm_end - vma->vm_start;
 
 	if (vma->vm_pgoff == 0) {
@@ -5844,7 +5860,7 @@ accounting:
 	lock_limit >>= PAGE_SHIFT;
 	locked = atomic64_read(&vma->vm_mm->pinned_vm) + extra;
 
-	if ((locked > lock_limit) && perf_paranoid_tracepoint_raw() &&
+	if ((locked > lock_limit) && perf_is_paranoid() &&
 		!capable(CAP_IPC_LOCK)) {
 		ret = -EPERM;
 		goto unlock;
@@ -10578,11 +10594,20 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		}
 	}
 
+	err = security_perf_event_alloc(event);
+	if (err)
+		goto err_callchain_buffer;
+
 	/* symmetric to unaccount_event() in _free_event() */
 	account_event(event);
 
 	return event;
 
+err_callchain_buffer:
+	if (!event->parent) {
+		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+			put_callchain_buffers();
+	}
 err_addr_filters:
 	kfree(event->addr_filter_ranges);
 
@@ -10671,9 +10696,11 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			attr->branch_sample_type = mask;
 		}
 		/* privileged levels capture (kernel, hv): check permissions */
-		if ((mask & PERF_SAMPLE_BRANCH_PERM_PLM)
-		    && perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-			return -EACCES;
+		if (mask & PERF_SAMPLE_BRANCH_PERM_PLM) {
+			ret = perf_allow_kernel(attr);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (attr->sample_type & PERF_SAMPLE_REGS_USER) {
@@ -10886,13 +10913,19 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (flags & ~PERF_FLAG_ALL)
 		return -EINVAL;
 
+	/* Do we allow access to perf_event_open(2) ? */
+	err = security_perf_event_open(&attr, PERF_SECURITY_OPEN);
+	if (err)
+		return err;
+
 	err = perf_copy_attr(attr_uptr, &attr);
 	if (err)
 		return err;
 
 	if (!attr.exclude_kernel) {
-		if (perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-			return -EACCES;
+		err = perf_allow_kernel(&attr);
+		if (err)
+			return err;
 	}
 
 	if (attr.namespaces) {
@@ -10909,9 +10942,11 @@ SYSCALL_DEFINE5(perf_event_open,
 	}
 
 	/* Only privileged users can get physical addresses */
-	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR) &&
-	    perf_paranoid_kernel() && !capable(CAP_SYS_ADMIN))
-		return -EACCES;
+	if ((attr.sample_type & PERF_SAMPLE_PHYS_ADDR)) {
+		err = perf_allow_kernel(&attr);
+		if (err)
+			return err;
+	}
 
 	err = security_locked_down(LOCKDOWN_PERF);
 	if (err && (attr.sample_type & PERF_SAMPLE_REGS_INTR))
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 0892e38..0917fee 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -8,6 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/kprobes.h>
+#include <linux/security.h>
 #include "trace.h"
 #include "trace_probe.h"
 
@@ -26,8 +27,10 @@ static int	total_ref_count;
 static int perf_trace_event_perm(struct trace_event_call *tp_event,
 				 struct perf_event *p_event)
 {
+	int ret;
+
 	if (tp_event->perf_perm) {
-		int ret = tp_event->perf_perm(tp_event, p_event);
+		ret = tp_event->perf_perm(tp_event, p_event);
 		if (ret)
 			return ret;
 	}
@@ -46,8 +49,9 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
 
 	/* The ftrace function trace is allowed only for root. */
 	if (ftrace_event_is_function(tp_event)) {
-		if (perf_paranoid_tracepoint_raw() && !capable(CAP_SYS_ADMIN))
-			return -EPERM;
+		ret = perf_allow_tracepoint(&p_event->attr);
+		if (ret)
+			return ret;
 
 		if (!is_sampling_event(p_event))
 			return 0;
@@ -82,8 +86,9 @@ static int perf_trace_event_perm(struct trace_event_call *tp_event,
 	 * ...otherwise raw tracepoint data can be a severe data leak,
 	 * only allow root to have these.
 	 */
-	if (perf_paranoid_tracepoint_raw() && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
+	ret = perf_allow_tracepoint(&p_event->attr);
+	if (ret)
+		return ret;
 
 	return 0;
 }
diff --git a/security/security.c b/security/security.c
index 1bc000f..cd2d18d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2404,3 +2404,30 @@ int security_locked_down(enum lockdown_reason what)
 	return call_int_hook(locked_down, 0, what);
 }
 EXPORT_SYMBOL(security_locked_down);
+
+#ifdef CONFIG_PERF_EVENTS
+int security_perf_event_open(struct perf_event_attr *attr, int type)
+{
+	return call_int_hook(perf_event_open, 0, attr, type);
+}
+
+int security_perf_event_alloc(struct perf_event *event)
+{
+	return call_int_hook(perf_event_alloc, 0, event);
+}
+
+void security_perf_event_free(struct perf_event *event)
+{
+	call_void_hook(perf_event_free, event);
+}
+
+int security_perf_event_read(struct perf_event *event)
+{
+	return call_int_hook(perf_event_read, 0, event);
+}
+
+int security_perf_event_write(struct perf_event *event)
+{
+	return call_int_hook(perf_event_write, 0, event);
+}
+#endif /* CONFIG_PERF_EVENTS */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9625b99..28eb054 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6795,6 +6795,67 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 	.lbs_msg_msg = sizeof(struct msg_security_struct),
 };
 
+#ifdef CONFIG_PERF_EVENTS
+static int selinux_perf_event_open(struct perf_event_attr *attr, int type)
+{
+	u32 requested, sid = current_sid();
+
+	if (type == PERF_SECURITY_OPEN)
+		requested = PERF_EVENT__OPEN;
+	else if (type == PERF_SECURITY_CPU)
+		requested = PERF_EVENT__CPU;
+	else if (type == PERF_SECURITY_KERNEL)
+		requested = PERF_EVENT__KERNEL;
+	else if (type == PERF_SECURITY_TRACEPOINT)
+		requested = PERF_EVENT__TRACEPOINT;
+	else
+		return -EINVAL;
+
+	return avc_has_perm(&selinux_state, sid, sid, SECCLASS_PERF_EVENT,
+			    requested, NULL);
+}
+
+static int selinux_perf_event_alloc(struct perf_event *event)
+{
+	struct perf_event_security_struct *perfsec;
+
+	perfsec = kzalloc(sizeof(*perfsec), GFP_KERNEL);
+	if (!perfsec)
+		return -ENOMEM;
+
+	perfsec->sid = current_sid();
+	event->security = perfsec;
+
+	return 0;
+}
+
+static void selinux_perf_event_free(struct perf_event *event)
+{
+	struct perf_event_security_struct *perfsec = event->security;
+
+	event->security = NULL;
+	kfree(perfsec);
+}
+
+static int selinux_perf_event_read(struct perf_event *event)
+{
+	struct perf_event_security_struct *perfsec = event->security;
+	u32 sid = current_sid();
+
+	return avc_has_perm(&selinux_state, sid, perfsec->sid,
+			    SECCLASS_PERF_EVENT, PERF_EVENT__READ, NULL);
+}
+
+static int selinux_perf_event_write(struct perf_event *event)
+{
+	struct perf_event_security_struct *perfsec = event->security;
+	u32 sid = current_sid();
+
+	return avc_has_perm(&selinux_state, sid, perfsec->sid,
+			    SECCLASS_PERF_EVENT, PERF_EVENT__WRITE, NULL);
+}
+#endif
+
 static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
@@ -7030,6 +7091,14 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
 	LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
 #endif
+
+#ifdef CONFIG_PERF_EVENTS
+	LSM_HOOK_INIT(perf_event_open, selinux_perf_event_open),
+	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
+	LSM_HOOK_INIT(perf_event_free, selinux_perf_event_free),
+	LSM_HOOK_INIT(perf_event_read, selinux_perf_event_read),
+	LSM_HOOK_INIT(perf_event_write, selinux_perf_event_write),
+#endif
 };
 
 static __init int selinux_init(void)
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 32e9b03..7db2485 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -244,6 +244,8 @@ struct security_class_mapping secclass_map[] = {
 	  {"map_create", "map_read", "map_write", "prog_load", "prog_run"} },
 	{ "xdp_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
+	{ "perf_event",
+	  {"open", "cpu", "kernel", "tracepoint", "read", "write"} },
 	{ NULL }
   };
 
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index 586b7ab..a4a86cb 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -141,7 +141,11 @@ struct pkey_security_struct {
 };
 
 struct bpf_security_struct {
-	u32 sid;  /*SID of bpf obj creater*/
+	u32 sid;  /* SID of bpf obj creator */
+};
+
+struct perf_event_security_struct {
+	u32 sid;  /* SID of perf_event obj creator */
 };
 
 extern struct lsm_blob_sizes selinux_blob_sizes;
