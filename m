Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C39F35B507
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbhDKNou (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33444 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbhDKNoE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:04 -0400
Date:   Sun, 11 Apr 2021 13:43:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NA3YPXltfZ9cQc4NH84VUZ8PCAXqvgFTFmBuKvAfmqE=;
        b=1NUafxiW7v7c5V510puSN12eagueb4eE60gr8ZDUh78hHTbnWvBqY48kpXWLXs14LWUn8A
        fBSI34AYgHMNDohISM2rlWpvuYVKrvJBBXm2J0fb9XLnis2kS0Gj5nNQNHQEcKbDTgE1FR
        RuObOPdZEJeIGwkJpLNMhRqXpIpNa4ZOJnArlcJ/Kl7mLBT2H+olWrC5YHZqVn7AZ4z/Rw
        Xaz1x+503iVYu9gg1RZi+bgStITZQpXOAtyCJzEPIjZYvFIF+ORCLlgySLsoMyK4m7PlTh
        8KAIgRrmV7yM3yYw5KVDwMD7cvboXwsUGtVnFDkHagKdm5Yn5z10sYQo0GWAPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NA3YPXltfZ9cQc4NH84VUZ8PCAXqvgFTFmBuKvAfmqE=;
        b=QKLD3Qj8hTij0V4UUjsH9+IqXrzBnMW8MgJ373iErcNw91LQ8nXzFXbauGbKLwER8teEoh
        UZIZzf5pkyWLhxDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add explicit barrier() to __rcu_read_unlock()
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860762.29796.4207906617795000377.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7e937220afa3eada0d4611b31e4e3c60770e39b4
Gitweb:        https://git.kernel.org/tip/7e937220afa3eada0d4611b31e4e3c60770e39b4
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 26 Feb 2021 11:25:29 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 15 Mar 2021 13:53:24 -07:00

rcu: Add explicit barrier() to __rcu_read_unlock()

Because preemptible RCU's __rcu_read_unlock() is an external function,
the rough equivalent of an implicit barrier() is inserted by the compiler.
Except that there is a direct call to __rcu_read_unlock() in that same
file, and compilers are getting to the point where they might choose to
inline the fastpath of the __rcu_read_unlock() function.

This commit therefore adds an explicit barrier() to the very beginning
of __rcu_read_unlock().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2d60377..a32494c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -393,8 +393,9 @@ void __rcu_read_unlock(void)
 {
 	struct task_struct *t = current;
 
+	barrier();  // critical section before exit code.
 	if (rcu_preempt_read_exit() == 0) {
-		barrier();  /* critical section before exit code. */
+		barrier();  // critical-section exit before .s check.
 		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
 			rcu_read_unlock_special(t);
 	}
