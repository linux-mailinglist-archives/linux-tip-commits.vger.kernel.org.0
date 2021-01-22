Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FFE300A61
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Jan 2021 18:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbhAVRv2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Jan 2021 12:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbhAVRmR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Jan 2021 12:42:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BC4C06174A;
        Fri, 22 Jan 2021 09:41:37 -0800 (PST)
Date:   Fri, 22 Jan 2021 17:41:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611337295;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vWApvcSANT83v+JCFoco0KltM/bSpHt02z6aEBwqOwM=;
        b=YGn4cbX6FfsI8h+4NWIzlIWEWeBQSt4ZE5CsaofTTkz63IXrGZoFk7lA/xHCXfXXJ2zPSd
        R5WSBQyviOaKdlngilb5ePxMowvzXxl6pp+ULcQgmXMVi+R2CMCqyC2Nls7+ERkP/heSK5
        BPooZASD/CwOZZgQHjKDJPqqbbNQiqt1z/SoexPYqRwOYKAq4HsDrzABbEd95XLliVdN32
        pEZBrJFSXGO2TphRn7ungvjVC/24q+A66lqrqojK/IE16htRa5OuqCNZmZVXahjDEwDxYM
        kC/gUHp+bukmjVcBEwIZXJzSihQZ1uqf6rd7CQJ+eAF4JqNZFBsMz+v6QDacbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611337295;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vWApvcSANT83v+JCFoco0KltM/bSpHt02z6aEBwqOwM=;
        b=8V7mNadao6rNlp/f0bAwIQTvzO89N5/jtgMEtdBOmsNBJ87zwdHjsmVhR9fh4rTDQ8mROh
        TLqEeiNQOcGsVIAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] workqueue: Restrict affinity change to rescuer
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210121103506.826629830@infradead.org>
References: <20210121103506.826629830@infradead.org>
MIME-Version: 1.0
Message-ID: <161133729498.414.8534909860979779052.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     640f17c82460e9724fd256f0a1f5d99e7ff0bda4
Gitweb:        https://git.kernel.org/tip/640f17c82460e9724fd256f0a1f5d99e7ff0bda4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 15 Jan 2021 19:08:36 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Jan 2021 15:09:43 +01:00

workqueue: Restrict affinity change to rescuer

create_worker() will already set the right affinity using
kthread_bind_mask(), this means only the rescuer will need to change
it's affinity.

Howveer, while in cpu-hot-unplug a regular task is not allowed to run
on online&&!active as it would be pushed away quite agressively. We
need KTHREAD_IS_PER_CPU to survive in that environment.

Therefore set the affinity after getting that magic flag.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210121103506.826629830@infradead.org
---
 kernel/workqueue.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index cce3433..894bb88 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1849,12 +1849,6 @@ static void worker_attach_to_pool(struct worker *worker,
 	mutex_lock(&wq_pool_attach_mutex);
 
 	/*
-	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
-	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
-	 */
-	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
-
-	/*
 	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
 	 * stable across this function.  See the comments above the flag
 	 * definition for details.
@@ -1864,6 +1858,9 @@ static void worker_attach_to_pool(struct worker *worker,
 	else
 		kthread_set_per_cpu(worker->task, pool->cpu);
 
+	if (worker->rescue_wq)
+		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+
 	list_add_tail(&worker->node, &pool->workers);
 	worker->pool = pool;
 
