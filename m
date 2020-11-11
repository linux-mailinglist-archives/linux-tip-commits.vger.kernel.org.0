Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829392AEB3D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgKKIZZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgKKIXQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C2BC0613D1;
        Wed, 11 Nov 2020 00:23:16 -0800 (PST)
Date:   Wed, 11 Nov 2020 08:23:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605082994;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RJdRSrbGS76RobRMblsCZCS6os8yklkIu25yn/sr2jA=;
        b=ILl2Uw7LFf1XgsUkQXlyBL+QWfU2FaV5Bt1tRbpEb9uLcT4J6lUh/VINatkQ80MFCTrBXW
        AW1vuAFJkuOpGCLLSS4Yzd2yLfOuPFT3x0YdaPujuqWez+gHPpLBN+Ye9hC1u7gfoxWKQX
        UAHP95q/ILlNA5UMIySXQ3tTpQg3RzNA77GhrqPFE2TuNW0oZgzznoAWvfNPtwB4xbe2En
        4MniMbrMibfuazB9DTx1woAVqOPysJtA7cAEHQSriMX5WBbamAAdIPstu/5nq6wOzkRtyD
        KrCZApBudgBUcGgpBRc9u6j+GPCMdDetD+mD2AdhRre8zuffc8SlHrMkBLRzAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605082994;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RJdRSrbGS76RobRMblsCZCS6os8yklkIu25yn/sr2jA=;
        b=5Qn3x79uPI4vLUvwukCFx9PPx9xRVyr8TgXH1kvd3uUWKZxBDhWTcODrCMK8V5eIY/D0h6
        zeoxcT8etO6v16Ag==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add WF_TTWU, WF_EXEC wakeup flags
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201102184514.2733-2-valentin.schneider@arm.com>
References: <20201102184514.2733-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <160508299362.11244.3308131020454587854.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     17770579059258c5f1eef759e941af5f1a54f482
Gitweb:        https://git.kernel.org/tip/17770579059258c5f1eef759e941af5f1a54f482
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 02 Nov 2020 18:45:12 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:39:06 +01:00

sched: Add WF_TTWU, WF_EXEC wakeup flags

To remove the sd_flag parameter of select_task_rq(), we need another way of
encoding wakeup types. There already is a WF_FORK flag, add the missing two.

With that said, we still need an easy way to turn WF_foo into
SD_bar (e.g. WF_TTWU into SD_BALANCE_WAKE). As suggested by Peter, let's
make our lives easier and make them match exactly, and throw in some
compile-time checks for good measure.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201102184514.2733-2-valentin.schneider@arm.com
---
 kernel/sched/sched.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e897d77..4725873 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1744,13 +1744,20 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 	return READ_ONCE(p->on_rq) == TASK_ON_RQ_MIGRATING;
 }
 
-/*
- * wake flags
- */
-#define WF_SYNC			0x01		/* Waker goes to sleep after wakeup */
-#define WF_FORK			0x02		/* Child wakeup after fork */
-#define WF_MIGRATED		0x04		/* Internal use, task got migrated */
-#define WF_ON_CPU		0x08		/* Wakee is on_cpu */
+/* Wake flags. The first three directly map to some SD flag value */
+#define WF_EXEC     0x02 /* Wakeup after exec; maps to SD_BALANCE_EXEC */
+#define WF_FORK     0x04 /* Wakeup after fork; maps to SD_BALANCE_FORK */
+#define WF_TTWU     0x08 /* Wakeup;            maps to SD_BALANCE_WAKE */
+
+#define WF_SYNC     0x10 /* Waker goes to sleep after wakeup */
+#define WF_MIGRATED 0x20 /* Internal use, task got migrated */
+#define WF_ON_CPU   0x40 /* Wakee is on_cpu */
+
+#ifdef CONFIG_SMP
+static_assert(WF_EXEC == SD_BALANCE_EXEC);
+static_assert(WF_FORK == SD_BALANCE_FORK);
+static_assert(WF_TTWU == SD_BALANCE_WAKE);
+#endif
 
 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution
