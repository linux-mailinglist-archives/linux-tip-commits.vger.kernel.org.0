Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E362882C7
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbgJIGjr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:39:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55382 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731812AbgJIGfN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:13 -0400
Date:   Fri, 09 Oct 2020 06:35:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=KWNhhWJ562cRLHT28WuO6VhbvPGFEY3yyCND+UYaMS8=;
        b=03w1AWDsJx59Ul99megY2Bmeuzng9NUOHR78DuAgQir1TPxlrojTHUwS7btsHWY9sEWba+
        9FrXkFB880GkTySEojF/b5RE4CuQfP6H6+2xt4eeTtnacavnVtspK+2cq4qVpcxmfapSyS
        6YYdmdVMZxLaML0HtVL+0SHBMuk1d164tfPfgItaJ8sk3FXG2Fpg0hjYnhaYXRBxzo6lf8
        PdFhn4foU2nenXFLn7WD5B6JsGNYC2MgbwQFR0uPOBAyzZAe1ntTxCbXUaLa/mdI8UEVqI
        3NEqA4csPyOU7n+SFg3S/O0j8THCVqeo1hY/SdsSPuSIJ6xHCXySLWcAAu2VtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=KWNhhWJ562cRLHT28WuO6VhbvPGFEY3yyCND+UYaMS8=;
        b=0ZKoeTJrTWwsIkGaq0BwAlDNTZ5EV3dMuqq5YLZ5H5ifVkfy4mM/BsMrzly94aVyxYRm9R
        680v4uC52+uZw7Cw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Allow pointer leaks to test diagnostic code
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222531096.7002.13517221420771141991.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d685514260e21aabd65a9aa8be045766bdaa0549
Gitweb:        https://git.kernel.org/tip/d685514260e21aabd65a9aa8be045766bdaa0549
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 11 Aug 2020 10:33:39 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:45:36 -07:00

rcutorture: Allow pointer leaks to test diagnostic code

This commit adds an rcutorture.leakpointer module parameter that
intentionally leaks an RCU-protected pointer out of the RCU read-side
critical section and checks to see if the corresponding grace period
has elapsed, emitting a WARN_ON_ONCE() if so.  This module parameter can
be used to test facilities like CONFIG_RCU_STRICT_GRACE_PERIOD that end
grace periods quickly.

While in the area, also document rcutorture.irqreader, which was
previously left out.

Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
 kernel/rcu/rcutorture.c                         |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdc1f33..6d984f1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4269,6 +4269,18 @@
 			are zero, rcutorture acts as if is interpreted
 			they are all non-zero.
 
+	rcutorture.irqreader= [KNL]
+			Run RCU readers from irq handlers, or, more
+			accurately, from a timer handler.  Not all RCU
+			flavors take kindly to this sort of thing.
+
+	rcutorture.leakpointer= [KNL]
+			Leak an RCU-protected pointer out of the reader.
+			This can of course result in splats, and is
+			intended to test the ability of things like
+			CONFIG_RCU_STRICT_GRACE_PERIOD=y to detect
+			such leaks.
+
 	rcutorture.n_barrier_cbs= [KNL]
 			Set callbacks/threads for rcu_barrier() testing.
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 983f82f..916ea4f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -87,6 +87,7 @@ torture_param(bool, gp_normal, false,
 	     "Use normal (non-expedited) GP wait primitives");
 torture_param(bool, gp_sync, false, "Use synchronous GP wait primitives");
 torture_param(int, irqreader, 1, "Allow RCU readers from irq handlers");
+torture_param(int, leakpointer, 0, "Leak pointer dereferences from readers");
 torture_param(int, n_barrier_cbs, 0,
 	     "# of callbacks/kthreads for barrier testing");
 torture_param(int, nfakewriters, 4, "Number of RCU fake writer threads");
@@ -1401,6 +1402,9 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 	preempt_enable();
 	rcutorture_one_extend(&readstate, 0, trsp, rtrsp);
 	WARN_ON_ONCE(readstate & RCUTORTURE_RDR_MASK);
+	// This next splat is expected behavior if leakpointer, especially
+	// for CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels.
+	WARN_ON_ONCE(leakpointer && READ_ONCE(p->rtort_pipe_count) > 1);
 
 	/* If error or close call, record the sequence of reader protections. */
 	if ((pipe_count > 1 || completed > 1) && !xchg(&err_segs_recorded, 1)) {
