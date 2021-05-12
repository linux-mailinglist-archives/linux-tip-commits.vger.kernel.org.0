Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BC637BA54
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhELK3b (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50342 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhELK3a (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:30 -0400
Date:   Wed, 12 May 2021 10:28:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815301;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LLlJ52VpL9DC6ynOsJikgYCbV/jrqDwpAwzTtzdnE6w=;
        b=RJdS4/pfy4QH4k5wZhpCvj0j09HkHad0/UW4b4P30FeZaodejrFDEuOkU612JVMWOdjjY7
        iPoskdUNyRkgFc/b2db40QRcUDe+14e7Z6fjT92U0I6K+GgzABRsFgY+b9/VX3naenZfQC
        k/end1xkM9anY8/qltHKP9YLKYCTiIbFUUMAYe+isNEwZC6PUjMM2itXXSGYE6LqKCoP8S
        H4vwLZWwW/6g3qsSO2aPznbEkd+EWmMZbS0Ac4ulJCEB00mPjWxeaDD48Jhn0Nv9E6cGZb
        YJnjuADDN9u9cakE/GO60lv9hTzmeejA5TfuqUqX1HTZ9nYAZGnCn4D3ov6OyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815301;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LLlJ52VpL9DC6ynOsJikgYCbV/jrqDwpAwzTtzdnE6w=;
        b=lQcM7sbYz1w4YicqEjOlqBNMFu5LCt+ZvIVqfpGtKrKq/FfhE5ZUTPebUPWsRb9J3QDQAP
        oPKrq40dsyLSlqAQ==
From:   "tip-bot2 for Chris Hyser" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: prctl() core-scheduling interface
Cc:     Chris Hyser <chris.hyser@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422123309.039845339@infradead.org>
References: <20210422123309.039845339@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530085.29796.9178006900954139428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7ac592aa35a684ff1858fb9ec282886b9e3575ac
Gitweb:        https://git.kernel.org/tip/7ac592aa35a684ff1858fb9ec282886b9e3575ac
Author:        Chris Hyser <chris.hyser@oracle.com>
AuthorDate:    Wed, 24 Mar 2021 17:40:15 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:31 +02:00

sched: prctl() core-scheduling interface

This patch provides support for setting and copying core scheduling
'task cookies' between threads (PID), processes (TGID), and process
groups (PGID).

The value of core scheduling isn't that tasks don't share a core,
'nosmt' can do that. The value lies in exploiting all the sharing
opportunities that exist to recover possible lost performance and that
requires a degree of flexibility in the API.

>From a security perspective (and there are others), the thread,
process and process group distinction is an existent hierarchal
categorization of tasks that reflects many of the security concerns
about 'data sharing'. For example, protecting against cache-snooping
by a thread that can just read the memory directly isn't all that
useful.

With this in mind, subcommands to CREATE/SHARE (TO/FROM) provide a
mechanism to create and share cookies. CREATE/SHARE_TO specify a
target pid with enum pidtype used to specify the scope of the targeted
tasks. For example, PIDTYPE_TGID will share the cookie with the
process and all of it's threads as typically desired in a security
scenario.

API:

  prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, tgtpid, pidtype, &cookie)
  prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, tgtpid, pidtype, NULL)
  prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, tgtpid, pidtype, NULL)
  prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, srcpid, pidtype, NULL)

where 'tgtpid/srcpid == 0' implies the current process and pidtype is
kernel enum pid_type {PIDTYPE_PID, PIDTYPE_TGID, PIDTYPE_PGID, ...}.

For return values, EINVAL, ENOMEM are what they say. ESRCH means the
tgtpid/srcpid was not found. EPERM indicates lack of PTRACE permission
access to tgtpid/srcpid. ENODEV indicates your machines lacks SMT.

[peterz: complete rewrite]
Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210422123309.039845339@infradead.org
---
 include/linux/sched.h            |   2 +-
 include/uapi/linux/prctl.h       |   8 ++-
 kernel/sched/core_sched.c        | 114 ++++++++++++++++++++++++++++++-
 kernel/sys.c                     |   5 +-
 tools/include/uapi/linux/prctl.h |   8 ++-
 5 files changed, 137 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index fba47e5..c7e7d50 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2182,6 +2182,8 @@ const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
 #ifdef CONFIG_SCHED_CORE
 extern void sched_core_free(struct task_struct *tsk);
 extern void sched_core_fork(struct task_struct *p);
