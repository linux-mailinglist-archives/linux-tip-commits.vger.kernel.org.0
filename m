Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4767128825E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbgJIGgi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732070AbgJIGfn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0C0C0613D6;
        Thu,  8 Oct 2020 23:35:43 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=73bKDFMLfwiTH2HmNqIbh6YZNcW9/seM7FzZ933Bn2o=;
        b=v18cco92/tlfPPR5sdvWBXPaSfrzpLsS6Xd6WKQRWetUdxYqlKS0vN2QOsD/YurEKG8F96
        aydpabvIG5AvHM+Nk+zfuZAYY3vvzOpRJfg1NAVhpvKjVQ5mE/1qtLAtjSq56nyRp1jty6
        KcyLSMeZHsRUSZrAHTLBbUazKIaQ3QFYju1x55X6mP0CYte4Xb+zEHU3gPYN6MkpQwmJtk
        +CzvlZk/TIBY6DLrjG6sAD+IMpSOUdPeyPAaGvXdrINRf5nQYJU4Q7rPUMFL7jSBwhUx5T
        Ph4z0mEt9w3x1sSNJG5RDXf+c12PkicF743cpipDk8C0tK948+u6Or5DVRvFIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=73bKDFMLfwiTH2HmNqIbh6YZNcW9/seM7FzZ933Bn2o=;
        b=Pj/VIp2RRQ7yO6Ex8uwPYxDEbfigW7fORdpQr/1Jd4ONFCc+m/fbLOMlqaJR4sORkdkMZS
        j3kLdy3uUUm+lGBQ==
From:   "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree: Force quiescent state on callback overload
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222534130.7002.18129565337789660727.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     9c39245382de4d52a122641952900709d4a9950b
Gitweb:        https://git.kernel.org/tip/9c39245382de4d52a122641952900709d4a9950b
Author:        Neeraj Upadhyay <neeraju@codeaurora.org>
AuthorDate:    Mon, 22 Jun 2020 00:07:27 +05:30
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:36:05 -07:00

rcu/tree: Force quiescent state on callback overload

On callback overload, it is necessary to quickly detect idle CPUs,
and rcu_gp_fqs_check_wake() checks for this condition.  Unfortunately,
the code following the call to this function does not repeat this check,
which means that in reality no actual quiescent-state forcing, instead
only a couple of quick and pointless wakeups at the beginning of the
grace period.

This commit therefore adds a check for the RCU_GP_FLAG_OVLD flag in
the post-wakeup "if" statement in rcu_gp_fqs_loop().

Fixes: 1fca4d12f4637 ("rcu: Expedite first two FQS scans under callback-overload conditions")
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8969120..4770d77 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1884,7 +1884,7 @@ static void rcu_gp_fqs_loop(void)
 			break;
 		/* If time for quiescent-state forcing, do it. */
 		if (!time_after(rcu_state.jiffies_force_qs, jiffies) ||
-		    (gf & RCU_GP_FLAG_FQS)) {
+		    (gf & (RCU_GP_FLAG_FQS | RCU_GP_FLAG_OVLD))) {
 			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 					       TPS("fqsstart"));
 			rcu_gp_fqs(first_gp_fqs);
