Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586C833F45B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhCQPtU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbhCQPsz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9508C061762;
        Wed, 17 Mar 2021 08:48:54 -0700 (PDT)
Date:   Wed, 17 Mar 2021 15:48:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4VUfWp3cDwcanrdAigcGTljzDx+DYdbCe9us4SpadZ0=;
        b=gFSMVA7mubdrdg1GeLYkxE7nlNMsE/sYHiMGge27VCwa0SafaujhOY7bmh6iGulJYyFl8m
        O549EFne/QVw+L31XfB83UtsURSnxnXclF2S6jfutGTCESft5dy4bxTmnE37a8izsTvufK
        /EtV2EYAV6qU1/9HSFLj+csapU9S29r7WZK97r+J3k+mK//z/zYScZePpz1FKNASQxR5m/
        s8j3txOkFZMqd2A09ivflavd320h15WwdyNGzkcgrnrXBu1f73vUy09Mcjn9TY6n6iZXMD
        v2XVimgjDW3ZewQT6aIIG48DtaVMTuGwkNY0XpW8QIsGubdD2+59CMctQdl1VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4VUfWp3cDwcanrdAigcGTljzDx+DYdbCe9us4SpadZ0=;
        b=aCZpDtGVHKSnj8jhBl/eyNTHl6JV2BLtMkXtvNKfbeObyZ3y69abPqsSPHNMZxbRXhtV5f
        ljiWLXKN4z8OxdDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] rcu: Prevent false positive softirq warning on RT
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309085727.626304079@linutronix.de>
References: <20210309085727.626304079@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599613274.398.8738579314257055609.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ba9e6cab49c1465c2c322dcb03d771d5cbecb692
Gitweb:        https://git.kernel.org/tip/ba9e6cab49c1465c2c322dcb03d771d5cbecb692
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 09 Mar 2021 09:55:58 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:34:12 +01:00

rcu: Prevent false positive softirq warning on RT

Soft interrupt disabled sections can legitimately be preempted or schedule
out when blocking on a lock on RT enabled kernels so the RCU preempt check
warning has to be disabled for RT kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309085727.626304079@linutronix.de

---
 include/linux/rcupdate.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index bd04f72..6d855ef 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -334,7 +334,8 @@ static inline void rcu_preempt_sleep_check(void) { }
 #define rcu_sleep_check()						\
 	do {								\
 		rcu_preempt_sleep_check();				\
-		RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map),	\
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))			\
+		    RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map),	\
 				 "Illegal context switch in RCU-bh read-side critical section"); \
 		RCU_LOCKDEP_WARN(lock_is_held(&rcu_sched_lock_map),	\
 				 "Illegal context switch in RCU-sched read-side critical section"); \
