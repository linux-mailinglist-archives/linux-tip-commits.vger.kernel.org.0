Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA0E319EEA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbhBLMn1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:43:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45442 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhBLMkz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:55 -0500
Date:   Fri, 12 Feb 2021 12:37:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WzH+kdvyrJCvi8PN8mzfxKyQAsX/Yh3uARy4lAQR7wE=;
        b=ui3zTxV1N74EUPVHGh5xthJwnNkOajpnAakHJdAyfwNPhEyscGqMVAgsYn7L4N90NttNRU
        KRqnW2IS9Sb9cwpP2AEmyu8+eLw9UBm9q6RRglT1wTTMaqUoJElD7W7DR2MmGndeYsW2HJ
        cUEm5Frmrliw90QFSIOYhintYrWr0jV0j9OIN1lgSwdZOidVLXAFh/gdGUxlkLTR3xTvHo
        zLiLvPY8BV9cSNxpVWTw5pK0hZUJ45dcdQq/BcsMw4FpG1hqN/kB+2GxXphpQu0JW1eQEO
        VlXvU/dNwLcnuHhUvv/LdR/affgwWbIN+skzuWRUNXkHcDsONOngU6udF1jnLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=WzH+kdvyrJCvi8PN8mzfxKyQAsX/Yh3uARy4lAQR7wE=;
        b=Z1VaD7wes621Gq7g3dhK5W9cTXhv3AiIJ8DjP5mQJHXgCRpGFru8RrmpgnoNIcqKbbvQcD
        JvFvcyKe1QRZGyBA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add lockdep_assert_irqs_disabled() to
 raw_spin_unlock_rcu_node() macros
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344380.23325.11146175858911860876.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7dffe01765d9309b8bd5505503933ec0ec53d192
Gitweb:        https://git.kernel.org/tip/7dffe01765d9309b8bd5505503933ec0ec53d192
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 19 Nov 2020 13:30:33 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 15:54:49 -08:00

rcu: Add lockdep_assert_irqs_disabled() to raw_spin_unlock_rcu_node() macros

This commit adds a lockdep_assert_irqs_disabled() call to the
helper macros that release the rcu_node structure's ->lock, namely
to raw_spin_unlock_rcu_node(), raw_spin_unlock_irq_rcu_node() and
raw_spin_unlock_irqrestore_rcu_node().  The point of this is to help track
down a situation where lockdep appears to be insisting that interrupts
are enabled while holding an rcu_node structure's ->lock.

Link: https://lore.kernel.org/lkml/20201111133813.GA81547@elver.google.com/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index e01cba5..839f5be 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -378,7 +378,11 @@ do {									\
 	smp_mb__after_unlock_lock();					\
 } while (0)
 
-#define raw_spin_unlock_rcu_node(p) raw_spin_unlock(&ACCESS_PRIVATE(p, lock))
+#define raw_spin_unlock_rcu_node(p)					\
+do {									\
+	lockdep_assert_irqs_disabled();					\
+	raw_spin_unlock(&ACCESS_PRIVATE(p, lock));			\
+} while (0)
 
 #define raw_spin_lock_irq_rcu_node(p)					\
 do {									\
@@ -387,7 +391,10 @@ do {									\
 } while (0)
 
 #define raw_spin_unlock_irq_rcu_node(p)					\
-	raw_spin_unlock_irq(&ACCESS_PRIVATE(p, lock))
+do {									\
+	lockdep_assert_irqs_disabled();					\
+	raw_spin_unlock_irq(&ACCESS_PRIVATE(p, lock));			\
+} while (0)
 
 #define raw_spin_lock_irqsave_rcu_node(p, flags)			\
 do {									\
@@ -396,7 +403,10 @@ do {									\
 } while (0)
 
 #define raw_spin_unlock_irqrestore_rcu_node(p, flags)			\
-	raw_spin_unlock_irqrestore(&ACCESS_PRIVATE(p, lock), flags)
+do {									\
+	lockdep_assert_irqs_disabled();					\
+	raw_spin_unlock_irqrestore(&ACCESS_PRIVATE(p, lock), flags);	\
+} while (0)
 
 #define raw_spin_trylock_rcu_node(p)					\
 ({									\
