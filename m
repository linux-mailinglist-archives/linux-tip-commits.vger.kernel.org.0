Return-Path: <linux-tip-commits+bounces-6672-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0922B802B2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 16:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337964A1213
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 14:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709FA303A29;
	Wed, 17 Sep 2025 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vzGc/gp1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/RlCxZa4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F09F2E11CB;
	Wed, 17 Sep 2025 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120249; cv=none; b=qPDmC6CPlivlfM0yEzlDhYfP1laSIPAFVmIo7n0Muw/Se2+KQhTSXFBEHExO8eulnO2yEs7XWmPoJJRhF4pSPjFkioLz7JqpPEbmWy5GvNpNcBvg9FShtsWdWjsw/5VkDhtwYAoI3cKGLzAEHFGXV2w5tzTtEzir2R4/32Fumns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120249; c=relaxed/simple;
	bh=eFT8aqwhkGyae9+KiZjS6K+XMarS7snz+WFCWKhLfCE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OQGm7QlPgnm0JQDug8/aagixOEYunwCzCpXStgs+0LcE/mHaxsJcJZ5tUkYy0bn3w5qMyQSuhgTFJFwe30IbevApG3jaNdu8QnM4D4hf1Ufvwkb8V+uiAdIxrNtHL5YZnXV/f2OQCZzcpF6KXfsWqTot+RPUOaUfbD4thuVHmyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vzGc/gp1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/RlCxZa4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 14:44:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758120245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=22KDmvnNZREBsjH3fg2sRYJFu1PAX/v0AwTWj2EEQNE=;
	b=vzGc/gp1623UPh49jiFFS4jZqUElL9mZIg07yj05f4b95G21cHyAAR8kHuoNcgd0Z2yDGX
	qn9S9YMX/xqR5CzpLqSHyoD7sr71DaCRiCUeyT8pYlqNcf/13sXRQ27wrYhSGoNXnmQfW5
	4caLu6hxRFF5rLiHBwFQh849tP/vwiTjA2vPTlCkCQ46DXHVGwUwo2aQn1fwSZbbdnJO8t
	7st7KEbswINBFhnr7VgnQ5r/L1meERlk1+LYE6W4zEWJM/aNxLxQBeP6RAQGsGh+P+eHgy
	fUicsRPQ+qHww9laVBd/kNrPBxKN3uTB8OdonyeOXLfth+N+PpSk08DYnGR8OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758120245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=22KDmvnNZREBsjH3fg2sRYJFu1PAX/v0AwTWj2EEQNE=;
	b=/RlCxZa4j1nepGEBfjURCCKngYgUjPuciGdjAi65VBBZE26LyeOsGFP3WMJVSvzrF3QB+N
	ntlK8ZB1McSOzSDw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] softirq: Provide a handshake for canceling tasklets
 via polling
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250904142526.1845999-3-bigeasy@linutronix.de>
References: <20250904142526.1845999-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175812024453.709179.2811378741492063853.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fd4e876f59b7e70283b4025c717cad8948397be1
Gitweb:        https://git.kernel.org/tip/fd4e876f59b7e70283b4025c717cad89483=
97be1
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 04 Sep 2025 16:25:24 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Sep 2025 16:25:41 +02:00

softirq: Provide a handshake for canceling tasklets via polling

The tasklet_unlock_spin_wait() via tasklet_disable_in_atomic() is
provided for a few legacy tasklet users. The interface is used from
atomic context (which is either softirq or disabled preemption) on
non-PREEMPT_RT and relies on spinning until the tasklet callback
completes.

On PREEMPT_RT the context is never atomic but the busy polling logic
remains. It is possible that the thread invoking tasklet_unlock_spin_wait()
has higher priority than the tasklet. If both run on the same CPU the the
tasklet makes no progress and the thread trying to cancel the tasklet will
live-lock the system.

To avoid the lockup tasklet_unlock_spin_wait() uses local_bh_disable()/
enable() which utilizes the local_lock_t for synchronisation. This lock is
a central per-CPU BKL and about to be removed.

Solve this by acquire a lock in tasklet_action_common() which is held while
the tasklet's callback is invoked. This lock will be acquired from
tasklet_unlock_spin_wait() via tasklet_callback_cancel_wait_running().

After the tasklet completed tasklet_callback_sync_wait_running() drops the
lock and acquires it again. In order to avoid unlocking the lock even if
there is no cancel request, there is a cb_waiters counter which is
incremented during a cancel request.  Blocking on the lock will PI-boost
the tasklet if needed, ensuring progress is made.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/softirq.c | 62 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 513b194..4e2c980 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -805,6 +805,58 @@ static bool tasklet_clear_sched(struct tasklet_struct *t)
 	return false;
 }
=20
+#ifdef CONFIG_PREEMPT_RT
+struct tasklet_sync_callback {
+	spinlock_t	cb_lock;
+	atomic_t	cb_waiters;
+};
+
+static DEFINE_PER_CPU(struct tasklet_sync_callback, tasklet_sync_callback) =
=3D {
+	.cb_lock	=3D __SPIN_LOCK_UNLOCKED(tasklet_sync_callback.cb_lock),
+	.cb_waiters	=3D ATOMIC_INIT(0),
+};
+
+static void tasklet_lock_callback(void)
+{
+	spin_lock(this_cpu_ptr(&tasklet_sync_callback.cb_lock));
+}
+
+static void tasklet_unlock_callback(void)
+{
+	spin_unlock(this_cpu_ptr(&tasklet_sync_callback.cb_lock));
+}
+
+static void tasklet_callback_cancel_wait_running(void)
+{
+	struct tasklet_sync_callback *sync_cb =3D this_cpu_ptr(&tasklet_sync_callba=
ck);
+
+	atomic_inc(&sync_cb->cb_waiters);
+	spin_lock(&sync_cb->cb_lock);
+	atomic_dec(&sync_cb->cb_waiters);
+	spin_unlock(&sync_cb->cb_lock);
+}
+
+static void tasklet_callback_sync_wait_running(void)
+{
+	struct tasklet_sync_callback *sync_cb =3D this_cpu_ptr(&tasklet_sync_callba=
ck);
+
+	if (atomic_read(&sync_cb->cb_waiters)) {
+		spin_unlock(&sync_cb->cb_lock);
+		spin_lock(&sync_cb->cb_lock);
+	}
+}
+
+#else /* !CONFIG_PREEMPT_RT: */
+
+static void tasklet_lock_callback(void) { }
+static void tasklet_unlock_callback(void) { }
+static void tasklet_callback_sync_wait_running(void) { }
+
+#ifdef CONFIG_SMP
+static void tasklet_callback_cancel_wait_running(void) { }
+#endif
+#endif /* !CONFIG_PREEMPT_RT */
+
 static void tasklet_action_common(struct tasklet_head *tl_head,
 				  unsigned int softirq_nr)
 {
@@ -816,6 +868,7 @@ static void tasklet_action_common(struct tasklet_head *tl=
_head,
 	tl_head->tail =3D &tl_head->head;
 	local_irq_enable();
=20
+	tasklet_lock_callback();
 	while (list) {
 		struct tasklet_struct *t =3D list;
=20
@@ -835,6 +888,7 @@ static void tasklet_action_common(struct tasklet_head *tl=
_head,
 					}
 				}
 				tasklet_unlock(t);
+				tasklet_callback_sync_wait_running();
 				continue;
 			}
 			tasklet_unlock(t);
@@ -847,6 +901,7 @@ static void tasklet_action_common(struct tasklet_head *tl=
_head,
 		__raise_softirq_irqoff(softirq_nr);
 		local_irq_enable();
 	}
+	tasklet_unlock_callback();
 }
=20
 static __latent_entropy void tasklet_action(void)
@@ -897,12 +952,9 @@ void tasklet_unlock_spin_wait(struct tasklet_struct *t)
 			/*
 			 * Prevent a live lock when current preempted soft
 			 * interrupt processing or prevents ksoftirqd from
-			 * running. If the tasklet runs on a different CPU
-			 * then this has no effect other than doing the BH
-			 * disable/enable dance for nothing.
+			 * running.
 			 */
-			local_bh_disable();
-			local_bh_enable();
+			tasklet_callback_cancel_wait_running();
 		} else {
 			cpu_relax();
 		}

