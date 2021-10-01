Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB8441F074
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 17:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354993AbhJAPII (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 11:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354910AbhJAPHr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 11:07:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB170C0613EC;
        Fri,  1 Oct 2021 08:05:53 -0700 (PDT)
Date:   Fri, 01 Oct 2021 15:05:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633100752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zLrJ8oBhRoOGHAvO/vfr78vQiyZkSw3otCkPOsi1/nk=;
        b=vTfeMdoAshiQl7fPDlYkdwauNA9+QMynacCjOXLqgjB8Eh+pG6fb2zu+kzZE11+a33BXQp
        PSTeXXdmWqgGmn+VjxbB4JYvHIRd64OSkHgWekiHNx6HxR2bmcWtA91P6ublpzFKyQF8Kh
        cXxO9rd+eF8UdBnaHKe+I0sAyGrwOTLpSsXrCNUe/Pd1Th1ij1ASET3U2RKup28T1MsndQ
        HCmUyTnj7WIYlGqrQeEieIVAzNwrjbipuli36LiUUq7IFjnrifYhxt9VFxzVWoQw4HqXAE
        yHWgxCWEumTxrdQkpMiuo0/spqLyQJdNMS0PmXTPwFkGgVNGb6fK87jMvDlhwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633100752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zLrJ8oBhRoOGHAvO/vfr78vQiyZkSw3otCkPOsi1/nk=;
        b=KWbael7laDvQI3FC2VQu4tGZedL3NJPM/w+AZDrgvptkAXjYFVvm2ELGCYcbezzO4WTQ9j
        FbBG7Uoj7CzeIhCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Limit the number of task migrations per batch on RT
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210928122411.425097596@linutronix.de>
References: <20210928122411.425097596@linutronix.de>
MIME-Version: 1.0
Message-ID: <163310075145.25758.10821100401474045244.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     92add3a897e9e923acde0f2c5e69705818076d69
Gitweb:        https://git.kernel.org/tip/92add3a897e9e923acde0f2c5e69705818076d69
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 28 Sep 2021 14:24:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:58:07 +02:00

sched: Limit the number of task migrations per batch on RT

Batched task migrations are a source for large latencies as they keep the
scheduler from running while processing the migrations.

Limit the batch size to 8 instead of 32 when running on a RT enabled
kernel.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210928122411.425097596@linutronix.de
---
 kernel/sched/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bb70a07..8d844d0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -74,7 +74,11 @@ __read_mostly int sysctl_resched_latency_warn_once = 1;
  * Number of tasks to iterate in a single balance run.
  * Limited because this is done with IRQs disabled.
  */
+#ifdef CONFIG_PREEMPT_RT
+const_debug unsigned int sysctl_sched_nr_migrate = 8;
+#else
 const_debug unsigned int sysctl_sched_nr_migrate = 32;
+#endif
 
 /*
  * period over which we measure -rt task CPU usage in us.
