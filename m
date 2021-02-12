Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F59A319E90
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhBLMio (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:38:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45360 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhBLMhx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:53 -0500
Date:   Fri, 12 Feb 2021 12:37:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HwPUiiq7w4vfrbGCAi5N0EGfv3DfPMreFa0Od1jEYN4=;
        b=RvLZO7RAoTaiFKIHdl6XG2gjtP2aGg2DJstZoc7+/jHpphZQwb9cZyxNkjEsXDTIpTUzJz
        8xUUglYp+DmDDMGVh9XhFVInfJ98/yvRWngrwFZ5+6V5Lhq6inf/4l9lf7p+OSuuYdCokW
        ec8PXg53t8gPPgH77NathUUKLN5vlunVgdql5MYAy0rBO8/KaYtBDpNOYWi/dYdcAyu/dw
        kLK9MV7hHM2ucA3ZyfX4ImxaP5SrADcVaKZhwS9HK0LfVl43wlEXKVmQgeOROLhEQcwgZJ
        dKgulDX1FsVpFke4+x6t+mLYGYDI2kWjGRDh5afeO1gTP4XkMPhe+EAIV98GRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HwPUiiq7w4vfrbGCAi5N0EGfv3DfPMreFa0Od1jEYN4=;
        b=kXX0o66lTQeps+ULMzTA66C0oQvD7VQSuC0lVj3bbiGazj912RnGxmWIShJYWHIJrGZ9p3
        OT/NchDMsd3jF6AQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Use torture_hrtimeout_jiffies() to avoid
 busy-waits
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342952.23325.12367181586526090712.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ea31fd9ca87399ac4e03cd6c215451fa7dc366e4
Gitweb:        https://git.kernel.org/tip/ea31fd9ca87399ac4e03cd6c215451fa7dc366e4
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 17 Nov 2020 11:32:54 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:17:19 -08:00

rcutorture: Use torture_hrtimeout_jiffies() to avoid busy-waits

Because rcu_torture_writer() and rcu_torture_fakewriter() predate
hrtimers, they do timer-wheel-decoupled timed waits by using the
timer-wheel-based schedule_timeout_interruptible() functions in
conjunction with a random udelay()-based wait.  This latter unnecessarily
burns CPU time, so this commit instead uses torture_hrtimeout_jiffies()
to decouple from the timer wheels without busy-waiting.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 03bdf67..9414e30 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1194,10 +1194,7 @@ rcu_torture_writer(void *arg)
 			case RTWS_COND_GET:
 				rcu_torture_writer_state = RTWS_COND_GET;
 				gp_snap = cur_ops->get_gp_state();
-				i = torture_random(&rand) % 16;
-				if (i != 0)
-					schedule_timeout_interruptible(i);
-				udelay(torture_random(&rand) % 1000);
+				torture_hrtimeout_jiffies(torture_random(&rand) % 16, &rand);
 				rcu_torture_writer_state = RTWS_COND_SYNC;
 				cur_ops->cond_sync(gp_snap);
 				rcu_torture_pipe_update(old_rp);
@@ -1206,12 +1203,9 @@ rcu_torture_writer(void *arg)
 				rcu_torture_writer_state = RTWS_POLL_GET;
 				gp_snap = cur_ops->start_gp_poll();
 				rcu_torture_writer_state = RTWS_POLL_WAIT;
-				while (!cur_ops->poll_gp_state(gp_snap)) {
-					i = torture_random(&rand) % 16;
-					if (i != 0)
-						schedule_timeout_interruptible(i);
-					udelay(torture_random(&rand) % 1000);
-				}
+				while (!cur_ops->poll_gp_state(gp_snap))
+					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
+								  &rand);
 				rcu_torture_pipe_update(old_rp);
 				break;
 			case RTWS_SYNC:
@@ -1290,7 +1284,6 @@ static int
 rcu_torture_fakewriter(void *arg)
 {
 	unsigned long gp_snap;
-	int i;
 	DEFINE_TORTURE_RANDOM(rand);
 
 	VERBOSE_TOROUT_STRING("rcu_torture_fakewriter task started");
@@ -1311,19 +1304,14 @@ rcu_torture_fakewriter(void *arg)
 				break;
 			case RTWS_COND_GET:
 				gp_snap = cur_ops->get_gp_state();
-				i = torture_random(&rand) % 16;
-				if (i != 0)
-					schedule_timeout_interruptible(i);
-				udelay(torture_random(&rand) % 1000);
+				torture_hrtimeout_jiffies(torture_random(&rand) % 16, &rand);
 				cur_ops->cond_sync(gp_snap);
 				break;
 			case RTWS_POLL_GET:
 				gp_snap = cur_ops->start_gp_poll();
 				while (!cur_ops->poll_gp_state(gp_snap)) {
-					i = torture_random(&rand) % 16;
-					if (i != 0)
-						schedule_timeout_interruptible(i);
-					udelay(torture_random(&rand) % 1000);
+					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
+								  &rand);
 				}
 				break;
 			case RTWS_SYNC:
