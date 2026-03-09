Return-Path: <linux-tip-commits+bounces-8385-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BE4J88kr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8385-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:51:43 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 349182405CD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8F9A30467D8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729C8410D26;
	Mon,  9 Mar 2026 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HYWGl0cQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="abYbr3JK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA48410D3C;
	Mon,  9 Mar 2026 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085706; cv=none; b=pmqYAtMVH3AFdLpl17nxX1CDWUZ2WJiYpxKwgiLV90kOM+c6FCvKJMr0a3MFu2zZcsb4yEbNkr9I/Ytc+0y5apZd/oHlVGQS03O1Z+AZDvko2DvtOC/H8GeGsofYH3edx3REweb/AbABKPzdBTtmtGna4sMZZoUTUHnNiQqqwMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085706; c=relaxed/simple;
	bh=AP2xErz1GRih7iE36hKYHWTpfvzCacg4Q1v3lMigIbs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OYxvifVYPYts1JKBTUKMGd6aJogCw/nnWz9csxXUxwaut+CkB8Wp6CD+ZQQ5AHqqg1BApah/JDQSmW1gKIvstQFOO+1W3uInp2eey79obkKPfc4MYYSGwNkFzPM9IjzaawOiGB0YwcKDwE6wt2oH3qBpWScxueQpcfTjC4JuD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HYWGl0cQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=abYbr3JK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085699;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zd6hy9Sb/Ag0bLN13ECw4HiSmxP4Zj1d7OdE+x8XPqk=;
	b=HYWGl0cQCidzqNqR+RCBcFGuEATyy8f12ndd7DOwSWX4OdeACXuAyQV/K1pkiGw95LCCgv
	Ar8xpgykpq3ONwZgP4Ls4dpVQ9boZnOh706KI3N2RK2B5FkpLsDocjNABDf/82OVUEtmoq
	Og/3twaPUi92cPdDLKfMqZ6dkgyTZ5+E2ATp0q6WGtAkHD9o+84+wWaiHL/HaKrOpF1erf
	xca6tfm5mgBz2m1YXVMIX5a2KLdx8E14WERYkBaoWm3NPpKVWO/OxvFs1Fl/Aa2fUc0Z9A
	ADR1pgzyHmS7Dm6ettPkRvqKIq+dP85p9ZykPai8xIzwNXCjlmVIRFIkfkQepA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085699;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zd6hy9Sb/Ag0bLN13ECw4HiSmxP4Zj1d7OdE+x8XPqk=;
	b=abYbr3JKEjw66f36AEPMh5ce+kUwmqPznh2Lv8fMXSRVjwaN8xShc/WZMJuFOCMR3iPXEt
	Dm09TbfHNfWuqGBA==
From: "tip-bot2 for Matthew Wilcox (Oracle)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/semaphore: Remove the list_head from
 struct semaphore
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260305195545.3707590-3-willy@infradead.org>
References: <20260305195545.3707590-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308569817.1647592.9772716447530683158.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 349182405CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8385-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,infradead.org:email,msgid.link:url,linutronix.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b9bdd4b6840454ef87f61b6506c9635c57a81650
Gitweb:        https://git.kernel.org/tip/b9bdd4b6840454ef87f61b6506c9635c57a=
81650
Author:        Matthew Wilcox (Oracle) <willy@infradead.org>
AuthorDate:    Thu, 05 Mar 2026 19:55:42=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:52 +01:00

locking/semaphore: Remove the list_head from struct semaphore

Instead of embedding a list_head in struct semaphore, store a pointer to
the first waiter.  The list of waiters remains a doubly linked list so
we can efficiently add to the tail of the list and remove from the front
(or middle) of the list.

Some of the list manipulation becomes more complicated, but it's a
reasonable tradeoff on the slow paths to shrink data structures
which embed a semaphore.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260305195545.3707590-3-willy@infradead.org
---
 drivers/acpi/osl.c         |  2 +-
 include/linux/semaphore.h  |  4 ++--
 kernel/locking/semaphore.c | 41 +++++++++++++++++++++++++++----------
 3 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5b77731..2af0db9 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1257,7 +1257,7 @@ acpi_status acpi_os_delete_semaphore(acpi_handle handle)
