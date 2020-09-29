Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43DF27BE98
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Sep 2020 09:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgI2H5a (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Sep 2020 03:57:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44392 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgI2H4v (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Sep 2020 03:56:51 -0400
Date:   Tue, 29 Sep 2020 07:56:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601366209;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZ3w8SsJAKo/o3IlRuPIMbGITx2IBGlQuNzdPw72lYI=;
        b=ZrnaXY54cCQMfSVGy4Hh6XrHzFzGmpcBYMWtpu1xRw37F4+kAPfYol0391PD/nJwSM7eTR
        k4NW3qcUPrAYHxlk5EgV7l2ztFqLZI0PEEV+jBnWsSYXAtHYLP1pVjK8i+AZC5eNH9Aq9Y
        l8uem3MvE/qRQbw1UYqTshFCOZjOzgJGBgvdpp6zptP2oxG0/ayzAgvlYLXFlpSoeKzkpx
        y9v0e8uUPwDeJLbrEKv7xwxuM+knSFf/IL6+4j+8tcWN43U4xCctSapj84/d2ld45XmZR3
        OTNCjEXmGp+3eXpl0VxQZuxU1L92xv/qcfREggQ7nrD4y8TlitUzgWEFEAiGJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601366209;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZ3w8SsJAKo/o3IlRuPIMbGITx2IBGlQuNzdPw72lYI=;
        b=zJ6X3ZyIn2MCYzDmJKXLU1klz78xP9N1R/PvJHUzEm4kGnLbgizMSq+IcqPrfLPfSd2pD9
        02ixmCc6BC2e0QAw==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Reduce busy load balance interval
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200921072424.14813-5-vincent.guittot@linaro.org>
References: <20200921072424.14813-5-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <160136620854.7002.17745483479490087690.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6e7499135db724539ca887b3aa64122502875c71
Gitweb:        https://git.kernel.org/tip/6e7499135db724539ca887b3aa64122502875c71
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 21 Sep 2020 09:24:24 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Sep 2020 14:23:26 +02:00

sched/fair: Reduce busy load balance interval

The busy_factor, which increases load balance interval when a cpu is busy,
is set to 32 by default. This value generates some huge LB interval on
large system like the THX2 made of 2 node x 28 cores x 4 threads.
For such system, the interval increases from 112ms to 3584ms at MC level.
And from 228ms to 7168ms at NUMA level.

Even on smaller system, a lower busy factor has shown improvement on the
fair distribution of the running time so let reduce it for all.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://lkml.kernel.org/r/20200921072424.14813-5-vincent.guittot@linaro.org
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 41df628..a3a2417 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1348,7 +1348,7 @@ sd_init(struct sched_domain_topology_level *tl,
 	*sd = (struct sched_domain){
 		.min_interval		= sd_weight,
 		.max_interval		= 2*sd_weight,
-		.busy_factor		= 32,
+		.busy_factor		= 16,
 		.imbalance_pct		= 117,
 
 		.cache_nice_tries	= 0,
