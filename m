Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E69288F75
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 19:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389867AbgJIRCG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 13:02:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59238 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389956AbgJIRB3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 13:01:29 -0400
Date:   Fri, 09 Oct 2020 17:01:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602262887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sPv/jwMpTJ/WLqjluXCnE6YwZw3GZZcgS5Miuo/XdZc=;
        b=pMYKcW/YWfGBK4sogmPNqTGpw0+lmMTpzNYxAedyCwcnJAAxjjRcG6pSEptUv9oj+BOvq8
        5Atya/Fd8njIGz87zkE5nSKc8H/rPuGb/fc+7kguV/CNOjdhFPhb0CP8jBP6Iyw/C75Bbp
        BX6vNJBtxLqNyQg8hcOo6DOrW4JHO90p4Re8nbGazSV4bW3BdM1zCMQEOdYqtMWHmJBqVk
        +lSkIHc3sgWBHzbIOJXfnKM6xdeyFQ7CVCIi9QCg7z/t+aS48JGi6s4J2VfTdKPEeEo3QN
        8nL0pWLgLDsJCGfuFqGe+JSFGvpFvNtPJJKNK3x18HlhRXUWjyJpR07eextDDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602262887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=sPv/jwMpTJ/WLqjluXCnE6YwZw3GZZcgS5Miuo/XdZc=;
        b=Vb4RU27SJjvsaKQkqBdJhbkw8sZQvApkAnFKM9T6RuF/bSZ53vquRytvR2yheERpDErRef
        fNpZfYMrLUlL70BQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] locking/bitspinlock: Cleanup PREEMPT_COUNT leftovers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160226288653.7002.2578979062422193705.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     cce05b43263a1b12b7c0a8b003d6c2295e17f580
Gitweb:        https://git.kernel.org/tip/cce05b43263a1b12b7c0a8b003d6c2295e17f580
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Sep 2020 19:28:08 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 28 Sep 2020 16:03:20 -07:00

locking/bitspinlock: Cleanup PREEMPT_COUNT leftovers

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/bit_spinlock.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730..1e03d54 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -90,10 +90,8 @@ static inline int bit_spin_is_locked(int bitnum, unsigned long *addr)
 {
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 	return test_bit(bitnum, addr);
-#elif defined CONFIG_PREEMPT_COUNT
-	return preempt_count();
 #else
-	return 1;
+	return preempt_count();
 #endif
 }
 
