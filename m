Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFF128826A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbgJIGg5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:36:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55490 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732032AbgJIGfk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:40 -0400
Date:   Fri, 09 Oct 2020 06:35:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1WFERfx/rSI7pI3YTD+hhGP8UecLm2meaDGfZwqXK9c=;
        b=WZQ0mNUA7ZpIY8T+E0sftgg9xnJ0puH7s/6Hdf56o9PtZgu7EMbMS12bebBZwL7l4pR2bK
        cJl+t3IRN7ZnhDBBOykI3tLcS16F2l9WS66yb92TGrrSN9NvcDp6cyn4pu3YSdCq7cxP98
        QHAfNe+ihhlRoUZvfn+OUxAF+TYagWmiU++EkpFb0rMaN6xF7MBKUZUuLIMNeECQXt3AVI
        VPex1PiU2MfIkvTd7Y9G66YD2x2+X4VVVeeDXFNwqOHD+x/yxqX0ZEdnq0A4AfQ1m/57iF
        4HqyHnyPsU0o+o0RjCJcWlskVJh6fg6/4edOB+HCRNTwlAfVVNmZue7qdex7Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1WFERfx/rSI7pI3YTD+hhGP8UecLm2meaDGfZwqXK9c=;
        b=U7b+WPDOyzH9YAoED60KUZmEk58gP3GLFyy6D1yZD53bX0Xy+7MZZWD2kHZaTPMYOMGgSo
        hCBPR0/cbIuvZyBA==
From:   "tip-bot2 for Tobias Klauser" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Fix kerneldoc comments in rcupdate.h
Cc:     Tobias Klauser <tklauser@distanz.ch>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222533771.7002.18170202456845299999.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     000601bb62330f18dc8f5d2d0b82e9aec3e207c4
Gitweb:        https://git.kernel.org/tip/000601bb62330f18dc8f5d2d0b82e9aec3e207c4
Author:        Tobias Klauser <tklauser@distanz.ch>
AuthorDate:    Thu, 09 Jul 2020 15:05:59 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:36:08 -07:00

rcu: Fix kerneldoc comments in rcupdate.h

This commit fixes the kerneldoc comments for rcu_read_unlock_bh(),
rcu_read_unlock_sched() and rcu_head_after_call_rcu() so they e.g. get
properly linked in the API documentation. Also add parenthesis after
function names to match the notation used in other kerneldoc comments in
the same file.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index d15d46d..b47d6b6 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -709,8 +709,8 @@ static inline void rcu_read_lock_bh(void)
 			 "rcu_read_lock_bh() used illegally while idle");
 }
 
-/*
- * rcu_read_unlock_bh - marks the end of a softirq-only RCU critical section
+/**
+ * rcu_read_unlock_bh() - marks the end of a softirq-only RCU critical section
  *
  * See rcu_read_lock_bh() for more information.
  */
@@ -751,10 +751,10 @@ static inline notrace void rcu_read_lock_sched_notrace(void)
 	__acquire(RCU_SCHED);
 }
 
-/*
- * rcu_read_unlock_sched - marks the end of a RCU-classic critical section
+/**
+ * rcu_read_unlock_sched() - marks the end of a RCU-classic critical section
  *
- * See rcu_read_lock_sched for more information.
+ * See rcu_read_lock_sched() for more information.
  */
 static inline void rcu_read_unlock_sched(void)
 {
@@ -945,7 +945,7 @@ static inline void rcu_head_init(struct rcu_head *rhp)
 }
 
 /**
- * rcu_head_after_call_rcu - Has this rcu_head been passed to call_rcu()?
+ * rcu_head_after_call_rcu() - Has this rcu_head been passed to call_rcu()?
  * @rhp: The rcu_head structure to test.
  * @f: The function passed to call_rcu() along with @rhp.
  *
