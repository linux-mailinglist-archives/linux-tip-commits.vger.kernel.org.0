Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB592D8FF8
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394477AbgLMTTC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390858AbgLMTCp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95143C0619D2;
        Sun, 13 Dec 2020 11:01:10 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=G7QLHTegqDOMbTL7Eolqj5e3EEvh3LxSWYrSs8xHqV8=;
        b=u6ferVDrP6I+tUzXNwb14CJchkAx3RfW5So1hzDJ2GJ3iRHEJ+1z3E6kQipFQqfXwOn/iT
        BBR+Dj198UjJk3dqMmRk+0qdNqaLRVDZLkTmVGHXdeuuxkpV3PU4K595IbEAf5fRyGxfKO
        ykDGy9Yn4WXgYQkczG8GkX5DRRzYSJKL3FyJluKFkyYRRPojEq6K2v71KO5oLr/SM70re/
        MQYY+ZND9lYmm3h2uwI7YZv3R2iwpXV+Ggk1O+hVSGPkD8qNaxghThy/Bkxb3SJ/yd6Vne
        hFDZB0NGS0yDm6hjtkvu5fLfzbb1kVgk9GPmdi3vZSSNcHzkv9YuywrhL13pbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=G7QLHTegqDOMbTL7Eolqj5e3EEvh3LxSWYrSs8xHqV8=;
        b=C2gbe4WYv4ghLb1VwYyKZqB6GnGRWX5tVm56bccRIBtqKcmXRn+FWRibterW2WTpOGiw3F
        grCb492/hI+Ku5DA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Prevent hangs for invalid arguments
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606872.3364.1545706199518102462.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     4994684ce10924a0302567c315c91b0a64eeef46
Gitweb:        https://git.kernel.org/tip/4994684ce10924a0302567c315c91b0a64eeef46
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 18 Sep 2020 13:30:33 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:53 -08:00

rcutorture: Prevent hangs for invalid arguments

If an rcutorture torture-test run is given a bad kvm.sh argument, the
test will complain to the console, which is good.  What is bad is that
from the user's perspective, it will just hang for the time specified
by the --duration argument.  This commit therefore forces an immediate
kernel shutdown if a rcu_torture_init()-time error occurs, thus avoiding
the appearance of a hang.  It also forces a console splat in this case
to clearly indicate the presence of an error.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 916ea4f..db37671 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2647,7 +2647,6 @@ rcu_torture_init(void)
 		for (i = 0; i < ARRAY_SIZE(torture_ops); i++)
 			pr_cont(" %s", torture_ops[i]->name);
 		pr_cont("\n");
-		WARN_ON(!IS_MODULE(CONFIG_RCU_TORTURE_TEST));
 		firsterr = -EINVAL;
 		cur_ops = NULL;
 		goto unwind;
@@ -2815,6 +2814,10 @@ rcu_torture_init(void)
 unwind:
 	torture_init_end();
 	rcu_torture_cleanup();
+	if (shutdown_secs) {
+		WARN_ON(!IS_MODULE(CONFIG_RCU_TORTURE_TEST));
+		kernel_power_off();
+	}
 	return firsterr;
 }
 
