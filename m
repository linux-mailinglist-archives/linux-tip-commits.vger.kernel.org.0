Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE5731BB88
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhBOO4g (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:56:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33100 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhBOO40 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:26 -0500
Date:   Mon, 15 Feb 2021 14:55:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4xXGIgU2kaxNdTzlTpv0MIPJkbMjPZPxdoMjjwc9QVs=;
        b=QP/i+UIcPeezjaWWq7skZMzGEbM7ZgHTalAnozkYd1shnkAdE3luS10jquDQMa4L5hdNQw
        B/4pHol6znrv5NKJQ8FhJsSyhJ7338QoyUnVvBr6SYRfXFRA7s2kZuGlEaAr0iI/FFzWH5
        9X9YnuTUjF7bX8JOgI/j2G9iGQVWSWShIVEGJ4jaT3LFylYjM8URePiD0N2AN6QvKvYa1z
        yFI12sz4vsgRLjqN3qus/Wl6dGNC8GvBoUFZ7fw+G0r6gYhSjhDpV/b/o3oQGVTYJDdb5A
        gLzMw3c3ou4Pse+8HpHPIRAXg51+qANmOImWZ2acs0AH0eKR1sDmPhkWTGCP0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=4xXGIgU2kaxNdTzlTpv0MIPJkbMjPZPxdoMjjwc9QVs=;
        b=Gpd4SbtWQKM9SypZGX9h7MINbaSuTO+SJXe+7JN8BPcOKFGyHADGs2b/t1o8UGtFqFQfBj
        taPIwkQKXZn7MtDg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Add reader-side tests of polling grace-period API
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094315.20312.17192020164195875784.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     bc480a6354ef2e15c26c3bdbd0db647026e788a7
Gitweb:        https://git.kernel.org/tip/bc480a6354ef2e15c26c3bdbd0db647026e788a7
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 15 Nov 2020 12:45:57 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:53:40 -08:00

rcutorture: Add reader-side tests of polling grace-period API

This commit adds reader-side testing of the polling grace-period API.
This testing verifies that a cookie obtained in an SRCU read-side critical
section does not get a true return from poll_state_synchronize_srcu()
within that same critical section.

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 78ba95d..96d55f0 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1429,6 +1429,7 @@ rcutorture_loop_extend(int *readstate, struct torture_random_state *trsp,
  */
 static bool rcu_torture_one_read(struct torture_random_state *trsp)
 {
+	unsigned long cookie;
 	int i;
 	unsigned long started;
 	unsigned long completed;
@@ -1444,6 +1445,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 	WARN_ON_ONCE(!rcu_is_watching());
 	newstate = rcutorture_extend_mask(readstate, trsp);
 	rcutorture_one_extend(&readstate, newstate, trsp, rtrsp++);
+	if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
+		cookie = cur_ops->get_gp_state();
 	started = cur_ops->get_gp_seq();
 	ts = rcu_trace_clock_local();
 	p = rcu_dereference_check(rcu_torture_current,
@@ -1480,6 +1483,13 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 	}
 	__this_cpu_inc(rcu_torture_batch[completed]);
 	preempt_enable();
+	if (cur_ops->get_gp_state && cur_ops->poll_gp_state)
+		WARN_ONCE(cur_ops->poll_gp_state(cookie),
+			  "%s: Cookie check 3 failed %s(%d) %lu->%lu\n",
+			  __func__,
+			  rcu_torture_writer_state_getname(),
+			  rcu_torture_writer_state,
+			  cookie, cur_ops->get_gp_state());
 	rcutorture_one_extend(&readstate, 0, trsp, rtrsp);
 	WARN_ON_ONCE(readstate & RCUTORTURE_RDR_MASK);
 	// This next splat is expected behavior if leakpointer, especially
