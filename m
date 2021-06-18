Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094C13AC671
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 10:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhFRIsW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 04:48:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54120 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbhFRIsS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 04:48:18 -0400
Date:   Fri, 18 Jun 2021 08:46:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624005968;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k6uPhUqy+eKUapq1oNgY80IMx1sPkSy9lrTqRk3VuGk=;
        b=w8Cidfnys1yKq3uBKMQOoBjoM5NLGcZW8y8o57etEDJa9fPO3WJG89EETK5bg31eZYHEjT
        geoqWwO7mv4SCukuuoNISyBL9lBJq+aWWSZrTgLXzRO6fC/wGs66r5XLj0Vr7uYf5DI7eR
        Op85TmXZsbpHAPujs68+tSjczTIs+ZYgjM9wtgEc1llsqb5FTAYQJHeqXE1QMPqloIAdKe
        Z/NOKPngulyfWm5MlkvubFnjOrDO3sY0+TZfDPxpG0Lh9JoVTXCFXqE9dfKpXcGJYu9w3A
        jmEMuGpe5wKIKOTMBN9GhVShasrG4b+i4c45EdvfQa41Lg6vfc7fBCCJH3/KQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624005968;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k6uPhUqy+eKUapq1oNgY80IMx1sPkSy9lrTqRk3VuGk=;
        b=7xqdPuB45AynWcp4yTONxBXCGG64R8ShisG43LF8Rqlr9VzwvXcrVm0j1WA2ZiIzpu7XTz
        lnKP4GjwAmNuDwBg==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/pelt: Check that *_avg are null when *_sum are
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Odin Ugedal <odin@uged.al>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210601155328.19487-1-vincent.guittot@linaro.org>
References: <20210601155328.19487-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <162400596764.19906.16000251209838889232.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9e077b52d86ac364a295b05c916c7478a16865b2
Gitweb:        https://git.kernel.org/tip/9e077b52d86ac364a295b05c916c7478a16865b2
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 01 Jun 2021 17:53:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 17 Jun 2021 14:11:42 +02:00

sched/pelt: Check that *_avg are null when *_sum are

Check that we never break the rule that pelt's avg values are null if
pelt's sum are.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Odin Ugedal <odin@uged.al>
Link: https://lore.kernel.org/r/20210601155328.19487-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ce625bf..198514d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8026,6 +8026,15 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (cfs_rq->avg.runnable_sum)
 		return false;
 
+	/*
+	 * _avg must be null when _sum are null because _avg = _sum / divider
+	 * Make sure that rounding and/or propagation of PELT values never
+	 * break this.
+	 */
+	SCHED_WARN_ON(cfs_rq->avg.load_avg ||
+		      cfs_rq->avg.util_avg ||
+		      cfs_rq->avg.runnable_avg);
+
 	return true;
 }
 
