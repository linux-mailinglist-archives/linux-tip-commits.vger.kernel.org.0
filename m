Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902F13AC670
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 10:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhFRIsV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 04:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbhFRIsS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 04:48:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F211C061768;
        Fri, 18 Jun 2021 01:46:09 -0700 (PDT)
Date:   Fri, 18 Jun 2021 08:46:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624005967;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rD+Z/NtBb2ny/Mr7DacuAyqlIsTFeyyxmoKadm6e44o=;
        b=O6CObESUUcwluMNyFXJt4T5Tf2pAU67mRUrsC291gn0bmhfSJHjN6htf3NfE06kmY27wbP
        0ANmw9zqddCdGtwD71qdHbSGXyJMPZIH3Ybae5TUd1Aj4nc1XmN9Av45PRfN7wCzLyU9Ri
        nhjH+51wtGU3M1EO0ITZlPep451ImbZDGrDuxv5lIsYNs2Y0arRZhGEHqwOTU9Ecp5FaW6
        a4FddB8dMjbh4cD8FyIXy1WY+pXdSbG2dr1ZW3NNMrIhOUrRLit0bZF+JNk2iPtivAGW4e
        Ri05DMxsETJZodTyQua6V6V0dvigBXohpRDKRNSxYE/l3yV9nruzbJg1TxctOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624005967;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rD+Z/NtBb2ny/Mr7DacuAyqlIsTFeyyxmoKadm6e44o=;
        b=HuMk5E4co2kHQ+MmYVQQJW3rqZGWDu1lpkWbUPqfRnX4uv/+KsZQpbNclMCwDKKP3wZa2e
        59hfyDl1wl+a5TDw==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Return early from update_tg_cfs_load()
 if delta == 0
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210601083616.804229-1-dietmar.eggemann@arm.com>
References: <20210601083616.804229-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <162400596716.19906.6497557861624006450.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     83c5e9d573e1f0757f324d01adb6ee77b49c3f0e
Gitweb:        https://git.kernel.org/tip/83c5e9d573e1f0757f324d01adb6ee77b49c3f0e
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Tue, 01 Jun 2021 10:36:16 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 17 Jun 2021 14:11:42 +02:00

sched/fair: Return early from update_tg_cfs_load() if delta == 0

In case the _avg delta is 0 there is no need to update se's _avg
(level n) nor cfs_rq's _avg (level n-1). These values stay the same.

Since cfs_rq's _avg isn't changed, i.e. no load is propagated down,
cfs_rq's _sum should stay the same as well.

So bail out after se's _sum has been updated.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20210601083616.804229-1-dietmar.eggemann@arm.com
---
 kernel/sched/fair.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 198514d..06c8ba7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3502,9 +3502,12 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	load_sum = (s64)se_weight(se) * runnable_sum;
 	load_avg = div_s64(load_sum, divider);
 
+	se->avg.load_sum = runnable_sum;
+
 	delta = load_avg - se->avg.load_avg;
+	if (!delta)
+		return;
 
-	se->avg.load_sum = runnable_sum;
 	se->avg.load_avg = load_avg;
 
 	add_positive(&cfs_rq->avg.load_avg, delta);
