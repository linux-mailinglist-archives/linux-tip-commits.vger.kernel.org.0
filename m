Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B686C399F74
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jun 2021 13:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhFCLFe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Jun 2021 07:05:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45864 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFCLFd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Jun 2021 07:05:33 -0400
Date:   Thu, 03 Jun 2021 11:03:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622718228;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pSoMEDGIPmsY+/ZdZ3O/svOoGfxunDIusb/oOZb+vQ=;
        b=ahz2zOkQbRvZch9yxkFcS6JV459dCC2yNsUZbHnvbHjHvytDIrFr1+Gk3dE5MnGjeKVARw
        WAeXwVuc/RoPCO5ptDUT65wWZH6xCojgB617vcnBE+fRVnZeIFZYFfJJq688b8dMuJJZQM
        Ll/CN6n9MT1+QfkoB9OJpufpJOxwiKqE80y1PUoeNXq6QOa9KqlcE/dSrzO7EzBdKho9Tn
        cmqWrGQ+Br/ENkaMS1xsBHD6gaJFDuiqCMk7mqHgbFsc8BuyBvs1Z9QvO1G/RsQGBi8I9H
        o4R1D+K2DHNt2meB4sHAAdL70KFfnX8clMP8CghS7MjfeUKiPXUz9D90AhtwaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622718228;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pSoMEDGIPmsY+/ZdZ3O/svOoGfxunDIusb/oOZb+vQ=;
        b=53Q9b4c2CiPXTBsXPM11CcAoXeDbbixdnmhfP6uFRMX3cZahvnSaiwZxs4IwofBWvYsfOV
        mtvXI0Zy7FaF1XBQ==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/pelt: Ensure that *_sum is always synced with *_avg
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210601085832.12626-1-vincent.guittot@linaro.org>
References: <20210601085832.12626-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <162271822738.29796.10300371462032063368.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     fcf6631f3736985ec89bdd76392d3c7bfb60119f
Gitweb:        https://git.kernel.org/tip/fcf6631f3736985ec89bdd76392d3c7bfb60119f
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 01 Jun 2021 10:58:32 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Jun 2021 12:55:55 +02:00

sched/pelt: Ensure that *_sum is always synced with *_avg

Rounding in PELT calculation happening when entities are attached/detached
of a cfs_rq can result into situations where util/runnable_avg is not null
but util/runnable_sum is. This is normally not possible so we need to
ensure that util/runnable_sum stays synced with util/runnable_avg.

detach_entity_load_avg() is the last place where we don't sync
util/runnable_sum with util/runnbale_avg when moving some sched_entities

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210601085832.12626-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e7c8277..7b98fb3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3765,11 +3765,17 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
  */
 static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	/*
+	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
+	 * See ___update_load_avg() for details.
+	 */
+	u32 divider = get_pelt_divider(&cfs_rq->avg);
+
 	dequeue_load_avg(cfs_rq, se);
 	sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
-	sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
+	cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * divider;
 	sub_positive(&cfs_rq->avg.runnable_avg, se->avg.runnable_avg);
-	sub_positive(&cfs_rq->avg.runnable_sum, se->avg.runnable_sum);
+	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * divider;
 
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
