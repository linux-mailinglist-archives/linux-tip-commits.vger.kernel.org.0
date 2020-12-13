Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF41C2D8FAA
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392757AbgLMTDS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392262AbgLMTDI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:03:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2634AC0611CF;
        Sun, 13 Dec 2020 11:01:09 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CPvhgryxZcXu30pYcRnjDYgNdJjOQ9zjQCN1l8Bc+TQ=;
        b=YR3yMs378mDh3lqD2/pze6m9gvHLdcj2iGgFNTebiC7gAAQQ7rLwzKKgjTMFXbG4vwULPd
        0WSPBwT/iIOQWoGGOgePCcVvHymX9elDfB4vuLn/UdDRNe5s2VwfgstYBWmTdcP9Tso/5u
        KPU+cwXaBnx5nB0L88TZHi76lCMYHoHawWEEAV11INknDOfeWwWYj0zenLulYcPfhQ6944
        QyNFpRc8QYHhZ22CFjf7xScedrZUDzLcMiYAvRyYTrUPhUgLJDT6rEm1m6o0GtHpLHbPAd
        YolCSRnukqjM0mNoFTjna9gbS4mSz3QSTBGIlzUOtqD70BzsKTPt4pTRgeRyUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CPvhgryxZcXu30pYcRnjDYgNdJjOQ9zjQCN1l8Bc+TQ=;
        b=FXIA8swJuKJtVSkDcaq1oNvJ/6/o1sXt+5giWBiYgTr7Q3R0f61i4mVa5tpT4UgXLqQ9dv
        ZrMX2LUZdwwYp9Bg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Don't do need_resched() testing if ->sync is NULL
Cc:     Tom Rix <trix@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606722.3364.14457642071832399627.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a7eb937b67b64b8b4645f1ebca3ac2079c6de81b
Gitweb:        https://git.kernel.org/tip/a7eb937b67b64b8b4645f1ebca3ac2079c6de81b
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 09 Oct 2020 19:51:55 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:57 -08:00

rcutorture: Don't do need_resched() testing if ->sync is NULL

If cur_ops->sync is NULL, rcu_torture_fwd_prog_nr() will nevertheless
attempt to call through it.  This commit therefore flags cases where
neither need_resched() nor call_rcu() forward-progress testing
can be performed due to NULL function pointers, and also causes
rcu_torture_fwd_prog_nr() to take an early exit if cur_ops->sync()
is NULL.

Reported-by: Tom Rix <trix@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index e7d52fd..4dfd113 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1923,7 +1923,9 @@ static void rcu_torture_fwd_prog_nr(struct rcu_fwd *rfp,
 	unsigned long stopat;
 	static DEFINE_TORTURE_RANDOM(trs);
 
-	if  (cur_ops->call && cur_ops->sync && cur_ops->cb_barrier) {
+	if (!cur_ops->sync)
+		return; // Cannot do need_resched() forward progress testing without ->sync.
+	if (cur_ops->call && cur_ops->cb_barrier) {
 		init_rcu_head_on_stack(&fcs.rh);
 		selfpropcb = true;
 	}
@@ -2149,8 +2151,8 @@ static int __init rcu_torture_fwd_prog_init(void)
 
 	if (!fwd_progress)
 		return 0; /* Not requested, so don't do it. */
-	if (!cur_ops->stall_dur || cur_ops->stall_dur() <= 0 ||
-	    cur_ops == &rcu_busted_ops) {
+	if ((!cur_ops->sync && !cur_ops->call) ||
+	    !cur_ops->stall_dur || cur_ops->stall_dur() <= 0 || cur_ops == &rcu_busted_ops) {
 		VERBOSE_TOROUT_STRING("rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test");
 		return 0;
 	}
