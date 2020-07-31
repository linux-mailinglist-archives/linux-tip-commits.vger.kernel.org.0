Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86E823430E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbgGaJ1y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:27:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56434 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732323AbgGaJXD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:03 -0400
Date:   Fri, 31 Jul 2020 09:23:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187381;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=p3qtbIjLpunaHmK7TDw9hkmJuKk63MnYBiXMc3g1CEE=;
        b=cmrwkBAnHN5DibwQbddiI2v3EUIJfhOIKagcGxcYC70D3VZhkj4eyC2q6YASAKM0uR+Jso
        Y7oo/lsJMAtWkJtCwJ356Ln2BkCgRLCXOkPzjuZbfqtqe1/B5PjxJlClGfWrbV7HQluyzK
        qqnE0PBTDU1hqFI8cX4CgJAwXQy30H0fRQeEAcfcI5+gtnHIM649oCKeunOV6Y4658VX1G
        8tgF5QKRBz3Rm/eGtVxhYdsYcDn1V90p7UKOWY3Hkrdq2whIwvlboPwY8T7DR/3zSSLWS8
        VGZ90gCWnQGxwhaze1J29wJ0p/NbVlW2eqLeaLao/bBtOWQAFA3UkrvWOKgXxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187381;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=p3qtbIjLpunaHmK7TDw9hkmJuKk63MnYBiXMc3g1CEE=;
        b=WCytlpIhY7mozlY83tIuHKWCF+K9r/oUxUJsoWvyD0UmbO/mJylcdt5lp9dY1nuCrmiDdf
        eYW8g7wdkoT/+mDg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: More closely synchronize reader start times
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618738111.4006.1578218464216543931.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     86e0da2bb8ed934d3dce5a337895f1118f59c087
Gitweb:        https://git.kernel.org/tip/86e0da2bb8ed934d3dce5a337895f1118f59c087
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 26 May 2020 11:40:52 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:45 -07:00

refperf: More closely synchronize reader start times

Currently, readers are awakened individually.  On most systems, this
results in significant wakeup delay from one reader to the next, which
can result in the first and last reader having sole access to the
synchronization primitive in question.  If that synchronization primitive
involves shared memory, those readers will rack up a huge number of
operations in a very short time, causing large perturbations in the
results.

This commit therefore has the readers busy-wait after being awakened,
and uses a new n_started variable to synchronize their start times.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 2fd3ed1..234bb0e 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -99,6 +99,7 @@ static atomic_t nreaders_exp;
 
 // Use to wait for all threads to start.
 static atomic_t n_init;
+static atomic_t n_started;
 
 // Track which experiment is currently running.
 static int exp_idx;
@@ -253,6 +254,9 @@ repeat:
 	WARN_ON_ONCE(smp_processor_id() != me);
 
 	WRITE_ONCE(rt->start_reader, 0);
+	if (!atomic_dec_return(&n_started))
+		while (atomic_read_acquire(&n_started))
+			cpu_relax();
 
 	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d started", me, exp_idx);
 
@@ -367,6 +371,7 @@ static int main_func(void *arg)
 
 		reset_readers();
 		atomic_set(&nreaders_exp, nreaders);
+		atomic_set(&n_started, nreaders);
 
 		exp_idx = exp;
 
