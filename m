Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A753E5A8E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 14:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241019AbhHJM6n (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 08:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241018AbhHJM6m (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 08:58:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3BDC061798;
        Tue, 10 Aug 2021 05:58:19 -0700 (PDT)
Date:   Tue, 10 Aug 2021 12:58:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628600297;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJAGW2RFf+9ArRte0x0irpl9rNXNVU/GkFwXqVvn29o=;
        b=fjY9A/cDUfEOgWVFu5n+uiYKkv8roSjVEYDdjVjHME832WzE1KwrYag+8+oP3ZMZYUP83Y
        edpUg1L9g0yrFK4gRGcMvSYHZSSWFUAKL4tS3AyfFmYGQREzYyjslPjmZokI2wQghfcXju
        GMB14DoR/lvtLdT4O2kfdGPwgmmUpI3R7Y8gDYuvWugacaN7JW+5yZd0RTpvwEDgrEoKKo
        1jptv7R4BotkAzrs6z0P2o1q6Hgo6H3gZXlOJzErbav4mU3XKkvGk/QIW27IrCW0TTqUIN
        pmBzC5svoVY/J8ggX+EhTn/nQetVE+lIlFUuiveHQAIDDUJZz4zuXTivcMjEzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628600297;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJAGW2RFf+9ArRte0x0irpl9rNXNVU/GkFwXqVvn29o=;
        b=4KmNAcTdo5KzIJR9f0oKB4oNQJv6Su8kl9x01g8DjpAp/v+6rk/INTho9VqMg5Yrl6dRX/
        AvEMbE41db35lEAg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Replace deprecated CPU-hotplug functions.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803141621.780504-33-bigeasy@linutronix.de>
References: <20210803141621.780504-33-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <162860029619.395.4537477779689323124.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     746f5ea9c4283d98353c1cd41864aec475e0edbd
Gitweb:        https://git.kernel.org/tip/746f5ea9c4283d98353c1cd41864aec475e0edbd
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 03 Aug 2021 16:16:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 14:53:00 +02:00

sched: Replace deprecated CPU-hotplug functions.

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210803141621.780504-33-bigeasy@linutronix.de

---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 433b400..d67c5dd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9840,7 +9840,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 	 * Prevent race between setting of cfs_rq->runtime_enabled and
 	 * unthrottle_offline_cfs_rqs().
 	 */
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&cfs_constraints_mutex);
 	ret = __cfs_schedulable(tg, period, quota);
 	if (ret)
@@ -9884,7 +9884,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 		cfs_bandwidth_usage_dec();
 out_unlock:
 	mutex_unlock(&cfs_constraints_mutex);
-	put_online_cpus();
+	cpus_read_unlock();
 
 	return ret;
 }
