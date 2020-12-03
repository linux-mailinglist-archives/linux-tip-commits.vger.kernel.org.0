Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF532CD23C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 10:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgLCJOD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 04:14:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39472 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgLCJOC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 04:14:02 -0500
Date:   Thu, 03 Dec 2020 09:13:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606986800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=132nFXVQJMUd8IdpyU75XD6LEF8LrlNQoNesc2KuiMw=;
        b=syEOw0oL181o0izYOaOdkdQA6xlI0aX2+bs7uKK3w1kLQk6Gxg3B3FR/N5uoaxVowcewtx
        zZAME4cHcQ46TxgvMtTrMRph4L8jKbXXSSd7B34GFieExufCIgOwsAlm6q7ae4MKxLCEtP
        cCH/Xe+cPgKobLOp7K0QJYeyB1O2TRFN3gcyqRz5r6l7d19LVbGXkIvrAVpacvXolKDeWJ
        olhN8KmpdHY12u3gZBYjBgX9lmU1VKGxN2VUw8U68XO9zCoWOPKFOXAYbwqaaS+AnTGLbb
        LR2iHgITGtqAH83jhYY84cq6ALpjM3t/1dbTbkm+TArpi+1jcLrLxvbx6s8iVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606986800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=132nFXVQJMUd8IdpyU75XD6LEF8LrlNQoNesc2KuiMw=;
        b=vWqgXKDQyd/qWcvX+PptreUXItEer2AtVvNTaziG6Cm9zmqKoZoYBGH2SjQmeyabNJh0Rh
        P2TMQCLKVOizoqBQ==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Clear SMT siblings after determining
 the core is not idle
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201130144020.GS3371@techsingularity.net>
References: <20201130144020.GS3371@techsingularity.net>
MIME-Version: 1.0
Message-ID: <160698680023.3364.529165199604253383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     82b738de57d571cd366d89e75b5fd60f3060852b
Gitweb:        https://git.kernel.org/tip/82b738de57d571cd366d89e75b5fd60f3060852b
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Mon, 30 Nov 2020 14:40:20 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 10:00:36 +01:00

sched/fair: Clear SMT siblings after determining the core is not idle

The clearing of SMT siblings from the SIS mask before checking for an idle
core is a small but unnecessary cost. Defer the clearing of the siblings
until the scan moves to the next potential target. The cost of this was
not measured as it is borderline noise but it should be self-evident.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20201130144020.GS3371@techsingularity.net
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f5dceda..efac224 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6086,10 +6086,11 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int 
 				break;
 			}
 		}
-		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 
 		if (idle)
 			return core;
+
+		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 	}
 
 	/*
