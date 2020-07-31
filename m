Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F84234289
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732540AbgGaJXm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732534AbgGaJXl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAB3C061574;
        Fri, 31 Jul 2020 02:23:41 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:23:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DvoLE/JY5LwefemuH9CN/d633R7C50AHRegQTdSbONs=;
        b=nLbpSaU3sHh2JkdjGnQM49P9AHOqglyRn4cvUgeLQKVrAOD8FNy7BIc3BgEzD8/cDoZrWM
        N/mXa5u/BHPSZ7AAW3rG4RBnNezAmvv/bKFMsTS67kkES9z0O53ZyN7hPbic09dmZsvLi3
        ofYF6mZZGMqllMqQrWim/uQ3dCQ+WKWleaigkYloj3m7ypEBO/f8fyEKKVcaIoU3ZuOWVt
        Oy4qNQfPqgtS4DAHCCvJwwzVY2S9Lew/nPFDvGx36pCviOxEwAGu5WygDJLUzfrZoL7CFE
        lNeiscLcfl/s1X0Ty1Cbd/NOY0pYhm/PrrVtkDAINHevRLs8Bfw/b84Sw2nSBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DvoLE/JY5LwefemuH9CN/d633R7C50AHRegQTdSbONs=;
        b=4ntfbXmK04euoSKU7wXpDTMc20OEq8225UU1H3PfLuJ25zEb1rKSJTmPv7jAQUoZ7B7d1P
        aOaI5RkJOgrg7lCg==
From:   "tip-bot2 for Wei Yang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Simplify the calculation of rcu_state.ncpus
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618741942.4006.16696150175049470222.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     abfce0414814149f716e1d30da1fb3140d1b3473
Gitweb:        https://git.kernel.org/tip/abfce0414814149f716e1d30da1fb3140d1b3473
Author:        Wei Yang <richard.weiyang@gmail.com>
AuthorDate:    Sun, 19 Apr 2020 21:57:15 
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:49 -07:00

rcu: Simplify the calculation of rcu_state.ncpus

There is only 1 bit set in mask, which means that the only difference
between oldmask and the new one will be at the position where the bit is
set in mask.  This commit therefore updates rcu_state.ncpus by checking
whether the bit in mask is already set in rnp->expmaskinitnext.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6c6569e..bef1dc9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3842,10 +3842,9 @@ void rcu_cpu_starting(unsigned int cpu)
 {
 	unsigned long flags;
 	unsigned long mask;
-	int nbits;
-	unsigned long oldmask;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
+	bool newcpu;
 
 	if (per_cpu(rcu_cpu_started, cpu))
 		return;
@@ -3857,12 +3856,10 @@ void rcu_cpu_starting(unsigned int cpu)
 	mask = rdp->grpmask;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
-	oldmask = rnp->expmaskinitnext;
+	newcpu = !(rnp->expmaskinitnext & mask);
 	rnp->expmaskinitnext |= mask;
-	oldmask ^= rnp->expmaskinitnext;
-	nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
 	/* Allow lockless access for expedited grace periods. */
-	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + nbits); /* ^^^ */
+	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + newcpu); /* ^^^ */
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.ncpus);
 	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
