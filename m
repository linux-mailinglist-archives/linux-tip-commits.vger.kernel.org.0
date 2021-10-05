Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0C6422A78
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbhJEOOm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbhJEOOI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:14:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCCDC061794;
        Tue,  5 Oct 2021 07:12:15 -0700 (PDT)
Date:   Tue, 05 Oct 2021 14:12:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+KkUewm5Vuy2HVgDvqZBxFySJ4Pd+yGWAR2vs2QsjLc=;
        b=zSJJXGSiPggOb6hu5tG0HfGvhtiLNAY9m/W5GGrTfPtKp3qds6xsTYnvWXn7Sgu51hzCai
        v6BC6i3lVZtrMk3rpVorJZpgaZ+XCwqICGv2i/rum8IwtyOvbt2MEycJoLMmsvAe8X09Sm
        GVpIcByNobZqQ/Hrh3gjiJ1yljAKyXuWMWDWCQhk4AA6PxXXcd2+4cXvzUJQ9YK7/kbe+2
        wS8HicF7y9+yFUCSpb//UQnHl7CAR6CUn/N6xIRiNPad6F1N9R3I+EI9YF6S21K61ajlvZ
        u2SbWV41UJxpNkN711bLOWKPwydyNilEXTiKYk7XZyTr1zfohJAklm6/eRmjcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+KkUewm5Vuy2HVgDvqZBxFySJ4Pd+yGWAR2vs2QsjLc=;
        b=BxU7BBZRAjEse2HHGtVZUpDheYbA75XJ6KnDtnZOpCnB5y0QrGfr23O5zARkc6T7fkkqP4
        a5mAnoCMcs2QEqAg==
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
Message-ID: <163344313292.25758.13469550980550076038.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2cae3948edd488ebdef4deaf1d1043f92f47e665
Gitweb:        https://git.kernel.org/tip/2cae3948edd488ebdef4deaf1d1043f92f47e665
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Thu, 19 Aug 2021 18:04:03 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:51:39 +02:00

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
index d835061..5457c80 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4230,7 +4230,12 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 
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
