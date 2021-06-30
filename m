Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C13E3B83C3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbhF3Nus (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32938 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbhF3NuS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:18 -0400
Date:   Wed, 30 Jun 2021 13:47:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VsbTz+gB+sB2nZDArGhw0sDdqLdV29x6hq89LyHgyS4=;
        b=mz853SlyiKf/e9N9TM9PZRBQ3a5GT8LPW01KFIKCYnMwkfNYto28gbheMhuOfgSx1SzpVn
        uPZr6M7XWo1BTMEycF8h8PTnv4ZXLwvG1MYc4a0iCCXaxzwPpG+CzCNOPU0aekzEHp6gqO
        PPkmJ6R6En0MJAPkcQiVepYDgTuEyd9PDn5xwl0RzoqY1PXBKjKxCqaNixEaPUQseUnZX5
        TG+ei/ShX3JVuxl8ejrtJP0OFgEZIFqR1Ri6ZK8GrdPxTcMUFNBlWBg/D2acM3MYm2aM0N
        218/9/kWEJ1f5n6leyTbExU7vI7vs0Jc+DCANLETAh1xG47KiF+7S2y60olHzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VsbTz+gB+sB2nZDArGhw0sDdqLdV29x6hq89LyHgyS4=;
        b=DlEocfsH74Vken6YkGA5QGQxUnQSK1/IhdnDImL/AWm/AnKrMPg9QRlPKJhNmzs9sJ41/X
        nYiudtoFmaOhNyAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refscale: Add acqrel, lock, and lock-irq
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506086763.395.18377470985655966721.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e9b800db96fa40170c5607d8968b2ec6212c2026
Gitweb:        https://git.kernel.org/tip/e9b800db96fa40170c5607d8968b2ec6212c2026
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 10 Mar 2021 18:02:36 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:05 -07:00

refscale: Add acqrel, lock, and lock-irq

This commit adds scale_type of acqrel, lock, and lock-irq to
test acquisition and release.  Note that the refscale.nreaders=1
module parameter is required if you wish to test uncontended locking.
In contrast, acqrel uses a per-CPU variable, so should be just fine with
large values of the refscale.nreaders=1 module parameter.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 109 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 02dd976..313d454 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -362,6 +362,111 @@ static struct ref_scale_ops rwsem_ops = {
 	.name		= "rwsem"
 };
 
+// Definitions for global spinlock
+static DEFINE_SPINLOCK(test_lock);
+
+static void ref_lock_section(const int nloops)
+{
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		spin_lock(&test_lock);
+		spin_unlock(&test_lock);
+	}
+	preempt_enable();
+}
+
+static void ref_lock_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		spin_lock(&test_lock);
+		un_delay(udl, ndl);
+		spin_unlock(&test_lock);
+	}
+	preempt_enable();
+}
+
+static struct ref_scale_ops lock_ops = {
+	.readsection	= ref_lock_section,
+	.delaysection	= ref_lock_delay_section,
+	.name		= "lock"
+};
+
+// Definitions for global irq-save spinlock
+
+static void ref_lock_irq_section(const int nloops)
+{
+	unsigned long flags;
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		spin_lock_irqsave(&test_lock, flags);
+		spin_unlock_irqrestore(&test_lock, flags);
+	}
+	preempt_enable();
+}
+
+static void ref_lock_irq_delay_section(const int nloops, const int udl, const int ndl)
+{
+	unsigned long flags;
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		spin_lock_irqsave(&test_lock, flags);
+		un_delay(udl, ndl);
+		spin_unlock_irqrestore(&test_lock, flags);
+	}
+	preempt_enable();
+}
+
+static struct ref_scale_ops lock_irq_ops = {
+	.readsection	= ref_lock_irq_section,
+	.delaysection	= ref_lock_irq_delay_section,
+	.name		= "lock-irq"
+};
+
+// Definitions acquire-release.
+static DEFINE_PER_CPU(unsigned long, test_acqrel);
+
+static void ref_acqrel_section(const int nloops)
+{
+	unsigned long x;
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		x = smp_load_acquire(this_cpu_ptr(&test_acqrel));
+		smp_store_release(this_cpu_ptr(&test_acqrel), x + 1);
+	}
+	preempt_enable();
+}
+
+static void ref_acqrel_delay_section(const int nloops, const int udl, const int ndl)
+{
+	unsigned long x;
+	int i;
+
+	preempt_disable();
+	for (i = nloops; i >= 0; i--) {
+		x = smp_load_acquire(this_cpu_ptr(&test_acqrel));
+		un_delay(udl, ndl);
+		smp_store_release(this_cpu_ptr(&test_acqrel), x + 1);
+	}
+	preempt_enable();
+}
+
+static struct ref_scale_ops acqrel_ops = {
+	.readsection	= ref_acqrel_section,
+	.delaysection	= ref_acqrel_delay_section,
+	.name		= "acqrel"
+};
+
 static void rcu_scale_one_reader(void)
 {
 	if (readdelay <= 0)
@@ -653,8 +758,8 @@ ref_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static struct ref_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &rcu_trace_ops, &rcu_tasks_ops,
-		&refcnt_ops, &rwlock_ops, &rwsem_ops,
+		&rcu_ops, &srcu_ops, &rcu_trace_ops, &rcu_tasks_ops, &refcnt_ops, &rwlock_ops,
+		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops,
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
