Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFD13D8B39
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jul 2021 11:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbhG1J6M (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Jul 2021 05:58:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59024 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbhG1J6L (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Jul 2021 05:58:11 -0400
Date:   Wed, 28 Jul 2021 09:58:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627466289;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEl9xS3e4PERu/97WA6iiQpaVCa7x8QuWgD/1iD7Z5I=;
        b=LRt1P4UAVJq0UjAFos+tAwI7ordu+uAocvRWtCl9dQ+SISZl+KZBsSu2K2VGoN6tbFmOaf
        VBGRN+F95uhFKjpK+Ag1f+0wLbI4nO9PQoZkHlVqGShvk4PxcK9ybVVBhQWT4HXTlkCRow
        6cYTh8zZ3T0ueFT4TbHyOHrKvMZiLgTmCoAs20rZeiW4WsIAqjJp7q3JYPhUJyNtfMTpSp
        olhsrLJuymypd60sIsE3+RV4tZOubmR4u9AkJt0ZuYvqpHTrXr+HA4OQaGIMmK+O6ogYZx
        2Lf3QSFk4FpIj1RofCiqmaNXxVvWf5x/DpZZbYLX+fYU/Hp0yqREdrjX1ZbSAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627466289;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEl9xS3e4PERu/97WA6iiQpaVCa7x8QuWgD/1iD7Z5I=;
        b=tzUz4avZShCMy5n6prmv/zVy/h5mLcCX4KATohWnQN6Xddnt4M7DE1rdCMxiJqShRb+Gco
        dUhrk6GufhlVIhDg==
From:   "tip-bot2 for Balbir Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] sched: Add task_work callback for paranoid L1D flush
Cc:     Balbir Singh <sblbir@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210108121056.21940-1-sblbir@amazon.com>
References: <20210108121056.21940-1-sblbir@amazon.com>
MIME-Version: 1.0
Message-ID: <162746628890.395.5107935067363601209.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     58e106e725eed59896b9141a1c9a917d2f67962a
Gitweb:        https://git.kernel.org/tip/58e106e725eed59896b9141a1c9a917d2f67962a
Author:        Balbir Singh <sblbir@amazon.com>
AuthorDate:    Mon, 26 Apr 2021 21:59:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Jul 2021 11:42:24 +02:00

sched: Add task_work callback for paranoid L1D flush

The upcoming paranoid L1D flush infrastructure allows to conditionally
(opt-in) flush L1D in switch_mm() as a defense against potential new side
channels or for paranoia reasons. As the flush makes only sense when a task
runs on a non-SMT enabled core, because SMT siblings share L1, the
switch_mm() logic will kill a task which is flagged for L1D flush when it
is running on a SMT thread.

Add a taskwork callback so switch_mm() can queue a SIG_KILL command which
is invoked when the task tries to return to user space.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210108121056.21940-1-sblbir@amazon.com
---
 arch/Kconfig          |  3 +++
 include/linux/sched.h | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 129df49..98db634 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1282,6 +1282,9 @@ config ARCH_SPLIT_ARG64
 config ARCH_HAS_ELFCORE_COMPAT
 	bool
 
+config ARCH_HAS_PARANOID_L1D_FLUSH
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ec8d07d..c048e59 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1400,6 +1400,16 @@ struct task_struct {
 	struct llist_head               kretprobe_instances;
 #endif
 
+#ifdef CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH
+	/*
+	 * If L1D flush is supported on mm context switch
+	 * then we use this callback head to queue kill work
+	 * to kill tasks that are not running on SMT disabled
+	 * cores
+	 */
+	struct callback_head		l1d_flush_kill;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
