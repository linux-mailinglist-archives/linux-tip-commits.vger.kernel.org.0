Return-Path: <linux-tip-commits+bounces-3253-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13575A129A5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 18:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29028167422
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B064189521;
	Wed, 15 Jan 2025 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DQxHnwqF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7J9ZwMhr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2848D78289;
	Wed, 15 Jan 2025 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736961597; cv=none; b=b8Y2tyNpfAOxkfBGPNZdcYPZD53AsiTwM6fc5H8u690psFaXhczRZ+EHgx3JN/6EkyxgTVu4IxBltLg2HhzTN/R8LXB+cBg72CikkYv74VdOvm1tksz9e7v+afNSWcDc12zEmJKqKrRaJzRlnP7Pk/+DAeBXrV5gyH0ZkKtQLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736961597; c=relaxed/simple;
	bh=G5JUe3T7T1iwcjpT3DI2fgtzom/naGiKhZtrfag6o1E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PZWNigCP5/sOSWpGz3Vq2F1sjiU7JOKYAXUIFGIH04r43EOUx5AlNYxNNnnbsmKP6C2L98yCe7YMY05DIu6mx7InZEImJPmyGciEWNoCbW5fxhOZARdby7rrsuAKCLISTQMg05DTWfdZjkA+gH7h2sObMdyB40IphjKjPOvANz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DQxHnwqF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7J9ZwMhr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 17:19:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736961593;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vo2ByT4n9RlZ9KPLoQLVivGc4G/dXysDzDTH5/nefC0=;
	b=DQxHnwqF7nOpEzWggC+THEF89EwPzk0XDjflFUbRiwXTnEdvdTVZYMjxJ69ohYbT9q7a6G
	Q6pNzvaowpcef4/xW00ly0nOUvlvHk4wR+9Q+L9OFN0TYrC4gBjXzV/xvrvJDuWA/aMoAq
	X5I4vXqNa7RdckVZPOfbpYuK9LVNtOhaRpdXGFEE8FQI2m4OqVdH2+Iu8brdlfSKfynGKe
	lCmXt7zmybJubgvSa0kaM3F2AtJhfnDHkdChaXyce0qI0rtVyFCwbuK9XzXGEpf4ndmpuH
	OjzflcipqRxQ0p/kjur0bTyGVUagnoCAZVB3+oemPkPKNGlnGlnlcxsQRb2ofQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736961593;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vo2ByT4n9RlZ9KPLoQLVivGc4G/dXysDzDTH5/nefC0=;
	b=7J9ZwMhrtdYgi6KOAkFUQ6WEOBUtYdYoygP2fQurzWID6beTi2jILSZA2o7/7wj1jDRcpc
	ryERIyjvyTWrPuDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] signal/posixtimers: Handle ignore/blocked
 sequences correctly
Cc: syzbot+3c2e3cc60665d71de2f7@syzkaller.appspotmail.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87ikqhcnjn.ffs@tglx>
References: <87ikqhcnjn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173696159065.31546.15771902571847449667.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     8c4840277b6daffe09dea0338f3fce1eb4319a43
Gitweb:        https://git.kernel.org/tip/8c4840277b6daffe09dea0338f3fce1eb4319a43
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 14 Jan 2025 18:28:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 18:08:01 +01:00

signal/posixtimers: Handle ignore/blocked sequences correctly

syzbot triggered the warning in posixtimer_send_sigqueue(), which warns
about a non-ignored signal being already queued on the ignored list.

The warning is actually bogus, as the following sequence causes this:

    signal($SIG, SIGIGN);
    timer_settime(...);			// arm periodic timer

      timer fires, signal is ignored and queued on ignored list

    sigprocmask(SIG_BLOCK, ...);        // block the signal
    timer_settime(...);			// re-arm periodic timer

      timer fires, signal is not ignored because it is blocked
        ---> Warning triggers as signal is on the ignored list

Ideally timer_settime() could remove the signal, but that's racy and
incomplete vs. other scenarios and requires a full reevaluation of the
pending signal list.

