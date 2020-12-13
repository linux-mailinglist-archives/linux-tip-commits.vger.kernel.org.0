Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482362D9013
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393457AbgLMTXt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389122AbgLMTC1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580BDC06138C;
        Sun, 13 Dec 2020 11:01:05 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jjSM7ULy+XQqbevDdgIK118huGg+ws48rTMdiIhtli0=;
        b=a/4k46dnFopH0Nwf2HnON1n2cxVPHhaqF3winSQbLTSMrU0Movq9lNYmM0kVFcUsjoS3VT
        kLVVeC6b0Crwd1wJwBI0ldFHjPA/GQ83XiwHg75WOPddxAfyrekM8u6ddWxogbClzErz/Q
        1LXTfG4i4eBfHkGQk9jx0iczqo0zBewNp0lyL/+f+MKFqDRCK5GM2ohl9dJHUhahT3yzg/
        QYSo2Dk1FE0Ej45KAzWYrTeh+X/eBtxV6D0Gzzhh5RRTl4YkgqwexCtkTrSPcge7qoNoRp
        Z/oAz5en/nP3wyjnstexYJrV9oZCSiAwBVDLw8debOIz1Pckir5+r2+NIvExZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jjSM7ULy+XQqbevDdgIK118huGg+ws48rTMdiIhtli0=;
        b=RBZL9UzvOOKfL5uOjQsCadGjSos8OKDjQi+fq1oqXmLyshc9YI+K0vShTOnRZofVV2BKDx
        pTAl9+Kpa9HaQGAw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] x86/smpboot: Move rcu_cpu_starting() earlier
Cc:     Qian Cai <cai@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606343.3364.4390956395500747982.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     29368e09392123800e5e2bf0f3eda91f16972e52
Gitweb:        https://git.kernel.org/tip/29368e09392123800e5e2bf0f3eda91f16972e52
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 20 Oct 2020 21:13:55 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 19 Nov 2020 19:37:16 -08:00

x86/smpboot:  Move rcu_cpu_starting() earlier

The call to rcu_cpu_starting() in mtrr_ap_init() is not early enough
in the CPU-hotplug onlining process, which results in lockdep splats
as follows:

=============================
WARNING: suspicious RCU usage
5.9.0+ #268 Not tainted
-----------------------------
kernel/kprobes.c:300 RCU-list traversed in non-reader section!!

other info that might help us debug this:

RCU used illegally from offline CPU!
rcu_scheduler_active = 1, debug_locks = 1
no locks held by swapper/1/0.

stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.9.0+ #268
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1ubuntu1 04/01/2014
Call Trace:
 dump_stack+0x77/0x97
 __is_insn_slot_addr+0x15d/0x170
 kernel_text_address+0xba/0xe0
 ? get_stack_info+0x22/0xa0
 __kernel_text_address+0x9/0x30
 show_trace_log_lvl+0x17d/0x380
 ? dump_stack+0x77/0x97
 dump_stack+0x77/0x97
 __lock_acquire+0xdf7/0x1bf0
 lock_acquire+0x258/0x3d0
 ? vprintk_emit+0x6d/0x2c0
 _raw_spin_lock+0x27/0x40
 ? vprintk_emit+0x6d/0x2c0
 vprintk_emit+0x6d/0x2c0
 printk+0x4d/0x69
 start_secondary+0x1c/0x100
 secondary_startup_64_no_verify+0xb8/0xbb

This is avoided by moving the call to rcu_cpu_starting up near
the beginning of the start_secondary() function.  Note that the
raw_smp_processor_id() is required in order to avoid calling into lockdep
before RCU has declared the CPU to be watched for readers.

Link: https://lore.kernel.org/lkml/160223032121.7002.1269740091547117869.tip-bot2@tip-bot2/
Reported-by: Qian Cai <cai@redhat.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/x86/kernel/cpu/mtrr/mtrr.c | 2 --
 arch/x86/kernel/smpboot.c       | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 6a80f36..5f436cb 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -794,8 +794,6 @@ void mtrr_ap_init(void)
 	if (!use_intel() || mtrr_aps_delayed_init)
 		return;
 
-	rcu_cpu_starting(smp_processor_id());
-
 	/*
 	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
 	 * changed, but this routine will be called in cpu boot time,
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index de776b2..99bdceb 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -229,6 +229,7 @@ static void notrace start_secondary(void *unused)
 #endif
 	cpu_init_exception_handling();
 	cpu_init();
+	rcu_cpu_starting(raw_smp_processor_id());
 	x86_cpuinit.early_percpu_clock_init();
 	preempt_disable();
 	smp_callin();
