Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A09041399BE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Jan 2020 20:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgAMTKY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 13 Jan 2020 14:10:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39988 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgAMTJz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 13 Jan 2020 14:09:55 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ir55y-00018u-0F; Mon, 13 Jan 2020 20:09:50 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9B44E1C18DA;
        Mon, 13 Jan 2020 20:09:31 +0100 (CET)
Date:   Mon, 13 Jan 2020 19:09:31 -0000
From:   "tip-bot2 for Andrei Vagin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ns: Introduce Time Namespace
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-4-dima@arista.com>
References: <20191112012724.250792-4-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157894257147.19145.13550617182390797646.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8a0093f91318cb4117d85f871701b575442c32a1
Gitweb:        https://git.kernel.org/tip/8a0093f91318cb4117d85f871701b575442c32a1
Author:        Andrei Vagin <avagin@openvz.org>
AuthorDate:    Tue, 12 Nov 2019 01:26:52 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 13 Jan 2020 08:10:47 +01:00

ns: Introduce Time Namespace

Time Namespace isolates clock values.

The kernel provides access to several clocks CLOCK_REALTIME,
CLOCK_MONOTONIC, CLOCK_BOOTTIME, etc.

CLOCK_REALTIME
      System-wide clock that measures real (i.e., wall-clock) time.

CLOCK_MONOTONIC
      Clock that cannot be set and represents monotonic time since
      some unspecified starting point.

CLOCK_BOOTTIME
      Identical to CLOCK_MONOTONIC, except it also includes any time
      that the system is suspended.

For many users, the time namespace means the ability to changes date and
time in a container (CLOCK_REALTIME). Providing per namespace notions of
CLOCK_REALTIME would be complex with a massive overhead, but has a dubious
value.

But in the context of checkpoint/restore functionality, monotonic and
boottime clocks become interesting. Both clocks are monotonic with
unspecified starting points. These clocks are widely used to measure time
slices and set timers. After restoring or migrating processes, it has to be
guaranteed that they never go backward. In an ideal case, the behavior of
these clocks should be the same as for a case when a whole system is
suspended. All this means that it is required to set CLOCK_MONOTONIC and
CLOCK_BOOTTIME clocks, which can be achieved by adding per-namespace
offsets for clocks.

A time namespace is similar to a pid namespace in the way how it is
created: unshare(CLONE_NEWTIME) system call creates a new time namespace,
but doesn't set it to the current process. Then all children of the process
will be born in the new time namespace, or a process can use the setns()
system call to join a namespace.

This scheme allows setting clock offsets for a namespace, before any
processes appear in it.

All available clone flags have been used, so CLONE_NEWTIME uses the highest
bit of CSIGNAL. It means that it can be used only with the unshare() and
the clone3() system calls.

[ tglx: Adjusted paragraph about clone3() to reality and massaged the
  	changelog a bit. ]

Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://criu.org/Time_namespace
Link: https://lists.openvz.org/pipermail/criu/2018-June/041504.html
Link: https://lore.kernel.org/r/20191112012724.250792-4-dima@arista.com

---
 MAINTAINERS                    |   2 +-
 fs/proc/namespaces.c           |   4 +-
 include/linux/nsproxy.h        |   2 +-
 include/linux/proc_ns.h        |   3 +-
 include/linux/time_namespace.h |  71 ++++++++++-
 include/linux/user_namespace.h |   1 +-
 include/uapi/linux/sched.h     |   6 +-
 init/Kconfig                   |   7 +-
 kernel/fork.c                  |  16 +-
 kernel/nsproxy.c               |  41 ++++--
 kernel/time/Makefile           |   1 +-
 kernel/time/namespace.c        | 217 ++++++++++++++++++++++++++++++++-
 12 files changed, 361 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/time_namespace.h
 create mode 100644 kernel/time/namespace.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8982c6e..f6d0002 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13214,6 +13214,8 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
 S:	Maintained
 F:	fs/timerfd.c
 F:	include/linux/timer*
