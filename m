Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999002D8F91
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbgLMTBy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:01:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46616 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbgLMTBu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:50 -0500
Date:   Sun, 13 Dec 2020 19:01:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bm/nGd57qCEevPTswuIeZKlrqcD/ZfdDeehNZWxmPTw=;
        b=kp1x886AWxYLy+f0zn1RLvSCXr+koGWNlp3ZIKN3purkPKFE1f0xqaC6DLX4rc8kdzEviW
        4daZIxNk1I1ylBAS6jY0/CM9v/NEkZyoINLSxizehoruZ/tXSh9ZZOralFoOpWJgXKxg3c
        EGcx5MPjXVbzv11yd1GVXyOnFfYkD8E3h9u9dfuSzz8zdBhgZFig6wmB4g0pFxLYKudDAw
        AisDua5bC6JPtLQaHhBnsUl9U2N3VXv9YaXURWHRp/8crPDXO6M0CeJJEtcXpxPmjz6ILb
        KyV/YQXTHcJH0YwOenGL9RIRjYMGi/+NR2S0403x7YKj1GMH4auTZ7G47yEK3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bm/nGd57qCEevPTswuIeZKlrqcD/ZfdDeehNZWxmPTw=;
        b=YxKr0f7xE0zvdfz2sio0ShHGh4yBcEbMe2O6z+Au6I3rqMLKxCiBj3f6z2Rst9k+Tgb2WD
        XMw61gkM4k/MxLBQ==
From:   "tip-bot2 for Hou Tao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] locktorture: Invoke percpu_free_rwsem() to do
 percpu-rwsem cleanup
Cc:     Hou Tao <houtao1@huawei.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606739.3364.4829469333093562268.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0d7202876bcb968a68f5608b9ff7a824fbc7e94d
Gitweb:        https://git.kernel.org/tip/0d7202876bcb968a68f5608b9ff7a824fbc7e94d
Author:        Hou Tao <houtao1@huawei.com>
AuthorDate:    Thu, 24 Sep 2020 22:18:54 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:56 -08:00

locktorture: Invoke percpu_free_rwsem() to do percpu-rwsem cleanup

When executing the LOCK06 locktorture scenario featuring percpu-rwsem,
the RCU callback rcu_sync_func() may still be pending after locktorture
module is removed.  This can in turn lead to the following Oops:

  BUG: unable to handle page fault for address: ffffffffc00eb920
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 6500a067 P4D 6500a067 PUD 6500c067 PMD 13a36c067 PTE 800000013691c163
  Oops: 0000 [#1] PREEMPT SMP
  CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.9.0-rc5+ #4
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
  RIP: 0010:rcu_cblist_dequeue+0x12/0x30
  Call Trace:
   <IRQ>
   rcu_core+0x1b1/0x860
   __do_softirq+0xfe/0x326
   asm_call_on_stack+0x12/0x20
   </IRQ>
   do_softirq_own_stack+0x5f/0x80
   irq_exit_rcu+0xaf/0xc0
   sysvec_apic_timer_interrupt+0x2e/0xb0
   asm_sysvec_apic_timer_interrupt+0x12/0x20

This commit avoids tis problem by adding an exit hook in lock_torture_ops
and using it to call percpu_free_rwsem() for percpu rwsem torture during
the module-cleanup function, thus ensuring that rcu_sync_func() completes
before module exits.

It is also necessary to call the exit hook if lock_torture_init()
fails half-way, so this commit also adds an ->init_called field in
lock_torture_cxt to indicate that exit hook, if present, must be called.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/locktorture.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 79fbd97..fd838ce 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -76,6 +76,7 @@ static void lock_torture_cleanup(void);
  */
 struct lock_torture_ops {
 	void (*init)(void);
+	void (*exit)(void);
 	int (*writelock)(void);
 	void (*write_delay)(struct torture_random_state *trsp);
 	void (*task_boost)(struct torture_random_state *trsp);
@@ -92,12 +93,13 @@ struct lock_torture_cxt {
 	int nrealwriters_stress;
 	int nrealreaders_stress;
 	bool debug_lock;
+	bool init_called;
 	atomic_t n_lock_torture_errors;
 	struct lock_torture_ops *cur_ops;
 	struct lock_stress_stats *lwsa; /* writer statistics */
 	struct lock_stress_stats *lrsa; /* reader statistics */
 };
-static struct lock_torture_cxt cxt = { 0, 0, false,
+static struct lock_torture_cxt cxt = { 0, 0, false, false,
 				       ATOMIC_INIT(0),
 				       NULL, NULL};
 /*
@@ -573,6 +575,11 @@ static void torture_percpu_rwsem_init(void)
 	BUG_ON(percpu_init_rwsem(&pcpu_rwsem));
 }
 
+static void torture_percpu_rwsem_exit(void)
+{
+	percpu_free_rwsem(&pcpu_rwsem);
+}
+
 static int torture_percpu_rwsem_down_write(void) __acquires(pcpu_rwsem)
 {
 	percpu_down_write(&pcpu_rwsem);
@@ -597,6 +604,7 @@ static void torture_percpu_rwsem_up_read(void) __releases(pcpu_rwsem)
 
 static struct lock_torture_ops percpu_rwsem_lock_ops = {
 	.init		= torture_percpu_rwsem_init,
+	.exit		= torture_percpu_rwsem_exit,
 	.writelock	= torture_percpu_rwsem_down_write,
 	.write_delay	= torture_rwsem_write_delay,
 	.task_boost     = torture_boost_dummy,
@@ -789,9 +797,10 @@ static void lock_torture_cleanup(void)
 
 	/*
 	 * Indicates early cleanup, meaning that the test has not run,
-	 * such as when passing bogus args when loading the module. As
-	 * such, only perform the underlying torture-specific cleanups,
-	 * and avoid anything related to locktorture.
+	 * such as when passing bogus args when loading the module.
+	 * However cxt->cur_ops.init() may have been invoked, so beside
+	 * perform the underlying torture-specific cleanups, cur_ops.exit()
+	 * will be invoked if needed.
 	 */
 	if (!cxt.lwsa && !cxt.lrsa)
 		goto end;
@@ -831,6 +840,11 @@ static void lock_torture_cleanup(void)
 	cxt.lrsa = NULL;
 
 end:
+	if (cxt.init_called) {
+		if (cxt.cur_ops->exit)
+			cxt.cur_ops->exit();
+		cxt.init_called = false;
+	}
 	torture_cleanup_end();
 }
 
@@ -878,8 +892,10 @@ static int __init lock_torture_init(void)
 		goto unwind;
 	}
 
-	if (cxt.cur_ops->init)
+	if (cxt.cur_ops->init) {
 		cxt.cur_ops->init();
+		cxt.init_called = true;
+	}
 
 	if (nwriters_stress >= 0)
 		cxt.nrealwriters_stress = nwriters_stress;
