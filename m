Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E58365471
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 10:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhDTIqt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 04:46:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51042 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhDTIqs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 04:46:48 -0400
Date:   Tue, 20 Apr 2021 08:46:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618908376;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uuQixnNEBiCNiqwfuVnyZrvDsy6wXRftDK7IKYjxUnI=;
        b=Cjqngsl++da7k9RbP0aGTQsolZXDJTW97aIR3B17pxuNY/KH7RH66iuVFf64wp7srJ3aic
        at4TUofs/y2H6y1W2ujpnEGPAN4VyqULiOiwBD8jXbWGUwyuMxtJBStH5Z1gz8aI8Sx7vR
        XFQGv+HaCOMZoHKcERksAAaWWG6QNnwjxeb8xAGC2qb0YGaHsP/6A5wptqMoLCNEpVEtzs
        eO+3gS2nrsZRj1F/+6EPtwiKmB07la5Y9VTey/DOe0WeBn16gXZbYFlRa0PpMymbdsdE2z
        1dx6Fpfds5Ue217SpoBUvbsbN8Sf90MVLZuKTdqKQWEp5Id/ItzGlzCiepiThg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618908376;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uuQixnNEBiCNiqwfuVnyZrvDsy6wXRftDK7IKYjxUnI=;
        b=0CqVaCeyHteop9JNkBVozRyDsvFug00WL5qAh5JQzejSd0KsA41X9MK7q7mGkykWPYSHpl
        GHhhZ6CXD7Hm16Ag==
From:   "tip-bot2 for YueHaibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Move update_nohz_stats() to the
 CONFIG_NO_HZ_COMMON block to simplify the code & fix an unused function
 warning
Cc:     YueHaibing <yuehaibing@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210329144029.29200-1-yuehaibing@huawei.com>
References: <20210329144029.29200-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Message-ID: <161890837554.29796.9442405099846421634.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3f5ad91488e813026f8c5f46b839e91a83912703
Gitweb:        https://git.kernel.org/tip/3f5ad91488e813026f8c5f46b839e91a839=
12703
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Mon, 29 Mar 2021 22:40:29 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 20 Apr 2021 10:14:15 +02:00

sched/fair: Move update_nohz_stats() to the CONFIG_NO_HZ_COMMON block to simp=
lify the code & fix an unused function warning

When !CONFIG_NO_HZ_COMMON we get this new GCC warning:

   kernel/sched/fair.c:8398:13: warning: =E2=80=98update_nohz_stats=E2=80=99 =
defined but not used [-Wunused-function]

Move update_nohz_stats() to an already existing CONFIG_NO_HZ_COMMON #ifdef
block.

Beyond fixing the GCC warning, this also simplifies the update_nohz_stats() f=
unction.

[ mingo: Rewrote the changelog. ]

Fixes: 0826530de3cb ("sched/fair: Remove update of blocked load from newidle_=
balance")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20210329144029.29200-1-yuehaibing@huawei.com
---
 kernel/sched/fair.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 49636a4..7ea3b93 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8430,28 +8430,6 @@ group_type group_classify(unsigned int imbalance_pct,
 	return group_has_spare;
 }
=20
-static bool update_nohz_stats(struct rq *rq)
-{
-#ifdef CONFIG_NO_HZ_COMMON
-	unsigned int cpu =3D rq->cpu;
-
-	if (!rq->has_blocked_load)
-		return false;
-
-	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
-		return false;
-
-	if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))
-		return true;
-
-	update_blocked_averages(cpu);
-
-	return rq->has_blocked_load;
-#else
-	return false;
-#endif
-}
-
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
@@ -10406,6 +10384,24 @@ out:
 	WRITE_ONCE(nohz.has_blocked, 1);
 }
=20
+static bool update_nohz_stats(struct rq *rq)
+{
+	unsigned int cpu =3D rq->cpu;
+
+	if (!rq->has_blocked_load)
+		return false;
+
+	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
+		return false;
+
+	if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))
+		return true;
+
+	update_blocked_averages(cpu);
+
+	return rq->has_blocked_load;
+}
+
 /*
  * Internal function that runs load balance for all idle cpus. The load bala=
nce
  * can be a simple update of blocked load or a complete load balance with
