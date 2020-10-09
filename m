Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE482882C9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbgJIGjs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:39:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55364 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731799AbgJIGfN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:13 -0400
Date:   Fri, 09 Oct 2020 06:35:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225310;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WAxjOUB9rtODp/BI/jYbe1P5W3QNUhSlB17Dz+TBlKk=;
        b=3g5vbdoyzcnjx+tFiJfmAOogY32FpX7Vu1ehs6uRJZj6Nqbw1XdYTsldlY/9DFuXgHJ4tq
        MGoFl21I9TkW+W+BMDCsvMlgv184TDjRnB/MAUtYth0xwK2AzmV1Gng8tQZj0LYdKNP6HC
        BDHQ1fVznJREDNIYeoLnI/qxCfJUPRluHsEiSg7a7bgkoQEtIWV3rBZY/Jor4scPvOC586
        6TVyGfDFx6TDZdu8dkT/omfz2AiL76BRX/IAL5Mnp8yM3Wy/FQgMRHvxzeYK3+M+lyxhr0
        fhlLZUW84WgK9r3II6TJC4CPlFaY1Xl3fO6sJLwNtNcUPFCha8B52LyTjfQqFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225310;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WAxjOUB9rtODp/BI/jYbe1P5W3QNUhSlB17Dz+TBlKk=;
        b=fPpHpVa+Ipjyd24R/4pZhIpFoN+YebjZHOOz0nhXeJk94LqRbRnwoIqHwtT/ieg35Oh2Uv
        BZoqnYz1v/c17MBQ==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/segcblist: Prevent useless GP start if no CBs to
 accelerate
Cc:     urezki@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222530981.7002.4276533268486366820.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     53922270d21de707a1a0ffaf1e07644e77fcb8db
Gitweb:        https://git.kernel.org/tip/53922270d21de707a1a0ffaf1e07644e77fcb8db
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Thu, 18 Jun 2020 16:29:49 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 03 Sep 2020 09:39:59 -07:00

rcu/segcblist: Prevent useless GP start if no CBs to accelerate

The rcu_segcblist_accelerate() function returns true iff it is necessary
to request another grace period.  A tracing session showed that this
function unnecessarily requests grace periods.

For example, consider the following sequence of events:
1. Callbacks are queued only on the NEXT segment of CPU A's callback list.
2. CPU A runs RCU_SOFTIRQ, accelerating these callbacks from NEXT to WAIT.
3. Thus rcu_segcblist_accelerate() returns true, requesting grace period N.
4. RCU's grace-period kthread wakes up on CPU B and starts grace period N.
4. CPU A notices the new grace period and invokes RCU_SOFTIRQ.
5. CPU A's RCU_SOFTIRQ again invokes rcu_segcblist_accelerate(), but
   there are no new callbacks.  However, rcu_segcblist_accelerate()
   nevertheless (uselessly) requests a new grace period N+1.

This extra grace period results in additional lock contention and also
additional wakeups, all for no good reason.

This commit therefore adds a check to rcu_segcblist_accelerate() that
prevents the return of true when there are no new callbacks.

This change reduces the number of grace periods (GPs) and wakeups in each
of eleven five-second rcutorture runs as follows:

+----+-------------------+-------------------+
| #  | Number of GPs     | Number of Wakeups |
+====+=========+=========+=========+=========+
| 1  | With    | Without | With    | Without |
+----+---------+---------+---------+---------+
| 2  |      75 |      89 |     113 |     119 |
+----+---------+---------+---------+---------+
| 3  |      62 |      91 |     105 |     123 |
+----+---------+---------+---------+---------+
| 4  |      60 |      79 |      98 |     110 |
+----+---------+---------+---------+---------+
| 5  |      63 |      79 |      99 |     112 |
+----+---------+---------+---------+---------+
| 6  |      57 |      89 |      96 |     123 |
+----+---------+---------+---------+---------+
| 7  |      64 |      85 |      97 |     118 |
+----+---------+---------+---------+---------+
| 8  |      58 |      83 |      98 |     113 |
+----+---------+---------+---------+---------+
| 9  |      57 |      77 |      89 |     104 |
+----+---------+---------+---------+---------+
| 10 |      66 |      82 |      98 |     119 |
+----+---------+---------+---------+---------+
| 11 |      52 |      82 |      83 |     117 |
+----+---------+---------+---------+---------+

The reduction in the number of wakeups ranges from 5% to 40%.

Cc: urezki@gmail.com
[ paulmck: Rework commit log and comment. ]
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 9a0f661..2d2a6b6 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -475,8 +475,16 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 	 * Also advance to the oldest segment of callbacks whose
 	 * ->gp_seq[] completion is at or after that passed in via "seq",
 	 * skipping any empty segments.
+	 *
+	 * Note that segment "i" (and any lower-numbered segments
+	 * containing older callbacks) will be unaffected, and their
+	 * grace-period numbers remain unchanged.  For example, if i ==
+	 * WAIT_TAIL, then neither WAIT_TAIL nor DONE_TAIL will be touched.
+	 * Instead, the CBs in NEXT_TAIL will be merged with those in
+	 * NEXT_READY_TAIL and the grace-period number of NEXT_READY_TAIL
+	 * would be updated.  NEXT_TAIL would then be empty.
 	 */
-	if (++i >= RCU_NEXT_TAIL)
+	if (rcu_segcblist_restempty(rsclp, i) || ++i >= RCU_NEXT_TAIL)
 		return false;
 
 	/*
