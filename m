Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DB63B83AD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhF3Nub (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbhF3NuG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA319C0611C1;
        Wed, 30 Jun 2021 06:47:36 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DU+g2Br/5uhTVGutGXt2LRCn0Fiq5VLVEpXQidC0Hew=;
        b=Blg27ED2vTo42MgWjS6frUKZpId3mTds0VMwuQAJn3IsVLrQGE07KYUV+kGYIJ0xm4WBne
        mjtmAEd9hKu+c5byD/I1wB+6CM0eRL+toP/lDRhhdl5GP1Ti1pAxLvhwTViuZI84PvmFX7
        D7Xp9gsvveap+WCekHdgs9QADBZxLJXCh0ST9uPa8Bbx13xtFHE+EEiGI7Jom/4pze62v9
        e7zRelBZoiZ/tlhNdK+0vVch3vS989iwv5YoWrYVTcTqUwZpcmoCR1/yVic/RYZZvoGQVx
        IA9OuZg76CjNcU6cnXuABugFH0Wwau60MbNr8KpjmCnc7Zj4TCvTly6rlalzng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DU+g2Br/5uhTVGutGXt2LRCn0Fiq5VLVEpXQidC0Hew=;
        b=OH+JKIsbDMU0mm7rEFxOCUkrzRGD1SB/K4QjBz/h4s7p14uXVVtpxnhJ8cxB56QWR4cbfn
        pVpvLONVgvZDLaCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Reject RCU_LOCKDEP_WARN() false positives
Cc:     syzbot+dde0cc33951735441301@syzkaller.appspotmail.com,
        Matthew Wilcox <willy@infradead.org>,
        syzbot+88e4f02896967fe1ab0d@syzkaller.appspotmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506085491.395.17524374219853971312.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3066820034b5dd4e89bd74a7739c51c2d6f5e554
Gitweb:        https://git.kernel.org/tip/3066820034b5dd4e89bd74a7739c51c2d6f5e554
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 05 Apr 2021 09:51:05 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:22:54 -07:00

rcu: Reject RCU_LOCKDEP_WARN() false positives

If another lockdep report runs concurrently with an RCU lockdep report
from RCU_LOCKDEP_WARN(), the following sequence of events can occur:

1.	debug_lockdep_rcu_enabled() sees that lockdep is enabled
	when called from (say) synchronize_rcu().

2.	Lockdep is disabled by a concurrent lockdep report.

3.	debug_lockdep_rcu_enabled() evaluates its lockdep-expression
	argument, for example, lock_is_held(&rcu_bh_lock_map).

4.	Because lockdep is now disabled, lock_is_held() plays it safe and
	returns the constant 1.

5.	But in this case, the constant 1 is not safe, because invoking
	synchronize_rcu() under rcu_read_lock_bh() is disallowed.

6.	debug_lockdep_rcu_enabled() wrongly invokes lockdep_rcu_suspicious(),
	resulting in a false-positive splat.

This commit therefore changes RCU_LOCKDEP_WARN() to check
debug_lockdep_rcu_enabled() after checking the lockdep expression,
so that any "safe" returns from lock_is_held() are rejected by
debug_lockdep_rcu_enabled().  This requires memory ordering, which is
supplied by READ_ONCE(debug_locks).  The resulting volatile accesses
prevent the compiler from reordering and the fact that only one variable
is being accessed prevents the underlying hardware from reordering.
The combination works for IA64, which can reorder reads to the same
location, but this is defeated by the volatile accesses, which compile
to load instructions that provide ordering.

Reported-by: syzbot+dde0cc33951735441301@syzkaller.appspotmail.com
Reported-by: Matthew Wilcox <willy@infradead.org>
Reported-by: syzbot+88e4f02896967fe1ab0d@syzkaller.appspotmail.com
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 2 +-
 kernel/rcu/update.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 9455476..1199ffd 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -315,7 +315,7 @@ static inline int rcu_read_lock_any_held(void)
 #define RCU_LOCKDEP_WARN(c, s)						\
 	do {								\
 		static bool __section(".data.unlikely") __warned;	\
-		if (debug_lockdep_rcu_enabled() && !__warned && (c)) {	\
+		if ((c) && debug_lockdep_rcu_enabled() && !__warned) {	\
 			__warned = true;				\
 			lockdep_rcu_suspicious(__FILE__, __LINE__, s);	\
 		}							\
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index b95ae86..dd94a60 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -277,7 +277,7 @@ EXPORT_SYMBOL_GPL(rcu_callback_map);
 
 noinstr int notrace debug_lockdep_rcu_enabled(void)
 {
-	return rcu_scheduler_active != RCU_SCHEDULER_INACTIVE && debug_locks &&
+	return rcu_scheduler_active != RCU_SCHEDULER_INACTIVE && READ_ONCE(debug_locks) &&
 	       current->lockdep_recursion == 0;
 }
 EXPORT_SYMBOL_GPL(debug_lockdep_rcu_enabled);
