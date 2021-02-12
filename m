Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B998319EC4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhBLMkt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhBLMjg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:39:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4928C06121C;
        Fri, 12 Feb 2021 04:37:13 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nTUoTa7TB+cxEq8aC/KZIHSUO7eErDEswM3D62udRS8=;
        b=vB9aVmNcTTDhaX+dXylBVTnHGXut3+VffvXS/KidVxpNcOKcgAKYtltxBPiVFwu5Pnfa8P
        YrP3CYydkZCwVhUl1rff4Xf7uSUTdN9x06QVM63BTmuoabsdnRrFXghrDgtNq4xQW9FyuZ
        75i2bPN3uCYbXFEYWjFP8+VesRTlPOOU7NPQrBJyGH3w/0+BqIhUXPwvaJBwEMXohH9OEf
        ydwR8ylQqBgM/B8TidjM0u+Zuhp3iSkbEHuNcaeWlf1hGUgBJGlsLg5oinCxW4n9YtCjPu
        RcGIRFoGK0R1/owQwjPcWkQmjAdGKGjuBkuvrAKpGre6XzYqY7qCgo2+kEycpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nTUoTa7TB+cxEq8aC/KZIHSUO7eErDEswM3D62udRS8=;
        b=DC/DPXtPB1t0ZSYO5y1naZDpEqhMNVUSyyQo+hCzuPjPR73VNvvqREoNeZiPeb2B0ekxyh
        jDvnmKi8BOTzcRCA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Make rcu_torture_fakewriter() use
 blocking wait primitives
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343004.23325.5312040016001072915.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     682189a3f874db57b3e755512f2a2953f61fc54e
Gitweb:        https://git.kernel.org/tip/682189a3f874db57b3e755512f2a2953f61fc54e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 16 Nov 2020 17:10:39 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:17:18 -08:00

rcutorture: Make rcu_torture_fakewriter() use blocking wait primitives

Full testing of the new SRCU polling API requires that the fake
writers also use it in order to test concurrent calls to all of the API
members, especially start_poll_synchronize_srcu().  This commit makes
rcu_torture_fakewriter() use all available blocking grace-period-wait
primitives available from the RCU flavor under test.

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 0d257e2..03bdf67 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1289,6 +1289,8 @@ rcu_torture_writer(void *arg)
 static int
 rcu_torture_fakewriter(void *arg)
 {
+	unsigned long gp_snap;
+	int i;
 	DEFINE_TORTURE_RANDOM(rand);
 
 	VERBOSE_TOROUT_STRING("rcu_torture_fakewriter task started");
@@ -1300,15 +1302,37 @@ rcu_torture_fakewriter(void *arg)
 		if (cur_ops->cb_barrier != NULL &&
 		    torture_random(&rand) % (nfakewriters * 8) == 0) {
 			cur_ops->cb_barrier();
-		} else if (gp_normal == gp_exp) {
-			if (cur_ops->sync && torture_random(&rand) & 0x80)
-				cur_ops->sync();
-			else if (cur_ops->exp_sync)
+		} else {
+			switch (synctype[torture_random(&rand) % nsynctypes]) {
+			case RTWS_DEF_FREE:
+				break;
+			case RTWS_EXP_SYNC:
 				cur_ops->exp_sync();
-		} else if (gp_normal && cur_ops->sync) {
-			cur_ops->sync();
-		} else if (cur_ops->exp_sync) {
-			cur_ops->exp_sync();
+				break;
+			case RTWS_COND_GET:
+				gp_snap = cur_ops->get_gp_state();
+				i = torture_random(&rand) % 16;
+				if (i != 0)
+					schedule_timeout_interruptible(i);
+				udelay(torture_random(&rand) % 1000);
+				cur_ops->cond_sync(gp_snap);
+				break;
+			case RTWS_POLL_GET:
+				gp_snap = cur_ops->start_gp_poll();
+				while (!cur_ops->poll_gp_state(gp_snap)) {
+					i = torture_random(&rand) % 16;
+					if (i != 0)
+						schedule_timeout_interruptible(i);
+					udelay(torture_random(&rand) % 1000);
+				}
+				break;
+			case RTWS_SYNC:
+				cur_ops->sync();
+				break;
+			default:
+				WARN_ON_ONCE(1);
+				break;
+			}
 		}
 		stutter_wait("rcu_torture_fakewriter");
 	} while (!torture_must_stop());
