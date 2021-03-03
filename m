Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E690132C78C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355642AbhCDAcP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842931AbhCCKWj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF6CC08EC2B;
        Wed,  3 Mar 2021 01:49:38 -0800 (PST)
Date:   Wed, 03 Mar 2021 09:49:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614764975;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mgOPFoYyiw8NY2vGV+0scutbfVbhkpkyvQHNVX42788=;
        b=VVs5ZsVJGHgLCbrc0NBP+zNGhO2y4lof3U1THGtSQBV8Recg7mVnQQ8kJwCNHrYgtClLZV
        DjDDlQcxQrzcwWZYGO4UvviZXdJo1UBKaCo4UcjxVGaQC3+ydbPmOYfpOqNEl1g1wFTFpp
        22cZlnIh6L9BjRyxhLbJa+oy8G47g6YSF4KYSYwO44/zwb2UDtB58oFJG4SvsWlgjihDt8
        FayK6eW6VMYgt/L4ljChCspSBHp330e5VpKvitLdMflVJStb3Oq+UcFNnAodoE7I2mLUaY
        OSl4WdW81tXtrECgF2SspBOl5SeHcYVl4eC49zwXI2HExBXeNl9i3Kce+lN4ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614764975;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mgOPFoYyiw8NY2vGV+0scutbfVbhkpkyvQHNVX42788=;
        b=Vogyc8ShRcM9ybwP3l2T65Mi4mvsbDqkEkd1t0A5xpnh740R5cJgUdDZOzRiCsakjHCJF4
        U36U3Pd+UrtpIIAw==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpu/hotplug: CPUHP_BRINGUP_CPU failure exception
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210216103506.416286-3-vincent.donnefort@arm.com>
References: <20210216103506.416286-3-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <161476497481.20312.7532268175021230545.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5e7f238920174248049ff840eff43c94f3a2e67e
Gitweb:        https://git.kernel.org/tip/5e7f238920174248049ff840eff43c94f3a2e67e
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Tue, 16 Feb 2021 10:35:05 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 10:33:00 +01:00

cpu/hotplug: CPUHP_BRINGUP_CPU failure exception

The atomic states (between CPUHP_AP_IDLE_DEAD and CPUHP_AP_ONLINE) are
triggered by the CPUHP_BRINGUP_CPU step. If the latter fails, no atomic
state can be rolled back.

DEAD callbacks too can't fail and disallow recovery. As a consequence,
during hotunplug, the fail injection interface should prohibit all states
from CPUHP_BRINGUP_CPU to CPUHP_ONLINE.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210216103506.416286-3-vincent.donnefort@arm.com
---
 kernel/cpu.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 9121edf..680ed8f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1045,9 +1045,13 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 	 * to do the further cleanups.
 	 */
 	ret = cpuhp_down_callbacks(cpu, st, target);
-	if (ret && st->state == CPUHP_TEARDOWN_CPU && st->state < prev_state) {
-		cpuhp_reset_state(st, prev_state);
-		__cpuhp_kick_ap(st);
+	if (ret && st->state < prev_state) {
+		if (st->state == CPUHP_TEARDOWN_CPU) {
+			cpuhp_reset_state(st, prev_state);
+			__cpuhp_kick_ap(st);
+		} else {
+			WARN(1, "DEAD callback error for CPU%d", cpu);
+		}
 	}
 
 out:
@@ -2222,6 +2226,15 @@ static ssize_t write_cpuhp_fail(struct device *dev,
 		return -EINVAL;
 
 	/*
+	 * DEAD callbacks cannot fail...
+	 * ... neither can CPUHP_BRINGUP_CPU during hotunplug. The latter
+	 * triggering STARTING callbacks, a failure in this state would
+	 * hinder rollback.
+	 */
+	if (fail <= CPUHP_BRINGUP_CPU && st->state > CPUHP_BRINGUP_CPU)
+		return -EINVAL;
+
+	/*
 	 * Cannot fail anything that doesn't have callbacks.
 	 */
 	mutex_lock(&cpuhp_state_mutex);
