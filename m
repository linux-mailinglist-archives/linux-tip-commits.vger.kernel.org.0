Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81042319EDD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhBLMmy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:42:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45340 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhBLMkb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:31 -0500
Date:   Fri, 12 Feb 2021 12:37:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133441;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=22UX9Wgl3X6qdYccbhJ7T5IzsLnTx8s1xpfH7QUmsOM=;
        b=mkoiJ02HkAMKsRp6cdcAp/nixvbrG6acmNPxCQ+Dt0OiKtNVUDGHLjL/i7UrdDHB2cx45w
        Nm+1OMplb1xq49gD7oES6mhBZHYbiKfQ/FDjyNcasUrhK4HW+0pFPl5g7ye1pfsKhP0RPo
        ztIY2hOphTqeRRABQeYGprQXURO4cIQRrKPbYfnMdw2dcN5e5f3Rhoh8tPZlJ1D0HRf6bb
        5M8JOp6YxGBIqo9leykjKMpmJYY51mWnGeY3W4TQ8nxeA+TDFvSIo7QP+DdNMpzLsnmNWZ
        QjQK4Y08+LtCk8JVcxdPXQ51pC2Ntff85aR0TioweuA1l9P8AgajWK9MBJQhIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133441;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=22UX9Wgl3X6qdYccbhJ7T5IzsLnTx8s1xpfH7QUmsOM=;
        b=2234JElhEMDDptnV9omJ5kRbKlFfr1NE/Gv508FkxcwgpqqURD2XgLJr2H4bgCXgNWguVi
        c+fped7Uvuly55Dg==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/segcblist: Add debug checks for segment lengths
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344111.23325.2231734956269796292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b4e6039e8af8c20dfbbdfcaebfcbd7c9d9ffe713
Gitweb:        https://git.kernel.org/tip/b4e6039e8af8c20dfbbdfcaebfcbd7c9d9ffe713
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Wed, 18 Nov 2020 11:15:41 -05:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:24:19 -08:00

rcu/segcblist: Add debug checks for segment lengths

This commit adds debug checks near the end of rcu_do_batch() that emit
warnings if an empty rcu_segcblist structure has non-zero segment counts,
or, conversely, if a non-empty structure has all-zero segment counts.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
[ paulmck: Fix queue/segment-length checks. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 12 ++++++++++++
 kernel/rcu/rcu_segcblist.h |  3 +++
 kernel/rcu/tree.c          |  8 ++++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 1e80a0a..89e0dff 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -94,6 +94,18 @@ static long rcu_segcblist_get_seglen(struct rcu_segcblist *rsclp, int seg)
 	return READ_ONCE(rsclp->seglen[seg]);
 }
 
+/* Return number of callbacks in segmented callback list by summing seglen. */
+long rcu_segcblist_n_segment_cbs(struct rcu_segcblist *rsclp)
+{
+	long len = 0;
+	int i;
+
+	for (i = RCU_DONE_TAIL; i < RCU_CBLIST_NSEGS; i++)
+		len += rcu_segcblist_get_seglen(rsclp, i);
+
+	return len;
+}
+
 /* Set the length of a segment of the rcu_segcblist structure. */
 static void rcu_segcblist_set_seglen(struct rcu_segcblist *rsclp, int seg, long v)
 {
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index cd35c9f..18e101d 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -15,6 +15,9 @@ static inline long rcu_cblist_n_cbs(struct rcu_cblist *rclp)
 	return READ_ONCE(rclp->len);
 }
 
+/* Return number of callbacks in segmented callback list by summing seglen. */
+long rcu_segcblist_n_segment_cbs(struct rcu_segcblist *rsclp);
+
 void rcu_cblist_init(struct rcu_cblist *rclp);
 void rcu_cblist_enqueue(struct rcu_cblist *rclp, struct rcu_head *rhp);
 void rcu_cblist_flush_enqueue(struct rcu_cblist *drclp,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6bf269c..8086c04 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2434,6 +2434,7 @@ int rcutree_dead_cpu(unsigned int cpu)
 static void rcu_do_batch(struct rcu_data *rdp)
 {
 	int div;
+	bool __maybe_unused empty;
 	unsigned long flags;
 	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_head *rhp;
@@ -2548,9 +2549,12 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	 * The following usually indicates a double call_rcu().  To track
 	 * this down, try building with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y.
 	 */
-	WARN_ON_ONCE(count == 0 && !rcu_segcblist_empty(&rdp->cblist));
+	empty = rcu_segcblist_empty(&rdp->cblist);
+	WARN_ON_ONCE(count == 0 && !empty);
 	WARN_ON_ONCE(!IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-		     count != 0 && rcu_segcblist_empty(&rdp->cblist));
+		     count != 0 && empty);
+	WARN_ON_ONCE(count == 0 && rcu_segcblist_n_segment_cbs(&rdp->cblist) != 0);
+	WARN_ON_ONCE(!empty && rcu_segcblist_n_segment_cbs(&rdp->cblist) == 0);
 
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