+extern int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
+				unsigned long uaddr);
 #else
 static inline void sched_core_free(struct task_struct *tsk) { }
 static inline void sched_core_fork(struct task_struct *p) { }
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 18a9f59..967d9c5 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -259,4 +259,12 @@ struct prctl_mm_map {
 #define PR_PAC_SET_ENABLED_KEYS		60
 #define PR_PAC_GET_ENABLED_KEYS		61
 
+/* Request the scheduler to share a core */
+#define PR_SCHED_CORE			62
+# define PR_SCHED_CORE_GET		0
+# define PR_SCHED_CORE_CREATE		1 /* create unique core_sched cookie */
+# define PR_SCHED_CORE_SHARE_TO		2 /* push core_sched cookie to pid */
+# define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
+# define PR_SCHED_CORE_MAX		4
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index dcbbeae..9a80e9a 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/prctl.h>
 #include "sched.h"
 
 /*
@@ -113,3 +114,116 @@ void sched_core_free(struct task_struct *p)
 {
 	sched_core_put_cookie(p->core_cookie);
 }
+
+static void __sched_core_set(struct task_struct *p, unsigned long cookie)
+{
+	cookie = sched_core_get_cookie(cookie);
+	cookie = sched_core_update_cookie(p, cookie);
+	sched_core_put_cookie(cookie);
+}
+
+/* Called from prctl interface: PR_SCHED_CORE */
+int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
+			 unsigned long uaddr)
+{
+	unsigned long cookie = 0, id = 0;
+	struct task_struct *task, *p;
+	struct pid *grp;
+	int err = 0;
+
+	if (!static_branch_likely(&sched_smt_present))
+		return -ENODEV;
+
+	if (type > PIDTYPE_PGID || cmd >= PR_SCHED_CORE_MAX || pid < 0 ||
+	    (cmd != PR_SCHED_CORE_GET && uaddr))
+		return -EINVAL;
+
+	rcu_read_lock();
+	if (pid == 0) {
+		task = current;
+	} else {
+		task = find_task_by_vpid(pid);
+		if (!task) {
+			rcu_read_unlock();
+			return -ESRCH;
+		}
+	}
+	get_task_struct(task);
+	rcu_read_unlock();
+
+	/*
+	 * Check if this process has the right to modify the specified
+	 * process. Use the regular "ptrace_may_access()" checks.
+	 */
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
+		err = -EPERM;
+		goto out;
+	}
+
+	switch (cmd) {
+	case PR_SCHED_CORE_GET:
+		if (type != PIDTYPE_PID || uaddr & 7) {
+			err = -EINVAL;
+			goto out;
+		}
+		cookie = sched_core_clone_cookie(task);
+		if (cookie) {
+			/* XXX improve ? */
+			ptr_to_hashval((void *)cookie, &id);
+		}
+		err = put_user(id, (u64 __user *)uaddr);
+		goto out;
+
+	case PR_SCHED_CORE_CREATE:
+		cookie = sched_core_alloc_cookie();
+		if (!cookie) {
+			err = -ENOMEM;
+			goto out;
+		}
+		break;
+
+	case PR_SCHED_CORE_SHARE_TO:
+		cookie = sched_core_clone_cookie(current);
+		break;
+
+	case PR_SCHED_CORE_SHARE_FROM:
+		if (type != PIDTYPE_PID) {
+			err = -EINVAL;
+			goto out;
+		}
+		cookie = sched_core_clone_cookie(task);
+		__sched_core_set(current, cookie);
+		goto out;
+
+	default:
+		err = -EINVAL;
+		goto out;
+	};
+
+	if (type == PIDTYPE_PID) {
+		__sched_core_set(task, cookie);
+		goto out;
+	}
+
+	read_lock(&tasklist_lock);
+	grp = task_pid_type(task, type);
+
+	do_each_pid_thread(grp, type, p) {
+		if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS)) {
+			err = -EPERM;
+			goto out_tasklist;
+		}
+	} while_each_pid_thread(grp, type, p);
+
+	do_each_pid_thread(grp, type, p) {
+		__sched_core_set(p, cookie);
+	} while_each_pid_thread(grp, type, p);
+out_tasklist:
+	read_unlock(&tasklist_lock);
+
+out:
+	sched_core_put_cookie(cookie);
+	put_task_struct(task);
+	return err;
+}
+
diff --git a/kernel/sys.c b/kernel/sys.c
index 3a583a2..9de46a4 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2550,6 +2550,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		error = set_syscall_user_dispatch(arg2, arg3, arg4,
 						  (char __user *) arg5);
 		break;
+#ifdef CONFIG_SCHED_CORE
+	case PR_SCHED_CORE:
+		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
+		break;
+#endif
 	default:
 		error = -EINVAL;
 		break;
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index 18a9f59..967d9c5 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -259,4 +259,12 @@ struct prctl_mm_map {
 #define PR_PAC_SET_ENABLED_KEYS		60
 #define PR_PAC_GET_ENABLED_KEYS		61
 
+/* Request the scheduler to share a core */
+#define PR_SCHED_CORE			62
+# define PR_SCHED_CORE_GET		0
+# define PR_SCHED_CORE_CREATE		1 /* create unique core_sched cookie */
+# define PR_SCHED_CORE_SHARE_TO		2 /* push core_sched cookie to pid */
+# define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
+# define PR_SCHED_CORE_MAX		4
+
 #endif /* _LINUX_PRCTL_H */
