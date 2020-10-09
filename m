Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255E4288299
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbgJIGf0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731817AbgJIGfO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0ED6C0613D2;
        Thu,  8 Oct 2020 23:35:13 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0N4vNgK+rVWMvyZZubbpmWOOLGWYtpsTa4vXrnvRx78=;
        b=wIOhCruNEJuU6HMVrO9UOPHf89FAurPStvdT4NPuOnAGStywotHThRLzXz7pzZDQrwYb2G
        FJbxK5llPbKloEu9T05pp8Nc+fmGyci5Du781cWPpsxUOjwwm24TGPo5WtMqJtrd3tShGy
        66lv6EAV7lFnn6b8sB9zxOgS6z2BqwjvtZWOssmfW6sFlsnEBPJ4QrYSgRgj3KZAqtF1nZ
        xEfoL3WDudrMYodISjEpoKmLZEOFoz8VfNNw+dFcoW29T0XXMWD15zP6i+WdRBNI99Nqyl
        WYsY/k7/s28nZTB8T/xPla17yaCC7tRilRR3oloJCq4lFoIDge37rtLSDFxllg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0N4vNgK+rVWMvyZZubbpmWOOLGWYtpsTa4vXrnvRx78=;
        b=1LH5V2ETx7FNbN357zj7omyMjiscBgjykpSyxZsZVpXyIl5fL+lHWb+N0C0pk911ScHXtU
        v/FJHdHavN1tW2DA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Hoist OOM registry up one level
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222531148.7002.16466300601924266132.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     299c7d94f635ab93ffb0468aec6b6e2176ec5cbf
Gitweb:        https://git.kernel.org/tip/299c7d94f635ab93ffb0468aec6b6e2176ec5cbf
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 22 Jul 2020 10:45:12 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:45:35 -07:00

rcutorture: Hoist OOM registry up one level

Currently, registering and unregistering the OOM notifier is done
right before and after the test, respectively.  This will not work
well for multi-threaded tests, so this commit hoists this registering
and unregistering up into the rcu_torture_fwd_prog_init() and
rcu_torture_fwd_prog_cleanup() functions.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 2b3f04e..983f82f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2110,13 +2110,11 @@ static int rcu_torture_fwd_prog(void *args)
 	do {
 		schedule_timeout_interruptible(fwd_progress_holdoff * HZ);
 		WRITE_ONCE(rcu_fwd_emergency_stop, false);
-		register_oom_notifier(&rcutorture_oom_nb);
 		if (!IS_ENABLED(CONFIG_TINY_RCU) ||
 		    rcu_inkernel_boot_has_ended())
 			rcu_torture_fwd_prog_nr(rfp, &tested, &tested_tries);
 		if (rcu_inkernel_boot_has_ended())
 			rcu_torture_fwd_prog_cr(rfp);
-		unregister_oom_notifier(&rcutorture_oom_nb);
 
 		/* Avoid slow periods, better to test when busy. */
 		stutter_wait("rcu_torture_fwd_prog");
@@ -2159,6 +2157,7 @@ static int __init rcu_torture_fwd_prog_init(void)
 	mutex_lock(&rcu_fwd_mutex);
 	rcu_fwds = rfp;
 	mutex_unlock(&rcu_fwd_mutex);
+	register_oom_notifier(&rcutorture_oom_nb);
 	return torture_create_kthread(rcu_torture_fwd_prog, rfp, fwd_prog_task);
 }
 
@@ -2171,6 +2170,7 @@ static void rcu_torture_fwd_prog_cleanup(void)
 	mutex_lock(&rcu_fwd_mutex);
 	rcu_fwds = NULL;
 	mutex_unlock(&rcu_fwd_mutex);
+	unregister_oom_notifier(&rcutorture_oom_nb);
 	kfree(rfp);
 }
 
