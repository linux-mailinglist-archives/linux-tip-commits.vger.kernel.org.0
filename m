Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44463EF327
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhHQUOc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34542 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbhHQUOb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:31 -0400
Date:   Tue, 17 Aug 2021 20:13:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231237;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h1zVwYA69SWhGYXWVxA6O0Yyf7TV48d/4Qb1uxXRKV0=;
        b=NLc2BCR0mlEa/2jPZu2sWpvshmRYG5xDBRSqy47HeDx4HVZjsWyt3HXiYpUly87vuXE9kT
        PbxOUn5kTPtGnHNtcMBICUf9i7naNVkHRm3w59lB6K2HIS+ZFttL12cs/12TnRB37qSbWj
        ZFzAKsPaibfEe2ztfWpc5OhfVqnJE3bWr1DrHLa/H9rl8kl+UQ87Gatl7YwGdpqepMarTv
        BvqIfWt49Rmz04J+BvD6RFsKSS6ymZRNfUVdNOAbW2dnctyaKablqL3xGKA6n5LJbILpGG
        aJML7niintLSvER7M/adab2LgRfR6ofarml4+WHlIVoYJt22Iu2HupMNPsv3hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231237;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h1zVwYA69SWhGYXWVxA6O0Yyf7TV48d/4Qb1uxXRKV0=;
        b=xPkWFA7RR6keQPbVDosIxKOORdP7WYCjvArIrCgl/eFG+irLzBnkY+tTMDGSP82THEuqq4
        xzPA7BIEQLAmy+Dg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] static_call: Update API documentation
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YQwIorQBHEq+s73b@hirez.programming.kicks-ass.net>
References: <YQwIorQBHEq+s73b@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <162923123566.25758.13896123511356080788.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9ae6ab27f44ee0da47520011afc04218f90e8b12
Gitweb:        https://git.kernel.org/tip/9ae6ab27f44ee0da47520011afc04218f90e8b12
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 05 Aug 2021 17:49:54 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:09:27 +02:00

static_call: Update API documentation

Update the comment with the new features.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/YQwIorQBHEq+s73b@hirez.programming.kicks-ass.net
---
 include/linux/static_call.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index fc94faa..3e56a97 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -17,11 +17,17 @@
  *   DECLARE_STATIC_CALL(name, func);
  *   DEFINE_STATIC_CALL(name, func);
  *   DEFINE_STATIC_CALL_NULL(name, typename);
+ *   DEFINE_STATIC_CALL_RET0(name, typename);
+ *
+ *   __static_call_return0;
+ *
  *   static_call(name)(args...);
  *   static_call_cond(name)(args...);
  *   static_call_update(name, func);
  *   static_call_query(name);
  *
+ *   EXPORT_STATIC_CALL{,_TRAMP}{,_GPL}()
+ *
  * Usage example:
  *
  *   # Start with the following functions (with identical prototypes):
@@ -96,6 +102,33 @@
  *   To query which function is currently set to be called, use:
  *
  *   func = static_call_query(name);
+ *
+ *
+ * DEFINE_STATIC_CALL_RET0 / __static_call_return0:
+ *
+ *   Just like how DEFINE_STATIC_CALL_NULL() / static_call_cond() optimize the
+ *   conditional void function call, DEFINE_STATIC_CALL_RET0 /
+ *   __static_call_return0 optimize the do nothing return 0 function.
+ *
+ *   This feature is strictly UB per the C standard (since it casts a function
+ *   pointer to a different signature) and relies on the architecture ABI to
+ *   make things work. In particular it relies on Caller Stack-cleanup and the
+ *   whole return register being clobbered for short return values. All normal
+ *   CDECL style ABIs conform.
+ *
+ *   In particular the x86_64 implementation replaces the 5 byte CALL
+ *   instruction at the callsite with a 5 byte clear of the RAX register,
+ *   completely eliding any function call overhead.
+ *
+ *   Notably argument setup is unconditional.
+ *
+ *
+ * EXPORT_STATIC_CALL() vs EXPORT_STATIC_CALL_TRAMP():
+ *
+ *   The difference is that the _TRAMP variant tries to only export the
+ *   trampoline with the result that a module can use static_call{,_cond}() but
+ *   not static_call_update().
+ *
  */
 
 #include <linux/types.h>
