Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F5A3B5F81
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Jun 2021 15:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhF1OCO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 28 Jun 2021 10:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhF1OAd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 28 Jun 2021 10:00:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDC7C061574;
        Mon, 28 Jun 2021 06:58:07 -0700 (PDT)
Date:   Mon, 28 Jun 2021 13:58:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624888686;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EA49D6jjvfTlGevWpnlR1iszrSoWl6SMVQnnoJ7fGqw=;
        b=UJnMJ2MA7/SKmCq87VvNM1jwi/VKXr79u6gdEc/5C/o3fQqvERmxC5QOAhkhvGIYfnYRAp
        Dc6xpMBHe7d7wkxlPrPSo+Uu/tCY/HUrj36gwF25bm5BAcAQRcqKoscPrLOybEXvnDJ7Je
        fPTmPlZG1TRv12NrEyvAhDN2JnFqoEFDCb+7ykfjEm5jHOIWFEU3Hd85oCU3+sHCjSNiHG
        XOVPxFg9lLYnix1WKcXsKsiQHb5eAERwRJZRMsltyGg5LXasRq3u+rsZmQoBubKysnkEPo
        +PWFVLIq4htdDN2OzAoaLFAusZGGi4lkiy8M+0EbfMA12CL+zfVkGvC5JkWvaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624888686;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EA49D6jjvfTlGevWpnlR1iszrSoWl6SMVQnnoJ7fGqw=;
        b=1JLBBZm+UfIKDwE2LUJCd2szVYD4eF9xsdXPtij4IMjkAniNKbQth94KP8e5IK1Mbg8OCh
        qYPuuVyxp1VZ4gCg==
From:   "tip-bot2 for Odin Ugedal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Ensure _sum and _avg values stay consistent
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Odin Ugedal <odin@uged.al>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624111815.57937-1-odin@uged.al>
References: <20210624111815.57937-1-odin@uged.al>
MIME-Version: 1.0
Message-ID: <162488868552.395.3605721602918699622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1c35b07e6d3986474e5635be566e7bc79d97c64d
Gitweb:        https://git.kernel.org/tip/1c35b07e6d3986474e5635be566e7bc79d97c64d
Author:        Odin Ugedal <odin@uged.al>
AuthorDate:    Thu, 24 Jun 2021 13:18:15 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 28 Jun 2021 15:42:24 +02:00

sched/fair: Ensure _sum and _avg values stay consistent

The _sum and _avg values are in general sync together with the PELT
divider. They are however not always completely in perfect sync,
resulting in situations where _sum gets to zero while _avg stays
positive. Such situations are undesirable.

This comes from the fact that PELT will increase period_contrib, also
increasing the PELT divider, without updating _sum and _avg values to
stay in perfect sync where (_sum == _avg * divider). However, such PELT
change will never lower _sum, making it impossible to end up in a
situation where _sum is zero and _avg is not.

Therefore, we need to ensure that when subtracting load outside PELT,
that when _sum is zero, _avg is also set to zero. This occurs when
(_sum < _avg * divider), and the subtracted (_avg * divider) is bigger
or equal to the current _sum, while the subtracted _avg is smaller than
the current _avg.

Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Odin Ugedal <odin@uged.al>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Link: https://lore.kernel.org/r/20210624111815.57937-1-odin@uged.al
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4a3e61a..45edf61 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3657,15 +3657,15 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 
 		r = removed_load;
 		sub_positive(&sa->load_avg, r);
-		sub_positive(&sa->load_sum, r * divider);
+		sa->load_sum = sa->load_avg * divider;
 
 		r = removed_util;
 		sub_positive(&sa->util_avg, r);
-		sub_positive(&sa->util_sum, r * divider);
+		sa->util_sum = sa->util_avg * divider;
 
 		r = removed_runnable;
 		sub_positive(&sa->runnable_avg, r);
-		sub_positive(&sa->runnable_sum, r * divider);
+		sa->runnable_sum = sa->runnable_avg * divider;
 
 		/*
 		 * removed_runnable is the unweighted version of removed_load so we
