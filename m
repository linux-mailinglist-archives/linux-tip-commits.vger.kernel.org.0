Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F61F31BB9B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhBOO5O (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhBOO5H (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:57:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581F8C0617A7;
        Mon, 15 Feb 2021 06:55:47 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4H4J9yLMyAZ4uHIglQY+Zl4X3n525BLn6RYLeG9cBcY=;
        b=E/yGcDh931HEoauvO/qMrjrskIIFnL9cRFFvNdtgWyaLm5XOW5RhSLHxFDKea8zTUqIikY
        bNIj3TAKacvK75NqKK9SWz2uBUIMkwyfgezHk706gUSpssKga85goTt5bAlLxnoLYgNeYI
        RncwelDqOhM2PvbHucVh8Bz18LFqvXYhLXptS3vE0sV5Ou5t9DwlvVnLJGEgpn5d/dspjw
        SfkA/fLRpjjYTXnM2bMRugwt47S5J2DHE/91i+rPQKwWx7eFDfvYul6NhGveQ6oW03b59K
        ZDnTFR+B5olpAogtsIzPjg/uQXTAokWXh4DX3Cx1rzbU4wa3HdS13cUo4BRHlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4H4J9yLMyAZ4uHIglQY+Zl4X3n525BLn6RYLeG9cBcY=;
        b=Kpbd9tAdGf2BX8XSwLAKfWedV/e2WqZ0zFe+a7dIBGK7cdY5zmVhXKYSZbyQVI9isGJiYP
        9nLAfCc7Zxb02CCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Provide polling interfaces for Tiny SRCU grace periods
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094472.20312.4135097897204210652.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8b5bd67cf6422b63ee100d76d8de8960ca2df7f0
Gitweb:        https://git.kernel.org/tip/8b5bd67cf6422b63ee100d76d8de8960ca2df7f0
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 12:54:48 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:53:38 -08:00

srcu: Provide polling interfaces for Tiny SRCU grace periods

There is a need for a polling interface for SRCU grace
periods, so this commit supplies get_state_synchronize_srcu(),
start_poll_synchronize_srcu(), and poll_state_synchronize_srcu() for this
purpose.  The first can be used if future grace periods are inevitable
(perhaps due to a later call_srcu() invocation), the second if future
grace periods might not otherwise happen, and the third to check if a
grace period has elapsed since the corresponding call to either of the
first two.

As with get_state_synchronize_rcu() and cond_synchronize_rcu(),
the return value from either get_state_synchronize_srcu() or
start_poll_synchronize_srcu() must be passed in to a later call to
poll_state_synchronize_srcu().

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
[ paulmck: Add EXPORT_SYMBOL_GPL() per kernel test robot feedback. ]
[ paulmck: Apply feedback from Neeraj Upadhyay. ]
Link: https://lore.kernel.org/lkml/20201117004017.GA7444@paulmck-ThinkPad-P72/
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h |  2 +-
 include/linux/srcu.h     |  3 ++-
 include/linux/srcutiny.h |  1 +-
 kernel/rcu/srcutiny.c    | 55 +++++++++++++++++++++++++++++++++++++--
 4 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index de08264..e09c0d8 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -33,6 +33,8 @@
 #define ULONG_CMP_GE(a, b)	(ULONG_MAX / 2 >= (a) - (b))
 #define ULONG_CMP_LT(a, b)	(ULONG_MAX / 2 < (a) - (b))
 #define ulong2long(a)		(*(long *)(&(a)))
+#define USHORT_CMP_GE(a, b)	(USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
+#define USHORT_CMP_LT(a, b)	(USHRT_MAX / 2 < (unsigned short)((a) - (b)))
 
 /* Exported common interfaces */
 void call_rcu(struct rcu_head *head, rcu_callback_t func);
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index e432cc9..a0895bb 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -60,6 +60,9 @@ void cleanup_srcu_struct(struct srcu_struct *ssp);
 int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
 void synchronize_srcu(struct srcu_struct *ssp);
+unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
+unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp);
+bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index b8b42d0..0e0cf4d 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -16,6 +16,7 @@
 struct srcu_struct {
 	short srcu_lock_nesting[2];	/* srcu_read_lock() nesting depth. */
 	unsigned short srcu_idx;	/* Current reader array element in bit 0x2. */
+	unsigned short srcu_idx_max;	/* Furthest future srcu_idx request. */
 	u8 srcu_gp_running;		/* GP workqueue running? */
 	u8 srcu_gp_waiting;		/* GP waiting for readers? */
 	struct swait_queue_head srcu_wq;
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 3bac1db..26344dc 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -34,6 +34,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
 	ssp->srcu_gp_running = false;
 	ssp->srcu_gp_waiting = false;
 	ssp->srcu_idx = 0;
+	ssp->srcu_idx_max = 0;
 	INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
 	INIT_LIST_HEAD(&ssp->srcu_work.entry);
 	return 0;
@@ -84,6 +85,8 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 	WARN_ON(ssp->srcu_gp_waiting);
 	WARN_ON(ssp->srcu_cb_head);
 	WARN_ON(&ssp->srcu_cb_head != ssp->srcu_cb_tail);
+	WARN_ON(ssp->srcu_idx != ssp->srcu_idx_max);
+	WARN_ON(ssp->srcu_idx & 0x1);
 }
 EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
 
@@ -114,7 +117,7 @@ void srcu_drive_gp(struct work_struct *wp)
 	struct srcu_struct *ssp;
 
 	ssp = container_of(wp, struct srcu_struct, srcu_work);
-	if (ssp->srcu_gp_running || !READ_ONCE(ssp->srcu_cb_head))
+	if (ssp->srcu_gp_running || USHORT_CMP_GE(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
 		return; /* Already running or nothing to do. */
 
 	/* Remove recently arrived callbacks and wait for readers. */
@@ -147,13 +150,19 @@ void srcu_drive_gp(struct work_struct *wp)
 	 * straighten that out.
 	 */
 	WRITE_ONCE(ssp->srcu_gp_running, false);
-	if (READ_ONCE(ssp->srcu_cb_head))
+	if (USHORT_CMP_LT(ssp->srcu_idx, READ_ONCE(ssp->srcu_idx_max)))
 		schedule_work(&ssp->srcu_work);
 }
 EXPORT_SYMBOL_GPL(srcu_drive_gp);
 
 static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 {
+	unsigned short cookie;
+
+	cookie = get_state_synchronize_srcu(ssp);
+	if (USHORT_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie))
+		return;
+	WRITE_ONCE(ssp->srcu_idx_max, cookie);
 	if (!READ_ONCE(ssp->srcu_gp_running)) {
 		if (likely(srcu_init_done))
 			schedule_work(&ssp->srcu_work);
@@ -196,6 +205,48 @@ void synchronize_srcu(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(synchronize_srcu);
 
+/*
+ * get_state_synchronize_srcu - Provide an end-of-grace-period cookie
+ */
+unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp)
+{
+	unsigned long ret;
+
+	barrier();
+	ret = (READ_ONCE(ssp->srcu_idx) + 3) & ~0x1;
+	barrier();
+	return ret & USHRT_MAX;
+}
+EXPORT_SYMBOL_GPL(get_state_synchronize_srcu);
+
+/*
+ * start_poll_synchronize_srcu - Provide cookie and start grace period
+ *
+ * The difference between this and get_state_synchronize_srcu() is that
+ * this function ensures that the poll_state_synchronize_srcu() will
+ * eventually return the value true.
+ */
+unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)
+{
+	unsigned long ret = get_state_synchronize_srcu(ssp);
+
+	srcu_gp_start_if_needed(ssp);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
+
+/*
+ * poll_state_synchronize_srcu - Has cookie's grace period ended?
+ */
+bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
+{
+	bool ret = USHORT_CMP_GE(READ_ONCE(ssp->srcu_idx), cookie);
+
+	barrier();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(poll_state_synchronize_srcu);
+
 /* Lockdep diagnostics.  */
 void __init rcu_scheduler_starting(void)
 {
