Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB392342ED
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbgGaJXO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:23:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56476 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732388AbgGaJXM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:12 -0400
Date:   Fri, 31 Jul 2020 09:23:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187391;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tWDLYvHFAeuHLQOF4mmZFIwvvKxHQvyCY01Dr3xXpXk=;
        b=Br4Skf/Wl/qDjzEbR57PL78YtKApH+bng/cStxqDgd2tmwI9PzXFlLVJIoGqWgUtAvhUbo
        +4Ozlgz4iTTKPHGuVzZeCrq31J3ZhIgJKdrE8ple/GgLigQ7RWASBMIjOnklHGaSzLIN4W
        XrQjwkvMFhrrv6XShB78Rg8NNpGy/z84M4acX+ObGkAaKeP67TeGWRasnLajJu5lZJufRX
        QMzZk6yKF10l0/25kkUp1dcnxzG2s4AdRWh3vp9ZT6OX804wRkSrlDxHkwklQs++3nJ9vi
        XUsmAhrpxEUkumquyKRs6C7Uy6a57aggm9H0/9QjILvx9SF+jV4u4tmQXZ7D8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187391;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tWDLYvHFAeuHLQOF4mmZFIwvvKxHQvyCY01Dr3xXpXk=;
        b=Ew51md5NQXqE7cP+bjGR1QmYxut3nSDh6uA2+u8efe16dJnD6iwOa2/Lszjx/vIXBS6H41
        RVDaa+0lH0OTmIAw==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcuperf: Remove useless while loops around wait_event
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618739063.4006.2066950779707384906.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7e866460cc18797b3a59360f5f8c444598a21729
Gitweb:        https://git.kernel.org/tip/7e866460cc18797b3a59360f5f8c444598a21729
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Mon, 25 May 2020 00:36:47 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:44 -07:00

rcuperf: Remove useless while loops around wait_event

wait_event() already retries if the condition for the wake up is not
satisifed after wake up. Remove them from the rcuperf test.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuperf.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index 16dd1e6..246da8f 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -576,11 +576,8 @@ static int compute_real(int n)
 static int
 rcu_perf_shutdown(void *arg)
 {
-	do {
-		wait_event(shutdown_wq,
-			   atomic_read(&n_rcu_perf_writer_finished) >=
-			   nrealwriters);
-	} while (atomic_read(&n_rcu_perf_writer_finished) < nrealwriters);
+	wait_event(shutdown_wq,
+		   atomic_read(&n_rcu_perf_writer_finished) >= nrealwriters);
 	smp_mb(); /* Wake before output. */
 	rcu_perf_cleanup();
 	kernel_power_off();
@@ -693,11 +690,8 @@ kfree_perf_cleanup(void)
 static int
 kfree_perf_shutdown(void *arg)
 {
-	do {
-		wait_event(shutdown_wq,
-			   atomic_read(&n_kfree_perf_thread_ended) >=
-			   kfree_nrealthreads);
-	} while (atomic_read(&n_kfree_perf_thread_ended) < kfree_nrealthreads);
+	wait_event(shutdown_wq,
+		   atomic_read(&n_kfree_perf_thread_ended) >= kfree_nrealthreads);
 
 	smp_mb(); /* Wake before output. */
 
