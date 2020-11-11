Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30682AEB01
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgKKIXW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:23:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36218 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgKKIXR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:17 -0500
Date:   Wed, 11 Nov 2020 08:23:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605082995;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GvOqN5/5x3y6kI8UWCeTiKL7OlKyHIa/Zd2k3XWzzm0=;
        b=1o2jkhZYN0FiA2fqhqZLkiz5WcIktVbZI+vxvSNPNO2CXg0Mlo6NZRFUnMQoi3XVY1Fx89
        7SkA+bHmhBpgypOG3csb2Wh7BYS39Rj6nnJlSF77a1hXECyPZ3kr0ROTk098lqwKtE8wA2
        vuXutyW/oHysbnSf8EsWJYJMziStGXwObhgiKDIoPNhxAA3nSFPIVsIYeDYq8nwwn06FoC
        qvhwCD73BvzH744K35Cq5gXNQ+KtKT+TfzUeprdsiuff0maa/eumuvXNufi97YHvzaK0DN
        soeolmslltwc1rtdcH64gCXYoP0P112fFKpkv/BTeoSkTx41x+Rv4sZmnoayqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605082995;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GvOqN5/5x3y6kI8UWCeTiKL7OlKyHIa/Zd2k3XWzzm0=;
        b=nghSIH5/R7wJc9uk2/IzZcZpFfrNRo8luOkWYvi6BxNwPJjcFnIpXJXw0ClNEhKDPg/b1C
        UL5QW+1vPpl7KHBg==
From:   "tip-bot2 for Hui Su" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove superfluous lock section in
 do_sched_cfs_slack_timer()
Cc:     Hui Su <sh_def@163.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>, Ben Segall <bsegall@google.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201030144621.GA96974@rlk>
References: <20201030144621.GA96974@rlk>
MIME-Version: 1.0
Message-ID: <160508299420.11244.12434914421630975924.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     cdb310474dece99985e4cdd2b96b1324e39c1c9d
Gitweb:        https://git.kernel.org/tip/cdb310474dece99985e4cdd2b96b1324e39c1c9d
Author:        Hui Su <sh_def@163.com>
AuthorDate:    Fri, 30 Oct 2020 22:46:21 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:39:05 +01:00

sched/fair: Remove superfluous lock section in do_sched_cfs_slack_timer()

Since ab93a4bc955b ("sched/fair: Remove distribute_running fromCFS
bandwidth"), there is nothing to protect between
raw_spin_lock_irqsave/store() in do_sched_cfs_slack_timer().

Signed-off-by: Hui Su <sh_def@163.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Reviewed-by: Ben Segall <bsegall@google.com>
Link: https://lkml.kernel.org/r/20201030144621.GA96974@rlk
---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2755a7e..3e5d98f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5126,9 +5126,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 		return;
 
 	distribute_cfs_runtime(cfs_b);
-
-	raw_spin_lock_irqsave(&cfs_b->lock, flags);
-	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 }
 
 /*
