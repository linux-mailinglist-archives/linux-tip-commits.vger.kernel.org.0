Return-Path: <linux-tip-commits+bounces-2868-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B90D29D16E0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Nov 2024 18:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC501F21FB1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Nov 2024 17:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B421BD9DA;
	Mon, 18 Nov 2024 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BpqZv+RO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gveirhDD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2DD199E89;
	Mon, 18 Nov 2024 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731950116; cv=none; b=UIhl36AtfP+LOywdvnFaH4n8X/vD+dpP5gzSFFxFSHMwqxW8c4hK/mVvKH91Kv3MbNmW/FOhNRyvqO1WMj3sc3Q5tOuNwWMQlxnj4RqUsCliWDIR64WvSrffVMPalNZ9UL7cjoh2Odp87csWLwxdEUSfN8Ja8xg9NFFdnlPmwAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731950116; c=relaxed/simple;
	bh=OriTaLdwFjr6ntU9U/4PhrKSR3DPlhVA+LiAOjfwK3Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pqEFg7ue2N0d/O8qyQmvFbU64B6WA3lRxjF6PsxY4m6cW5c7Xp3KysybyKmcRo+8mBZD+wdUiGurhPX/6C8ERJZvTbTpwoBFmaySWLIHBk5eQTQjvyw7p6G6eIgD8Ixb3vypABRc0N3aQMTHHQ9bcsXSeIuflVkVZOiP704WWbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BpqZv+RO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gveirhDD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Nov 2024 17:15:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731950112;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yire9oZ4glwobMKbi913ZTld21ZlNAGCDTZpgF5ctxA=;
	b=BpqZv+RO3DeOyQtQ1y/a7fqe7ngYPVmivY7wUHdbH3TFUG5zB0tfPNDyzT+pIF8wCZjyET
	b/hASMMvSVEx1Y8h2ytQFZ2FQejWI4eSNjjfsx0bmbd7bh9jDRG7Tlg5e1NeOLbYKZhw58
	bide5Cl7zNGGH6I0J1SlxBdwvtzpIB2161OWbz/CfzGF8v9ISp91WRxIQl9yugTLpZ1mXB
	//mx+h0Po9kshkYffdvhrgQbc/cySDjtxsrDUcQN7zjjeQ7jDouIZ6j//V7UHGDrjcnZ6K
	OUPDKM/VCb7HQtLz0DRaJEI2m6ioxFr5d/JzCljPZo5aWr8p+S0U3e4Mtpj/9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731950112;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yire9oZ4glwobMKbi913ZTld21ZlNAGCDTZpgF5ctxA=;
	b=gveirhDDd6ifrOb1G1DvC8hQQ3j9jvR36zReflwMx16JHz6yrAbMs8xyTnG1VC3IS9963G
	Sc9pLnZAi+/+kABg==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Fix spurious warning on double
 enqueue versus do_exit()
Cc: syzbot+852e935b899bde73626e@syzkaller.appspotmail.com,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241116234823.28497-1-frederic@kernel.org>
References: <20241116234823.28497-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173195011105.412.2147858521751223874.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     cdc905d16b07981363e53a21853ba1cf6cd8e92a
Gitweb:        https://git.kernel.org/tip/cdc905d16b07981363e53a21853ba1cf6cd8e92a
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Sun, 17 Nov 2024 00:48:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 18 Nov 2024 18:03:59 +01:00

posix-timers: Fix spurious warning on double enqueue versus do_exit()

A timer sigqueue may find itself already pending when it is tried to
be enqueued. This situation can happen if the timer sigqueue is enqueued
but then the timer is reset afterwards and fires before the pending
signal managed to be delivered.

However when such a double enqueue occurs while the corresponding signal
is ignored, the sigqueue is expected to be found either on the dedicated
ignored list if the timer was periodic or dropped if the timer was
one-shot. In any case it is not supposed to be queued on the real signal
queue.

An assertion verifies the latter expectation on top of the return value
of prepare_signal(), assuming "false" means that the signal is being
ignored. But prepare_signal() may also fail if the target is exiting as
the last task of its group. In this case the double enqueue observes the
sigqueue queued, as in such a situation:

    TASK A (same group as B)                   TASK B (same group as A)
    ------------------------                   ------------------------

    // timer event
    // queue signal to TASK B
    posix_timer_queue_signal()
    // reset timer through syscall
    do_timer_settime()
    // exit, leaving task B alone
    do_exit()
                                               do_exit()
                                                  synchronize_group_exit()
                                                      signal->flags = SIGNAL_GROUP_EXIT
                                                  // ========> <IRQ> timer event
                                                  posix_timer_queue_signal()
                                                  // return false due to SIGNAL_GROUP_EXIT
                                                  if (!prepare_signal())
                                                     WARN_ON_ONCE(!list_empty(&q->list))

And this spuriously triggers this warning:

    WARNING: CPU: 0 PID: 5854 at kernel/signal.c:2008 posixtimer_send_sigqueue
    CPU: 0 UID: 0 PID: 5854 Comm: syz-executor139 Not tainted 6.12.0-rc6-next-20241108-syzkaller #0
    RIP: 0010:posixtimer_send_sigqueue+0x9da/0xbc0 kernel/signal.c:2008
    Call Trace:
     <IRQ>
     alarm_handle_timer
     alarmtimer_fired
     __run_hrtimer
     __hrtimer_run_queues
     hrtimer_interrupt
     local_apic_timer_interrupt
     __sysvec_apic_timer_interrupt
     instr_sysvec_apic_timer_interrupt
     sysvec_apic_timer_interrupt
     </IRQ>

Fortunately the recovery code in that case already does the right thing:
just exit from posixtimer_send_sigqueue() and wait for __exit_signal()
to flush the pending signal. Just make sure to warn only the case when
the sigqueue is queued and the signal is really ignored.

Fixes: df7a996b4dab ("signal: Queue ignored posixtimers on ignore list")
Reported-by: syzbot+852e935b899bde73626e@syzkaller.appspotmail.com
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: syzbot+852e935b899bde73626e@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/20241116234823.28497-1-frederic@kernel.org
Closes: https://lore.kernel.org/all/673549c6.050a0220.1324f8.008c.GAE@google.com
---
 kernel/signal.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index cbf70c8..10b464b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2003,9 +2003,15 @@ void posixtimer_send_sigqueue(struct k_itimer *tmr)
 	if (!prepare_signal(sig, t, false)) {
 		result = TRACE_SIGNAL_IGNORED;
 
-		/* Paranoia check. Try to survive. */
-		if (WARN_ON_ONCE(!list_empty(&q->list)))
+		if (!list_empty(&q->list)) {
+			/*
+			 * If task group is exiting with the signal already pending,
+			 * wait for __exit_signal() to do its job. Otherwise if
+			 * ignored, it's not supposed to be queued. Try to survive.
+			 */
+			WARN_ON_ONCE(!(t->signal->flags & SIGNAL_GROUP_EXIT));
 			goto out;
+		}
 
 		/* Periodic timers with SIG_IGN are queued on the ignored list */
 		if (tmr->it_sig_periodic) {

