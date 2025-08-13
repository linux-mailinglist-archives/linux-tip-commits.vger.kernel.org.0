Return-Path: <linux-tip-commits+bounces-6246-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16386B24A6E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Aug 2025 15:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9373A7BA1C4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Aug 2025 13:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46812D063C;
	Wed, 13 Aug 2025 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WvoQ9Bb0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7y2jq2OS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5762A8C1;
	Wed, 13 Aug 2025 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091130; cv=none; b=WU4gE58r08rD0OO0nrJ5oFrY5iuikpogTxiYjmdgHWXmKvrVPC8VuxfIA3p6aR/FQyrnCD4ZRQxwdw4q+916ceKuHzHyeaBZEQOPArtPwoRUwrWA+Xpe9fZrvRgKwRhccOxFnIzOIAiNsYVA27n7eGsEu678UbbyXmPqNeOJ24o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091130; c=relaxed/simple;
	bh=b/qIegiKWO23LgukXkZFQL7iWs82Se23DHEY5X246Bs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TXScet+b+P4KiT/vlJQsnwvhfXxk9ROzUaqomT+itkWk1ut81UODPzImxnLNNletoMapNsI1TroGv3FrmkcJpxbg6QEu0z191CLnyrE4SwwiBDGJNV0RENGQZDUf9p4zjK6F0jKhZ1Uq7d0SkVYIuiBVbkGgqhMRNBO0BWQRbQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WvoQ9Bb0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7y2jq2OS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Aug 2025 13:18:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755091126;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0UXY3yeT5o2UxdSLHKDhpm3hJEqv9rNtP6Six1kSQ2Y=;
	b=WvoQ9Bb0bQ5mSPeLGVAnBQYOdHk6MWgjy7rM4PUZapoCyOrtPYN/8bRM6SBKaXnlPrwwI4
	F/aGNo9lSqzW1jJpNDsQKRA3DZhUHLsYo3czlAqYp+Nf5oDAldYw2uPU9hO8cGNur+Ell4
	Nz+eq1GgwqcO+/3GR4gfkDAkWmvGWnnWey8Hl1KtnziG+hw5ad2aWTnjlVnZvC54xGifzH
	4VAaMaBYW5zlHoVvRdIAh2hup1Lqz1zEIQ8zoQZPpm2POPzWBC2v+aEyHNCrJlsfAvWcg1
	blYoGwEsCSytJtFm0Nlv+REchlxlKw90/mOuIV3g3rRcBf+B6uYhLiBR+q+hgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755091126;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0UXY3yeT5o2UxdSLHKDhpm3hJEqv9rNtP6Six1kSQ2Y=;
	b=7y2jq2OSRbs5vAiPgIhjPPkMncOm6f+WQNlvjqDgIdIGBTsvTv0lAdrqd/U67EGj6XJq9D
	i1QUPfLrBPJBFpDQ==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking: Fix __clear_task_blocked_on() warning
 from __ww_mutex_wound() path
Cc: syzbot+602c4720aed62576cd79@syzkaller.appspotmail.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250805001026.2247040-1-jstultz@google.com>
References: <20250805001026.2247040-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175509112460.1420.2528978507381552492.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     21924af67d69d7c9fdaf845be69043cfe75196a1
Gitweb:        https://git.kernel.org/tip/21924af67d69d7c9fdaf845be69043cfe75=
196a1
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Tue, 05 Aug 2025 00:10:02=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 13 Aug 2025 10:34:54 +02:00

locking: Fix __clear_task_blocked_on() warning from __ww_mutex_wound() path

The __clear_task_blocked_on() helper added a number of sanity
checks ensuring we hold the mutex wait lock and that the task
we are clearing blocked_on pointer (if set) matches the mutex.

However, there is an edge case in the _ww_mutex_wound() logic
where we need to clear the blocked_on pointer for the task that
owns the mutex, not the task that is waiting on the mutex.

For this case the sanity checks aren't valid, so handle this
by allowing a NULL lock to skip the additional checks.

