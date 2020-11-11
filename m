Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356582AEB1F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgKKIXY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:23:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36254 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgKKIXS (ORCPT
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
        bh=VX4PAJsPvqT70kPqw10nw9m39Ci/83tM6xn3Y0idueQ=;
        b=mLqCQjphvPq3WS9jhuqiYGct5P/Nys2hK/K53ZHOcYRGCxSltCcziBjIrBHEV+82szjMzg
        oS9G1dFqVfggTKpzyG21nemrfEqm0qvCk/9EUVQxm0ISrJTGCQOntxBNd6DINlKA4obUYe
        UtDu/xaARf582mwNhd69N6YG/uUcxb8ena7LSpDEXcEvRCSstoqVNeS1NxKKCDY944OP/i
        Y6d9XdnWpsSDMyNwtBtraDkiidGdtXePo7sVH0UvQjoxFCZbYYbP737OHurR1WtLhCv/yS
        mEbG9MjkIBrIIvCgcA4N4Q+xzhwJRAktsI4Ysk25yHxS7Mj9UtmDCL6oE76FpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605082996;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VX4PAJsPvqT70kPqw10nw9m39Ci/83tM6xn3Y0idueQ=;
        b=x3+QM/Y0YpMk0mTCZe6MKMncYMjoGraMYz26doElRv+yBZcxqKcVje0sXXpfQcVKacnZ2W
        Lm0YHXPBtX0uu+AA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/proc: Print accurate cpumask vs migrate_disable()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201023102347.593984734@infradead.org>
References: <20201023102347.593984734@infradead.org>
MIME-Version: 1.0
Message-ID: <160508299588.11244.10650495223094189437.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     86fbcd3b4ba2c3e19daf705bc13d90fb53aab648
Gitweb:        https://git.kernel.org/tip/86fbcd3b4ba2c3e19daf705bc13d90fb53aab648
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 05 Oct 2020 12:49:16 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:39:01 +01:00

sched/proc: Print accurate cpumask vs migrate_disable()

Ensure /proc/*/status doesn't print 'random' cpumasks due to
migrate_disable().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lkml.kernel.org/r/20201023102347.593984734@infradead.org
---
 fs/proc/array.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 65ec202..7052441 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -382,9 +382,9 @@ static inline void task_context_switch_counts(struct seq_file *m,
 static void task_cpus_allowed(struct seq_file *m, struct task_struct *task)
 {
 	seq_printf(m, "Cpus_allowed:\t%*pb\n",
-		   cpumask_pr_args(task->cpus_ptr));
+		   cpumask_pr_args(&task->cpus_mask));
 	seq_printf(m, "Cpus_allowed_list:\t%*pbl\n",
-		   cpumask_pr_args(task->cpus_ptr));
+		   cpumask_pr_args(&task->cpus_mask));
 }
 
 static inline void task_core_dumping(struct seq_file *m, struct mm_struct *mm)
