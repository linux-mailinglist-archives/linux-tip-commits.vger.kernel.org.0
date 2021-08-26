Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37353F8CB5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 19:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhHZRIi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 13:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhHZRIh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 13:08:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE31C061757;
        Thu, 26 Aug 2021 10:07:50 -0700 (PDT)
Date:   Thu, 26 Aug 2021 17:07:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629997666;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eLAv6LYW78MokONVcjZKx/Uxo+7iqbxuyr+edxCR5Yg=;
        b=c3IYZvasz7yc/NWUxL4b4NAdDYO5I5cXyRY2O/KDVxN4UoD+qIZVILiaZ9iBukGB+XZw73
        /CTx66383NdER+G23yR37PIheNJ3Dzmk1dptNqjU8uSoRTqaRWrp0EIUulz39euJwyb5CX
        pj9lm8+sdWqP1kA/MihTAUuAytSe+MyBGDQliGz8Of7NPG3sycTEB1vQVRdJQpkiyCYUf5
        ACqEg5RbK9Er1g+3kIbIcwSQ0lumI17zQwwkHQgDs3wqDI2QE8nRscMh9n+M9a+Dx+r0o9
        5i8IGSIiv83oCQI2kMUsEQm/7r8XYx9b+1wFbSIQ3iN+HAXoojS0uTjwi/FsoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629997666;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eLAv6LYW78MokONVcjZKx/Uxo+7iqbxuyr+edxCR5Yg=;
        b=yG9eALEXOPUTPAcTUtsBRQ2RcUzMAWidQVhSA7QJ73/32FxZvm5mGaWYd46OR25gEwID0H
        l2PDPJaaCzIWc5Bg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix get_push_task() vs migrate_disable()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210826133738.yiotqbtdaxzjsnfj@linutronix.de>
References: <20210826133738.yiotqbtdaxzjsnfj@linutronix.de>
MIME-Version: 1.0
Message-ID: <162999766586.25758.3269412583101742484.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     e681dcbaa4b284454fecd09617f8b24231448446
Gitweb:        https://git.kernel.org/tip/e681dcbaa4b284454fecd09617f8b24231448446
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 26 Aug 2021 15:37:38 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 26 Aug 2021 19:02:00 +02:00

sched: Fix get_push_task() vs migrate_disable()

push_rt_task() attempts to move the currently running task away if the
next runnable task has migration disabled and therefore is pinned on the
current CPU.

The current task is retrieved via get_push_task() which only checks for
nr_cpus_allowed == 1, but does not check whether the task has migration
disabled and therefore cannot be moved either. The consequence is a
pointless invocation of the migration thread which correctly observes
that the task cannot be moved.

Return NULL if the task has migration disabled and cannot be moved to
another CPU.

Fixes: a7c81556ec4d3 ("sched: Fix migrate_disable() vs rt/dl balancing")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210826133738.yiotqbtdaxzjsnfj@linutronix.de
---
 kernel/sched/sched.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index da4295f..ddefb04 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2255,6 +2255,9 @@ static inline struct task_struct *get_push_task(struct rq *rq)
 	if (p->nr_cpus_allowed == 1)
 		return NULL;
 
+	if (p->migration_disabled)
+		return NULL;
+
 	rq->push_busy = true;
 	return get_task_struct(p);
 }
