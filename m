Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4712D8F95
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgLMTB4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:01:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46620 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbgLMTBu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:50 -0500
Date:   Sun, 13 Dec 2020 19:01:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=M167gq44Wr5znh/chsllqYI0ftQ0W9qpaXug1CxMeRY=;
        b=KcYwmFmrjUv8GXxkt4k7q0E8Hm/z6SekL3aVa/z1D45+BTIu8ghv10Aq1h+zyu1VISFcef
        /JtLf6kc0U3tuBJNnjILdJsrSpWRW1cJxj22PITBLn/B1IlsI0cZgbhp+VuiGkA52dRgUZ
        yarCFOrpZXLPaY9m4sImgb2XIPHylikDS+l8wU4NHyhC+yY7cVOjqpjk1WZXcQlNGYYxTi
        h6xcMyer+iy0u5OVs2oeDDgAtiajO8MlijsQLB/DV39fvahGw7517EiqGoV0BCUgnQWTdD
        rKQFmWCSuhcQbVPPEu268iUlz5GhzF04v8eHyIuiHebqmHSD9n+PGIpjHNRoZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=M167gq44Wr5znh/chsllqYI0ftQ0W9qpaXug1CxMeRY=;
        b=vRY/SfOXQpjyb5d55JKxzWyZ0K7xZro3HqfOjl/iSr28Yb40nYhk4s6BMX3yF0v+tC5gTo
        T/j/vyfTeWPLj8AQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] scftorture: Add full-test stutter capability
Cc:     Chris Mason <clm@fb.com>, "Paul E. McKenney" <paulmck@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606754.3364.12336088913711753326.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     85558182d545fe9c0583a39dbb6359ee954e35d5
Gitweb:        https://git.kernel.org/tip/85558182d545fe9c0583a39dbb6359ee954e35d5
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 24 Sep 2020 12:11:57 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:56 -08:00

scftorture: Add full-test stutter capability

In virtual environments on systems with hardware assist, inter-processor
interrupts must do very different things based on whether the target
vCPU is running or not.  This commit therefore enables torture-test
stuttering to better test these running/not-running transitions.

Suggested-by: Chris Mason <clm@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 3fbb7a7..d55a9f8 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -59,7 +59,7 @@ torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (s), 0=disable");
 torture_param(int, shutdown_secs, 0, "Shutdown time (ms), <= zero to disable.");
 torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s.");
-torture_param(int, stutter_cpus, 5, "Number of jiffies to change CPUs under test, 0=disable");
+torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
 torture_param(bool, use_cpus_read_lock, 0, "Use cpus_read_lock() to exclude CPU hotplug.");
 torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
 torture_param(int, weight_resched, -1, "Testing weight for resched_cpu() operations.");
@@ -436,6 +436,7 @@ static int scftorture_invoker(void *arg)
 			was_offline = false;
 		}
 		cond_resched();
+		stutter_wait("scftorture_invoker");
 	} while (!torture_must_stop());
 
 	VERBOSE_SCFTORTOUT("scftorture_invoker %d ended", scfp->cpu);
@@ -448,8 +449,8 @@ static void
 scftorture_print_module_parms(const char *tag)
 {
 	pr_alert(SCFTORT_FLAG
-		 "--- %s:  verbose=%d holdoff=%d longwait=%d nthreads=%d onoff_holdoff=%d onoff_interval=%d shutdown_secs=%d stat_interval=%d stutter_cpus=%d use_cpus_read_lock=%d, weight_resched=%d, weight_single=%d, weight_single_wait=%d, weight_many=%d, weight_many_wait=%d, weight_all=%d, weight_all_wait=%d\n", tag,
-		 verbose, holdoff, longwait, nthreads, onoff_holdoff, onoff_interval, shutdown, stat_interval, stutter_cpus, use_cpus_read_lock, weight_resched, weight_single, weight_single_wait, weight_many, weight_many_wait, weight_all, weight_all_wait);
+		 "--- %s:  verbose=%d holdoff=%d longwait=%d nthreads=%d onoff_holdoff=%d onoff_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d use_cpus_read_lock=%d, weight_resched=%d, weight_single=%d, weight_single_wait=%d, weight_many=%d, weight_many_wait=%d, weight_all=%d, weight_all_wait=%d\n", tag,
+		 verbose, holdoff, longwait, nthreads, onoff_holdoff, onoff_interval, shutdown, stat_interval, stutter, use_cpus_read_lock, weight_resched, weight_single, weight_single_wait, weight_many, weight_many_wait, weight_all, weight_all_wait);
 }
 
 static void scf_cleanup_handler(void *unused)
@@ -558,6 +559,11 @@ static int __init scf_torture_init(void)
 		if (firsterr)
 			goto unwind;
 	}
+	if (stutter > 0) {
+		firsterr = torture_stutter_init(stutter, stutter);
+		if (firsterr)
+			goto unwind;
+	}
 
 	// Worker tasks invoking smp_call_function().
 	if (nthreads < 0)
