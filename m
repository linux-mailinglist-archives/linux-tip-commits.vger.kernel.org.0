Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC887234321
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbgGaJ2R (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:28:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56390 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbgGaJW4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:56 -0400
Date:   Fri, 31 Jul 2020 09:22:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zkISJ9r3nlJQXx+yjwv77/zQvu/bCClKJInmSQpEtj0=;
        b=CLkHXTCXEZVyfm/4ff4TiC4Vuy3xzQxCF8rBiVz2Mq7lF49kpVDDMy7EjeyxYlm2Y+JoyH
        zj14mCzqqYRJkIooP6hI+/G/FW+sE0zGJo5fFh34pFosgSL2p9IE/O61UVeTp5v4aTffB+
        TmLJya8hlwLjbCgXxACNQg62tHIAoPaKF1dzA5yrxY/q3Ab5yEnW8mpMx8UWDw15uTjLfE
        4xBeZn6f4UKMFRfqW7r+Muy9uJLL9OO4BQjB32+okjBj4YW8AJc1Ec08PCKPYVHK2MqP5h
        FNAJzjeEfn0sk5etl1KzlFMecbOCrJlJMcETr7P/Si9XGoZGpRo/Z7DSUUfaLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zkISJ9r3nlJQXx+yjwv77/zQvu/bCClKJInmSQpEtj0=;
        b=cWV3LShizFUWF2YNs7NYPDc4vAmQSdF2T66lQE2NnuyNCjOw9IiRNfj8NvSkW5o1R0W8wr
        A6wUPOaM8UATMRDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Add test for RCU Tasks readers
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618737390.4006.3908578018562144708.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e13ef442fe522fa1f604efec8c899a0e1fc3d426
Gitweb:        https://git.kernel.org/tip/e13ef442fe522fa1f604efec8c899a0e1fc3d426
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 03 Jun 2020 11:56:34 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:46 -07:00

refperf: Add test for RCU Tasks readers

This commit adds testing for RCU Tasks readers to the refperf module.
This also applies to RCU Rude readers, as both flavors have empty
(as in non-existent) read-side markers.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index da7de9a..2bfdcdc 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -192,6 +192,31 @@ static struct ref_perf_ops srcu_ops = {
 	.name		= "srcu"
 };
 
+// Definitions for RCU Tasks ref perf testing: Empty read markers.
+// These definitions also work for RCU Rude readers.
+static void rcu_tasks_ref_perf_read_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--)
+		continue;
+}
+
+static void rcu_tasks_ref_perf_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--)
+		un_delay(udl, ndl);
+}
+
+static struct ref_perf_ops rcu_tasks_ops = {
+	.init		= rcu_sync_perf_init,
+	.readsection	= rcu_tasks_ref_perf_read_section,
+	.delaysection	= rcu_tasks_ref_perf_delay_section,
+	.name		= "rcu-tasks"
+};
+
 // Definitions for RCU Tasks Trace ref perf testing.
 static void rcu_trace_ref_perf_read_section(const int nloops)
 {
@@ -613,7 +638,8 @@ ref_perf_init(void)
 	long i;
 	int firsterr = 0;
 	static struct ref_perf_ops *perf_ops[] = {
-		&rcu_ops, &srcu_ops, &rcu_trace_ops, &refcnt_ops, &rwlock_ops, &rwsem_ops,
+		&rcu_ops, &srcu_ops, &rcu_trace_ops, &rcu_tasks_ops,
+		&refcnt_ops, &rwlock_ops, &rwsem_ops,
 	};
 
 	if (!torture_init_begin(perf_type, verbose))
