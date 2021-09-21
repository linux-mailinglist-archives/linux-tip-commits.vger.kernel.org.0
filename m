Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07E5412F60
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 09:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhIUH3X (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Sep 2021 03:29:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46892 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhIUH3W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Sep 2021 03:29:22 -0400
Date:   Tue, 21 Sep 2021 07:27:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632209273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RLXxZ1PAJGQflVJ9unYlD2Sc3zeMhSTk/LbI99+e0Ak=;
        b=f1xx9al90LqdwSbXsIDIsky+dNOA97wXspeeJi57FI+i/6cGlLTNuneX9uTIc0ZFze7hao
        fIO0aikNblNgwQUMjJUAIr/mbas/oItfwveJBtkCBNp4mRQNxaDBvzcNf66hrxbw4p6Sgz
        tHntb2FxozDtMKs4oydQh9MTpFM3x77vdS+MtT6JBABr4Gn+iWicKWLlQaTsIR9cG1dHpu
        mtMl52dDhoemTnUnaXusPt+ZalHwG2yD253hZ06peTuTVzKCjNjbGYJxnv4Qi6v1CvKr+S
        Qw+7dZainhPpLKxCq3rQcip3HnRdTEjejkZI4TpZRINXIXWbNXDdnXEdsKGbKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632209273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RLXxZ1PAJGQflVJ9unYlD2Sc3zeMhSTk/LbI99+e0Ak=;
        b=YzGXps2B+hD1Qz0Apmp7Mu3Kw9XHWKq+4uzXKwHowf1L5O3mT6w6NSQVGC4/OYDy1yNtEz
        K9+VoEoyXAefZSCQ==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Optimize checking for group_asym_packing
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Len Brown <len.brown@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210911011819.12184-4-ricardo.neri-calderon@linux.intel.com>
References: <20210911011819.12184-4-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163220927280.25758.10968958544939883057.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     cb0e4ee938b1a08507ded179cec3a35b4a8d75b8
Gitweb:        https://git.kernel.org/tip/cb0e4ee938b1a08507ded179cec3a35b4a8d75b8
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Fri, 10 Sep 2021 18:18:16 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 18 Sep 2021 12:18:39 +02:00

sched/fair: Optimize checking for group_asym_packing

sched_asmy_prefer() always returns false when called on the local group. By
checking local_group, we can avoid additional checks and invoking
sched_asmy_prefer() when it is not needed. No functional changes are
introduced.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Len Brown <len.brown@intel.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210911011819.12184-4-ricardo.neri-calderon@linux.intel.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e26d622..d85c5a4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8598,7 +8598,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	}
 
 	/* Check if dst CPU is idle and preferred to this group */
-	if (env->sd->flags & SD_ASYM_PACKING &&
+	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
 	    env->idle != CPU_NOT_IDLE &&
 	    sgs->sum_h_nr_running &&
 	    sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
