Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E4D319ED8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhBLMmc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:42:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45336 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhBLMk1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:27 -0500
Date:   Fri, 12 Feb 2021 12:37:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133441;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RlHWmu5HR3jcWVkmPcxvx06u6vL8D5hp+lex+XWGwNQ=;
        b=FlU+CIEwmDEZm8nDszJJT8CgEFj0IBFMtEIM2+GaE3r+Rp1NQu53/j85il/ANTRPeP6FOA
        aofqiRp4+JJgQcRraqU9z/dlFR6PUjJqDvfwUOO1mniHfk+xSfYr4QcXEQ/lOd5RWzgbY6
        GJntsjGJbMGr+RkjmI7JBLPB9JHb+TsIza1odPykXsx4ssXCQvQzeYn6FkimS8aclS5krV
        hm0GSt/o//CJ7mRAelWTpJfXKFefrIHT/Zx2clzNMzMc3/47FGCP8k8iz3+0c5Z25pCpQX
        hiMOrs3Muyi5ZgQh/+/pbrU27kt8ygSs+s+KM9e/5LFt8waYSpV72dnmYkwJtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133441;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RlHWmu5HR3jcWVkmPcxvx06u6vL8D5hp+lex+XWGwNQ=;
        b=byVy9bI1+f3jFLd2/2HsqBiimO7xL6WztCq8Tg83+0N/04oTjsDGujD1zCj07fgSQb9Uht
        qXBHq9Mtk3+fp/BA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Turn enabled/offload states into a common flag
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344082.23325.17986937695195452246.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     65e560327fe68153a9ad7452d5fd3171a1927d33
Gitweb:        https://git.kernel.org/tip/65e560327fe68153a9ad7452d5fd3171a1927d33
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 13:13:16 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:24:19 -08:00

rcu/nocb: Turn enabled/offload states into a common flag

This commit gathers the rcu_segcblist ->enabled and ->offloaded property
field into a single ->flags bitmask to avoid further proliferation of
individual u8 fields in the structure.  This change prepares for the
state formerly known as ->offloaded state to be modified at runtime.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcu_segcblist.h |  6 ++++--
 kernel/rcu/rcu_segcblist.c    |  6 +++---
 kernel/rcu/rcu_segcblist.h    | 23 +++++++++++++++++++++--
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 6c01f09..4714b02 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -63,6 +63,9 @@ struct rcu_cblist {
 #define RCU_NEXT_TAIL		3
 #define RCU_CBLIST_NSEGS	4
 
+#define SEGCBLIST_ENABLED	BIT(0)
+#define SEGCBLIST_OFFLOADED	BIT(1)
+
 struct rcu_segcblist {
 	struct rcu_head *head;
 	struct rcu_head **tails[RCU_CBLIST_NSEGS];
@@ -73,8 +76,7 @@ struct rcu_segcblist {
 	long len;
 #endif
 	long seglen[RCU_CBLIST_NSEGS];
-	u8 enabled;
-	u8 offloaded;
+	u8 flags;
 };
 
 #define RCU_SEGCBLIST_INITIALIZER(n) \
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 89e0dff..934945d 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -246,7 +246,7 @@ void rcu_segcblist_init(struct rcu_segcblist *rsclp)
 		rcu_segcblist_set_seglen(rsclp, i, 0);
 	}
 	rcu_segcblist_set_len(rsclp, 0);
-	rsclp->enabled = 1;
+	rcu_segcblist_set_flags(rsclp, SEGCBLIST_ENABLED);
 }
 
 /*
@@ -257,7 +257,7 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
 {
 	WARN_ON_ONCE(!rcu_segcblist_empty(rsclp));
 	WARN_ON_ONCE(rcu_segcblist_n_cbs(rsclp));
-	rsclp->enabled = 0;
+	rcu_segcblist_clear_flags(rsclp, SEGCBLIST_ENABLED);
 }
 
 /*
@@ -266,7 +266,7 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
  */
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
 {
-	rsclp->offloaded = 1;
+	rcu_segcblist_set_flags(rsclp, SEGCBLIST_OFFLOADED);
 }
 
 /*
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 18e101d..ff372db 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -53,19 +53,38 @@ static inline long rcu_segcblist_n_cbs(struct rcu_segcblist *rsclp)
 #endif
 }
 
+static inline void rcu_segcblist_set_flags(struct rcu_segcblist *rsclp,
+					   int flags)
+{
+	rsclp->flags |= flags;
+}
+
+static inline void rcu_segcblist_clear_flags(struct rcu_segcblist *rsclp,
+					     int flags)
+{
+	rsclp->flags &= ~flags;
+}
+
+static inline bool rcu_segcblist_test_flags(struct rcu_segcblist *rsclp,
+					    int flags)
+{
+	return READ_ONCE(rsclp->flags) & flags;
+}
+
 /*
  * Is the specified rcu_segcblist enabled, for example, not corresponding
  * to an offline CPU?
  */
 static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
 {
-	return rsclp->enabled;
+	return rcu_segcblist_test_flags(rsclp, SEGCBLIST_ENABLED);
 }
 
 /* Is the specified rcu_segcblist offloaded?  */
 static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
 {
-	return IS_ENABLED(CONFIG_RCU_NOCB_CPU) && rsclp->offloaded;
+	return IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
+		rcu_segcblist_test_flags(rsclp, SEGCBLIST_OFFLOADED);
 }
 
 /*
