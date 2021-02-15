Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83F231BBA6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhBOO5m (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhBOO5L (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:57:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C71CC061221;
        Mon, 15 Feb 2021 06:55:50 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xs9WI6YIxKepm9+XhT2ManvoRnnEKXhFK1fJSJ1e2kQ=;
        b=mLf43FpQSRZtAQ2I3xCpk9uGOm7XkBO1BZQzWqyYqwwbnjZHMhKxCwNpmNPnVoZoAexWvi
        baDWdwQVzGb63cKujqnf2PvfLnFVGcoEbZ395sD/AqwlYrxE5db7p2n+j1RmnS8TQuOZoD
        4MMySZkZc+F75+vp0esETgCWroNT84nmL/5JtFoaMORCMKWq8zQnhQwKyIFxW3hKnMEYas
        GejXzN5BuzITwYVTkdXvTZsH0mu+CelegGlh8II1RIzl9UxbT5mpWaxAELNvNHH5wz9zL9
        nOMnZsHXVj/XaqaO2mSJHzI+zmAMQzUfv91fyiFL3KAOTCttywwOjBGDx7cfGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xs9WI6YIxKepm9+XhT2ManvoRnnEKXhFK1fJSJ1e2kQ=;
        b=eRxf7yiH+qtcyfWBl2OBfE8LUFyDQ78q26nCxiiUjwYQxwYh8ZZ906vksY4z38Bn166Sb/
        yhcfCynMJSFEaBAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc: Remove obsolete RCU-bh and RCU-sched update-side
 API members
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094832.20312.177667296241669826.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     2c8bce609f095a8879d3948e0c18d629881518dd
Gitweb:        https://git.kernel.org/tip/2c8bce609f095a8879d3948e0c18d629881518dd
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 10 Nov 2020 16:17:42 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:35:13 -08:00

doc: Remove obsolete RCU-bh and RCU-sched update-side API members

synchronize_rcu_bh(), synchronize_rcu_bh_expedited(), call_rcu_bh(),
rcu_barrier_bh(), synchronize_sched(), synchronize_rcu_sched_expedited(),
call_rcu_sched(), and rcu_barrier_sched() no longer exist, so this
commit removes mention of them.

Reported-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 28 ++++-----
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 9b23be6..1e3df77 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2438,13 +2438,13 @@ glance as if rcu_read_unlock_bh() was executing very slowly.
 
 The `RCU-bh
 API <https://lwn.net/Articles/609973/#RCU%20Per-Flavor%20API%20Table>`__
-includes rcu_read_lock_bh(), rcu_read_unlock_bh(),
-rcu_dereference_bh(), rcu_dereference_bh_check(),
-synchronize_rcu_bh(), synchronize_rcu_bh_expedited(),
-call_rcu_bh(), rcu_barrier_bh(), and
-rcu_read_lock_bh_held(). However, the update-side APIs are now
-simple wrappers for other RCU flavors, namely RCU-sched in
-CONFIG_PREEMPT=n kernels and RCU-preempt otherwise.
+includes rcu_read_lock_bh(), rcu_read_unlock_bh(), rcu_dereference_bh(),
+rcu_dereference_bh_check(), and rcu_read_lock_bh_held(). However, the
+old RCU-bh update-side APIs are now gone, replaced by synchronize_rcu(),
+synchronize_rcu_expedited(), call_rcu(), and rcu_barrier().  In addition,
+anything that disables bottom halves also marks an RCU-bh read-side
+critical section, including local_bh_disable() and local_bh_enable(),
+local_irq_save() and local_irq_restore(), and so on.
 
 Sched Flavor (Historical)
 ~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -2481,13 +2481,13 @@ The `RCU-sched
 API <https://lwn.net/Articles/609973/#RCU%20Per-Flavor%20API%20Table>`__
 includes rcu_read_lock_sched(), rcu_read_unlock_sched(),
 rcu_read_lock_sched_notrace(), rcu_read_unlock_sched_notrace(),
-rcu_dereference_sched(), rcu_dereference_sched_check(),
-synchronize_sched(), synchronize_rcu_sched_expedited(),
-call_rcu_sched(), rcu_barrier_sched(), and
-rcu_read_lock_sched_held(). However, anything that disables
-preemption also marks an RCU-sched read-side critical section, including
-preempt_disable() and preempt_enable(), local_irq_save() and
-local_irq_restore(), and so on.
+rcu_dereference_sched(), rcu_dereference_sched_check(), and
+rcu_read_lock_sched_held().  However, the old RCU-sched update-side APIs
+are now gone, replaced by synchronize_rcu(), synchronize_rcu_expedited(),
+call_rcu(), and rcu_barrier().  In addition, anything that disables
+preemption also marks an RCU-sched read-side critical section,
+including preempt_disable() and preempt_enable(), local_irq_save()
+and local_irq_restore(), and so on.
 
 Sleepable RCU
 ~~~~~~~~~~~~~
