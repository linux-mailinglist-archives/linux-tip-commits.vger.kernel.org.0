Return-Path: <linux-tip-commits+bounces-8259-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL5DC9MLn2lVYwQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8259-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Feb 2026 15:48:51 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5E6198F09
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Feb 2026 15:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3AC6E300AD93
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Feb 2026 14:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270743C196C;
	Wed, 25 Feb 2026 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VThNRUqo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="57YeLIyx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC133203A0;
	Wed, 25 Feb 2026 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772030919; cv=none; b=HYyZtAqpeRiSaxKu2XEYvLQAm9nJUWq8jVPdFieEc1xN0oIShxxi+5sNOmYNPAC1qgBHj0QTGXPtjpyN2G5Ht5QmDLGgmW3zj8HxKPVu5baK+1F/wY/519YbnjpnW0NcAzY+78rCtyyCH4t8c/rajMz26n+h/RxgIji75YCtNlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772030919; c=relaxed/simple;
	bh=GDlFEg8C6KxXVzFNv4qnnjBxHMoXjhjxKSmd58k5U5I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CShIcP1sy4M3jm/sfPIAJuNvCvo7K1U/FB7SQUReJqwxRZ9dmHPJwgTCzT4jV3HmlHKYV0RkY9HB73CsKh++1+MytU1LI0eCE0gs1LBY2tptXg3ShlszZe/ucsJKM4EhF0T60x/VRQHP2Ztj93QNdB9yevf7ifxp2ScNkglpf14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VThNRUqo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=57YeLIyx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 25 Feb 2026 14:48:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772030915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2t1C5aKVCokemCFQ4A24WQ75nqYi3cJpOKbLYVYpT40=;
	b=VThNRUqoK7zrNHUytTxEFXnNqY5zNCvy1pRVBy3Mwb1UWqrs2g2Ydp5QAUMkrcMkc1YTRb
	FD8qjLLg6+ECEhA+KGqBUnJshQfW+lPoN+BFrjy0y0wRCwKQQ7F9Fc4X42lquOnJ1zxm3r
	6A5LH1bOpD+J4Yjcp4+XIBWk2sZiilFTsPwnfO3RFUVQXQk3M2mStPkAHggdBp1mnvJuR6
	agijshLSMAXVkg15pdFNEpEedQ51an755ioeWIqHdqLu6WI0T89bc21AK7UIC71hPKDjKr
	5SLrHeBQ0hn+it9zfOl137gibp5kcLVbpbGpAqszgVBcMM21V8DOw0/B2Nb/jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772030915;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2t1C5aKVCokemCFQ4A24WQ75nqYi3cJpOKbLYVYpT40=;
	b=57YeLIyx1VW8yuN2AAxrt7vtBvQYE4z2dO157VGqAbzNm1g9oUkTBLiWVaU39FO+2+9ZeS
	J8nU4pIyysP75qDg==
From: "tip-bot2 for Tommaso Cucinotta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Add reporting of runtime left & abs
 deadline to sched_getattr() for DEADLINE tasks
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Matteo Martelli <matteo.martelli@codethink.co.uk>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250912053937.31636-2-tommaso.cucinotta@santannapisa.it>
References: <20250912053937.31636-2-tommaso.cucinotta@santannapisa.it>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177203091435.1647592.7803062651799307317.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8259-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 3D5E6198F09
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2e7af192697ef2a71c76fd57860b0fcd02754e14
Gitweb:        https://git.kernel.org/tip/2e7af192697ef2a71c76fd57860b0fcd027=
54e14
Author:        Tommaso Cucinotta <tommaso.cucinotta@gmail.com>
AuthorDate:    Fri, 12 Sep 2025 07:38:29 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 25 Feb 2026 15:35:58 +01:00

sched/deadline: Add reporting of runtime left & abs deadline to sched_getattr=
() for DEADLINE tasks

The SCHED_DEADLINE scheduler allows reading the statically configured
run-time, deadline, and period parameters through the sched_getattr()
system call. However, there is no immediate way to access, from user space,
the current parameters used within the scheduler: the instantaneous runtime
left in the current cycle, as well as the current absolute deadline.

