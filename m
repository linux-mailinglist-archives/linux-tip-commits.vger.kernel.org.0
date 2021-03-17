Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A49233F077
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 13:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhCQMif (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 08:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhCQMiY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 08:38:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5F3C06175F;
        Wed, 17 Mar 2021 05:38:24 -0700 (PDT)
Date:   Wed, 17 Mar 2021 12:38:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984702;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qhlB1kzRQfS7bJ7PfJvr05B9fynDVipph7TA9K1l1Ck=;
        b=cAFHxn0SUtnE98GxNKCdd8I1l1trRRZSwplwTNe8btz5hAP6E7IKjaH3fH8KifIDdK4b7g
        sf4ip2gEJBYhcLGwHndl3EACYqU3lFDHFBbGin9OLIGsGBOakiKUid+zbwco41k6pBnnSB
        gn/ptMJKehgaoRGG/2k0EyfpqcXsMMh3+E3FYu8X6oIgezKdRfZT8vJUk7n3dVpA2r7OCE
        m2zWEsaFj8bcJZHiWHTYG/USTi0nJJMZABoSBevcTJwYG3Jb5L5ueo0Z8lQ0JGMO05MRzV
        e4fuwTvb2q5h2Wl/UoQYspofzXIO0iGmblZv8H71Uij3h7iqh4ZOmiMKb3pMpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984702;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qhlB1kzRQfS7bJ7PfJvr05B9fynDVipph7TA9K1l1Ck=;
        b=GhtxHj/del+wYA0dKl4rQFnIfBmZqG6awiQqAhKf9gE9tPYLcnwEUQUL0V8xTKO6bE5ruc
        O71VTWe0lPLeiADQ==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/ww_mutex: Fix acquire/release imbalance
 in ww_acquire_init()/ww_acquire_fini()
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210316153119.13802-3-longman@redhat.com>
References: <20210316153119.13802-3-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <161598470224.398.10597010936099036923.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     bee645788e07eea63055d261d2884ea45c2ba857
Gitweb:        https://git.kernel.org/tip/bee645788e07eea63055d261d2884ea45c2ba857
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Tue, 16 Mar 2021 11:31:17 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Mar 2021 09:56:45 +01:00

locking/ww_mutex: Fix acquire/release imbalance in ww_acquire_init()/ww_acquire_fini()

In ww_acquire_init(), mutex_acquire() is gated by CONFIG_DEBUG_LOCK_ALLOC.
The dep_map in the ww_acquire_ctx structure is also gated by the
same config. However mutex_release() in ww_acquire_fini() is gated by
CONFIG_DEBUG_MUTEXES. It is possible to set CONFIG_DEBUG_MUTEXES without
setting CONFIG_DEBUG_LOCK_ALLOC though it is an unlikely configuration.
That may cause a compilation error as dep_map isn't defined in this
case. Fix this potential problem by enclosing mutex_release() inside
CONFIG_DEBUG_LOCK_ALLOC.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210316153119.13802-3-longman@redhat.com
---
 include/linux/ww_mutex.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 850424e..6ecf2a0 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -173,9 +173,10 @@ static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
  */
 static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
 {
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
 	mutex_release(&ctx->dep_map, _THIS_IP_);
-
+#endif
+#ifdef CONFIG_DEBUG_MUTEXES
 	DEBUG_LOCKS_WARN_ON(ctx->acquired);
 	if (!IS_ENABLED(CONFIG_PROVE_LOCKING))
 		/*
