Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3DA2342C2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbgGaJZp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732479AbgGaJXa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912F4C061575;
        Fri, 31 Jul 2020 02:23:30 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:23:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=11U/0Ie+kAPWdse3u92f65v5lLRR2r61qLynCDPMksM=;
        b=w/3xSqw2O9a9V5InncAqt+oJEs78zaLLDZlhbb/JvjJa65rqubZdyeFF2No5y8DSpQsNsZ
        V4pZuc2JzX89embjHQlPSWGdC/7x56jqeFShLftQzcBVPmjfEtcwMWwSx4NOF/xpPVABrL
        1vfCQHC+CM0UlHGU3788FF4g4oeJBkvdvgGvJR63+whIvq7J375IRq4o6QJYkFgnbATWt8
        IqnYV1V1mQqcJdQ9AiymqST3S1SAZ0SJnKzBC7iaCqp4EfBBC8RcIHP6MyY6ojBOugUxIy
        oTpoeYBSjdYhQaOOArSdnsXaDxKMDFF0zu21YrA8ZakhlceOJQqN/3g4VB8XSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187409;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=11U/0Ie+kAPWdse3u92f65v5lLRR2r61qLynCDPMksM=;
        b=+6UA0VIGD+9svcbcTSJTLW/TmQ+UC3XgJk0cihdzPRYSMm3e9Wi4Kna2v2ZNSWYRqSv3lD
        GRttKBttym3B4rBg==
From:   "tip-bot2 for Wei Yang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: gp_max is protected by root rcu_node's lock
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618740851.4006.12238943856453230041.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     00943a609d7ad0f08e58bc9c214f38b0ba163c88
Gitweb:        https://git.kernel.org/tip/00943a609d7ad0f08e58bc9c214f38b0ba163c88
Author:        Wei Yang <richard.weiyang@linux.alibaba.com>
AuthorDate:    Fri, 12 Jun 2020 10:07:52 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:51 -07:00

rcu: gp_max is protected by root rcu_node's lock

Because gp_max is protected by root rcu_node's lock, this commit moves
the gp_max definition to the region of the rcu_node structure containing
fields protected by this lock.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 575745f..09ec93b 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -302,6 +302,8 @@ struct rcu_state {
 	u8	boost ____cacheline_internodealigned_in_smp;
 						/* Subject to priority boost. */
 	unsigned long gp_seq;			/* Grace-period sequence #. */
+	unsigned long gp_max;			/* Maximum GP duration in */
+						/*  jiffies. */
 	struct task_struct *gp_kthread;		/* Task for grace periods. */
 	struct swait_queue_head gp_wq;		/* Where GP task waits. */
 	short gp_flags;				/* Commands for GP task. */
@@ -347,8 +349,6 @@ struct rcu_state {
 						/*  a reluctant CPU. */
 	unsigned long n_force_qs_gpstart;	/* Snapshot of n_force_qs at */
 						/*  GP start. */
-	unsigned long gp_max;			/* Maximum GP duration in */
-						/*  jiffies. */
 	const char *name;			/* Name of structure. */
 	char abbr;				/* Abbreviated name. */
 
