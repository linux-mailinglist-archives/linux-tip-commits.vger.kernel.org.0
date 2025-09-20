Return-Path: <linux-tip-commits+bounces-6687-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC0B8CC73
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 18:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9BF57AD8C5
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 15:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC212FDC24;
	Sat, 20 Sep 2025 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0je4bzvO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D9sZwD55"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18022FC86F;
	Sat, 20 Sep 2025 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758384007; cv=none; b=dkGGAYwyA9rjzvYfD+cf9cZ9SJYJV+eDxf/KfIcRPOHy3iq2Dre5tK+UPxxQp1rZ04309FnEG1DqQqAIYqh2XqiWFP28vej2Qwm5H+QTCwZ0q+m1KTvziG+U+7PjOY4HW3DLi4iXONFuv9M8q5ZocwPTT+qpvM44HI4+oQBTXds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758384007; c=relaxed/simple;
	bh=3pqbnFllDk+g5SeR+N4Far2AKpTpxRWxBdukdzHikXo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=crzjsHZGkp8vXf2JHG+o0fq0EhNEzDElrYosSSlhLezk6dKetywzeAeyujHiO0+mKQDmxTUhWFX+aBZ5yQ0nAgIpwawkjmC5m49S8EVetHxLNbIJvmBSrfRpsbBgaUpYH8fqPIxgcwtYHsM8XrdgV78QCMwWA/9vSpH/AosSEOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0je4bzvO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D9sZwD55; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 15:59:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758384003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZM+WGFWvYHIMIx1+lRhduX/r+yMYc43cILStsoHUH98=;
	b=0je4bzvOaPt/M9IwAeGL6ZnzBBFHRwbqpl1+s3owkRhx+P84C6hFSrcmu3n2faArvFsVMg
	bQaVjyltmQyqjsU13Mob51oK0uAImNq6eK4x1HAv4Z5fY0Ill8qz6PShRTBQgybvA0X6Mc
	EgMYZhEUb8l6V8stnzqQlZTYfdyKC4/qc9RoQLbnmxBgWYtcJIVKB619stmpwBlbw7UX42
	rrYQBtzSR2XbdUmGKxdKAwOH5Ft43hui9AN2Q6/wxaB9yETduTyQ3vDKrCwjqgvJApJUZG
	o95nL9G/wVd7S5qkRVxgqO/XxVlhVtjmLmfq0a5IrT76oEb8oJhEAGMe/iX0Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758384003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZM+WGFWvYHIMIx1+lRhduX/r+yMYc43cILStsoHUH98=;
	b=D9sZwD55fs1hzqVGNNT2Mn//soGppyieqJ4+lOlGWyMcueJQiNNS6bProSdSDb+KR3GoKb
	n4bMyk8JHreWtNDw==
From: "tip-bot2 for Pranav Tyagi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/futex] futex: Don't leak robust_list pointer on exec race
Cc: Jann Horn <jann@thejh.net>, Pranav Tyagi <pranav.tyagi03@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250915182154.9468-1-pranav.tyagi03@gmail.com>
References: <20250915182154.9468-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175838399647.709179.13370572845425919919.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     6b54082c3ed4dc9821cdf0edb17302355cc5bb45
Gitweb:        https://git.kernel.org/tip/6b54082c3ed4dc9821cdf0edb17302355cc=
5bb45
Author:        Pranav Tyagi <pranav.tyagi03@gmail.com>
AuthorDate:    Mon, 15 Sep 2025 23:51:54 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 20 Sep 2025 17:54:01 +02:00

futex: Don't leak robust_list pointer on exec race

sys_get_robust_list() and compat_get_robust_list() use ptrace_may_access()
to check if the calling task is allowed to access another task's
robust_list pointer. This check is racy against a concurrent exec() in the
target process.

During exec(), a task may transition from a non-privileged binary to a
privileged one (e.g., setuid binary) and its credentials/memory mappings
may change. If get_robust_list() performs ptrace_may_access() before
this transition, it may erroneously allow access to sensitive information
after the target becomes privileged.

A racy access allows an attacker to exploit a window during which
ptrace_may_access() passes before a target process transitions to a
privileged state via exec().

For example, consider a non-privileged task T that is about to execute a
setuid-root binary. An attacker task A calls get_robust_list(T) while T
is still unprivileged. Since ptrace_may_access() checks permissions
based on current credentials, it succeeds. However, if T begins exec
immediately afterwards, it becomes privileged and may change its memory
mappings. Because get_robust_list() proceeds to access T->robust_list
without synchronizing with exec() it may read user-space pointers from a
now-privileged process.

