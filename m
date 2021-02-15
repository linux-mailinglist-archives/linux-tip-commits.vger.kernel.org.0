Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0C931BB85
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhBOO4d (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhBOO4Z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668A1C06178B;
        Mon, 15 Feb 2021 06:55:45 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K9bKSp29cUREGFqbPeqx0oUny9c3YP4FwXNow3LmipU=;
        b=yNzy2efhJbDCHENWQIKoz0s1Rwty19l4ojVhxMstfPgPej9SnE4sLIn7ppBpqpotUMJst5
        rp9A3v0lhRGSZpTHh0k1Y+hMiFQJmYQoUncO7fba//JjZEAHNaQSUlVVO/QXQZb2J9hT56
        8xHyx5Og+qmMA6UBffj72/+N3bidT2+VOvF4igFqfoCvIE1MwnEAEdTs/Stjk+Uh/WdnSS
        HC/CiJH82S9tk0pk0sEJpb1P7/TCSZFKtog2R5y0WZfLZqrc/a8q95CJSvzIChue9BBEcO
        yPZQ54blO8PH75VxFZzV1bcgJGkkPYu8rUv8j0lEbgNqR4gOdc+StcHth0+/uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K9bKSp29cUREGFqbPeqx0oUny9c3YP4FwXNow3LmipU=;
        b=V/BRLVFq6GFufeAEojZdGvS5iSRlMsCMJlrTqW5/nQYq5h97UfdL4J1XRgAj3XfFu04bFL
        poLvy5ouMDyuIqAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] scftorture: Add debug output for wrong-CPU warning
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094252.20312.18417638383007418895.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     f3ea978b712f768a02137e867aced5bfdcea670e
Gitweb:        https://git.kernel.org/tip/f3ea978b712f768a02137e867aced5bfdcea670e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 11 Nov 2020 10:12:05 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:53:41 -08:00

scftorture: Add debug output for wrong-CPU warning

This commit adds the desired CPU, the actual CPU, and nr_cpu_ids to
the wrong-CPU warning in scftorture_invoker(), the better to help with
debugging.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index d55a9f8..2377cbb 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -398,6 +398,7 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 static int scftorture_invoker(void *arg)
 {
 	int cpu;
+	int curcpu;
 	DEFINE_TORTURE_RANDOM(rand);
 	struct scf_statistics *scfp = (struct scf_statistics *)arg;
 	bool was_offline = false;
@@ -412,7 +413,10 @@ static int scftorture_invoker(void *arg)
 	VERBOSE_SCFTORTOUT("scftorture_invoker %d: Waiting for all SCF torturers from cpu %d", scfp->cpu, smp_processor_id());
 
 	// Make sure that the CPU is affinitized appropriately during testing.
-	WARN_ON_ONCE(smp_processor_id() != scfp->cpu);
+	curcpu = smp_processor_id();
+	WARN_ONCE(curcpu != scfp->cpu % nr_cpu_ids,
+		  "%s: Wanted CPU %d, running on %d, nr_cpu_ids = %d\n",
+		  __func__, scfp->cpu, curcpu, nr_cpu_ids);
 
 	if (!atomic_dec_return(&n_started))
 		while (atomic_read_acquire(&n_started)) {
