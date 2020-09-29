Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F1F27BE8A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Sep 2020 09:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbgI2H5E (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Sep 2020 03:57:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44408 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbgI2H4w (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Sep 2020 03:56:52 -0400
Date:   Tue, 29 Sep 2020 07:56:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601366210;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EeB9bOENKeP52AlMH1PRmkkTBbYlI3ckFIEfrajbQ8o=;
        b=HZPegXiiVuMC6eFd4nIXeZ2hS9L8SEI2ZH0gLSQhRNXVNWyYJilQcCLz52ieXWvaxqUkBd
        gXfhuELNGnQzOfVY42nsgHiVZc4CLX/rHhxPXDKCsyX/plmf9XEEDwK1p7hk1T1hnkW/f5
        5HVHslWJmLnzqlwma9+ym9o8lI1mK2kv8eTnwKFoe51/WKNXwJXWHHGA9vrgQjeIhgj8Zq
        zGiPQ+0SHlvP7P9aMctvsPcjSrc8OzShpVSIQXuhMkRsabQo4bMReR5vLB607zKij85LQl
        Y46Xa94m0FazPBpQvixCoaijM+GuQ22YuuplTru1St8C2ptSqP0ZBSslb3w9sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601366210;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EeB9bOENKeP52AlMH1PRmkkTBbYlI3ckFIEfrajbQ8o=;
        b=irpJBQ91OvtGnR2smDNoBffys1bTKpdfTkHXeGoDwmFM/39e/qQRhCNCOL8DaS6Iji5VV5
        mQxgz76H+KgOxFAA==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Reduce minimal imbalance threshold
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200921072424.14813-3-vincent.guittot@linaro.org>
References: <20200921072424.14813-3-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <160136620949.7002.18026460832388099077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2208cdaa56c957e20d8e16f28819aeb47851cb1e
Gitweb:        https://git.kernel.org/tip/2208cdaa56c957e20d8e16f28819aeb47851cb1e
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 21 Sep 2020 09:24:22 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Sep 2020 14:23:26 +02:00

sched/fair: Reduce minimal imbalance threshold

The 25% default imbalance threshold for DIE and NUMA domain is large
enough to generate significant unfairness between threads. A typical
example is the case of 11 threads running on 2x4 CPUs. The imbalance of
20% between the 2 groups of 4 cores is just low enough to not trigger
the load balance between the 2 groups. We will have always the same 6
threads on one group of 4 CPUs and the other 5 threads on the other
group of CPUS. With a fair time sharing in each group, we ends up with
+20% running time for the group of 5 threads.

Consider decreasing the imbalance threshold for overloaded case where we
use the load to balance task and to ensure fair time sharing.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Acked-by: Hillf Danton <hdanton@sina.com>
Link: https://lkml.kernel.org/r/20200921072424.14813-3-vincent.guittot@linaro.org
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 249bec7..41df628 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1349,7 +1349,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		.min_interval		= sd_weight,
 		.max_interval		= 2*sd_weight,
 		.busy_factor		= 32,
-		.imbalance_pct		= 125,
+		.imbalance_pct		= 117,
 
 		.cache_nice_tries	= 0,
 
