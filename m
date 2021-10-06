Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3839C4239D2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Oct 2021 10:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbhJFIgF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 6 Oct 2021 04:36:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56800 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237543AbhJFIgE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 6 Oct 2021 04:36:04 -0400
Date:   Wed, 06 Oct 2021 08:34:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633509251;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oVi+lpnpsrEDEqMdnl3rHrC/2waG/Ksk5IfPk2Ukxys=;
        b=mvj1eL+0cuyOS6ZJQvTeXPeGWqRu8FD/K/IWMvysEk3OVgpW7VN/xJB95GAuN6KfvyXsHm
        POdRgpVz0UAITIoVuRLx3qujWCRJoysnhk2GZqxBOEn3yKo1RGsu6XCoNM8HfImL5y54nW
        8Tvc0HWiqAIGLbxY5IIY2WabYotqxhYOMx9/hfyq6/OWSxtSYUMkAQi6izY3HH8GloVgOO
        Lyss77To9/TGB8y7sseiwNOELgbx+IrYyQz03Fj05Btj/XkhRidAbVUvYxtlj1VnlxR3Rl
        YlyUYHDrtC8P3WTdwjbTk4f0bdTuXJR2WzUE4zanNOzqYKLlEGO5+TL6xm1Qcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633509251;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oVi+lpnpsrEDEqMdnl3rHrC/2waG/Ksk5IfPk2Ukxys=;
        b=m4nguNnDpepW0JvZ9z6IlZG03hZZIKqOkgQSvDpVH+kM6Dr7srLWkcJQsDZ5/PKgDS6bOl
        zqdq/oWB5ismdCCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix DEBUG && !SCHEDSTATS warn
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <163350925087.25758.549028012827953790.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     769fdf83df57b373660343ef4270b3ada91ef434
Gitweb:        https://git.kernel.org/tip/769fdf83df57b373660343ef4270b3ada91ef434
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 06 Oct 2021 10:12:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 06 Oct 2021 10:30:57 +02:00

sched: Fix DEBUG && !SCHEDSTATS warn

When !SCHEDSTATS schedstat_enabled() is an unconditional 0 and the
whole block doesn't exist, however GCC figures the scoped variable
'stats' is unused and complains about it.

Upgrade the warning from -Wunused-variable to -Wunused-but-set-variable
by writing it in two statements. This fixes the build because the new
warning is in W=1.

Given that whole if(0) {} thing, I don't feel motivated to change
things overly much and quite strongly feel this is the compiler being
daft.

Fixes: cb3e971c435d ("sched: Make struct sched_statistics independent of fair sched class")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 26fac5e..7dcbaa3 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -463,7 +463,8 @@ static void print_cfs_group_stats(struct seq_file *m, int cpu, struct task_group
 	PN(se->sum_exec_runtime);
 
 	if (schedstat_enabled()) {
-               struct sched_statistics *stats =  __schedstats_from_se(se);
+		struct sched_statistics *stats;
+		stats = __schedstats_from_se(se);
 
 		PN_SCHEDSTAT(wait_start);
 		PN_SCHEDSTAT(sleep_start);
