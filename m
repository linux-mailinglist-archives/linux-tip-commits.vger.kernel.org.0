Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E764F234319
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732909AbgGaJ2S (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:28:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732270AbgGaJWz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:55 -0400
Date:   Fri, 31 Jul 2020 09:22:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FUHDskQAGqgFdsSZTqpVDss7wtQQTXoPFh4JE/tbJlA=;
        b=ZcmhSek1o4L66YGCreewA4lpM52xGn57YpoHlY4McGsPNKEdOHIv3aLZ9pjgrfYSR0nkyX
        PyMpteNRLF2QJk97h7CahVPaK9YaMI4esvI+8YfIAKgORE+PT+kgHqWED4eAP/8cGey3YE
        3Ulb2Ji0HdmhL3mlbVfGrcTJDEwKLyoz8maXLX9XmJp3PNEVF+R7ZDN5rCkTbmrarmXORz
        vA26eNp1WJQQMm3jwI9lI5bskyDM30rwrj/flosWzwaJjhY+hvPttdv3ZNja64rV6ofi04
        IJsG1JDYGB0yz5MZCZf/h7e5hKx6qN/7gAuenf4zY+jKlslatM8ERtaA4bwYjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FUHDskQAGqgFdsSZTqpVDss7wtQQTXoPFh4JE/tbJlA=;
        b=w0Vv5QrF3dBCYzAZaYseIJFkBcbr3HZVTakft2YV2QT/nrOp9IhI5jwN2xlLV4yVL9w7Xx
        ljuu5rI2KfC93zAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Fix synchronize_rcu_tasks_trace() header comment
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618737325.4006.5412982422660684871.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c7dcf8106f7570b133b05ff68fd4100064965d9d
Gitweb:        https://git.kernel.org/tip/c7dcf8106f7570b133b05ff68fd4100064965d9d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 12 Jun 2020 13:11:29 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:46 -07:00

rcu-tasks: Fix synchronize_rcu_tasks_trace() header comment

The synchronize_rcu_tasks_trace() header comment incorrectly claims that
any number of things delimit RCU Tasks Trace read-side critical sections,
when in fact only rcu_read_lock_trace() and rcu_read_unlock_trace() do so.
This commit therefore fixes this comment, and, while in the area, fixes
a typo in the rcu_read_lock_trace() header comment.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate_trace.h |  4 ++--
 kernel/rcu/tasks.h             |  9 ++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index 4c25a41..d9015aa 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -36,8 +36,8 @@ void rcu_read_unlock_trace_special(struct task_struct *t, int nesting);
 /**
  * rcu_read_lock_trace - mark beginning of RCU-trace read-side critical section
  *
- * When synchronize_rcu_trace() is invoked by one task, then that task
- * is guaranteed to block until all other tasks exit their read-side
+ * When synchronize_rcu_tasks_trace() is invoked by one task, then that
+ * task is guaranteed to block until all other tasks exit their read-side
  * critical sections.  Similarly, if call_rcu_trace() is invoked on one
  * task while other tasks are within RCU read-side critical sections,
  * invocation of the corresponding RCU callback is deferred until after
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index ce23f6c..a77298c 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1118,11 +1118,10 @@ EXPORT_SYMBOL_GPL(call_rcu_tasks_trace);
  * synchronize_rcu_tasks_trace - wait for a trace rcu-tasks grace period
  *
  * Control will return to the caller some time after a trace rcu-tasks
- * grace period has elapsed, in other words after all currently
- * executing rcu-tasks read-side critical sections have elapsed.  These
- * read-side critical sections are delimited by calls to schedule(),
- * cond_resched_tasks_rcu_qs(), userspace execution, and (in theory,
- * anyway) cond_resched().
+ * grace period has elapsed, in other words after all currently executing
+ * rcu-tasks read-side critical sections have elapsed.  These read-side
+ * critical sections are delimited by calls to rcu_read_lock_trace()
+ * and rcu_read_unlock_trace().
  *
  * This is a very specialized primitive, intended only for a few uses in
  * tracing and other situations requiring manipulation of function preambles
