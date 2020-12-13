Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4EB2D9012
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbgLMTCJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:02:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46708 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729653AbgLMTBy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:54 -0500
Date:   Sun, 13 Dec 2020 19:01:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886071;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wEAGE5QdANTPmTk/HKHQWL4k5NjmNt5/Ae3YeTcU168=;
        b=4BZIrsXnOWB0qge4a1A7l4KkQY6vr6ChObHEA/GewVAq2Zn9Ef4w4mMr0wRIpntHJvkXaI
        VbXGgzi9pi8ismyday+FRql/hspdS51DJqlvStb5AR/r7V/S2XchW14DVXtKbqw68Wo1tC
        zOq48uszov0zKNFWsDsWpvmH2eCqo9o58Rx/ROkM8OCU+K9600JpYS7BYEBmlloIG/zwsU
        Qm+FjObFjbVUNYDsO8n0dsGEqXPKyZUMT2IsjNbh3WlGiMC3qLhd1uzkR1OHo9uSLpNokT
        +G/BvWPN9LQDl//LPPHYSUZlYTE4iaq3dEpneX4dsB3CEJdZ+f1EZuC4DoqwbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886071;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wEAGE5QdANTPmTk/HKHQWL4k5NjmNt5/Ae3YeTcU168=;
        b=EcLXlY68il70ViqUlQNnnhdXH/IDYKu+6sjx1B7E/Fcp/htXjzlPexilio+PCmoa7rjXta
        vWQG82z6rFEmeRDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Periodically pause in stutter_wait()
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607079.3364.6740584701213996513.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     19012b786ecccb29a9fa20c4ec0a67e2cdfbc010
Gitweb:        https://git.kernel.org/tip/19012b786ecccb29a9fa20c4ec0a67e2cdfbc010
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 01 Sep 2020 16:58:41 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:48 -08:00

torture: Periodically pause in stutter_wait()

Running locktorture scenario LOCK05 results in hangs:

tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --torture lock --duration 3 --configs LOCK05

The lock_torture_writer() kthreads set themselves to MAX_NICE while
running SCHED_OTHER.  Other locktorture kthreads run at default niceness,
also SCHED_OTHER.  This results in these other locktorture kthreads
indefinitely preempting the lock_torture_writer() kthreads.  Note that
the cond_resched() in the stutter_wait() function's loop is ineffective
because this scenario is built with CONFIG_PREEMPT=y.

It is not clear that such indefinite preemption is supposed to happen, but
in the meantime this commit prevents kthreads running in stutter_wait()
from being completely CPU-bound, thus allowing the other threads to get
some CPU in a timely fashion.  This commit also uses hrtimers to provide
very short sleeps to avoid degrading the sudden-on testing that stutter
is supposed to provide.

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 1061492..be09377 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -602,8 +602,11 @@ static int stutter_gap;
  */
 bool stutter_wait(const char *title)
 {
-	int spt;
+	ktime_t delay;
+	unsigned int i = 0;
+	int oldnice;
 	bool ret = false;
+	int spt;
 
 	cond_resched_tasks_rcu_qs();
 	spt = READ_ONCE(stutter_pause_test);
@@ -612,8 +615,17 @@ bool stutter_wait(const char *title)
 		if (spt == 1) {
 			schedule_timeout_interruptible(1);
 		} else if (spt == 2) {
-			while (READ_ONCE(stutter_pause_test))
+			oldnice = task_nice(current);
+			set_user_nice(current, MAX_NICE);
+			while (READ_ONCE(stutter_pause_test)) {
+				if (!(i++ & 0xffff)) {
+					set_current_state(TASK_INTERRUPTIBLE);
+					delay = 10 * NSEC_PER_USEC;
+					schedule_hrtimeout(&delay, HRTIMER_MODE_REL);
+				}
 				cond_resched();
+			}
+			set_user_nice(current, oldnice);
 		} else {
 			schedule_timeout_interruptible(round_jiffies_relative(HZ));
 		}
