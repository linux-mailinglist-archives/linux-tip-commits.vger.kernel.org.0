Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072FA422A57
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhJEON6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbhJEONv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:13:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54944C061749;
        Tue,  5 Oct 2021 07:12:00 -0700 (PDT)
Date:   Tue, 05 Oct 2021 14:11:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443119;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MO4ONO4/LvRT6SbTELfO2gK+gVyae+STqHWpSU6IN5E=;
        b=yBDHtQ01zPMfvmLL/R+4pr6HvHF7guYPuygT/sJyyO+KD2wbqVjYOWLBjr8dtTf3GpO/ar
        8ttufmhVLRXN6HeY0d7jVylpGeiJ3nltkyoc0yJeALJwpFWJa1fBqD08n9b+TdU3oXr1pm
        Wq09RNYBgBU6ZBEGXQieAUanYwJL69htn7vOwLDCu2zsB8bn1gCheMqKdY4Ujy4Fkch6pf
        8C2agUa6G27zhZXYHUrG2ZG7WTvtCWBt479k5J/PjoKm9ryqLU34f8CAZsgiEAam3p8zNM
        eNoQ6eAvQ9XzPOcG2G2LxnEas6F2S6oIr9XwS0c2vt99Ki1fhUxz1+eJ38dKsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443119;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MO4ONO4/LvRT6SbTELfO2gK+gVyae+STqHWpSU6IN5E=;
        b=zoBz6Zc2W6IBRfzkksPV6dvRehdPx6XumVtCsxN+9Fm3uN776elCD+21y8gqUo5c4Q1S+a
        SVEnX9PHiZMFyNDQ==
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
Message-ID: <163344311816.25758.1473259863674435692.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     691925f3ddccea832cf2d162dc277d2623a816e3
Gitweb:        https://git.kernel.org/tip/691925f3ddccea832cf2d162dc277d2623a816e3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 28 Sep 2021 14:24:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:52:11 +02:00

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
index 9eaeba6..749284f 100644
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
