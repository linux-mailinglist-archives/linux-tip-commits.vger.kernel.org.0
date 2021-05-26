Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935FD391607
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhEZL11 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbhEZL0d (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DECC061344;
        Wed, 26 May 2021 04:24:44 -0700 (PDT)
Date:   Wed, 26 May 2021 11:24:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028283;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dreSlGkmYUAr345SslUjWzdBde5v9W1Dmo4K5Iu9dKY=;
        b=y9jlCLluHlyLg5zM8n6QJNagz8dhjlH/4CbnGSGDGvaYr8cKEs896eqDrUegZ5+BGbcVXe
        LIHV19+Mdmjk4BWCIUTe7mJTtLro/GAmNtVX2dITL+Hei1qO2ZJ4ldumlmGBCAN+vjq8zI
        4LP0w092o07BNTh8lVNeKLWv6OklCrimVxfhJSWK5juEN6BD2khkLOdRPnxnilIExuEBKB
        y5PDPhMwHR+ndoAFuoP7CMfOo3FH7re2QTFcwU57/N18V74scO8k2HxITWp1gWzYl5eOLP
        kb+DkoXUh80D8FZeQmKeDs63fpzLoVvH53mwxQy0h0Nwp3qena+SrwleemZTjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028283;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dreSlGkmYUAr345SslUjWzdBde5v9W1Dmo4K5Iu9dKY=;
        b=8tEowypSrScWg1JStydbzG14+scj0UiwPcfFO9E4KRBt9AdyhjXT3ztClA/JKfDUZoDTRN
        t3PCT031+imKvYDg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: net: use linux/atomic.h for xchg
 & cmpxchg
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-3-mark.rutland@arm.com>
References: <20210525140232.53872-3-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202828269.29796.5719715173875797514.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     201e2c1bbe659720913ed5272a2c44e6ab646c8a
Gitweb:        https://git.kernel.org/tip/201e2c1bbe659720913ed5272a2c44e6ab646c8a
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:01 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:49 +02:00

locking/atomic: net: use linux/atomic.h for xchg & cmpxchg

As xchg*() and cmpxchg*() may be instrumented by atomic-instrumented.h,
it's necessary to include <linux/atomic.h> to use these, rather than
<asm/cmpxchg.h>, which is effectively an arch-internal header.

In a couple of places we include <asm/cmpxchg.h>, but get away with this
as <linux/atomic.h> gets pulled in inidrectly by another include. Before
we convert more architectures to use atomic-instrumented.h, let's fix
these up to use <linux/atomic.h> so that we don't make things more
fragile.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-3-mark.rutland@arm.com
---
 net/core/filter.c          | 2 +-
 net/sunrpc/xprtmultipath.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index cae56d0..ce4ae1a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -17,6 +17,7 @@
  * Kris Katterjohn - Added many additional checks in bpf_check_classic()
  */
 
+#include <linux/atomic.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/mm.h>
@@ -41,7 +42,6 @@
 #include <linux/timer.h>
 #include <linux/uaccess.h>
 #include <asm/unaligned.h>
-#include <asm/cmpxchg.h>
 #include <linux/filter.h>
 #include <linux/ratelimit.h>
 #include <linux/seccomp.h>
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 78c075a..1b40731 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -7,13 +7,13 @@
  * Trond Myklebust <trond.myklebust@primarydata.com>
  *
  */
+#include <linux/atomic.h>
 #include <linux/types.h>
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/rcupdate.h>
 #include <linux/rculist.h>
 #include <linux/slab.h>
-#include <asm/cmpxchg.h>
 #include <linux/spinlock.h>
 #include <linux/sunrpc/xprt.h>
 #include <linux/sunrpc/addr.h>
