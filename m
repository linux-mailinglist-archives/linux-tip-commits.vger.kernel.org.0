Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB92522C0E2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Jul 2020 10:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgGXIe7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 24 Jul 2020 04:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgGXIdm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC4BC0619D3;
        Fri, 24 Jul 2020 01:33:42 -0700 (PDT)
Date:   Fri, 24 Jul 2020 08:33:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YM+dktwy6hZYHzBJ7JFif/FV77D56WitMVi8mX4D9Tg=;
        b=fWDDtUG5PPxpEym5nHaOgKHMEFhaWMfM92W57nonsTRoOGgcCXggElM7u0zFgrarVRiiJv
        XxnnxyW9qmKWA9jEZI2Z8iLasHc7wOtKHmYou6EWlCakWxX6iuREutLXGnaXOQi/A05lyd
        W+RZthc9dz7PV+zrs27niZWC4BzcwIvqVnSVjtwT92N45DOGNguLAPiIxTHhhIPcDmoYmY
        ArgRiRadsxVpgDlJvx0nEucWt++7nYmpLOksfwWhDirnUz1m+ddLYJmpwIaW/hmAB9FVZj
        MzqwP30+FVq5hKGdPGY4AytDO6X5pQ0bIgkGWUnIL7SG58QtxgQpRm/1oXZeZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YM+dktwy6hZYHzBJ7JFif/FV77D56WitMVi8mX4D9Tg=;
        b=P4Gg3ty+tUJYlqbNqtcgah7NrLTripsDT7hTabCp/zkXssAo5c/StbPcKB9clbFwmU+qrv
        Q4z7Pd9wCJPRU8AQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,rcutorture: Convert to sched_set_fifo_low()
Cc:     paulmck@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557961998.4006.14486399918150443631.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     ce1c8afd3f3119ddaddcdff27579f5723f55c75e
Gitweb:        https://git.kernel.org/tip/ce1c8afd3f3119ddaddcdff27579f5723f55c75e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:25 +02:00

sched,rcutorture: Convert to sched_set_fifo_low()

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

Effectively no change.

Cc: paulmck@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index efb792e..bbc3c8a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -889,13 +889,11 @@ static int rcu_torture_boost(void *arg)
 	unsigned long endtime;
 	unsigned long oldstarttime;
 	struct rcu_boost_inflight rbi = { .inflight = 0 };
-	struct sched_param sp;
 
 	VERBOSE_TOROUT_STRING("rcu_torture_boost started");
 
 	/* Set real-time priority. */
-	sp.sched_priority = 1;
-	if (sched_setscheduler(current, SCHED_FIFO, &sp) < 0) {
+	if (sched_set_fifo_low(current) < 0) {
 		VERBOSE_TOROUT_STRING("rcu_torture_boost RT prio failed!");
 		n_rcu_torture_boost_rterror++;
 	}
