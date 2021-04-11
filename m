Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E6235B51B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbhDKNpM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:45:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33472 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbhDKNoZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:25 -0400
Date:   Sun, 11 Apr 2021 13:43:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=o9DyPl1wMPCboiIuFhlis/idjad7mZ2Miq7rIOhn1KI=;
        b=YnkkVFehQNL2iEB1IPEj16LVoIlWnpI37Fy4d9KeoYwapKYCAeLPtIOXSCKWk8MJVv8tEz
        MNi9tQ2jwyRaZs7g/T9HI5P7YutYyi0iYu2iw5LGiGlhu/aeE2goc15tiysH3W3Wug/fB2
        iPyo3slUn7jeN0AzletoMmWHYMLfiFZniozLoQxEfRp+2K898PscLi7CvQ8IeIxtChrPaI
        ZiV/qlnW6q7qFKUSJKfmWPhxd0Wi4Rz6iqNDXS66dkTIF02fRGn3a80NGtwnowJXfMVkF8
        dD0kXVo+4Q0lkqJo6J5XGnJU4KwYkLXTAX5S08IVrrlP1pWWdZpCrNIjAE7YCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=o9DyPl1wMPCboiIuFhlis/idjad7mZ2Miq7rIOhn1KI=;
        b=ySx/3Gda2J9Ruu+BCgiKVd5sbBzdyiLlum4T0qLLnA1Sya8WRJBQyVbjR5z8kQArXR7Jua
        VGIEpZRteBcY7jBw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Remove superfluous rdp fetch
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814862300.29796.10245179127236295536.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d3ad5bbc4da70c25ad6b386e038e711d0755767b
Gitweb:        https://git.kernel.org/tip/d3ad5bbc4da70c25ad6b386e038e711d0755767b
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 06 Jan 2021 23:07:15 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:17:35 -08:00

rcu: Remove superfluous rdp fetch

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar<mingo@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index da6f521..cdf091f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -648,7 +648,6 @@ static noinstr void rcu_eqs_enter(bool user)
 	instrumentation_begin();
 	trace_rcu_dyntick(TPS("Start"), rdp->dynticks_nesting, 0, atomic_read(&rdp->dynticks));
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
-	rdp = this_cpu_ptr(&rcu_data);
 	rcu_prepare_for_idle();
 	rcu_preempt_deferred_qs(current);
 
