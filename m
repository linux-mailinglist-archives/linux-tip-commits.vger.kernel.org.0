Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7D9319EB1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhBLMkN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhBLMig (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3314C061356;
        Fri, 12 Feb 2021 04:37:13 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=L6SovPkdYLc6MPrhexodUBs6Mld+HEpGhcBY/KA77bI=;
        b=RO3jBVdOimm/hE1mSw9KFVcixrmgqN/gNj1q5fCNILmj1u5QBZXXCBG80N5vVu5SWl2625
        IoLkF0ft5xfP5allD7wrFTMgRoY0Gd92jaH/BCxdO4cc57COHU9TzAqJABzYtWeG0IC3LV
        Ah50/0j7nGFQl6O0gfBMPo28s38GwHY9QOLwLQag+rkK6isVoMHWbUzxQXlXCWbZNE36H4
        DeJUi49CuZ3oBNEzsP2DVOZTjxPeLhJLzi1R30XgKWGn/jDiBa4DBXPUt+bIRs3pFB3lrI
        WQO/nKH8VLEixMF5BcG5bssQhuVO9ACxWvsA+ObZDUzeyAmvo5/1+tCHaQg1dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=L6SovPkdYLc6MPrhexodUBs6Mld+HEpGhcBY/KA77bI=;
        b=N/3Mq5DzViQtMbXF/dc6O/eR+jOCD/qmxDT9vuilG66+xqBUZ/3VNJbg2xSR3rpgPIyuj0
        PscgHxQQ753TqqAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Require entire stutter period be post-boot
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343056.23325.6317203482024134200.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     12a910e3cd3d11e00b2a2df24ea995ffa3e27ae5
Gitweb:        https://git.kernel.org/tip/12a910e3cd3d11e00b2a2df24ea995ffa3e27ae5
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 16 Nov 2020 16:01:50 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:08:12 -08:00

rcutorture: Require entire stutter period be post-boot

Currently, the rcu_torture_writer() function checks that all required
grace periods elapse during a stutter interval, which is a multi-second
time period during which the test load is removed.  However, this check
is suppressed during early boot (that is, before init is spawned) in
order to avoid false positives that otherwise occur due to heavy load
on the single boot CPU.

Unfortunately, this approach is insufficient.  It is possible that the
stutter interval might end just as init is spawned, so that early boot
conditions prevailed during almost the entire stutter interval.

This commit therefore takes a snapshot of boot-complete state just
before the stutter interval, thus suppressing the check for failure to
complete grace periods unless the entire stutter interval took place
after early boot.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 338e118..1930d92 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1070,6 +1070,7 @@ rcu_torture_fqs(void *arg)
 static int
 rcu_torture_writer(void *arg)
 {
+	bool boot_ended;
 	bool can_expedite = !rcu_gp_is_expedited() && !rcu_gp_is_normal();
 	unsigned long cookie;
 	int expediting = 0;
@@ -1239,12 +1240,13 @@ rcu_torture_writer(void *arg)
 				       !rcu_gp_is_normal();
 		}
 		rcu_torture_writer_state = RTWS_STUTTER;
+		boot_ended = rcu_inkernel_boot_has_ended();
 		stutter_waited = stutter_wait("rcu_torture_writer");
 		if (stutter_waited &&
 		    !READ_ONCE(rcu_fwd_cb_nodelay) &&
 		    !cur_ops->slow_gps &&
 		    !torture_must_stop() &&
-		    rcu_inkernel_boot_has_ended())
+		    boot_ended)
 			for (i = 0; i < ARRAY_SIZE(rcu_tortures); i++)
 				if (list_empty(&rcu_tortures[i].rtort_free) &&
 				    rcu_access_pointer(rcu_torture_current) !=
