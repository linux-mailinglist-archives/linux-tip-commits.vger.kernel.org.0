Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286BE234322
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbgGaJ2R (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732288AbgGaJW4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5097C061575;
        Fri, 31 Jul 2020 02:22:56 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:22:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jMKxphsfuVkPBvCEYM3UlEvRxEtBbKtBk4gYcglfmlc=;
        b=2ABfW7lo+UcRTH8MFwM/jX12oC/sr7UHE835Ze0zSs0mWaX2eR01t3Qvg0UKZkammyAs4u
        SNk01fupSXOs06MTxaPscJBLlAmm/ofDK0bLZ8ccUmdcwctxue9sIlwq4sitrKo94gkz1a
        XwBvM3qB0qxH8zNYxbvQr1TaXkqt79J7JKM8PcJlZ8fjFzYHnqZT7joOqdxmkBCC1Eu2bJ
        uqTTsWMH4mCxdeQBAaaAZCYJRJlbNxuu+aQhqV0kOyBPyuoEtzHdLECMlYTL+7iDdST/fF
        EbN5v+RJK2W/mYTxgH//byv8eqmUjkmRKQcvmglJTzdahMK91fPRTnOpytvlHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jMKxphsfuVkPBvCEYM3UlEvRxEtBbKtBk4gYcglfmlc=;
        b=wxH2T/bUYw2bgAwazfok2yRJTEdq4j94tpELPrPdOyaqHAodSTIudLfnuyoIZTMh7v6GU2
        lL7kwNRwRQQAO4Bw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Add test for RCU Tasks Trace readers.
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618737459.4006.18036105655591171728.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     72bb749e7048d0a8d7663b59ec1a33bd56c51083
Gitweb:        https://git.kernel.org/tip/72bb749e7048d0a8d7663b59ec1a33bd56c51083
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 02 Jun 2020 08:34:41 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:45 -07:00

refperf: Add test for RCU Tasks Trace readers.

This commit adds testing for RCU Tasks Trace readers to the refperf module.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 49fffb9..da7de9a 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -25,6 +25,7 @@
 #include <linux/notifier.h>
 #include <linux/percpu.h>
 #include <linux/rcupdate.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/reboot.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
@@ -157,7 +158,6 @@ static struct ref_perf_ops rcu_ops = {
 	.name		= "rcu"
 };
 
-
 // Definitions for SRCU ref perf testing.
 DEFINE_STATIC_SRCU(srcu_refctl_perf);
 static struct srcu_struct *srcu_ctlp = &srcu_refctl_perf;
@@ -192,6 +192,35 @@ static struct ref_perf_ops srcu_ops = {
 	.name		= "srcu"
 };
 
+// Definitions for RCU Tasks Trace ref perf testing.
+static void rcu_trace_ref_perf_read_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		rcu_read_lock_trace();
+		rcu_read_unlock_trace();
+	}
+}
+
+static void rcu_trace_ref_perf_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		rcu_read_lock_trace();
+		un_delay(udl, ndl);
+		rcu_read_unlock_trace();
+	}
+}
+
+static struct ref_perf_ops rcu_trace_ops = {
+	.init		= rcu_sync_perf_init,
+	.readsection	= rcu_trace_ref_perf_read_section,
+	.delaysection	= rcu_trace_ref_perf_delay_section,
+	.name		= "rcu-trace"
+};
+
 // Definitions for reference count
 static atomic_t refcnt;
 
@@ -584,7 +613,7 @@ ref_perf_init(void)
 	long i;
 	int firsterr = 0;
 	static struct ref_perf_ops *perf_ops[] = {
-		&rcu_ops, &srcu_ops, &refcnt_ops, &rwlock_ops, &rwsem_ops,
+		&rcu_ops, &srcu_ops, &rcu_trace_ops, &refcnt_ops, &rwlock_ops, &rwsem_ops,
 	};
 
 	if (!torture_init_begin(perf_type, verbose))