+F:	include/linux/time_namespace.h
+F:	kernel/time_namespace.c
 F:	kernel/time/*timer*
 
 POWER MANAGEMENT CORE
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index dd2b35f..8b5c720 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -33,6 +33,10 @@ static const struct proc_ns_operations *ns_entries[] = {
 #ifdef CONFIG_CGROUPS
 	&cgroupns_operations,
 #endif
+#ifdef CONFIG_TIME_NS
+	&timens_operations,
+	&timens_for_children_operations,
+#endif
 };
 
 static const char *proc_ns_get_link(struct dentry *dentry,
diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index 2ae1b1a..074f395 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -35,6 +35,8 @@ struct nsproxy {
 	struct mnt_namespace *mnt_ns;
 	struct pid_namespace *pid_ns_for_children;
 	struct net 	     *net_ns;
+	struct time_namespace *time_ns;
+	struct time_namespace *time_ns_for_children;
 	struct cgroup_namespace *cgroup_ns;
 };
 extern struct nsproxy init_nsproxy;
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index d31cb62..d312e62 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -32,6 +32,8 @@ extern const struct proc_ns_operations pidns_for_children_operations;
 extern const struct proc_ns_operations userns_operations;
 extern const struct proc_ns_operations mntns_operations;
 extern const struct proc_ns_operations cgroupns_operations;
+extern const struct proc_ns_operations timens_operations;
+extern const struct proc_ns_operations timens_for_children_operations;
 
 /*
  * We always define these enumerators
@@ -43,6 +45,7 @@ enum {
 	PROC_USER_INIT_INO	= 0xEFFFFFFDU,
 	PROC_PID_INIT_INO	= 0xEFFFFFFCU,
 	PROC_CGROUP_INIT_INO	= 0xEFFFFFFBU,
+	PROC_TIME_INIT_INO	= 0xEFFFFFFAU,
 };
 
 #ifdef CONFIG_PROC_FS
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
new file mode 100644
index 0000000..8c74cc1
--- /dev/null
+++ b/include/linux/time_namespace.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TIMENS_H
+#define _LINUX_TIMENS_H
+
+
+#include <linux/sched.h>
+#include <linux/kref.h>
+#include <linux/nsproxy.h>
+#include <linux/ns_common.h>
+#include <linux/err.h>
+
+struct user_namespace;
+extern struct user_namespace init_user_ns;
+
+struct time_namespace {
+	struct kref		kref;
+	struct user_namespace	*user_ns;
+	struct ucounts		*ucounts;
+	struct ns_common	ns;
+} __randomize_layout;
+
+extern struct time_namespace init_time_ns;
+
+#ifdef CONFIG_TIME_NS
+static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
+{
+	kref_get(&ns->kref);
+	return ns;
+}
+
+struct time_namespace *copy_time_ns(unsigned long flags,
+				    struct user_namespace *user_ns,
+				    struct time_namespace *old_ns);
+void free_time_ns(struct kref *kref);
+int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk);
+
+static inline void put_time_ns(struct time_namespace *ns)
+{
+	kref_put(&ns->kref, free_time_ns);
+}
+
+#else
+static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
+{
+	return NULL;
+}
+
+static inline void put_time_ns(struct time_namespace *ns)
+{
+}
+
+static inline
+struct time_namespace *copy_time_ns(unsigned long flags,
+				    struct user_namespace *user_ns,
+				    struct time_namespace *old_ns)
+{
+	if (flags & CLONE_NEWTIME)
+		return ERR_PTR(-EINVAL);
+
+	return old_ns;
+}
+
+static inline int timens_on_fork(struct nsproxy *nsproxy,
+				 struct task_struct *tsk)
+{
+	return 0;
+}
+
+#endif
+
+#endif /* _LINUX_TIMENS_H */
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index fb9f4f7..6ef1c71 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -45,6 +45,7 @@ enum ucount_type {
 	UCOUNT_NET_NAMESPACES,
 	UCOUNT_MNT_NAMESPACES,
 	UCOUNT_CGROUP_NAMESPACES,
+	UCOUNT_TIME_NAMESPACES,
 #ifdef CONFIG_INOTIFY_USER
 	UCOUNT_INOTIFY_INSTANCES,
 	UCOUNT_INOTIFY_WATCHES,
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 4a02178..2e3bc22 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -36,6 +36,12 @@
 /* Flags for the clone3() syscall. */
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
 
+/*
+ * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
+ * syscalls only:
+ */
+#define CLONE_NEWTIME	0x00000080	/* New time namespace */
+
 #ifndef __ASSEMBLY__
 /**
  * struct clone_args - arguments for the clone3 syscall
diff --git a/init/Kconfig b/init/Kconfig
index a34064a..b34314f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1080,6 +1080,13 @@ config UTS_NS
 	  In this namespace tasks see different info provided with the
 	  uname() system call
 
+config TIME_NS
+	bool "TIME namespace"
+	default y
+	help
+	  In this namespace boottime and monotonic clocks can be set.
+	  The time will keep going with the same pace.
+
 config IPC_NS
 	bool "IPC namespace"
 	depends on (SYSVIPC || POSIX_MQUEUE)
diff --git a/kernel/fork.c b/kernel/fork.c
index 2508a4f..3635958 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1832,6 +1832,7 @@ static __latent_entropy struct task_struct *copy_process(
 	struct multiprocess_signals delayed;
 	struct file *pidfile = NULL;
 	u64 clone_flags = args->flags;
+	struct nsproxy *nsp = current->nsproxy;
 
 	/*
 	 * Don't allow sharing the root directory with processes in a different
@@ -1874,8 +1875,16 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 	if (clone_flags & CLONE_THREAD) {
 		if ((clone_flags & (CLONE_NEWUSER | CLONE_NEWPID)) ||
-		    (task_active_pid_ns(current) !=
-				current->nsproxy->pid_ns_for_children))
+		    (task_active_pid_ns(current) != nsp->pid_ns_for_children))
+			return ERR_PTR(-EINVAL);
+	}
+
+	/*
+	 * If the new process will be in a different time namespace
+	 * do not allow it to share VM or a thread group with the forking task.
+	 */
+	if (clone_flags & (CLONE_THREAD | CLONE_VM)) {
+		if (nsp->time_ns != nsp->time_ns_for_children)
 			return ERR_PTR(-EINVAL);
 	}
 
@@ -2811,7 +2820,8 @@ static int check_unshare_flags(unsigned long unshare_flags)
 	if (unshare_flags & ~(CLONE_THREAD|CLONE_FS|CLONE_NEWNS|CLONE_SIGHAND|
 				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|
 				CLONE_NEWUTS|CLONE_NEWIPC|CLONE_NEWNET|
-				CLONE_NEWUSER|CLONE_NEWPID|CLONE_NEWCGROUP))
+				CLONE_NEWUSER|CLONE_NEWPID|CLONE_NEWCGROUP|
+				CLONE_NEWTIME))
 		return -EINVAL;
 	/*
 	 * Not implemented, but pretend it works if there is nothing
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index c815f58..ed98821 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -18,6 +18,7 @@
 #include <linux/pid_namespace.h>
 #include <net/net_namespace.h>
 #include <linux/ipc_namespace.h>
+#include <linux/time_namespace.h>
 #include <linux/proc_ns.h>
 #include <linux/file.h>
 #include <linux/syscalls.h>
@@ -40,6 +41,10 @@ struct nsproxy init_nsproxy = {
 #ifdef CONFIG_CGROUPS
 	.cgroup_ns		= &init_cgroup_ns,
 #endif
+#ifdef CONFIG_TIME_NS
+	.time_ns		= &init_time_ns,
+	.time_ns_for_children	= &init_time_ns,
+#endif
 };
 
 static inline struct nsproxy *create_nsproxy(void)
@@ -106,8 +111,18 @@ static struct nsproxy *create_new_namespaces(unsigned long flags,
 		goto out_net;
 	}
 
+	new_nsp->time_ns_for_children = copy_time_ns(flags, user_ns,
+					tsk->nsproxy->time_ns_for_children);
+	if (IS_ERR(new_nsp->time_ns_for_children)) {
+		err = PTR_ERR(new_nsp->time_ns_for_children);
+		goto out_time;
+	}
+	new_nsp->time_ns = get_time_ns(tsk->nsproxy->time_ns);
+
 	return new_nsp;
 
+out_time:
+	put_net(new_nsp->net_ns);
 out_net:
 	put_cgroup_ns(new_nsp->cgroup_ns);
 out_cgroup:
@@ -136,15 +151,16 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 	struct nsproxy *old_ns = tsk->nsproxy;
 	struct user_namespace *user_ns = task_cred_xxx(tsk, user_ns);
 	struct nsproxy *new_ns;
+	int ret;
 
 	if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
 			      CLONE_NEWPID | CLONE_NEWNET |
-			      CLONE_NEWCGROUP)))) {
-		get_nsproxy(old_ns);
-		return 0;
-	}
-
-	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
+			      CLONE_NEWCGROUP | CLONE_NEWTIME)))) {
+		if (likely(old_ns->time_ns_for_children == old_ns->time_ns)) {
+			get_nsproxy(old_ns);
+			return 0;
+		}
+	} else if (!ns_capable(user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	/*
@@ -162,6 +178,12 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 	if (IS_ERR(new_ns))
 		return  PTR_ERR(new_ns);
 
+	ret = timens_on_fork(new_ns, tsk);
+	if (ret) {
+		free_nsproxy(new_ns);
+		return ret;
+	}
+
 	tsk->nsproxy = new_ns;
 	return 0;
 }
@@ -176,6 +198,10 @@ void free_nsproxy(struct nsproxy *ns)
 		put_ipc_ns(ns->ipc_ns);
 	if (ns->pid_ns_for_children)
 		put_pid_ns(ns->pid_ns_for_children);
+	if (ns->time_ns)
+		put_time_ns(ns->time_ns);
+	if (ns->time_ns_for_children)
+		put_time_ns(ns->time_ns_for_children);
 	put_cgroup_ns(ns->cgroup_ns);
 	put_net(ns->net_ns);
 	kmem_cache_free(nsproxy_cachep, ns);
@@ -192,7 +218,8 @@ int unshare_nsproxy_namespaces(unsigned long unshare_flags,
 	int err = 0;
 
 	if (!(unshare_flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
-			       CLONE_NEWNET | CLONE_NEWPID | CLONE_NEWCGROUP)))
+			       CLONE_NEWNET | CLONE_NEWPID | CLONE_NEWCGROUP |
+			       CLONE_NEWTIME)))
 		return 0;
 
 	user_ns = new_cred ? new_cred->user_ns : current_user_ns();
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index 1867044..c8f0016 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_TICK_ONESHOT)			+= tick-oneshot.o tick-sched.o
 obj-$(CONFIG_HAVE_GENERIC_VDSO)			+= vsyscall.o
 obj-$(CONFIG_DEBUG_FS)				+= timekeeping_debug.o
 obj-$(CONFIG_TEST_UDELAY)			+= test_udelay.o
+obj-$(CONFIG_TIME_NS)				+= namespace.o
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
new file mode 100644
index 0000000..2662a69
--- /dev/null
+++ b/kernel/time/namespace.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Author: Andrei Vagin <avagin@openvz.org>
+ * Author: Dmitry Safonov <dima@arista.com>
+ */
+
+#include <linux/time_namespace.h>
+#include <linux/user_namespace.h>
+#include <linux/sched/signal.h>
+#include <linux/sched/task.h>
+#include <linux/proc_ns.h>
+#include <linux/export.h>
+#include <linux/time.h>
+#include <linux/slab.h>
+#include <linux/cred.h>
+#include <linux/err.h>
+
+static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
+{
+	return inc_ucount(ns, current_euid(), UCOUNT_TIME_NAMESPACES);
+}
+
+static void dec_time_namespaces(struct ucounts *ucounts)
+{
+	dec_ucount(ucounts, UCOUNT_TIME_NAMESPACES);
+}
+
+/**
+ * clone_time_ns - Clone a time namespace
+ * @user_ns:	User namespace which owns a new namespace.
+ * @old_ns:	Namespace to clone
+ *
+ * Clone @old_ns and set the clone refcount to 1
+ *
+ * Return: The new namespace or ERR_PTR.
+ */
+static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
+					  struct time_namespace *old_ns)
+{
+	struct time_namespace *ns;
+	struct ucounts *ucounts;
+	int err;
+
+	err = -ENOSPC;
+	ucounts = inc_time_namespaces(user_ns);
+	if (!ucounts)
+		goto fail;
+
+	err = -ENOMEM;
+	ns = kmalloc(sizeof(*ns), GFP_KERNEL);
+	if (!ns)
+		goto fail_dec;
+
+	kref_init(&ns->kref);
+
+	err = ns_alloc_inum(&ns->ns);
+	if (err)
+		goto fail_free;
+
+	ns->ucounts = ucounts;
+	ns->ns.ops = &timens_operations;
+	ns->user_ns = get_user_ns(user_ns);
+	return ns;
+
+fail_free:
+	kfree(ns);
+fail_dec:
+	dec_time_namespaces(ucounts);
+fail:
+	return ERR_PTR(err);
+}
+
+/**
+ * copy_time_ns - Create timens_for_children from @old_ns
+ * @flags:	Cloning flags
+ * @user_ns:	User namespace which owns a new namespace.
+ * @old_ns:	Namespace to clone
+ *
+ * If CLONE_NEWTIME specified in @flags, creates a new timens_for_children;
+ * adds a refcounter to @old_ns otherwise.
+ *
+ * Return: timens_for_children namespace or ERR_PTR.
+ */
+struct time_namespace *copy_time_ns(unsigned long flags,
+	struct user_namespace *user_ns, struct time_namespace *old_ns)
+{
+	if (!(flags & CLONE_NEWTIME))
+		return get_time_ns(old_ns);
+
+	return clone_time_ns(user_ns, old_ns);
+}
+
+void free_time_ns(struct kref *kref)
+{
+	struct time_namespace *ns;
+
+	ns = container_of(kref, struct time_namespace, kref);
+	dec_time_namespaces(ns->ucounts);
+	put_user_ns(ns->user_ns);
+	ns_free_inum(&ns->ns);
+	kfree(ns);
+}
+
+static struct time_namespace *to_time_ns(struct ns_common *ns)
+{
+	return container_of(ns, struct time_namespace, ns);
+}
+
+static struct ns_common *timens_get(struct task_struct *task)
+{
+	struct time_namespace *ns = NULL;
+	struct nsproxy *nsproxy;
+
+	task_lock(task);
+	nsproxy = task->nsproxy;
+	if (nsproxy) {
+		ns = nsproxy->time_ns;
+		get_time_ns(ns);
+	}
+	task_unlock(task);
+
+	return ns ? &ns->ns : NULL;
+}
+
+static struct ns_common *timens_for_children_get(struct task_struct *task)
+{
+	struct time_namespace *ns = NULL;
+	struct nsproxy *nsproxy;
+
+	task_lock(task);
+	nsproxy = task->nsproxy;
+	if (nsproxy) {
+		ns = nsproxy->time_ns_for_children;
+		get_time_ns(ns);
+	}
+	task_unlock(task);
+
+	return ns ? &ns->ns : NULL;
+}
+
+static void timens_put(struct ns_common *ns)
+{
+	put_time_ns(to_time_ns(ns));
+}
+
+static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
+{
+	struct time_namespace *ns = to_time_ns(new);
+
+	if (!current_is_single_threaded())
+		return -EUSERS;
+
+	if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN) ||
+	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
+		return -EPERM;
+
+	get_time_ns(ns);
+	put_time_ns(nsproxy->time_ns);
+	nsproxy->time_ns = ns;
+
+	get_time_ns(ns);
+	put_time_ns(nsproxy->time_ns_for_children);
+	nsproxy->time_ns_for_children = ns;
+	return 0;
+}
+
+int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
+{
+	struct ns_common *nsc = &nsproxy->time_ns_for_children->ns;
+	struct time_namespace *ns = to_time_ns(nsc);
+
+	/* create_new_namespaces() already incremented the ref counter */
+	if (nsproxy->time_ns == nsproxy->time_ns_for_children)
+		return 0;
+
+	get_time_ns(ns);
+	put_time_ns(nsproxy->time_ns);
+	nsproxy->time_ns = ns;
+
+	return 0;
+}
+
+static struct user_namespace *timens_owner(struct ns_common *ns)
+{
+	return to_time_ns(ns)->user_ns;
+}
+
+const struct proc_ns_operations timens_operations = {
+	.name		= "time",
+	.type		= CLONE_NEWTIME,
+	.get		= timens_get,
+	.put		= timens_put,
+	.install	= timens_install,
+	.owner		= timens_owner,
+};
+
+const struct proc_ns_operations timens_for_children_operations = {
+	.name		= "time_for_children",
+	.type		= CLONE_NEWTIME,
+	.get		= timens_for_children_get,
+	.put		= timens_put,
+	.install	= timens_install,
+	.owner		= timens_owner,
+};
+
+struct time_namespace init_time_ns = {
+	.kref		= KREF_INIT(3),
+	.user_ns	= &init_user_ns,
+	.ns.inum	= PROC_TIME_INIT_INO,
+	.ns.ops		= &timens_operations,
+};
+
+static int __init time_ns_init(void)
+{
+	return 0;
+}
+subsys_initcall(time_ns_init);
