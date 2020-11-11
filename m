Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0572AEB37
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgKKIZS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:25:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36242 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKIXS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:18 -0500
Date:   Wed, 11 Nov 2020 08:23:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605082996;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CmUOAzd/LeEYd+KOnMpvs/VAGk9M9APMi0iAuTcP/Eg=;
        b=GaKczrZ8wG3VF7+wZjIUc5Nv4xy3zQl+OiOWWI2DbooY61wkYP/hJtf4qh/XTgRVBppllH
        f9ej0GZdKxm/ZpkAQmM93aoRQGRUB73jgoMCtFBlwM0uPqs4y5My1QcbT7Pz9p+C3JJMCa
        RON6Dt3YRLiwWFZS5yk7539VvpA5sp0fKlKnqCd4LONR+6N3dYjC6qp78aoghcqg0yCDA3
        T2hjbBjy2Mjlg2mCGflOXCHaD3ugXXghB3a02hbCU/JB5CvUzXhnfLS/v/krEA1DbAmXxY
        2NZ9bAQ1YMBtWuM8xbzJoRfIdGxFgmXC5CFaozDHBEGZYAA9QOn9JvF4RatD4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605082996;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CmUOAzd/LeEYd+KOnMpvs/VAGk9M9APMi0iAuTcP/Eg=;
        b=q8fTu8ad/Zuew/yYmSJXuYrvHo5115ci2oDroMlj27UV2Icujj5/p6vQmSVuvT6v1seuqK
        FZM/FCF01MzCJHCQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Deny self-issued __set_cpus_allowed_ptr()
 when migrate_disable()
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201013140116.26651-1-valentin.schneider@arm.com>
References: <20201013140116.26651-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <160508299532.11244.16920106537072261900.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     885b3ba47aa5cc16550beb8a42181ad5e8302ceb
Gitweb:        https://git.kernel.org/tip/885b3ba47aa5cc16550beb8a42181ad5e8302ceb
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 13 Oct 2020 15:01:15 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:39:02 +01:00

sched: Deny self-issued __set_cpus_allowed_ptr() when migrate_disable()

  migrate_disable();
  set_cpus_allowed_ptr(current, {something excluding task_cpu(current)});
  affine_move_task(); <-- never returns

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201013140116.26651-1-valentin.schneider@arm.com
---
 kernel/sched/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e92d785..88c6fcb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2238,8 +2238,17 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		goto out;
 	}
 
-	if (!(flags & SCA_MIGRATE_ENABLE) && cpumask_equal(&p->cpus_mask, new_mask))
-		goto out;
+	if (!(flags & SCA_MIGRATE_ENABLE)) {
+		if (cpumask_equal(&p->cpus_mask, new_mask))
+			goto out;
+
+		if (WARN_ON_ONCE(p == current &&
+				 is_migration_disabled(p) &&
+				 !cpumask_test_cpu(task_cpu(p), new_mask))) {
+			ret = -EBUSY;
+			goto out;
+		}
+	}
 
 	/*
 	 * Picking a ~random cpu helps in cases where we are changing affinity
