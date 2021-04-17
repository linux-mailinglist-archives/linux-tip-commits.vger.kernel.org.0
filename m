Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F3E362FAE
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 Apr 2021 13:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhDQLtd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 17 Apr 2021 07:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236009AbhDQLtc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 17 Apr 2021 07:49:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB905C061574;
        Sat, 17 Apr 2021 04:49:06 -0700 (PDT)
Date:   Sat, 17 Apr 2021 11:49:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618660144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rFC/rWkjSJET2j48jfBQ2jr1THdQBw4FW0cnT1t61Gk=;
        b=iTwbxXJ4h0lbd5FXMG8qKPv5+dyVxKStcEjZVgTQ5sLGkuWw5UtSG+v+zVjGwlu4y3tIY2
        kW3mqW1epJekTVgIKDcjFNNs+7RgSIwyp/bGxPOxcxOz8jNXgkam14An8nHYhbR85BpK7E
        +sBg8TVXbq0zgCuGZz7ZovF4ZnOtO+RJjB9DEZvwmQ43ZAG/sBAA4D679Y+8yb5OqVF3zT
        IYO0mGzdo00WjduDtKPrT6x/de9HLXv9jAkc0g+nzAc0D7j9+wOSZezBR9j1eGG0rDbe14
        o77+AHW6WTYPqPPTDsUYmwWvaNLLpdiQzrCMQzcUKZLKL4Ab08zbQ+udpifdfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618660144;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rFC/rWkjSJET2j48jfBQ2jr1THdQBw4FW0cnT1t61Gk=;
        b=zEf8ELqoLreGZjsMKSXdcbE0KvsEPK8NrJmG/1jo5qBDmArZV5bp0VR7cbKJ7ItZZDdkWd
        xl/p7G1KzrFXOCCw==
From:   "tip-bot2 for Ali Saidi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/qrwlock: Fix ordering in
 queued_write_lock_slowpath()
Cc:     Ali Saidi <alisaidi@amazon.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Steve Capper <steve.capper@arm.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161866014365.29796.9238636476613418213.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     84a24bf8c52e66b7ac89ada5e3cfbe72d65c1896
Gitweb:        https://git.kernel.org/tip/84a24bf8c52e66b7ac89ada5e3cfbe72d65=
c1896
Author:        Ali Saidi <alisaidi@amazon.com>
AuthorDate:    Thu, 15 Apr 2021 17:27:11=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Apr 2021 13:40:50 +02:00

locking/qrwlock: Fix ordering in queued_write_lock_slowpath()

While this code is executed with the wait_lock held, a reader can
acquire the lock without holding wait_lock.  The writer side loops
checking the value with the atomic_cond_read_acquire(), but only truly
acquires the lock when the compare-and-exchange is completed
successfully which isn=E2=80=99t ordered. This exposes the window between the
acquire and the cmpxchg to an A-B-A problem which allows reads
following the lock acquisition to observe values speculatively before
the write lock is truly acquired.

We've seen a problem in epoll where the reader does a xchg while
holding the read lock, but the writer can see a value change out from
under it.

  Writer                                | Reader
  ---------------------------------------------------------------------------=
-----
  ep_scan_ready_list()                  |
  |- write_lock_irq()                   |
      |- queued_write_lock_slowpath()   |
	|- atomic_cond_read_acquire()   |
				        | read_lock_irqsave(&ep->lock, flags);
     --> (observes value before unlock) |  chain_epi_lockless()
     |                                  |    epi->next =3D xchg(&ep->ovflist,=
 epi);
     |                                  | read_unlock_irqrestore(&ep->lock, f=
lags);
     |                                  |
     |     atomic_cmpxchg_relaxed()     |
     |-- READ_ONCE(ep->ovflist);        |

A core can order the read of the ovflist ahead of the
atomic_cmpxchg_relaxed(). Switching the cmpxchg to use acquire
semantics addresses this issue at which point the atomic_cond_read can
be switched to use relaxed semantics.

Fixes: b519b56e378ee ("locking/qrwlock: Use atomic_cond_read_acquire() when s=
pinning in qrwlock")
Signed-off-by: Ali Saidi <alisaidi@amazon.com>
[peterz: use try_cmpxchg()]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steve Capper <steve.capper@arm.com>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Tested-by: Steve Capper <steve.capper@arm.com>
---
 kernel/locking/qrwlock.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index 4786dd2..b94f383 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -60,6 +60,8 @@ EXPORT_SYMBOL(queued_read_lock_slowpath);
  */
 void queued_write_lock_slowpath(struct qrwlock *lock)
 {
+	int cnts;
+
 	/* Put the writer into the wait queue */
 	arch_spin_lock(&lock->wait_lock);
=20
@@ -73,9 +75,8 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
=20
 	/* When no more readers or writers, set the locked flag */
 	do {
-		atomic_cond_read_acquire(&lock->cnts, VAL =3D=3D _QW_WAITING);
-	} while (atomic_cmpxchg_relaxed(&lock->cnts, _QW_WAITING,
-					_QW_LOCKED) !=3D _QW_WAITING);
+		cnts =3D atomic_cond_read_relaxed(&lock->cnts, VAL =3D=3D _QW_WAITING);
+	} while (!atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED));
 unlock:
 	arch_spin_unlock(&lock->wait_lock);
 }
