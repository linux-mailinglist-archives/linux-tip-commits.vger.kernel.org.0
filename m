Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4B4722A54
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jun 2023 17:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjFEPIn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jun 2023 11:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbjFEPIa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jun 2023 11:08:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40947F1;
        Mon,  5 Jun 2023 08:08:29 -0700 (PDT)
Date:   Mon, 05 Jun 2023 15:08:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685977707;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1bD6hLaUNRAo6XBj38rT/tzr/rKMzfyvrpIv8NDmkAQ=;
        b=Qa/nnTL1rnED6pRwSjRBbbDUMxv0UABQ4OCyzjnT/s7br7h/07wVy1Lu13fKOZS5wSxH1F
        S4eeRnQk99PCFBCAmoKf/qAInLBmo+FVhC8PBhGYzkt5LG5fK6Y2ZPWK8oLRvw+Dk8e7QV
        9/tNalwFlyZWeXinMgCkleLMNrHpSmLj130EPPf2iilbWpmvc1/zXyU9qUOfh6wXDA49WM
        pU+F1Jwq0dh9uJJ00TeDe01SPh6M19Q3Iw6Z63gnQWnMaXV6EAXB2qlSGM7uWwQbQYCVWv
        8baDJNO2q02ipXvNSpscQMQhhAWfpX7CYgeoCDDrLjV84F/u2Xe0DOuM0lTl6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685977707;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1bD6hLaUNRAo6XBj38rT/tzr/rKMzfyvrpIv8NDmkAQ=;
        b=APu5y6d+n+E3VUuCXXTRxfQJZekXPKqbAthBCQjRJ/HHugOfA51USnRIR6eZE5qeNqcL4P
        yELLmGXy9wSvUZCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Add proper comments in do_timer_create()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230425183313.619897296@linutronix.de>
References: <20230425183313.619897296@linutronix.de>
MIME-Version: 1.0
Message-ID: <168597770743.404.16840396422526470034.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2ef6cf6d46b462a1ff7fb70ad8050a2b35077e19
Gitweb:        https://git.kernel.org/tip/2ef6cf6d46b462a1ff7fb70ad8050a2b35077e19
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Apr 2023 20:49:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Jun 2023 17:03:38 +02:00

posix-timers: Add proper comments in do_timer_create()

The comment about timer lifetime at the end of the function is misplaced
and uncomprehensible.

Make it understandable and put it at the right place. Add a new comment
about the visibility of the new timer ID to user space.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230425183313.619897296@linutronix.de

---
 kernel/time/posix-timers.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 9ce13c9..5cfd09c 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -529,12 +529,17 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	new_timer->sigq->info.si_tid   = new_timer->it_id;
 	new_timer->sigq->info.si_code  = SI_TIMER;
 
-	if (copy_to_user(created_timer_id,
-			 &new_timer_id, sizeof (new_timer_id))) {
+	if (copy_to_user(created_timer_id, &new_timer_id, sizeof (new_timer_id))) {
 		error = -EFAULT;
 		goto out;
 	}
-
+	/*
+	 * After succesful copy out, the timer ID is visible to user space
+	 * now but not yet valid because new_timer::signal is still NULL.
+	 *
+	 * Complete the initialization with the clock specific create
+	 * callback.
+	 */
 	error = kc->timer_create(new_timer);
 	if (error)
 		goto out;
@@ -544,14 +549,11 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	WRITE_ONCE(new_timer->it_signal, current->signal);
 	list_add(&new_timer->list, &current->signal->posix_timers);
 	spin_unlock_irq(&current->sighand->siglock);
-
-	return 0;
 	/*
-	 * In the case of the timer belonging to another task, after
-	 * the task is unlocked, the timer is owned by the other task
-	 * and may cease to exist at any time.  Don't use or modify
-	 * new_timer after the unlock call.
+	 * After unlocking sighand::siglock @new_timer is subject to
+	 * concurrent removal and cannot be touched anymore
 	 */
+	return 0;
 out:
 	posix_timer_unhash_and_free(new_timer);
 	return error;
