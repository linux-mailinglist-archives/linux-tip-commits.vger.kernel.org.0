Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F98459EA4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Nov 2021 09:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbhKWI4x (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Nov 2021 03:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbhKWI4v (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Nov 2021 03:56:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F96C06173E;
        Tue, 23 Nov 2021 00:53:43 -0800 (PST)
Date:   Tue, 23 Nov 2021 08:53:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637657621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c4E96g0nyz298wn9p6WYB+XBjEFy18cyOMUGEPhwMCA=;
        b=gFFvEedGhqqbE8k7432hGJx4ov7YeTSB3SnFPuraO1w9OdN6weIw66hIojW/AHheyrFP5t
        LjRjLmbG49IQcIa81YSw93OL7ASyLtrphlOI4M1LpSuf2mtnexLQyT0a8MhZR3qpUFETHL
        7XhE6534OC1A/0+p47teYHtBWxwW2Dii4j5EGUzlEb0vEFIak4cMzAI+92Df8NjhvPDnh/
        htDltVJ82twyfAnuUl/0Wf88/Fhh7WRQWO4jiSq84nWkdtwTAlEZATfmR3TToSUs4BKSN7
        5+1rsmbWDEiQCXR2so9hdEEmYuSXG6azriUR0IxpmuJq2UmPpExgCdoNFGEnPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637657621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c4E96g0nyz298wn9p6WYB+XBjEFy18cyOMUGEPhwMCA=;
        b=6JJr/vI5lpr/BonqJ7PZBaeVuxQLyZ+QHIRe0fgyBB6Wn80xo/IMb4nMKcCGlRFcCCID/n
        0fy1ZYpwB8fOZODw==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Ignore sigtrap for tracepoints destined for
 other tasks
Cc:     syzbot+663359e32ce6f1a305ad@syzkaller.appspotmail.com,
        Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <kJWfmI@elver.google.com>
References: <kJWfmI@elver.google.com>
MIME-Version: 1.0
Message-ID: <163765762058.11128.9441697043522251183.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     73743c3b092277febbf69b250ce8ebbca0525aa2
Gitweb:        https://git.kernel.org/tip/73743c3b092277febbf69b250ce8ebbca0525aa2
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 09 Nov 2021 13:22:32 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Nov 2021 09:45:37 +01:00

perf: Ignore sigtrap for tracepoints destined for other tasks

syzbot reported that the warning in perf_sigtrap() fires, saying that
the event's task does not match current:

 | WARNING: CPU: 0 PID: 9090 at kernel/events/core.c:6446 perf_pending_event+0x40d/0x4b0 kernel/events/core.c:6513
 | Modules linked in:
 | CPU: 0 PID: 9090 Comm: syz-executor.1 Not tainted 5.15.0-syzkaller #0
 | Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
 | RIP: 0010:perf_sigtrap kernel/events/core.c:6446 [inline]
 | RIP: 0010:perf_pending_event_disable kernel/events/core.c:6470 [inline]
 | RIP: 0010:perf_pending_event+0x40d/0x4b0 kernel/events/core.c:6513
 | ...
 | Call Trace:
 |  <IRQ>
 |  irq_work_single+0x106/0x220 kernel/irq_work.c:211
 |  irq_work_run_list+0x6a/0x90 kernel/irq_work.c:242
 |  irq_work_run+0x4f/0xd0 kernel/irq_work.c:251
 |  __sysvec_irq_work+0x95/0x3d0 arch/x86/kernel/irq_work.c:22
 |  sysvec_irq_work+0x8e/0xc0 arch/x86/kernel/irq_work.c:17
 |  </IRQ>
 |  <TASK>
 |  asm_sysvec_irq_work+0x12/0x20 arch/x86/include/asm/idtentry.h:664
 | RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 | RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
 | ...
 |  coredump_task_exit kernel/exit.c:371 [inline]
 |  do_exit+0x1865/0x25c0 kernel/exit.c:771
 |  do_group_exit+0xe7/0x290 kernel/exit.c:929
 |  get_signal+0x3b0/0x1ce0 kernel/signal.c:2820
 |  arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:868
 |  handle_signal_work kernel/entry/common.c:148 [inline]
 |  exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 |  exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:207
 |  __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 |  syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 |  do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 |  entry_SYSCALL_64_after_hwframe+0x44/0xae

On x86 this shouldn't happen, which has arch_irq_work_raise().

The test program sets up a perf event with sigtrap set to fire on the
'sched_wakeup' tracepoint, which fired in ttwu_do_wakeup().

This happened because the 'sched_wakeup' tracepoint also takes a task
argument passed on to perf_tp_event(), which is used to deliver the
event to that other task.

Since we cannot deliver synchronous signals to other tasks, skip an event if
perf_tp_event() is targeted at another task and perf_event_attr::sigtrap is
set, which will avoid ever entering perf_sigtrap() for such events.

Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
Reported-by: syzbot+663359e32ce6f1a305ad@syzkaller.appspotmail.com
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/YYpoCOBmC/kJWfmI@elver.google.com
---
 kernel/events/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 523106a..30d94f6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9759,6 +9759,9 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 				continue;
 			if (event->attr.config != entry->type)
 				continue;
+			/* Cannot deliver synchronous signal to other task. */
+			if (event->attr.sigtrap)
+				continue;
 			if (perf_tp_event_match(event, &data, regs))
 				perf_swevent_event(event, count, &data, regs);
 		}
