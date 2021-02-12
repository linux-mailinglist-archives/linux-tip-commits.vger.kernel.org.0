Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B425319EB0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhBLMkM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbhBLMig (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34778C0617AA;
        Fri, 12 Feb 2021 04:37:12 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133429;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xvEVDcLPUg742PdKqYV+2NHR3hbPUURotgWt6pEJMjY=;
        b=Qu+lWlX4O+wlEAsNUTmmluWn0uy3iEbtNMBsclAcmeUSWP5w0+5oHk6T/6AUX0mKl0n1H4
        qvDcKfh3cGUifuf7yktuGGDKOhbtYVtsBcCwf+ENz1r6g4tnbErG12zXgOHtMSV4QpLfyY
        YS7A+njXliOTVtudQzWBayKzZwLBc+L+DsLbkdhbuER0GqzbcGy6ONbVyLE7/aM6pd8zxW
        aHmbUaCLrsHCjIGvMZFc0MBsXbNwAWrwOwTRw4vKWc6zs+u9qKvko4iqwvpiyMUJ8Jzakt
        AiUy7yiIgiyz5/74Olk8OZOnk3bhbhUjbshL4lRZnA4vmHQAGZ+/07OyXakvGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133429;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xvEVDcLPUg742PdKqYV+2NHR3hbPUURotgWt6pEJMjY=;
        b=bgwMjI96YH2oi6KrUhdoTZV5ujWrSMQEt0bu14hUeks7EBsuow6/mvA770YVkC9fFnFZkR
        kESmDrJXJr36gDDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make stutter use torture_hrtimeout_*() functions
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342928.23325.6636848051662243553.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ed24affa71f7abf7d81698a99b6c2623491a35b0
Gitweb:        https://git.kernel.org/tip/ed24affa71f7abf7d81698a99b6c2623491a35b0
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 17 Nov 2020 12:17:42 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:17:20 -08:00

torture: Make stutter use torture_hrtimeout_*() functions

This commit saves a few lines of code by making the stutter_wait()
and torture_stutter() functions use torture_hrtimeout_jiffies() and
torture_hrtimeout_us().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 7548634..7ad5c96 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -677,7 +677,6 @@ static int stutter_gap;
  */
 bool stutter_wait(const char *title)
 {
-	ktime_t delay;
 	unsigned int i = 0;
 	bool ret = false;
 	int spt;
@@ -693,11 +692,8 @@ bool stutter_wait(const char *title)
 			schedule_timeout_interruptible(1);
 		} else if (spt == 2) {
 			while (READ_ONCE(stutter_pause_test)) {
-				if (!(i++ & 0xffff)) {
-					set_current_state(TASK_INTERRUPTIBLE);
-					delay = 10 * NSEC_PER_USEC;
-					schedule_hrtimeout(&delay, HRTIMER_MODE_REL);
-				}
+				if (!(i++ & 0xffff))
+					torture_hrtimeout_us(10, 0, NULL);
 				cond_resched();
 			}
 		} else {
@@ -715,7 +711,6 @@ EXPORT_SYMBOL_GPL(stutter_wait);
  */
 static int torture_stutter(void *arg)
 {
-	ktime_t delay;
 	DEFINE_TORTURE_RANDOM(rand);
 	int wtime;
 
@@ -726,20 +721,15 @@ static int torture_stutter(void *arg)
 			if (stutter > 2) {
 				WRITE_ONCE(stutter_pause_test, 1);
 				wtime = stutter - 3;
-				delay = ktime_divns(NSEC_PER_SEC * wtime, HZ);
-				delay += (torture_random(&rand) >> 3) % NSEC_PER_MSEC;
-				set_current_state(TASK_INTERRUPTIBLE);
-				schedule_hrtimeout(&delay, HRTIMER_MODE_REL);
+				torture_hrtimeout_jiffies(wtime, &rand);
 				wtime = 2;
 			}
 			WRITE_ONCE(stutter_pause_test, 2);
-			delay = ktime_divns(NSEC_PER_SEC * wtime, HZ);
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_hrtimeout(&delay, HRTIMER_MODE_REL);
+			torture_hrtimeout_jiffies(wtime, NULL);
 		}
 		WRITE_ONCE(stutter_pause_test, 0);
 		if (!torture_must_stop())
-			schedule_timeout_interruptible(stutter_gap);
+			torture_hrtimeout_jiffies(stutter_gap, NULL);
 		torture_shutdown_absorb("torture_stutter");
 	} while (!torture_must_stop());
 	torture_kthread_stopping("torture_stutter");
