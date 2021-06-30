Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301893B83D2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhF3Nuy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33144 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbhF3NuX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:23 -0400
Date:   Wed, 30 Jun 2021 13:47:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=s9a75qrLhPOhxfReR9CvCjbs7BYQ2qmsHuEjayffs0Q=;
        b=X5xz+8sKcFbA1AjGJpu40jQa8ucVVVmZwpPMKg81/XX8/pz5cR47stMLPxHPgDwHPPSvz2
        FnKj7ftBjqLR06gd9iRFZ+4AlOvAObw5TmVKn03G11QhFuSSi5w/+0XMeqBniuDAsdc7j9
        UITPWyIsxnRRiuv6GjRmqUt0dZfvV4JOMy4h3m+peFdNADlfhytySqwfFxdQo0JXXaD64z
        DQYsutaUbXJiu04UlV1jCJs6CqlRo102TslTk06mmjJyACKZI88EaKTvY6v+uyPDIgndDU
        XjNa1GdqD4eIpwq46OGawXU9ScuSw9ASofw/uML1PJTjwYsheHK2pV3w31xCug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=s9a75qrLhPOhxfReR9CvCjbs7BYQ2qmsHuEjayffs0Q=;
        b=cGedrjNgLpfqOXOcsH354BlgS0gCml+/9UfBIGqAv3NcJZpqAPGSQg906n+RSfuHNzKH7f
        Hp7mIo5WWOjKheBg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Add block comment laying out RCU Rude design
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506087123.395.3429683196775357283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     9fc98e3143de7b7e8d766aef41b46ec0bc0ae4ca
Gitweb:        https://git.kernel.org/tip/9fc98e3143de7b7e8d766aef41b46ec0bc0ae4ca
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 04 Mar 2021 14:46:59 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:04:24 -07:00

rcu-tasks: Add block comment laying out RCU Rude design

This commit adds a block comment that gives a high-level overview of
how RCU Rude grace periods progress.  It also gives an overview of the
memory ordering.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 94d2c2c..d6aa352 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -645,8 +645,13 @@ void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
 // passing an empty function to schedule_on_each_cpu().  This approach
 // provides an asynchronous call_rcu_tasks_rude() API and batching
 // of concurrent calls to the synchronous synchronize_rcu_rude() API.
-// This sends IPIs far and wide and induces otherwise unnecessary context
-// switches on all online CPUs, whether idle or not.
+// This invokes schedule_on_each_cpu() in order to send IPIs far and wide
+// and induces otherwise unnecessary context switches on all online CPUs,
+// whether idle or not.
+//
+// Callback handling is provided by the rcu_tasks_kthread() function.
+//
+// Ordering is provided by the scheduler's context-switch code.
 
 // Empty function to allow workqueues to force a context switch.
 static void rcu_tasks_be_rude(struct work_struct *work)
