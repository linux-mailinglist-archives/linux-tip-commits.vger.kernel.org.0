Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD91234283
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732493AbgGaJXe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:23:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56476 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732482AbgGaJXd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:33 -0400
Date:   Fri, 31 Jul 2020 09:23:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0KgVErvS4zYfMOo0kghBf5qhs87t54iZnK/iBrfC4MM=;
        b=DqgG4WzyNSO8UibuI+V9uzWXIo3EQAXF4BMxYEACjM421IRUfE75w1NdxsdHhkKcfaSo8F
        kC9D2BSBWtelKzieVGfSI1bXYJDtUwzVg8VLEjnockSQ+BQaDfoCVvDbo8GhGw3wdPW1J+
        Cxa1gq/89ZIdXtyzaPqm+6rfjlRudmXC8/fmZ733JYcwyYWXmPKaAdbuox34ubPFJ2glUN
        /vPI9AwPn0mdvU50Z4FCloYDW9rgIhX2ttvhbqkdGwDT6bo9PNV41cLEIy0/QOgbbMntDb
        jlscY6YYPLMh4YwRylDpZiK/hBODkhjw96z+BZXmRvrZwv211axUt3GaycoHUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187411;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0KgVErvS4zYfMOo0kghBf5qhs87t54iZnK/iBrfC4MM=;
        b=gTvfxXCGLXWCswwUYatvquvpQRsNFKTc5GifxeRTrUcqsOdSwK118ZUSwMMPn+LLarDdGJ
        IXaYny69D6g1TxDA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] lockdep: Complain only once about RCU in extended
 quiescent state
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87wo4wnpzb.fsf@nanos.tec.linutronix.de>
References: <87wo4wnpzb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <159618741060.4006.12964143796256427824.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d29e0b26b020422cc51b5b51733cc50fcf443965
Gitweb:        https://git.kernel.org/tip/d29e0b26b020422cc51b5b51733cc50fcf443965
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 28 May 2020 08:49:29 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:51 -07:00

lockdep: Complain only once about RCU in extended quiescent state

Currently, lockdep_rcu_suspicious() complains twice about RCU read-side
critical sections being invoked from within extended quiescent states,
for example:

	RCU used illegally from idle CPU!
	rcu_scheduler_active = 2, debug_locks = 1
	RCU used illegally from extended quiescent state!

This commit therefore saves a couple lines of code and one line of
console-log output by eliminating the first of these two complaints.

Link: https://lore.kernel.org/lkml/87wo4wnpzb.fsf@nanos.tec.linutronix.de
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/locking/lockdep.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 29a8de4..0a7549d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5851,9 +5851,7 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	pr_warn("\n%srcu_scheduler_active = %d, debug_locks = %d\n",
 	       !rcu_lockdep_current_cpu_online()
 			? "RCU used illegally from offline CPU!\n"
-			: !rcu_is_watching()
-				? "RCU used illegally from idle CPU!\n"
-				: "",
+			: "",
 	       rcu_scheduler_active, debug_locks);
 
 	/*
