Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E0727BE88
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Sep 2020 09:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbgI2H4x (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Sep 2020 03:56:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44402 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgI2H4w (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Sep 2020 03:56:52 -0400
Date:   Tue, 29 Sep 2020 07:56:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601366209;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f1XYo2+cH1VCpRIz0lVKMzV6nqe5Kwfr/eW0vnIq1OU=;
        b=M+sBsSBnUxW8wpCM1vVMZ2kGfLYui19LgLQglgBYRPsKwZpnSpHX0/QefmiJxIIX+9O1z4
        cnXmYWRbLa7kHjQ5byaOygpG7VMSU6YjEbSRq+mltet3cgfVnNhxsefHKnwD+I1UbCQB0I
        xxf0R1FTdrNUiXq9L6cNUSqcDuOLhSDozO+KyUQQI1Za+EGd7SErZyhcIYmxCtVfbfVLpY
        FY81VkczbvhQhhTmKhm4qiK/zsyjt1vfOhAcsfjJPxMI0Tbd1BOpg1qfalgpkTSgtjH/DI
        nmkRD4jGOFGX8Bcg+iG3JloaTG659pmPat9AVyetTgtOP77XjRghBAlu/FjENQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601366209;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f1XYo2+cH1VCpRIz0lVKMzV6nqe5Kwfr/eW0vnIq1OU=;
        b=haxjIhCRRjpCTLbwy+NKtBO19zBgUb1b334HwcKxx50mkD7myRWZs/WfRxzVqj2LYzSoGr
        sE+90nAuZsKGA2Dw==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Minimize concurrent LBs between domain level
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200921072424.14813-4-vincent.guittot@linaro.org>
References: <20200921072424.14813-4-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <160136620899.7002.5463550699330938953.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e4d32e4d5444977d8dc25fa98b3ce0a65544db8c
Gitweb:        https://git.kernel.org/tip/e4d32e4d5444977d8dc25fa98b3ce0a65544db8c
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 21 Sep 2020 09:24:23 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Sep 2020 14:23:26 +02:00

sched/fair: Minimize concurrent LBs between domain level

sched domains tend to trigger simultaneously the load balance loop but
the larger domains often need more time to collect statistics. This
slowness makes the larger domain trying to detach tasks from a rq whereas
tasks already migrated somewhere else at a sub-domain level. This is not
a real problem for idle LB because the period of smaller domains will
increase with its CPUs being busy and this will let time for higher ones
to pulled tasks. But this becomes a problem when all CPUs are already busy
because all domains stay synced when they trigger their LB.

A simple way to minimize simultaneous LB of all domains is to decrement the
the busy interval by 1 jiffies. Because of the busy_factor, the interval of
larger domain will not be a multiple of smaller ones anymore.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://lkml.kernel.org/r/20200921072424.14813-4-vincent.guittot@linaro.org
---
 kernel/sched/fair.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5e3add3..24a5ee6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9790,6 +9790,15 @@ get_sd_balance_interval(struct sched_domain *sd, int cpu_busy)
 
 	/* scale ms to jiffies */
 	interval = msecs_to_jiffies(interval);
+
+	/*
+	 * Reduce likelihood of busy balancing at higher domains racing with
+	 * balancing at lower domains by preventing their balancing periods
+	 * from being multiples of each other.
+	 */
+	if (cpu_busy)
+		interval -= 1;
+
 	interval = clamp(interval, 1UL, max_load_balance_interval);
 
 	return interval;
