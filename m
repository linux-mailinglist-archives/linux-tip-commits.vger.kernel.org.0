Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD4935B4D9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbhDKNoP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33304 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbhDKNoF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:05 -0400
Date:   Sun, 11 Apr 2021 13:43:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=A6KCslrPWl/sxl6FuTSI4DSNPeYGm1Tww39dtrphbzw=;
        b=Ycg4C/bq0yKrwnCEO9Dqv7VtK18q2zv1rjtE/yp8Eans7YqIgJj5t3xtL/ABU/F/YxPdIB
        GTyj1rWOgrnmloGbx1b3KMwkbM/2jtHXxohWZ9uEb+tLjOKzx7fyXWTJgd2rSC3LbWkk5I
        n56ip5dTvPa/vJ/INp8A4l8UyNWrGMrYEBfWdvg30TlQXsk5GKLKK+S6bih6w89nV+b8TK
        eA8i3W9rCF6ZkuN84tnYiF8BDB4E2k/8LfCPgJNLNwc3DYcNF2Y3g3xGfkVtHX54Ef3ul5
        mJ4psQvdPQgD0lGIbgI9XcJPAQvJM11o9zhieen1kV8UjElu9/RWnAkNa34Zaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=A6KCslrPWl/sxl6FuTSI4DSNPeYGm1Tww39dtrphbzw=;
        b=R1zs6d7Hrv6WZpqT1Oz1lzoaH/wUIgzw13ytUudPnKKaWrfulRe44MHcKRdje8pn1ajlay
        HoTZVmAWsYBduVCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] softirq: Don't try waking ksoftirqd before it has
 been spawned
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860838.29796.15260901429057690999.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1c0c4bc1ceb580851b2d76fdef9712b3bdae134b
Gitweb:        https://git.kernel.org/tip/1c0c4bc1ceb580851b2d76fdef9712b3bdae134b
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 12 Feb 2021 16:20:40 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 15 Mar 2021 13:51:48 -07:00

softirq: Don't try waking ksoftirqd before it has been spawned

If there is heavy softirq activity, the softirq system will attempt
to awaken ksoftirqd and will stop the traditional back-of-interrupt
softirq processing.  This is all well and good, but only if the
ksoftirqd kthreads already exist, which is not the case during early
boot, in which case the system hangs.

One reproducer is as follows:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs "TREE03" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y CONFIG_NO_HZ_IDLE=y CONFIG_HZ_PERIODIC=n" --bootargs "threadirqs=1" --trust-make

This commit therefore adds a couple of existence checks for ksoftirqd
and forces back-of-interrupt softirq processing when ksoftirqd does not
yet exist.  With this change, the above test passes.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reported-by: Uladzislau Rezki <urezki@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
[ paulmck: Remove unneeded check per Sebastian Siewior feedback. ]
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/softirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 9908ec4..bad14ca 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -211,7 +211,7 @@ static inline void invoke_softirq(void)
 	if (ksoftirqd_running(local_softirq_pending()))
 		return;
 
-	if (!force_irqthreads) {
+	if (!force_irqthreads || !__this_cpu_read(ksoftirqd)) {
 #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
 		/*
 		 * We can safely execute softirq on the current stack if
