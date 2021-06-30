Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775803B83F0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbhF3NvY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:51:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33020 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbhF3Nue (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:34 -0400
Date:   Wed, 30 Jun 2021 13:47:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060874;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5Rl6vUD6Pt3BPKFJxSPdG/nGIhNV+czVSIxaEdJNjyY=;
        b=oFzF+WzcLin8tIkBQ93ti1Ye9Fw4ncPlk0UyhNeIBEHZ2PhhhwHN09STgWuVzsgEjWcKWK
        SvxvzzpWakbniUmxgFPR3+0YIWkKSs2PoWLbLFRwgLK2J6AChakYYz9Gc6x09LTBgzhabo
        F0DAn2rOG5pT0+mUk1Rw2xGjQci7LzxwKGDDxUSY3b8uHBWwrmA5OB7GdkXEEphynUZ6s8
        Upu5xCRjmGtaWopCooTGFFDVvSLeVtQcCtaB5tViyIaYZ0wsgzt74vDIndCMV8bhO7ko0J
        dx8toFwosBkuLJNypbMqkoobdLiNAjrfcs4SKE56aan+IWYpzug5eWdre/C2Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060874;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5Rl6vUD6Pt3BPKFJxSPdG/nGIhNV+czVSIxaEdJNjyY=;
        b=UyywAFBMvnmhMHj1xwZvIqQ96caVfeyCxzFUgqhVo+2HfXXcegAUJnpsHx37/MOMkt7Ers
        6QqQ9gKxMnZoPWAA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Remove superfluous ssp initialization for early
 callbacks
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506087380.395.2450772675330426567.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c75e9d29159b94904d10b23ad6aebdf869b61106
Gitweb:        https://git.kernel.org/tip/c75e9d29159b94904d10b23ad6aebdf869b61106
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 02 Apr 2021 01:47:02 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:03:34 -07:00

srcu: Remove superfluous ssp initialization for early callbacks

Pre-srcu_init() invocations of call_srcu() initialize the srcu_struct
structure in question, so there is no need to check this initialization
in srcu_init() when initiating grace periods for srcu_struct structures
that had early call_srcu() invocations.  This commit therefore drops
the calls to check_init_srcu_struct() in srcu_init().

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 3414aff..f4f0cbf 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1388,7 +1388,6 @@ void __init srcu_init(void)
 	while (!list_empty(&srcu_boot_list)) {
 		ssp = list_first_entry(&srcu_boot_list, struct srcu_struct,
 				      work.work.entry);
-		check_init_srcu_struct(ssp);
 		list_del_init(&ssp->work.work.entry);
 		queue_work(rcu_gp_wq, &ssp->work.work);
 	}
