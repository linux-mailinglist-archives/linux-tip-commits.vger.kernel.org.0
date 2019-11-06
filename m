Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE3BF2062
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2019 22:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfKFVGi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 6 Nov 2019 16:06:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45359 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbfKFVGi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 6 Nov 2019 16:06:38 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iSSVa-0003ER-KP; Wed, 06 Nov 2019 22:06:30 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E76D01C0131;
        Wed,  6 Nov 2019 22:06:29 +0100 (CET)
Date:   Wed, 06 Nov 2019 21:06:29 -0000
From:   "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Annotate lockless access to timer->state
Cc:     syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191106174804.74723-1-edumazet@google.com>
References: <20191106174804.74723-1-edumazet@google.com>
MIME-Version: 1.0
Message-ID: <157307438959.29376.9644507314555163943.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     de4db39b9f0e682e59caa828a277632510901560
Gitweb:        https://git.kernel.org/tip/de4db39b9f0e682e59caa828a277632510901560
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Wed, 06 Nov 2019 09:48:04 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 06 Nov 2019 21:59:56 +01:00

hrtimer: Annotate lockless access to timer->state

syzbot reported various data-race caused by hrtimer_is_queued() reading
timer->state. A READ_ONCE() is required there to silence the warning.

Also add the corresponding WRITE_ONCE() when timer->state is set.

In remove_hrtimer() the hrtimer_is_queued() helper is open coded to avoid
loading timer->state twice.

KCSAN reported these cases:

BUG: KCSAN: data-race in __remove_hrtimer / tcp_pacing_check

write to 0xffff8880b2a7d388 of 1 bytes by interrupt on cpu 0:
 __remove_hrtimer+0x52/0x130 kernel/time/hrtimer.c:991
 __run_hrtimer kernel/time/hrtimer.c:1496 [inline]
 __hrtimer_run_queues+0x250/0x600 kernel/time/hrtimer.c:1576
 hrtimer_run_softirq+0x10e/0x150 kernel/time/hrtimer.c:1593
 __do_softirq+0x115/0x33f kernel/softirq.c:292
 run_ksoftirqd+0x46/0x60 kernel/softirq.c:603
 smpboot_thread_fn+0x37d/0x4a0 kernel/smpboot.c:165
 kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352

read to 0xffff8880b2a7d388 of 1 bytes by task 24652 on cpu 1:
 tcp_pacing_check net/ipv4/tcp_output.c:2235 [inline]
 tcp_pacing_check+0xba/0x130 net/ipv4/tcp_output.c:2225
 tcp_xmit_retransmit_queue+0x32c/0x5a0 net/ipv4/tcp_output.c:3044
 tcp_xmit_recovery+0x7c/0x120 net/ipv4/tcp_input.c:3558
 tcp_ack+0x17b6/0x3170 net/ipv4/tcp_input.c:3717
 tcp_rcv_established+0x37e/0xf50 net/ipv4/tcp_input.c:5696
 tcp_v4_do_rcv+0x381/0x4e0 net/ipv4/tcp_ipv4.c:1561
 sk_backlog_rcv include/net/sock.h:945 [inline]
 __release_sock+0x135/0x1e0 net/core/sock.c:2435
 release_sock+0x61/0x160 net/core/sock.c:2951
 sk_stream_wait_memory+0x3d7/0x7c0 net/core/stream.c:145
 tcp_sendmsg_locked+0xb47/0x1f30 net/ipv4/tcp.c:1393
 tcp_sendmsg+0x39/0x60 net/ipv4/tcp.c:1434
 inet_sendmsg+0x6d/0x90 net/ipv4/af_inet.c:807
 sock_sendmsg_nosec net/socket.c:637 [inline]
 sock_sendmsg+0x9f/0xc0 net/socket.c:657

BUG: KCSAN: data-race in __remove_hrtimer / __tcp_ack_snd_check

write to 0xffff8880a3a65588 of 1 bytes by interrupt on cpu 0:
 __remove_hrtimer+0x52/0x130 kernel/time/hrtimer.c:991
 __run_hrtimer kernel/time/hrtimer.c:1496 [inline]
 __hrtimer_run_queues+0x250/0x600 kernel/time/hrtimer.c:1576
 hrtimer_run_softirq+0x10e/0x150 kernel/time/hrtimer.c:1593
 __do_softirq+0x115/0x33f kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0xbb/0xe0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:536 [inline]
 smp_apic_timer_interrupt+0xe6/0x280 arch/x86/kernel/apic/apic.c:1137
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830