K Prateek Nayak and Maarten Lankhorst also pointed out that in
this case where we don't hold the owner's mutex wait_lock, we
need to be a bit more careful using READ_ONCE/WRITE_ONCE in both
the __clear_task_blocked_on() and __set_task_blocked_on()
implementations to avoid accidentally tripping WARN_ONs if two
instances race. So do that here as well.

This issue was easier to miss, I realized, as the test-ww_mutex
driver only exercises the wait-die class of ww_mutexes. I've
sent a patch[1] to address this so the logic will be easier to
test.

[1]: https://lore.kernel.org/lkml/20250801023358.562525-2-jstultz@google.com/

Fixes: a4f0b6fef4b0 ("locking/mutex: Add p->blocked_on wrappers for correctne=
ss checks")
Closes: https://lore.kernel.org/lkml/68894443.a00a0220.26d0e1.0015.GAE@google=
.com/
Reported-by: syzbot+602c4720aed62576cd79@syzkaller.appspotmail.com
Reported-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Acked-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20250805001026.2247040-1-jstultz@google.com
---
 include/linux/sched.h     | 29 +++++++++++++++++------------
 kernel/locking/ww_mutex.h |  6 +++++-
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 40d2fa9..62103dd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2144,6 +2144,8 @@ static inline struct mutex *__get_task_blocked_on(struc=
t task_struct *p)
=20
 static inline void __set_task_blocked_on(struct task_struct *p, struct mutex=
 *m)
 {
+	struct mutex *blocked_on =3D READ_ONCE(p->blocked_on);
+
 	WARN_ON_ONCE(!m);
 	/* The task should only be setting itself as blocked */
 	WARN_ON_ONCE(p !=3D current);
@@ -2154,8 +2156,8 @@ static inline void __set_task_blocked_on(struct task_st=
ruct *p, struct mutex *m)
 	 * with a different mutex. Note, setting it to the same
 	 * lock repeatedly is ok.
 	 */
-	WARN_ON_ONCE(p->blocked_on && p->blocked_on !=3D m);
-	p->blocked_on =3D m;
+	WARN_ON_ONCE(blocked_on && blocked_on !=3D m);
+	WRITE_ONCE(p->blocked_on, m);
 }
=20
 static inline void set_task_blocked_on(struct task_struct *p, struct mutex *=
m)
@@ -2166,16 +2168,19 @@ static inline void set_task_blocked_on(struct task_st=
ruct *p, struct mutex *m)
=20
 static inline void __clear_task_blocked_on(struct task_struct *p, struct mut=
ex *m)
 {
-	WARN_ON_ONCE(!m);
-	/* Currently we serialize blocked_on under the mutex::wait_lock */
-	lockdep_assert_held_once(&m->wait_lock);
-	/*
-	 * There may be cases where we re-clear already cleared
-	 * blocked_on relationships, but make sure we are not
-	 * clearing the relationship with a different lock.
-	 */
-	WARN_ON_ONCE(m && p->blocked_on && p->blocked_on !=3D m);
-	p->blocked_on =3D NULL;
+	if (m) {
+		struct mutex *blocked_on =3D READ_ONCE(p->blocked_on);
+
+		/* Currently we serialize blocked_on under the mutex::wait_lock */
+		lockdep_assert_held_once(&m->wait_lock);
+		/*
+		 * There may be cases where we re-clear already cleared
+		 * blocked_on relationships, but make sure we are not
+		 * clearing the relationship with a different lock.
+		 */
+		WARN_ON_ONCE(blocked_on && blocked_on !=3D m);
+	}
+	WRITE_ONCE(p->blocked_on, NULL);
 }
=20
 static inline void clear_task_blocked_on(struct task_struct *p, struct mutex=
 *m)
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 086fd54..31a785a 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -342,8 +342,12 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 			 * When waking up the task to wound, be sure to clear the
 			 * blocked_on pointer. Otherwise we can see circular
 			 * blocked_on relationships that can't resolve.
+			 *
+			 * NOTE: We pass NULL here instead of lock, because we
+			 * are waking the mutex owner, who may be currently
+			 * blocked on a different mutex.
 			 */
-			__clear_task_blocked_on(owner, lock);
+			__clear_task_blocked_on(owner, NULL);
 			wake_q_add(wake_q, owner);
 		}
 		return true;

