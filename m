Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E183915F9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 May 2021 13:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhEZL0h (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 26 May 2021 07:26:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54626 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbhEZL0N (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 26 May 2021 07:26:13 -0400
Date:   Wed, 26 May 2021 11:24:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622028281;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vdLPKkI+OjMpgbWIfLk1B0dDxfu5U0HbX7gyk0gnB3o=;
        b=hyCHsUfQ56m63KgUR/mJMHZTPwGy8c1tcI+P/na9Uke7/KgWcHgCHrPTQ+YpSQ/KAxdlJN
        OesjD0AIc45UvAnUWlP9enV/JzG7ccIqXguQRR0DEnzPmlNKUUc3gMjfwztVP2Y8PDRAxw
        Rh07IFkjRYQW5skvGrVb+mnORpfNBNE2Szyp4CV9x3hCb1vB2tKKN5s1itHJr8P9UK1Dvj
        hf8kSYpnSbmTMt2uQ6uHycOnmVD5nF9qBVnfFCxzpy0deMNR9MJYdz9lYW5q0fpzTvw5yQ
        jszyCImoJL5/XsnxUIHB0qUmQx1cEg5p64NZMPrLGzVVxnDBKVyS1U9hfM3B1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622028281;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vdLPKkI+OjMpgbWIfLk1B0dDxfu5U0HbX7gyk0gnB3o=;
        b=m76pwL6wa2JM+oI7/us9W1lmwrz9gReQJwqxyr+ujrxubmVIg/WEcq2HMgpnmv3TCy11n+
        T8v0UL7xUcewdhBQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: atomic: remove stale comments
Cc:     Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525140232.53872-7-mark.rutland@arm.com>
References: <20210525140232.53872-7-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162202828083.29796.6434462463632947667.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2609a195fbd58f77d281c013f10b8dbaffca1637
Gitweb:        https://git.kernel.org/tip/2609a195fbd58f77d281c013f10b8dbaffca1637
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 25 May 2021 15:02:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 May 2021 13:20:49 +02:00

locking/atomic: atomic: remove stale comments

The commentary in asm-generic/atomic.h is stale; let's bring it up-to
date:

* The block comment at the start of the file mentions this is only
  usable on UP systems, but is immediately followed by an SMP
  implementation using cmpxchg. Let's delete the misleading statement.

* A comment near the end of the file was originally at the top of the
  file, but over time rework has shuffled it near the end, and it's long
  been superceded by the block comment at the top of the file. Let's
  remove it.

* Since asm-generic/atomic.h isn't the canonical documentation for the
  atomic ops, and since the existing comments are not in kerneldoc
  format, we don't need to document the semantics of each operation here
  (and this would be better done in a centralised document). Let's
  remove these comments.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210525140232.53872-7-mark.rutland@arm.com
---
 include/asm-generic/atomic.h | 39 +----------------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 11f96f4..ebacbc6 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Generic C implementation of atomic counter operations. Usable on
- * UP systems only. Do not include in machine independent code.
+ * Generic C implementation of atomic counter operations. Do not include in
+ * machine independent code.
  *
  * Copyright (C) 2007 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
@@ -12,23 +12,6 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
-/*
- * atomic_$op() - $op integer to atomic variable
- * @i: integer value to $op
- * @v: pointer to the atomic variable
- *
- * Atomically $ops @i to @v. Does not strictly guarantee a memory-barrier, use
- * smp_mb__{before,after}_atomic().
- */
-
-/*
- * atomic_$op_return() - $op interer to atomic variable and returns the result
- * @i: integer value to $op
- * @v: pointer to the atomic variable
- *
- * Atomically $ops @i to @v. Does imply a full memory barrier.
- */
-
 #ifdef CONFIG_SMP
 
 /* we can build all atomic primitives from cmpxchg */
@@ -154,28 +137,10 @@ ATOMIC_OP(xor, ^)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-/*
- * Atomic operations that C can't guarantee us.  Useful for
- * resource counting etc..
- */
-
-/**
- * atomic_read - read atomic variable
- * @v: pointer of type atomic_t
- *
- * Atomically reads the value of @v.
- */
 #ifndef atomic_read
 #define atomic_read(v)	READ_ONCE((v)->counter)
 #endif
 
-/**
- * atomic_set - set atomic variable
- * @v: pointer of type atomic_t
- * @i: required value
- *
- * Atomically sets the value of @v to @i.
- */
 #define atomic_set(v, i) WRITE_ONCE(((v)->counter), (i))
 
 #include <linux/irqflags.h>
