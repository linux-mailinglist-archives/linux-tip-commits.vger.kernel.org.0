Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBA332B144
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Mar 2021 04:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhCCDZT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Mar 2021 22:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378830AbhCBJCu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Mar 2021 04:02:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3946C06178C;
        Tue,  2 Mar 2021 01:01:54 -0800 (PST)
Date:   Tue, 02 Mar 2021 09:01:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614675713;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPLwpz5mA1JbzwLHQTwXYLJfYfCW5VBbPrdtXvLiQjY=;
        b=3HylGS6yL/3IXKSDRQYJNSsETyvJRaDAM5p+4J+no7gYuvQM1nAEhC0l8Z7sO4jYsW59Rh
        xIuAvnpK3aWWXqOi8i4zlcVohWqXkonSAGVwHnhPKy0ekeESyS6r1GrX9yTvIxDKZfDR8i
        ZeuM0Sek0Rdt4dpbMPNXg7rattdrYX4/gIkNZllExBPdDtEf91lRhCaDWvSjUL57MUYt1h
        cNoj88d9+KMt0h5WxPjiR8Ly6VIWVprBQA7XMDK8nM2nYMv+XJkxvqyTt7G0pbz/3+dL53
        6j4rOkP3ptP4OXUi4KU4pWivf6C2SZVXdr6EBnnw1cUMTCByLJHGYrQnZKepwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614675713;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPLwpz5mA1JbzwLHQTwXYLJfYfCW5VBbPrdtXvLiQjY=;
        b=9uZDzjbhRo3u1FaHDRPd3T+bxQgEzZsZ4x6dsFl4UnIudEaNA3RCOkLb1OFGlCN7pabfv3
        D4Ja0x75C/5dGiBA==
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
Message-ID: <161467571261.20312.13320924849581035602.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     92e1512c5329c7675b66163d357d00d95107fa03
Gitweb:        https://git.kernel.org/tip/92e1512c5329c7675b66163d357d00d95107fa03
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Tue, 16 Feb 2021 10:35:05 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 18:17:26 +01:00

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
