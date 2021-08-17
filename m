Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3645D3EF32E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbhHQUOg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbhHQUOe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2B2C061764;
        Tue, 17 Aug 2021 13:14:00 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:13:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231239;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ULNiH3Y9AZ/Rkh1/eOlN7iBIQ9nHO9mFesbUZZ/Gg6o=;
        b=45CsTBorA7FEfwY6qEcQ6V2FHeVnlWRdYo0j4nRNoNom6AooLi/dXdsuh1rc2/BfZhPnoy
        as+a6qValYiGP8VkEKgrTBYwCPYWBWXR4t4PIUW5UJ+pxVuSOo5qjK3k7RUhZCV0tXxSyr
        PRgLWrwmFlOKuHAp2EYaNMljLV9euPSUULI8zpY8JV7NE/uc2eZXaWTIXgw27YdLKjWw8r
        PgkwBaPrZn2dyTnqkX3NQ/nXxAqv7RzN6BT9fxGm/2L3r7RKp6yNDF6iNjKKW7WRvWk8xZ
        5pwFOKe7rG3fE99QeBMSwikJf7u46nDx5Vn/4X3XlKFnOgkJ0Banc0Sbzat2CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231239;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ULNiH3Y9AZ/Rkh1/eOlN7iBIQ9nHO9mFesbUZZ/Gg6o=;
        b=o/pqSsKaaaFIBim2ht25xhntRurTZxUzp6skJ2ybg9NCjTQR5NaX1OXWyQnOuGdbRmPWSv
        uG5gqqQIJO6n9pCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] preempt: Adjust PREEMPT_LOCK_OFFSET for RT
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211305.804246275@linutronix.de>
References: <20210815211305.804246275@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923123878.25758.9484499109477297052.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     015680aa4c5d784513d0a9728bc52ec7c4a64227
Gitweb:        https://git.kernel.org/tip/015680aa4c5d784513d0a9728bc52ec7c4a64227
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:29:22 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:06:04 +02:00

preempt: Adjust PREEMPT_LOCK_OFFSET for RT

On PREEMPT_RT regular spinlocks and rwlocks are substituted with rtmutex
based constructs. spin/rwlock held regions are preemptible on PREEMPT_RT,
so PREEMPT_LOCK_OFFSET has to be 0 to make the various cond_resched_*lock()
functions work correctly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211305.804246275@linutronix.de
---
 include/linux/preempt.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 9881eac..4d244e2 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -121,7 +121,11 @@
 /*
  * The preempt_count offset after spin_lock()
  */
+#if !defined(CONFIG_PREEMPT_RT)
 #define PREEMPT_LOCK_OFFSET	PREEMPT_DISABLE_OFFSET
+#else
+#define PREEMPT_LOCK_OFFSET	0
+#endif
 
 /*
  * The preempt_count offset needed for things like:
