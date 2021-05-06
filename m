Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FA8375515
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 May 2021 15:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhEFNt3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 May 2021 09:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbhEFNt0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 May 2021 09:49:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E6CC061574;
        Thu,  6 May 2021 06:48:28 -0700 (PDT)
Date:   Thu, 06 May 2021 13:48:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620308907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sxciWrMvRq1CnLH9X/yYQ4n/TDh4W/JKOparflwfy5E=;
        b=s6IdjsrFPm1mkeEFV8lTGZLRic0Togj85Z9rDgsp5sWK3snloUyya3zdvuFN2fqiPPcKiF
        g8++YgaD65aaj5JOLEaDQHRgwre/3tHLBXL6hIY5T9EMFGKFlwebclZY7bbG8H/JZEZILf
        Ng4fKYUmFLKonMjSx8dE3XhB332IOmMJoJDdYWATWTdwt3Iuk7SgRNlPOy3wdmbQwPZFkN
        cBJhi/yD8yfhPm6HK6VulzVP0GtQVSe7w8bo7CmpNs941PTiSfShL8xxFeqKj5hr7V/1o2
        Uvnev8yqui4tgwFg8Zz8H5r6uxMbrCjEGqPHj1bFSvt3Mt/bKxHg9QoH0LPh0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620308907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sxciWrMvRq1CnLH9X/yYQ4n/TDh4W/JKOparflwfy5E=;
        b=fnhPqw0D2RlQVkARg/klM3Ym7U7UT3sbx6ZZM4H+SiTtYLOVYYEMKrbb7MU5ujfZKUOjZ1
        Tnw+yWY64aZXrnAQ==
From:   "tip-bot2 for Quentin Perret" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix out-of-bound access in uclamp
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210430151412.160913-1-qperret@google.com>
References: <20210430151412.160913-1-qperret@google.com>
MIME-Version: 1.0
Message-ID: <162030890653.29796.8999602906883083626.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     6d2f8909a5fabb73fe2a63918117943986c39b6c
Gitweb:        https://git.kernel.org/tip/6d2f8909a5fabb73fe2a63918117943986c39b6c
Author:        Quentin Perret <qperret@google.com>
AuthorDate:    Fri, 30 Apr 2021 15:14:12 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 06 May 2021 15:33:26 +02:00

sched: Fix out-of-bound access in uclamp

Util-clamp places tasks in different buckets based on their clamp values
for performance reasons. However, the size of buckets is currently
computed using a rounding division, which can lead to an off-by-one
error in some configurations.

For instance, with 20 buckets, the bucket size will be 1024/20=51. A
task with a clamp of 1024 will be mapped to bucket id 1024/51=20. Sadly,
correct indexes are in range [0,19], hence leading to an out of bound
memory access.

Clamp the bucket id to fix the issue.

Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
Suggested-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lkml.kernel.org/r/20210430151412.160913-1-qperret@google.com
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9143163..5226cc2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -938,7 +938,7 @@ DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
 
 static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
 {
-	return clamp_value / UCLAMP_BUCKET_DELTA;
+	return min_t(unsigned int, clamp_value / UCLAMP_BUCKET_DELTA, UCLAMP_BUCKETS - 1);
 }
 
 static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
