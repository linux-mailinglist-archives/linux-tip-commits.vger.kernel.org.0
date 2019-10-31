Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D649CEAF8B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2019 12:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfJaL47 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 31 Oct 2019 07:56:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55430 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfJaLzY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92v-000365-9W; Thu, 31 Oct 2019 12:55:21 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EFD591C06CD;
        Thu, 31 Oct 2019 12:55:07 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:07 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Make in-kernel-loop testing more brutal
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252290769.29376.3589481983002794153.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     fbbd5e358cecb5fa490550ace66463517a7577e8
Gitweb:        https://git.kernel.org/tip/fbbd5e358cecb5fa490550ace66463517a7577e8
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 15 Aug 2019 11:43:53 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sat, 05 Oct 2019 11:50:18 -07:00

rcutorture: Make in-kernel-loop testing more brutal

The rcu_torture_fwd_prog_nr() tests the ability of RCU to tolerate
in-kernel busy loops.  It invokes rcu_torture_fwd_prog_cond_resched()
within its delay loop, which, in PREEMPT && NO_HZ_FULL kernels results
in the occasional direct call to schedule().  Now, this direct call to
schedule() is appropriate for call_rcu() flood testing, in which either
the kernel should restrain itself or userspace transitions will supply
the needed restraint.  But in pure in-kernel loops, the occasional
cond_resched() should do the job.

This commit therefore makes rcu_torture_fwd_prog_nr() use cond_resched()
instead of rcu_torture_fwd_prog_cond_resched() in order to increase the
brutality of this aspect of rcutorture testing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5ac4672..df1caa9 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1806,7 +1806,7 @@ static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
 		udelay(10);
 		cur_ops->readunlock(idx);
 		if (!fwd_progress_need_resched || need_resched())
-			rcu_torture_fwd_prog_cond_resched(1);
+			cond_resched();
 	}
 	(*tested_tries)++;
 	if (!time_before(jiffies, stopat) &&