=20
 	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Deleting semaphore[%p].\n", handle));
=20
-	BUG_ON(!list_empty(&sem->wait_list));
+	BUG_ON(sem->first_waiter);
 	kfree(sem);
 	sem =3D NULL;
=20
diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
index 8970615..a4c8651 100644
--- a/include/linux/semaphore.h
+++ b/include/linux/semaphore.h
@@ -15,7 +15,7 @@
 struct semaphore {
 	raw_spinlock_t		lock;
 	unsigned int		count;
-	struct list_head	wait_list;
+	struct semaphore_waiter *first_waiter;
=20
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
 	unsigned long		last_holder;
@@ -33,7 +33,7 @@ struct semaphore {
 {									\
 	.lock		=3D __RAW_SPIN_LOCK_UNLOCKED((name).lock),	\
 	.count		=3D n,						\
-	.wait_list	=3D LIST_HEAD_INIT((name).wait_list)		\
+	.first_waiter	=3D NULL						\
 	__LAST_HOLDER_SEMAPHORE_INITIALIZER				\
 }
=20
diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 3ef032e..74d4143 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -21,7 +21,7 @@
  * too.
  *
  * The ->count variable represents how many more tasks can acquire this
- * semaphore.  If it's zero, there may be tasks waiting on the wait_list.
+ * semaphore.  If it's zero, there may be waiters.
  */
=20
 #include <linux/compiler.h>
@@ -226,7 +226,7 @@ void __sched up(struct semaphore *sem)
=20
 	hung_task_sem_clear_if_holder(sem);
=20
-	if (likely(list_empty(&sem->wait_list)))
+	if (likely(!sem->first_waiter))
 		sem->count++;
 	else
 		__up(sem, &wake_q);
@@ -244,6 +244,21 @@ struct semaphore_waiter {
 	bool up;
 };
=20
+static inline
+void sem_del_waiter(struct semaphore *sem, struct semaphore_waiter *waiter)
+{
+	if (list_empty(&waiter->list)) {
+		sem->first_waiter =3D NULL;
+		return;
+	}
+
+	if (sem->first_waiter =3D=3D waiter) {
+		sem->first_waiter =3D list_first_entry(&waiter->list,
+						     struct semaphore_waiter, list);
+	}
+	list_del(&waiter->list);
+}
+
 /*
  * Because this function is inlined, the 'state' parameter will be
  * constant, and thus optimised away by the compiler.  Likewise the
@@ -252,9 +267,15 @@ struct semaphore_waiter {
 static inline int __sched ___down_common(struct semaphore *sem, long state,
 								long timeout)
 {
-	struct semaphore_waiter waiter;
-
-	list_add_tail(&waiter.list, &sem->wait_list);
+	struct semaphore_waiter waiter, *first;
+
+	first =3D sem->first_waiter;
+	if (first) {
+		list_add_tail(&waiter.list, &first->list);
+	} else {
+		INIT_LIST_HEAD(&waiter.list);
+		sem->first_waiter =3D &waiter;
+	}
 	waiter.task =3D current;
 	waiter.up =3D false;
=20
@@ -274,11 +295,11 @@ static inline int __sched ___down_common(struct semapho=
re *sem, long state,
 	}
=20
  timed_out:
-	list_del(&waiter.list);
+	sem_del_waiter(sem, &waiter);
 	return -ETIME;
=20
  interrupted:
-	list_del(&waiter.list);
+	sem_del_waiter(sem, &waiter);
 	return -EINTR;
 }
=20
@@ -321,9 +342,9 @@ static noinline int __sched __down_timeout(struct semapho=
re *sem, long timeout)
 static noinline void __sched __up(struct semaphore *sem,
 				  struct wake_q_head *wake_q)
 {
-	struct semaphore_waiter *waiter =3D list_first_entry(&sem->wait_list,
-						struct semaphore_waiter, list);
-	list_del(&waiter->list);
+	struct semaphore_waiter *waiter =3D sem->first_waiter;
+
+	sem_del_waiter(sem, waiter);
 	waiter->up =3D true;
 	wake_q_add(wake_q, waiter->task);
 }

