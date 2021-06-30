Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32D73B83A1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbhF3NuS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32948 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbhF3NuC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:02 -0400
Date:   Wed, 30 Jun 2021 13:47:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=25K8v78IL2EpNF0iPF+3mJPzMbr3WIUtQBQzGQMt82o=;
        b=OrpExOCVWH2ErHDM5VAoNVEzUXosRsFKNI2WWUm/tbAUMN0SZ3pTCERERhO2oNhhbHDX42
        7NE89ae0L3214yGZ+WLOl4FUOX6er+InAsf0fRMozr3rmXCM6OGt9d4d1ADPTcbVMvhkcY
        qQOWM1P+uaQQJKBS6qCe1tz+Dw704spL0QDlt00W92BhRUYkgjnL0ZNUT7eTnm955daVsC
        4xMNXYYRWn0Lb7GhB11djxpprrb6zMQarH4jBqM2BZ6rPyLx3ikGgfSblQapI3885P+IbT
        j7kRFHD+uJPMZ60Nxn6/oJdMJwGSk5OUxiA6XWfyLfSwTSsAO9Dx+C1/SAIPCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=25K8v78IL2EpNF0iPF+3mJPzMbr3WIUtQBQzGQMt82o=;
        b=rh7FS6oKjvUZBBma4dJ9NjRVfTnwNw+HqwMpycIM3KjKXll+jAP7xHMrd/Gk81Ov0kIfyT
        ELKwywYyZSPtUACw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Point to documentation of ordering guarantees
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506085167.395.4878331107023941526.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3d3a0d1b508dcc47e82b0e12cde6585bc088b0cc
Gitweb:        https://git.kernel.org/tip/3d3a0d1b508dcc47e82b0e12cde6585bc088b0cc
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 16 Apr 2021 16:53:16 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:22:54 -07:00

rcu: Point to documentation of ordering guarantees

Add comments to synchronize_rcu() and friends that point to
Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c |  3 +++
 kernel/rcu/tree.c     | 20 ++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index e26547b..f8340c3 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1000,6 +1000,9 @@ EXPORT_SYMBOL_GPL(synchronize_srcu_expedited);
  * synchronize_srcu(), srcu_read_lock(), and srcu_read_unlock() are
  * passed the same srcu_struct structure.
  *
+ * Implementation of these memory-ordering guarantees is similar to
+ * that of synchronize_rcu().
+ *
  * If SRCU is likely idle, expedite the first request.  This semantic
  * was provided by Classic SRCU, and is relied upon by its users, so TREE
  * SRCU must also provide it.  Note that detecting idleness is heuristic
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6eb64e4..2437960 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3084,6 +3084,9 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
  * between the call to call_rcu() and the invocation of "func()" -- even
  * if CPU A and CPU B are the same CPU (but again only if the system has
  * more than one CPU).
+ *
+ * Implementation of these memory-ordering guarantees is described here:
+ * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
@@ -3751,6 +3754,9 @@ static int rcu_blocking_is_gp(void)
  * to have executed a full memory barrier during the execution of
  * synchronize_rcu() -- even if CPU A and CPU B are the same CPU (but
  * again only if the system has more than one CPU).
+ *
+ * Implementation of these memory-ordering guarantees is described here:
+ * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
  */
 void synchronize_rcu(void)
 {
@@ -3821,7 +3827,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
 /**
  * poll_state_synchronize_rcu - Conditionally wait for an RCU grace period
  *
- * @oldstate: return from call to get_state_synchronize_rcu() or start_poll_synchronize_rcu()
+ * @oldstate: value from get_state_synchronize_rcu() or start_poll_synchronize_rcu()
  *
  * If a full RCU grace period has elapsed since the earlier call from
  * which oldstate was obtained, return @true, otherwise return @false.
@@ -3837,6 +3843,11 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
  * (many hours even on 32-bit systems) should check them occasionally
  * and either refresh them or set a flag indicating that the grace period
  * has completed.
+ *
+ * This function provides the same memory-ordering guarantees that
+ * would be provided by a synchronize_rcu() that was invoked at the call
+ * to the function that provided @oldstate, and that returned at the end
+ * of this function.
  */
 bool poll_state_synchronize_rcu(unsigned long oldstate)
 {
@@ -3851,7 +3862,7 @@ EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
 /**
  * cond_synchronize_rcu - Conditionally wait for an RCU grace period
  *
- * @oldstate: return value from earlier call to get_state_synchronize_rcu()
+ * @oldstate: value from get_state_synchronize_rcu() or start_poll_synchronize_rcu()
  *
  * If a full RCU grace period has elapsed since the earlier call to
  * get_state_synchronize_rcu() or start_poll_synchronize_rcu(), just return.
@@ -3861,6 +3872,11 @@ EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
  * counter wrap is harmless.  If the counter wraps, we have waited for
  * more than 2 billion grace periods (and way more on a 64-bit system!),
  * so waiting for one additional grace period should be just fine.
+ *
+ * This function provides the same memory-ordering guarantees that
+ * would be provided by a synchronize_rcu() that was invoked at the call
+ * to the function that provided @oldstate, and that returned at the end
+ * of this function.
  */
 void cond_synchronize_rcu(unsigned long oldstate)
 {
