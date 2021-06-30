Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6504F3B8411
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbhF3NwL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:52:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32938 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbhF3Nus (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:48 -0400
Date:   Wed, 30 Jun 2021 13:47:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060879;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+6T+41mviTV+ZIKUQsU44VQnL/hUAmfHnAHJctjMRPo=;
        b=OXRrQao/SYTbnTQUw2Zxcko0pfn8BQ4ntfGLKMr+RrMFgTVjC2Mbz4BYk2gi/1tSUnlhq6
        WRPONZNXdXLYmoFwNCfqsuYAuHojMdIfS4rAHRwV0RcKjB24FiDdx7N5dUMxCTcEtwS6WX
        x29JHzQTuh2+p1KgJeqlK2XKXfHXzW0itu0f6E2H2R2KYZLeiE92T+sJrnET0ZLnxEmyZ2
        jozlR421wgldAXGNl5pIQaScyTCaSrrD/E7y55wxmubUADLYllhJSKwHBbVptUdFeDSYQV
        vfw9+ix76jBbN1AoZiFMjanmyNSqQ+0Q2rFWo2zuj55veFn00XggWuUsPMOcTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060879;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+6T+41mviTV+ZIKUQsU44VQnL/hUAmfHnAHJctjMRPo=;
        b=aLpcr/trcXBmtJ5lL7T+Fwt1ulBH92C+FxaK0HOeuiZqZwqIeBDaH4KKEkr//ArxjGKHJc
        3X3BvKu5yX9C3sAg==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] kvfree_rcu: Add a bulk-list check when a scheduler is run
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506087907.395.2727391565876905648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d434c00fa3ac476ca6295b8310d097dd71984624
Gitweb:        https://git.kernel.org/tip/d434c00fa3ac476ca6295b8310d097dd71984624
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Thu, 15 Apr 2021 19:19:58 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:00:48 -07:00

kvfree_rcu: Add a bulk-list check when a scheduler is run

The rcu_scheduler_active flag is set to RCU_SCHEDULER_RUNNING once the
scheduler is up and running.  That signal is used in order to check
and queue a "monitor work" to reclaim freed objects (if there are any)
during early boot.  This flag is used by kvfree_rcu() to determine when
work can safely be queued, at which point memory passed to earlier
invocations of kvfree_rcu() can be processed.

However, only "krcp->head" is checked for objects that need to be
released, and there are now two more, namely, "krcp->bkvhead[0]" and
"krcp->bkvhead[1]".  Therefore, check these two additional channels.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 676a49a..e86f32d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3739,7 +3739,8 @@ void __init kfree_rcu_scheduler_running(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		raw_spin_lock_irqsave(&krcp->lock, flags);
-		if (!krcp->head || krcp->monitor_todo) {
+		if ((!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head) ||
+				krcp->monitor_todo) {
 			raw_spin_unlock_irqrestore(&krcp->lock, flags);
 			continue;
 		}