This violates the intended post-exec access restrictions and could
expose sensitive memory addresses or be used as a primitive in a larger
exploit chain. Consequently, the race can lead to unauthorized
disclosure of information across privilege boundaries and poses a
potential security risk.

Take a read lock on signal->exec_update_lock prior to invoking
ptrace_may_access() and accessing the robust_list/compat_robust_list.
This ensures that the target task's exec state remains stable during the
check, allowing for consistent and synchronized validation of
credentials.

Suggested-by: Jann Horn <jann@thejh.net>
Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/linux-fsdevel/1477863998-3298-5-git-send-email-=
jann@thejh.net/
Link: https://github.com/KSPP/linux/issues/119
---
 kernel/futex/syscalls.c | 106 ++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 50 deletions(-)

diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 4b6da91..880c9bf 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -39,6 +39,56 @@ SYSCALL_DEFINE2(set_robust_list, struct robust_list_head _=
_user *, head,
 	return 0;
 }
=20
+static inline void __user *futex_task_robust_list(struct task_struct *p, boo=
l compat)
+{
+#ifdef CONFIG_COMPAT
+	if (compat)
+		return p->compat_robust_list;
+#endif
+	return p->robust_list;
+}
+
+static void __user *futex_get_robust_list_common(int pid, bool compat)
+{
+	struct task_struct *p =3D current;
+	void __user *head;
+	int ret;
+
+	scoped_guard(rcu) {
+		if (pid) {
+			p =3D find_task_by_vpid(pid);
+			if (!p)
+				return (void __user *)ERR_PTR(-ESRCH);
+		}
+		get_task_struct(p);
+	}
+
+	/*
+	 * Hold exec_update_lock to serialize with concurrent exec()
+	 * so ptrace_may_access() is checked against stable credentials
+	 */
+	ret =3D down_read_killable(&p->signal->exec_update_lock);
+	if (ret)
+		goto err_put;
+
+	ret =3D -EPERM;
+	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
+		goto err_unlock;
+
+	head =3D futex_task_robust_list(p, compat);
+
+	up_read(&p->signal->exec_update_lock);
+	put_task_struct(p);
+
+	return head;
+
+err_unlock:
+	up_read(&p->signal->exec_update_lock);
+err_put:
+	put_task_struct(p);
+	return (void __user *)ERR_PTR(ret);
+}
+
 /**
  * sys_get_robust_list() - Get the robust-futex list head of a task
  * @pid:	pid of the process [zero for current task]
@@ -49,36 +99,14 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
 		struct robust_list_head __user * __user *, head_ptr,
 		size_t __user *, len_ptr)
 {
-	struct robust_list_head __user *head;
-	unsigned long ret;
-	struct task_struct *p;
-
-	rcu_read_lock();
-
-	ret =3D -ESRCH;
-	if (!pid)
-		p =3D current;
-	else {
-		p =3D find_task_by_vpid(pid);
-		if (!p)
-			goto err_unlock;
-	}
-
-	ret =3D -EPERM;
-	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
-		goto err_unlock;
+	struct robust_list_head __user *head =3D futex_get_robust_list_common(pid, =
false);
=20
-	head =3D p->robust_list;
-	rcu_read_unlock();
+	if (IS_ERR(head))
+		return PTR_ERR(head);
=20
 	if (put_user(sizeof(*head), len_ptr))
 		return -EFAULT;
 	return put_user(head, head_ptr);
-
-err_unlock:
-	rcu_read_unlock();
-
-	return ret;
 }
=20
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
@@ -455,36 +483,14 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 			compat_uptr_t __user *, head_ptr,
 			compat_size_t __user *, len_ptr)
 {
-	struct compat_robust_list_head __user *head;
-	unsigned long ret;
-	struct task_struct *p;
-
-	rcu_read_lock();
-
-	ret =3D -ESRCH;
-	if (!pid)
-		p =3D current;
-	else {
-		p =3D find_task_by_vpid(pid);
-		if (!p)
-			goto err_unlock;
-	}
-
-	ret =3D -EPERM;
-	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
-		goto err_unlock;
+	struct compat_robust_list_head __user *head =3D futex_get_robust_list_commo=
n(pid, true);
=20
-	head =3D p->compat_robust_list;
-	rcu_read_unlock();
+	if (IS_ERR(head))
+		return PTR_ERR(head);
=20
 	if (put_user(sizeof(*head), len_ptr))
 		return -EFAULT;
 	return put_user(ptr_to_compat(head), head_ptr);
-
-err_unlock:
-	rcu_read_unlock();
-
-	return ret;
 }
 #endif /* CONFIG_COMPAT */
=20

