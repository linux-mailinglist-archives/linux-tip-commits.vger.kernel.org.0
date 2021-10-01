Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795DB41F076
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 17:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354850AbhJAPIJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 11:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354937AbhJAPHs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 11:07:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03471C061780;
        Fri,  1 Oct 2021 08:05:55 -0700 (PDT)
Date:   Fri, 01 Oct 2021 15:05:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633100753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++gsgfHb1k6iXnO5o9hFJ9fiU2rkh2gTW1nfaNjEkjs=;
        b=iO/SL/SE78gVxci6kAYkRQJqL6TGNDYp7iT9sfI/81+QDhzwPKjoADNWjmz0KQG1xVVAOy
        q+J2EZa2EObUkVL887Avik88+RdrmiJrJW6Xtk5GV+ynTUJ/QT6INtXesCMdm2Cv40R5sx
        /+ui1eC8jES1j5oCLhtfrNC13nZrRh6TDLioDhYA3nazbb9g3P7yCycjppxdfdsvuzDwXX
        LMORDE+DghFQeQXlxLVOv/eOdo8ZO8uICyg4e/dhq9FveA5X95ut6X+4he9V0Zfk+dZU+1
        miyccl0s2l/GLHjexdW8XiFO4i6f0y2vCw80KrtRS/MYALCbtZbaRAy55KO7Og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633100753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++gsgfHb1k6iXnO5o9hFJ9fiU2rkh2gTW1nfaNjEkjs=;
        b=GNHslFfvpoeJruEgYJLqfDzMLBEl+gr3K4kbaib/bjJpzUMsrdS4RpzfvBV6G3FzGhpdN8
        YBQXPBXRQSmYGODA==
From:   "tip-bot2 for Shaokun Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Make cookie functions static
Cc:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210922085735.52812-1-zhangshaokun@hisilicon.com>
References: <20210922085735.52812-1-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Message-ID: <163310075281.25758.4311232499537861275.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1bc687b27bac7fabcc2b0a1a8efad5cf875ac769
Gitweb:        https://git.kernel.org/tip/1bc687b27bac7fabcc2b0a1a8efad5cf875ac769
Author:        Shaokun Zhang <zhangshaokun@hisilicon.com>
AuthorDate:    Wed, 22 Sep 2021 16:57:35 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:58:06 +02:00

sched: Make cookie functions static

Make cookie functions static as these are no longer invoked directly
by other code.

No functional change intended.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210922085735.52812-1-zhangshaokun@hisilicon.com
---
 kernel/sched/core_sched.c |  9 +++++----
 kernel/sched/sched.h      |  5 -----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 9a80e9a..48ac726 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -11,7 +11,7 @@ struct sched_core_cookie {
 	refcount_t refcnt;
 };
 
-unsigned long sched_core_alloc_cookie(void)
+static unsigned long sched_core_alloc_cookie(void)
 {
 	struct sched_core_cookie *ck = kmalloc(sizeof(*ck), GFP_KERNEL);
 	if (!ck)
@@ -23,7 +23,7 @@ unsigned long sched_core_alloc_cookie(void)
 	return (unsigned long)ck;
 }
 
-void sched_core_put_cookie(unsigned long cookie)
+static void sched_core_put_cookie(unsigned long cookie)
 {
 	struct sched_core_cookie *ptr = (void *)cookie;
 
@@ -33,7 +33,7 @@ void sched_core_put_cookie(unsigned long cookie)
 	}
 }
 
-unsigned long sched_core_get_cookie(unsigned long cookie)
+static unsigned long sched_core_get_cookie(unsigned long cookie)
 {
 	struct sched_core_cookie *ptr = (void *)cookie;
 
@@ -53,7 +53,8 @@ unsigned long sched_core_get_cookie(unsigned long cookie)
  *
  * Returns: the old cookie
  */
-unsigned long sched_core_update_cookie(struct task_struct *p, unsigned long cookie)
+static unsigned long sched_core_update_cookie(struct task_struct *p,
+					      unsigned long cookie)
 {
 	unsigned long old_cookie;
 	struct rq_flags rf;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 71bc710..3213e23 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1258,11 +1258,6 @@ extern void sched_core_dequeue(struct rq *rq, struct task_struct *p);
 extern void sched_core_get(void);
 extern void sched_core_put(void);
 
-extern unsigned long sched_core_alloc_cookie(void);
-extern void sched_core_put_cookie(unsigned long cookie);
-extern unsigned long sched_core_get_cookie(unsigned long cookie);
-extern unsigned long sched_core_update_cookie(struct task_struct *p, unsigned long cookie);
-
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