Instead of adding more complexity, handle it gracefully by removing the
warning and requeueing the signal to the pending list. That's correct
versus:

  1) sig[timed]wait() as that does not check for SIGIGN and only relies on
     dequeue_signal() -> posixtimers_deliver_signal() to check whether the
     pending signal is still valid.

  2) Unblocking of the signal.

     - If the unblocking happens before SIGIGN is replaced by a signal
       handler, then the timer is rearmed in dequeue_signal(), but
       get_signal() will ignore it. The next timer expiry will move it back
       to the ignored list.

     - If SIGIGN was replaced before unblocking, then the signal will be
       delivered and a subsequent expiry will queue a signal on the pending
       list again.

There is a related scenario to trigger the complementary warning in the
signal ignored path, which does not expect the signal to be on the pending
list when it is ignored. That can be triggered even before the above change
via:

task1			task2

signal($SIG, SIGIGN);
			sigprocmask(SIG_BLOCK, ...);

timer_create();		// Signal target is task2
timer_settime(...);	// arm periodic timer

   timer fires, signal is not ignored because it is blocked
   and queued on the pending list of task2

       	      	     	syscall()
			   // Sets the pending flag
			   sigprocmask(SIG_UNBLOCK, ...);

			-> preemption, task2 cannot dequeue the signal

timer_settime(...);	// re-arm periodic timer

   timer fires, signal is ignored
        ---> Warning triggers as signal is on task2's pending list
	     and the thread group is not exiting

Consequently, remove that warning too and just keep the signal on the
pending list.

The following attempt to deliver the signal on return to user space of
task2 will ignore the signal and a subsequent expiry will bring it back to
the ignored list, if it did not get blocked or un-ignored before that.

Fixes: df7a996b4dab ("signal: Queue ignored posixtimers on ignore list")
Reported-by: syzbot+3c2e3cc60665d71de2f7@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/87ikqhcnjn.ffs@tglx

---
 kernel/signal.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 989b1cc..a2afd54 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2007,11 +2007,22 @@ void posixtimer_send_sigqueue(struct k_itimer *tmr)
 
 		if (!list_empty(&q->list)) {
 			/*
-			 * If task group is exiting with the signal already pending,
-			 * wait for __exit_signal() to do its job. Otherwise if
-			 * ignored, it's not supposed to be queued. Try to survive.
+			 * The signal was ignored and blocked. The timer
+			 * expiry queued it because blocked signals are
+			 * queued independent of the ignored state.
+			 *
+			 * The unblocking set SIGPENDING, but the signal
+			 * was not yet dequeued from the pending list.
+			 * So prepare_signal() sees unblocked and ignored,
+			 * which ends up here. Leave it queued like a
+			 * regular signal.
+			 *
+			 * The same happens when the task group is exiting
+			 * and the signal is already queued.
+			 * prepare_signal() treats SIGNAL_GROUP_EXIT as
+			 * ignored independent of its queued state. This
+			 * gets cleaned up in __exit_signal().
 			 */
-			WARN_ON_ONCE(!(t->signal->flags & SIGNAL_GROUP_EXIT));
 			goto out;
 		}
 
@@ -2046,17 +2057,25 @@ void posixtimer_send_sigqueue(struct k_itimer *tmr)
 		goto out;
 	}
 
-	/* This should never happen and leaks a reference count */
-	if (WARN_ON_ONCE(!hlist_unhashed(&tmr->ignored_list)))
-		hlist_del_init(&tmr->ignored_list);
-
 	if (unlikely(!list_empty(&q->list))) {
 		/* This holds a reference count already */
 		result = TRACE_SIGNAL_ALREADY_PENDING;
 		goto out;
 	}
 
-	posixtimer_sigqueue_getref(q);
+	/*
+	 * If the signal is on the ignore list, it got blocked after it was
+	 * ignored earlier. But nothing lifted the ignore. Move it back to
+	 * the pending list to be consistent with the regular signal
+	 * handling. This already holds a reference count.
+	 *
+	 * If it's not on the ignore list acquire a reference count.
+	 */
+	if (likely(hlist_unhashed(&tmr->ignored_list)))
+		posixtimer_sigqueue_getref(q);
+	else
+		hlist_del_init(&tmr->ignored_list);
+
 	posixtimer_queue_sigqueue(q, t, tmr->it_pid_type);
 	result = TRACE_SIGNAL_DELIVERED;
 out:

