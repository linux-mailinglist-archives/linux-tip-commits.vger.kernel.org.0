Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B87319EAE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhBLMkK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhBLMie (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27210C0617A7;
        Fri, 12 Feb 2021 04:37:12 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133429;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ejD4zIIEhnIVAZoAXcqu21doYnsXPElv9otnLz9ZRG4=;
        b=kVvGppMG4TWagqz3Yvl1hpnQ3wHuh8H+Tax1VAAXXZey2ICgC7f0ANEFOjCJZ2lZObSCyY
        MomBVivDQSHqmAx9bQdJg3ziKv8fNTCeK8HhXDMHE7oCaBYucjP5sauba/EIpnF5+Xc0E0
        c/49l1WcHcMjZcfG0xAdif2fpWpVrOlxk7pnOTnWNpzHbWupCKsFNTC5KjMPmY/DpLrnmv
        pHYLsW+eN5FXYphxa2EFmJ1t4w87gDSPzSvoQYDS08Kxk6f+hP5BjunuwzLizzEaqZUbKq
        Q4MnksZI4OKUWYCgfYpkVrSUUG5+29rt2A+1L4mHEHHyFZXqf4E8SS0nlxBsVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133429;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ejD4zIIEhnIVAZoAXcqu21doYnsXPElv9otnLz9ZRG4=;
        b=E4SGDcWOiB9a0S/+MoCcfRNz2/xb4zaUcESJ+uGzB1x/qR0P5wTnKuqvM/kBW4Wo0v3NNV
        k/kLHwzg2DfC/uAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Use hrtimers for reader and writer delays
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342904.23325.4216115584676516596.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1eba0ef981fd3b5d5e94243aeced8884f43aef50
Gitweb:        https://git.kernel.org/tip/1eba0ef981fd3b5d5e94243aeced8884f43aef50
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 17 Nov 2020 14:12:24 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:17:20 -08:00

rcutorture: Use hrtimers for reader and writer delays

This commit replaces schedule_timeout_uninterruptible() and
schedule_timeout_interruptible() with torture_hrtimeout_us() and
torture_hrtimeout_jiffies() to avoid timer-wheel synchronization.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 9414e30..007595d 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1149,7 +1149,7 @@ rcu_torture_writer(void *arg)
 
 	do {
 		rcu_torture_writer_state = RTWS_FIXED_DELAY;
-		schedule_timeout_uninterruptible(1);
+		torture_hrtimeout_us(500, 1000, &rand);
 		rp = rcu_torture_alloc();
 		if (rp == NULL)
 			continue;
@@ -1290,8 +1290,7 @@ rcu_torture_fakewriter(void *arg)
 	set_user_nice(current, MAX_NICE);
 
 	do {
-		schedule_timeout_uninterruptible(1 + torture_random(&rand)%10);
-		udelay(torture_random(&rand) & 0x3ff);
+		torture_hrtimeout_jiffies(torture_random(&rand) % 10, &rand);
 		if (cur_ops->cb_barrier != NULL &&
 		    torture_random(&rand) % (nfakewriters * 8) == 0) {
 			cur_ops->cb_barrier();
@@ -1656,7 +1655,7 @@ rcu_torture_reader(void *arg)
 		if (!rcu_torture_one_read(&rand, myid) && !torture_must_stop())
 			schedule_timeout_interruptible(HZ);
 		if (time_after(jiffies, lastsleep) && !torture_must_stop()) {
-			schedule_timeout_interruptible(1);
+			torture_hrtimeout_us(500, 1000, &rand);
 			lastsleep = jiffies + 10;
 		}
 		while (num_online_cpus() < mynumonline && !torture_must_stop())
