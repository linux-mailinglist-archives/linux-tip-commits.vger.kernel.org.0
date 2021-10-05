Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D0B422A59
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbhJEOOA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:14:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51238 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbhJEONy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:13:54 -0400
Date:   Tue, 05 Oct 2021 14:12:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443122;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjw5LlBy+Xiql3NGjLFc0yu+wIQnvu+FRE2jLZRbsso=;
        b=xr38VHEYJPz3LLdfgGJqe2+D9HUpw4OTMXOnOLPqicsyNYapGvN25uVcqI2NNbxHm6tdK0
        sy5fmOJwkzkM4cDA8yotdfdTpxlTyLbaV117c8VMHneO8B8spZxlP90zH8U25frWrutp8p
        Jvd9ZzNLyz7jeEKLFQ/FIjHcSJRViqzdoeW4fUVq3hb+RYz/q2zYYLzWLgMG98W7UtUKEH
        kt68CFy+wPz8ik3bUi5NSGob4EiPjj957LYLKiDt8g+1o8j+iS8XEo/HxRU8rgqhBacfSy
        0tlJLhduAiQ6TK7Mwps01mt+Bv0+4GOzR8qApXV6+/k/tpKx+PrDl4O/G0fhVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443122;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjw5LlBy+Xiql3NGjLFc0yu+wIQnvu+FRE2jLZRbsso=;
        b=qR16D3/ctoD+EMXG4bcuh36OOeMg32N1D1Ynl8BOX9VPVKAeJ0z1+vxIN6Z80siKFwZS9W
        YlrWU8RIP9OsJgBw==
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
Message-ID: <163344312196.25758.5256572606366909232.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6025643596895695956c27119c6b0bfa40d8035b
Gitweb:        https://git.kernel.org/tip/6025643596895695956c27119c6b0bfa40d8035b
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Fri, 10 Sep 2021 18:18:16 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:52:02 +02:00

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
index 71b30ef..e050b1d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8631,7 +8631,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	}
 
 	/* Check if dst CPU is idle and preferred to this group */
-	if (env->sd->flags & SD_ASYM_PACKING &&
+	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
 	    env->idle != CPU_NOT_IDLE &&
 	    sgs->sum_h_nr_running &&
 	    sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