The `flags' sched_getattr() parameter, so far mandated to contain zero,
now supports the SCHED_GETATTR_FLAG_DL_DYNAMIC=3D1 flag, to request
retrieval of the leftover runtime and absolute deadline, converted to a
CLOCK_MONOTONIC reference, instead of the statically configured parameters.

This feature is useful for adaptive SCHED_DEADLINE tasks that need to
modify their behavior depending on whether or not there is enough runtime
left in the current period, and/or what is the current absolute deadline.

Notes:
- before returning the instantaneous parameters, the runtime is updated;
- the abs deadline is returned shifted from rq_clock() to ktime_get_ns(),
  in CLOCK_MONOTONIC reference; this causes multiple invocations from the
  same period to return values that may differ for a few ns (showing some
  small drift), albeit the deadline doesn't move, in rq_clock() reference;
- the abs deadline value returned to user-space, as unsigned 64-bit value,
  can represent nearly 585 years since boot time;
- setting flags=3D0 provides the old behavior (retrieve static parameters).

See also the notes from discussion held at OSPM 2025 on the topic
"Making user space aware of current deadline-scheduler parameters".

Signed-off-by: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
Link: https://patch.msgid.link/20250912053937.31636-2-tommaso.cucinotta@santa=
nnapisa.it
---
 include/uapi/linux/sched.h |  3 +++
 kernel/sched/deadline.c    | 19 ++++++++++++++++---
 kernel/sched/sched.h       |  2 +-
 kernel/sched/syscalls.c    | 16 +++++++++++-----
 4 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 359a14c..52b69ce 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -146,4 +146,7 @@ struct clone_args {
 			 SCHED_FLAG_KEEP_ALL		| \
 			 SCHED_FLAG_UTIL_CLAMP)
=20
+/* Only for sched_getattr() own flag param, if task is SCHED_DEADLINE */
+#define SCHED_GETATTR_FLAG_DL_DYNAMIC	0x01
+
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 2de5727..9e253a8 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3617,13 +3617,26 @@ void __setparam_dl(struct task_struct *p, const struc=
t sched_attr *attr)
 	dl_se->dl_density =3D to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
 }
=20
-void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
+void __getparam_dl(struct task_struct *p, struct sched_attr *attr, unsigned =
int flags)
 {
 	struct sched_dl_entity *dl_se =3D &p->dl;
+	struct rq *rq =3D task_rq(p);
+	u64 adj_deadline;
=20
 	attr->sched_priority =3D p->rt_priority;
-	attr->sched_runtime =3D dl_se->dl_runtime;
-	attr->sched_deadline =3D dl_se->dl_deadline;
+	if (flags & SCHED_GETATTR_FLAG_DL_DYNAMIC) {
+		guard(raw_spinlock_irq)(&rq->__lock);
+		update_rq_clock(rq);
+		if (task_current(rq, p))
+			update_curr_dl(rq);
+
+		attr->sched_runtime =3D dl_se->runtime;
+		adj_deadline =3D dl_se->deadline - rq_clock(rq) + ktime_get_ns();
+		attr->sched_deadline =3D adj_deadline;
+	} else {
+		attr->sched_runtime =3D dl_se->dl_runtime;
+		attr->sched_deadline =3D dl_se->dl_deadline;
+	}
 	attr->sched_period =3D dl_se->dl_period;
 	attr->sched_flags &=3D ~SCHED_DL_FLAGS;
 	attr->sched_flags |=3D dl_se->flags;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8bf2f7d..fa2237e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -356,7 +356,7 @@ extern int  sched_dl_global_validate(void);
 extern void sched_dl_do_global(void);
 extern int  sched_dl_overflow(struct task_struct *p, int policy, const struc=
t sched_attr *attr);
 extern void __setparam_dl(struct task_struct *p, const struct sched_attr *at=
tr);
-extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr);
+extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr, un=
signed int flags);
 extern bool __checkparam_dl(const struct sched_attr *attr);
 extern bool dl_param_changed(struct task_struct *p, const struct sched_attr =
*attr);
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const st=
ruct cpumask *trial);
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 6f10db3..a288ac0 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -881,10 +881,10 @@ err_size:
 	return -E2BIG;
 }
=20
-static void get_params(struct task_struct *p, struct sched_attr *attr)
+static void get_params(struct task_struct *p, struct sched_attr *attr, unsig=
ned int flags)
 {
 	if (task_has_dl_policy(p)) {
-		__getparam_dl(p, attr);
+		__getparam_dl(p, attr, flags);
 	} else if (task_has_rt_policy(p)) {
 		attr->sched_priority =3D p->rt_priority;
 	} else {
@@ -950,7 +950,7 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_a=
ttr __user *, uattr,
 		return -ESRCH;
=20
 	if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
-		get_params(p, &attr);
+		get_params(p, &attr, 0);
=20
 	return sched_setattr(p, &attr);
 }
@@ -1035,7 +1035,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched=
_attr __user *, uattr,
 	int retval;
=20
 	if (unlikely(!uattr || pid < 0 || usize > PAGE_SIZE ||
-		      usize < SCHED_ATTR_SIZE_VER0 || flags))
+		     usize < SCHED_ATTR_SIZE_VER0))
 		return -EINVAL;
=20
 	scoped_guard (rcu) {
@@ -1043,6 +1043,12 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sche=
d_attr __user *, uattr,
 		if (!p)
 			return -ESRCH;
=20
+		if (flags) {
+			if (!task_has_dl_policy(p) ||
+			    flags !=3D SCHED_GETATTR_FLAG_DL_DYNAMIC)
+				return -EINVAL;
+		}
+
 		retval =3D security_task_getscheduler(p);
 		if (retval)
 			return retval;
@@ -1050,7 +1056,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched=
_attr __user *, uattr,
 		kattr.sched_policy =3D p->policy;
 		if (p->sched_reset_on_fork)
 			kattr.sched_flags |=3D SCHED_FLAG_RESET_ON_FORK;
-		get_params(p, &kattr);
+		get_params(p, &kattr, flags);
 		kattr.sched_flags &=3D SCHED_FLAG_ALL;
=20
 #ifdef CONFIG_UCLAMP_TASK

