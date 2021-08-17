Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136163EF3A6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhHQUQk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbhHQUPq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD26C0611FB;
        Tue, 17 Aug 2021 13:14:30 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y1eByRkJhCNf+BtC/jnB3paZ7YWbapuv1mztA6p+eDE=;
        b=YurjvlkThOhJxmUvM3I4TyMR4Gn5ENWUGOTUhV1jdxrbEgwKxezcDq9mSS6GmNRH/PoleL
        PUquCdZKpfgLTFEbNyr49CL/wQpHIMFam0S9+p1DhoMezN1ypnhFqtunjjSPGWXNJ5+Tjk
        B5IRlX3YrWPN/Rte+OwSRJ4lVfXiFCgY6ldAwih5zjAwoV3HUjO+dDYPvzV3nQIIW1WW3F
        AroVvxM8d7YwvtUaZRam9Z8WHRhkUuMs0xX7XWpcDy8y95FkA0iGldlbtWJuAEhCf1Ns0O
        opEov6hSEPXwHXpE68LmkP16v+aFgbZ5Qg7jC+HPPtMj4dUB7qHDZ98cnTBZqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y1eByRkJhCNf+BtC/jnB3paZ7YWbapuv1mztA6p+eDE=;
        b=GEoKCGJNPBwt5Fu+zPJjhPAUwTSBJHr8DauX6Jj4RqQJG+tHE7mfMblaT4LALHWasODJAq
        FvkLRQsDk6nS2WDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Provide rt_mutex_base_is_locked()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211302.899572818@linutronix.de>
References: <20210815211302.899572818@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923126873.25758.15043028703595695163.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6bc8996add9f82d0153b0be44efe282bd45dc702
Gitweb:        https://git.kernel.org/tip/6bc8996add9f82d0153b0be44efe282bd45dc702
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:02 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:04:35 +02:00

locking/rtmutex: Provide rt_mutex_base_is_locked()

Provide rt_mutex_base_is_locked(), which will be used for various wrapped
locking primitives for RT.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211302.899572818@linutronix.de
---
 include/linux/rtmutex.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 8527402..174419e 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -13,6 +13,7 @@
 #ifndef __LINUX_RT_MUTEX_H
 #define __LINUX_RT_MUTEX_H
 
+#include <linux/compiler.h>
 #include <linux/linkage.h>
 #include <linux/rbtree.h>
 #include <linux/spinlock_types.h>
@@ -32,6 +33,17 @@ struct rt_mutex_base {
 	.owner = NULL							\
 }
 
+/**
+ * rt_mutex_base_is_locked - is the rtmutex locked
+ * @lock: the mutex to be queried
+ *
+ * Returns true if the mutex is locked, false if unlocked.
+ */
+static inline bool rt_mutex_base_is_locked(struct rt_mutex_base *lock)
+{
+	return READ_ONCE(lock->owner) != NULL;
+}
+
 extern void rt_mutex_base_init(struct rt_mutex_base *rtb);
 
 /**