read to 0xffff8880a3a65588 of 1 bytes by task 22891 on cpu 1:
 __tcp_ack_snd_check+0x415/0x4f0 net/ipv4/tcp_input.c:5265
 tcp_ack_snd_check net/ipv4/tcp_input.c:5287 [inline]
 tcp_rcv_established+0x750/0xf50 net/ipv4/tcp_input.c:5708
 tcp_v4_do_rcv+0x381/0x4e0 net/ipv4/tcp_ipv4.c:1561
 sk_backlog_rcv include/net/sock.h:945 [inline]
 __release_sock+0x135/0x1e0 net/core/sock.c:2435
 release_sock+0x61/0x160 net/core/sock.c:2951
 sk_stream_wait_memory+0x3d7/0x7c0 net/core/stream.c:145
 tcp_sendmsg_locked+0xb47/0x1f30 net/ipv4/tcp.c:1393
 tcp_sendmsg+0x39/0x60 net/ipv4/tcp.c:1434
 inet_sendmsg+0x6d/0x90 net/ipv4/af_inet.c:807
 sock_sendmsg_nosec net/socket.c:637 [inline]
 sock_sendmsg+0x9f/0xc0 net/socket.c:657
 __sys_sendto+0x21f/0x320 net/socket.c:1952
 __do_sys_sendto net/socket.c:1964 [inline]
 __se_sys_sendto net/socket.c:1960 [inline]
 __x64_sys_sendto+0x89/0xb0 net/socket.c:1960
 do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 24652 Comm: syz-executor.3 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011

[ tglx: Added comments ]

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191106174804.74723-1-edumazet@google.com

---
 include/linux/hrtimer.h | 14 ++++++++++----
 kernel/time/hrtimer.c   | 11 +++++++----
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 1b9a51a..6308952 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -456,12 +456,18 @@ extern u64 hrtimer_next_event_without(const struct hrtimer *exclude);
 
 extern bool hrtimer_active(const struct hrtimer *timer);
 
-/*
- * Helper function to check, whether the timer is on one of the queues
+/**
+ * hrtimer_is_queued = check, whether the timer is on one of the queues
+ * @timer:	Timer to check
+ *
+ * Returns: True if the timer is queued, false otherwise
+ *
+ * The function can be used lockless, but it gives only a current snapshot.
  */
-static inline int hrtimer_is_queued(struct hrtimer *timer)
+static inline bool hrtimer_is_queued(struct hrtimer *timer)
 {
-	return timer->state & HRTIMER_STATE_ENQUEUED;
+	/* The READ_ONCE pairs with the update functions of timer->state */
+	return !!READ_ONCE(timer->state) & HRTIMER_STATE_ENQUEUED;
 }
 
 /*
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 6560553..7f31932 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -966,7 +966,8 @@ static int enqueue_hrtimer(struct hrtimer *timer,
 
 	base->cpu_base->active_bases |= 1 << base->index;
 
-	timer->state = HRTIMER_STATE_ENQUEUED;
+	/* Pairs with the lockless read in hrtimer_is_queued() */
+	WRITE_ONCE(timer->state, HRTIMER_STATE_ENQUEUED);
 
 	return timerqueue_add(&base->active, &timer->node);
 }
@@ -988,7 +989,8 @@ static void __remove_hrtimer(struct hrtimer *timer,
 	struct hrtimer_cpu_base *cpu_base = base->cpu_base;
 	u8 state = timer->state;
 
-	timer->state = newstate;
+	/* Pairs with the lockless read in hrtimer_is_queued() */
+	WRITE_ONCE(timer->state, newstate);
 	if (!(state & HRTIMER_STATE_ENQUEUED))
 		return;
 
@@ -1013,8 +1015,9 @@ static void __remove_hrtimer(struct hrtimer *timer,
 static inline int
 remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base, bool restart)
 {
-	if (hrtimer_is_queued(timer)) {
-		u8 state = timer->state;
+	u8 state = timer->state;
+
+	if (state & HRTIMER_STATE_ENQUEUED) {
 		int reprogram;
 
 		/*
