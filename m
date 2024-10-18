Return-Path: <linux-tip-commits+bounces-2512-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C12C9A369F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2024 09:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587DF2813E4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2024 07:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7B118D62F;
	Fri, 18 Oct 2024 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="02pbBDy0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zRRZcvaH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B7318CBE8;
	Fri, 18 Oct 2024 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235274; cv=none; b=R7IDnRoGgPKJ6OhCXRv9WkS5NvMQbs5KscQyfZsf+HmVce3l/eQemWUF5NKYHdvlk0FRcanXmnVt8Gi7JxpVr+xuWFxgqRQ09etnEIPIem6Lj6MMXdqBk1xq6j9nP9YL1pJkNEhPVvnNEKg+DQFp+F9wSLxIquoBZQBdJlTXSDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235274; c=relaxed/simple;
	bh=XDnfxJr34FyX81X33c9P0ahxFzAUl4BLYTKvXvnJiNM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Tld2s6LfezBVn/m9bIRLalDdpF7k/mNUevW9m7X+FPx5d9EnrD1D/FDasSkHal7hoVaZWrh1o7NgJZNH5OSsdAPFW5KA+wTjeKqIWTgkWaHtO3T2i6NWv+kW4a+vLyybMSydY6eiHM0IPzblENMIAp/C5IcNv5mZ4kH44LZkap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=02pbBDy0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zRRZcvaH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Oct 2024 07:07:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729235263;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6e8wXwZ6i9dVFRQEqwRNN272BNUc/biQlTo93O0bzc0=;
	b=02pbBDy0vHB7BEvIIowPcpO4lGX3tPGE1XDiAWEiilLhzzBWnkrLf8Cd3q3gEI1ryT5u3F
	OXWmRFynYJEKy8JGlSjKFXaJ/kXZdRpSXqM5b5C7OwqExbyiqfWNQJbREHvjqR266wGSoF
	UZxr0rqS8BUleCnf5LhZBtG+6Eeu6pMFiGDAxFOlMRCmJ6ryOARvyRqdmdjOWBd7tmbv+U
	ZVXxFDOVecQfoyIfuik4QnCXTjtltd1Mu6wtVSCZsgsqNq+5x8p5EOG4UJF/GiPPBKlliW
	k3O+KSlEK3dEcsCgn/yX9zGyG1FxvnwCKXcAzJmomu0Z2Y62nhq6oN9SPFBEwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729235263;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6e8wXwZ6i9dVFRQEqwRNN272BNUc/biQlTo93O0bzc0=;
	b=zRRZcvaHbYFNJGS2eC7fGWTPNR2KHslwLu0f9O+uuacHreoHs9pv+U4i9st2rVuOiGcXWb
	cMZASt++iDao9ACA==
From: "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] locking/mutex: Expose __mutex_owner()
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 "Connor O'Brien" <connoro@google.com>, John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Metin Kaya <metin.kaya@arm.com>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241009235352.1614323-4-jstultz@google.com>
References: <20241009235352.1614323-4-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172923526315.1442.6207277037699667977.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3a9320ecb06c6c5ca5a8a595717e5186b5f20141
Gitweb:        https://git.kernel.org/tip/3a9320ecb06c6c5ca5a8a595717e5186b5f20141
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Wed, 09 Oct 2024 16:53:36 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Oct 2024 12:52:41 +02:00

locking/mutex: Expose __mutex_owner()

Implementing proxy execution requires that scheduler code be able to
identify the current owner of a mutex. Expose __mutex_owner() for
this purpose (alone!). Includes a null mutex check, so that users
of the function can be simplified.

[Removed the EXPORT_SYMBOL]
[jstultz: Reworked per Peter's suggestions]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Link: https://lore.kernel.org/r/20241009235352.1614323-4-jstultz@google.com
---
 kernel/locking/mutex.c | 25 -------------------------
 kernel/locking/mutex.h | 27 +++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index cd248d1..3302e52 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -56,31 +56,6 @@ __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
 }
 EXPORT_SYMBOL(__mutex_init);
 
-/*
- * @owner: contains: 'struct task_struct *' to the current lock owner,
- * NULL means not owned. Since task_struct pointers are aligned at
- * at least L1_CACHE_BYTES, we have low bits to store extra state.
- *
- * Bit0 indicates a non-empty waiter list; unlock must issue a wakeup.
- * Bit1 indicates unlock needs to hand the lock to the top-waiter
- * Bit2 indicates handoff has been done and we're waiting for pickup.
- */
-#define MUTEX_FLAG_WAITERS	0x01
-#define MUTEX_FLAG_HANDOFF	0x02
-#define MUTEX_FLAG_PICKUP	0x04
-
-#define MUTEX_FLAGS		0x07
-
-/*
- * Internal helper function; C doesn't allow us to hide it :/
- *
- * DO NOT USE (outside of mutex code).
- */
-static inline struct task_struct *__mutex_owner(struct mutex *lock)
-{
-	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
-}
-
 static inline struct task_struct *__owner_task(unsigned long owner)
 {
 	return (struct task_struct *)(owner & ~MUTEX_FLAGS);
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 0b2a79c..cbff35b 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -20,6 +20,33 @@ struct mutex_waiter {
 #endif
 };
 
+/*
+ * @owner: contains: 'struct task_struct *' to the current lock owner,
+ * NULL means not owned. Since task_struct pointers are aligned at
+ * at least L1_CACHE_BYTES, we have low bits to store extra state.
+ *
+ * Bit0 indicates a non-empty waiter list; unlock must issue a wakeup.
+ * Bit1 indicates unlock needs to hand the lock to the top-waiter
+ * Bit2 indicates handoff has been done and we're waiting for pickup.
+ */
+#define MUTEX_FLAG_WAITERS	0x01
+#define MUTEX_FLAG_HANDOFF	0x02
+#define MUTEX_FLAG_PICKUP	0x04
+
+#define MUTEX_FLAGS		0x07
+
+/*
+ * Internal helper function; C doesn't allow us to hide it :/
+ *
+ * DO NOT USE (outside of mutex & scheduler code).
+ */
+static inline struct task_struct *__mutex_owner(struct mutex *lock)
+{
+	if (!lock)
+		return NULL;
+	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
+}
+
 #ifdef CONFIG_DEBUG_MUTEXES
 extern void debug_mutex_lock_common(struct mutex *lock,
 				    struct mutex_waiter *waiter);

