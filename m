Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A00B2D8FAE
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgLMTEJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:04:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46450 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgLMTBo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:44 -0500
Date:   Sun, 13 Dec 2020 19:01:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0Nv/PJh7dwxulY0qmnXEP+WSQ7CYQccSMJKPCqnH5Ro=;
        b=DPDK9NECXeuvZgr1YSi8Cf4dK7gbadnOpdpk1msFx1aFZFdVJ0PD/bASm1FXYLGm7l9+FJ
        jNi3hfakw0oqBejOLeVeUFZyY2nwFDneMEyaLVArZbtWQJQw11H7CIYQqVRKMM/ShYgABr
        /Z/DOvVl/NHt9+Yi5/DDMcCiPgD3ojQ2PZ+YCPzqp7cOImecGCXA5cnZ0E1EO4SqwJ9DtY
        fQnkPXtS/OzWJrUlQoNZeyBufhcLncMV2EXLKhRmf0k03c3aXwUzfM2UC9fYnu5mVs6sDG
        zCeqzyxEifyxHzHdAnIAeCokkCSWOXH4IK9ODdQcx3CbjlXFbOVivuhV7S0tUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0Nv/PJh7dwxulY0qmnXEP+WSQ7CYQccSMJKPCqnH5Ro=;
        b=UuzTZfhSGP/nWyoBsOUy1RfT4GmdU1PR57px07lgU9uXjoHumkbhe8Wm2i//4MSUCKXZ1y
        glPYsb731ym3EvDQ==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree: nocb: Avoid raising softirq for offloaded
 ready-to-execute CBs
Cc:     Neeraj Upadhyay <neeraju@codeaurora.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606053.3364.4345333662369014444.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     bd56e0a4a291bc9db2cbaddef20ec61a1aad4208
Gitweb:        https://git.kernel.org/tip/bd56e0a4a291bc9db2cbaddef20ec61a1aad4208
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Wed, 07 Oct 2020 13:50:36 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 19 Nov 2020 19:37:17 -08:00

rcu/tree: nocb: Avoid raising softirq for offloaded ready-to-execute CBs

Testing showed that rcu_pending() can return 1 when offloaded callbacks
are ready to execute.  This invokes RCU core processing, for example,
by raising RCU_SOFTIRQ, eventually resulting in a call to rcu_core().
However, rcu_core() explicitly avoids in any way manipulating offloaded
callbacks, which are instead handled by the rcuog and rcuoc kthreads,
which work independently of rcu_core().

One exception to this independence is that rcu_core() invokes
do_nocb_deferred_wakeup(), however, rcu_pending() also checks
rcu_nocb_need_deferred_wakeup() in order to correctly handle this case,
invoking rcu_core() when needed.

This commit therefore avoids needlessly invoking RCU core processing
by checking rcu_segcblist_ready_cbs() only on non-offloaded CPUs.
This reduces overhead, for example, by reducing softirq activity.

This change passed 30 minute tests of TREE01 through TREE09 each.

On TREE08, there is at most 150us from the time that rcu_pending() chose
not to invoke RCU core processing to the time when the ready callbacks
were invoked by the rcuoc kthread.  This provides further evidence that
there is no need to invoke rcu_core() for offloaded callbacks that are
ready to invoke.

Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d6a015e..50d90ee 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3718,7 +3718,8 @@ static int rcu_pending(int user)
 		return 1;
 
 	/* Does this CPU have callbacks ready to invoke? */
-	if (rcu_segcblist_ready_cbs(&rdp->cblist))
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist) &&
+	    rcu_segcblist_ready_cbs(&rdp->cblist))
 		return 1;
 
 	/* Has RCU gone idle with this CPU needing another grace period? */
