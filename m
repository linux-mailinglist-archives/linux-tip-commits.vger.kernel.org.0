Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559D8404917
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Sep 2021 13:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhIILTm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Sep 2021 07:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbhIILTi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Sep 2021 07:19:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02FDC061575;
        Thu,  9 Sep 2021 04:18:28 -0700 (PDT)
Date:   Thu, 09 Sep 2021 11:18:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631186307;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WbYZBOLYppd4RViqwb2ZQ+/T98pvJqsorn1eVX3FCzs=;
        b=0JP3z42VWwWj7BEI1hyIEp+27tmgOqZ72KF/LDqVwU5gsI7O/TJpjvP5//AiWesBCysTpe
        9Hrw969pp/OL8tDeRT/MJpQ1+skhEN5smQVo1Cm38CZmFDqsdB8ITA7+BXg6JE7gPX2VfZ
        rHjLcyyiwN1v1HVbMDiIx+tB+8kRoVVjaFCVHLpjSTdZMtzarTjyfO1N5gMq4S6PG9G98U
        YswR+aA1OrRv9HFxaSZ8TajL2pJ6zH443xGPlBVkaZJD6CdjwZIesDowjzdGBFmMl/x+cL
        4NeUo4VLd6pbb7+ptGHvcsQrqU8cuFCNC/dGADN2wolNVvsdUPB2a6N+0LIiiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631186307;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WbYZBOLYppd4RViqwb2ZQ+/T98pvJqsorn1eVX3FCzs=;
        b=EjNNN/8iDEZr86AZmabhqzgo8l7FuTzK681nxgkySPIXfcePrRHfuH0Q3POmh+aNjDzXmM
        4rgkiQcAVQHIJsDQ==
From:   "tip-bot2 for Josh Don" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: adjust sleeper credit for SCHED_IDLE entities
Cc:     Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jiang Biao <benbjiang@tencent.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210820010403.946838-5-joshdon@google.com>
References: <20210820010403.946838-5-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <163118630675.25758.7642437893126433247.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     bb1fc3bc521782d018902143c8301ab4a5e53557
Gitweb:        https://git.kernel.org/tip/bb1fc3bc521782d018902143c8301ab4a5e53557
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Thu, 19 Aug 2021 18:04:03 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 09 Sep 2021 11:27:31 +02:00

sched: adjust sleeper credit for SCHED_IDLE entities

Give reduced sleeper credit to SCHED_IDLE entities. As a result, woken
SCHED_IDLE entities will take longer to preempt normal entities.

The benefit of this change is to make it less likely that a newly woken
SCHED_IDLE entity will preempt a short-running normal entity before it
blocks.

We still give a small sleeper credit to SCHED_IDLE entities, so that
idle<->idle competition retains some fairness.

Example: With HZ=1000, spawned four threads affined to one cpu, one of
which was set to SCHED_IDLE. Without this patch, wakeup latency for the
SCHED_IDLE thread was ~1-2ms, with the patch the wakeup latency was
~5ms.

Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Jiang Biao <benbjiang@tencent.com>
Link: https://lore.kernel.org/r/20210820010403.946838-5-joshdon@google.com
---
 kernel/sched/fair.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7330a77..b27ed8b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4201,7 +4201,12 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 
 	/* sleeps up to a single latency don't count. */
 	if (!initial) {
-		unsigned long thresh = sysctl_sched_latency;
+		unsigned long thresh;
+
+		if (se_is_idle(se))
+			thresh = sysctl_sched_min_granularity;
+		else
+			thresh = sysctl_sched_latency;
 
 		/*
 		 * Halve their sleep time's effect, to allow
