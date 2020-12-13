Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DEF2D8FA7
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392983AbgLMTDS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392549AbgLMTDL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:03:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3016C0619DB;
        Sun, 13 Dec 2020 11:01:12 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886071;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7nawM6Mt9Ak82bcDerdoLJUjO3Feelny/2Jl200B6Aw=;
        b=eWUCaWgedCSu2GqVgEZ8VM6gSnm5pfyeMto7v0C3VwPq3J14SHQI//FrvRhw3k2TD70MTS
        q362S3qRBIhPx2ZUZQPPAGOcZgRekCvHlxsNXnVOehjsSEeAPl8PSD2P3ezlpqGQMrdXLN
        JrAYgfZ/st9mpPniDZkw3anoIHyzkULzd0D1gH4+weldeCa4CXhQYmyqLOtrROecMxiOkB
        xCiuBuYAC5p4KrX+LzICt/x1yW9YC/GtWnPtm3KN2XDokFQFFWO1aUw2qIvVmyPHikMwrF
        PyfVOGKXqmumpYZGfDSqD40syq6RsvKeVL8ZJPRTZL1821clJ5X58ujcUrYDOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886071;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=7nawM6Mt9Ak82bcDerdoLJUjO3Feelny/2Jl200B6Aw=;
        b=ediocWKziCHhzHFaSUEvo4Z34hVpaWyyId3UcFG4e0AjE98wH4tlvEAWTzj+MPzzOBQagj
        gOX8pu7002o1afDQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make torture_stutter() use hrtimer
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607063.3364.17005020794280661837.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     fda5ba9ed254727ac5761b81455d8e93c78eba4a
Gitweb:        https://git.kernel.org/tip/fda5ba9ed254727ac5761b81455d8e93c78eba4a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 02 Sep 2020 21:08:41 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:49 -08:00

torture: Make torture_stutter() use hrtimer

The torture_stutter() function uses schedule_timeout_interruptible()
to time the stutter duration, but this can miss race conditions due to
its being time-synchronized with everything else that is based on the
timer wheels.  This commit therefore converts torture_stutter() to use
the high-resolution timers via schedule_hrtimeout(), and also to fuzz
the stutter interval.  While in the area, this commit also limits the
spin-loop portion of the stutter_wait() function's wait loop to two
jiffies, down from about one second.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index be09377..56ff02b 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -641,20 +641,27 @@ EXPORT_SYMBOL_GPL(stutter_wait);
  */
 static int torture_stutter(void *arg)
 {
+	ktime_t delay;
+	DEFINE_TORTURE_RANDOM(rand);
 	int wtime;
 
 	VERBOSE_TOROUT_STRING("torture_stutter task started");
 	do {
 		if (!torture_must_stop() && stutter > 1) {
 			wtime = stutter;
-			if (stutter > HZ + 1) {
+			if (stutter > 2) {
 				WRITE_ONCE(stutter_pause_test, 1);
-				wtime = stutter - HZ - 1;
-				schedule_timeout_interruptible(wtime);
-				wtime = HZ + 1;
+				wtime = stutter - 3;
+				delay = ktime_divns(NSEC_PER_SEC * wtime, HZ);
+				delay += (torture_random(&rand) >> 3) % NSEC_PER_MSEC;
+				set_current_state(TASK_INTERRUPTIBLE);
+				schedule_hrtimeout(&delay, HRTIMER_MODE_REL);
+				wtime = 2;
 			}
 			WRITE_ONCE(stutter_pause_test, 2);
-			schedule_timeout_interruptible(wtime);
+			delay = ktime_divns(NSEC_PER_SEC * wtime, HZ);
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_hrtimeout(&delay, HRTIMER_MODE_REL);
 		}
 		WRITE_ONCE(stutter_pause_test, 0);
 		if (!torture_must_stop())
