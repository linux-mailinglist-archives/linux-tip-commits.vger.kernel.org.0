Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E579732F9F9
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhCFLmc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhCFLmX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7574DC06175F;
        Sat,  6 Mar 2021 03:42:22 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:42:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615030940;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RfmAqv9hSCdzPoRd88OIWrCYrmaLELZjkgQeAmXt9Cg=;
        b=D+6akNMaiBNnml4vgQZu7QmhfIb1R4rvdBOSXnmpOeJ15ylhB/rlsu27nmhBbNtYG25AWY
        KBfbI7Syz3LfuNNnFN2/uEETawezpBsYJ2xXolFJKfcxgsvFq3+pK9qIDsNuzCs0K594pw
        o82Eo+Jkd81qZKW9cMOJDzGph0PmxWPIfG1T7Tcw//E5t3J2UHcMWNJXgKiFLkqMcG0Zfd
        RmwHBZUcBR4F09EgyoisMzUT1ptOFJV/LnMvYkCnbGCSoRh5V9XWUauDcE61M4+jHbTslv
        gdSeA3+98Skfn5VRSjZ9jQMLLB1ZuslaK1Dp7zStpf3Xw4fQY3o9ibUmxVByTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615030940;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RfmAqv9hSCdzPoRd88OIWrCYrmaLELZjkgQeAmXt9Cg=;
        b=ox/AOmGm8iMRrJCM0+VlzaKxa84EhD6UPipCOA425NNHwWMIlnTPvcIKit/GZChnmFIkzd
        hDuzldeAycJZNzDw==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpu/hotplug: CPUHP_BRINGUP_CPU failure exception
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210216103506.416286-3-vincent.donnefort@arm.com>
References: <20210216103506.416286-3-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <161503094020.398.16040794944705516686.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     62f250694092dd5fef9900dc3126f07110bf9d48
Gitweb:        https://git.kernel.org/tip/62f250694092dd5fef9900dc3126f07110bf9d48
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Tue, 16 Feb 2021 10:35:05 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:40:22 +01:00

cpu/hotplug: CPUHP_BRINGUP_CPU failure exception

The atomic states (between CPUHP_AP_IDLE_DEAD and CPUHP_AP_ONLINE) are
triggered by the CPUHP_BRINGUP_CPU step. If the latter fails, no atomic
state can be rolled back.

DEAD callbacks too can't fail and disallow recovery. As a consequence,
during hotunplug, the fail injection interface should prohibit all states
from CPUHP_BRINGUP_CPU to CPUHP_ONLINE.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
