Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD0B3E1184
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Aug 2021 11:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbhHEJlH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 5 Aug 2021 05:41:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41756 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbhHEJlH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 5 Aug 2021 05:41:07 -0400
Date:   Thu, 05 Aug 2021 09:40:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628156452;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ao+WuQoJmqnC5qbYOYclnazqJl7d6GFTKp5LiAiws9M=;
        b=QfRHI2VpKo+nPI9YekjmMNNAUxZ6+qOyRadTc6JV5qQwFZ08rB4FPgENaVQjEJE1IV44h1
        mlRcHv/yvqvTAJp6G2sKVE9+pMtk0yXw0AX6+Rtakz6rDfKA6QXAn+S4SDZWE6Vk3vcuZn
        bd5QoHHLlgszU7mNbedbAtYrUb/68/Gijq0uxqwhQ8lFEid++HdiM2jMt8kr5+hMxOQrAb
        JmFIeXK1e631Uc0IgpZD+HSQTUZ4d46sso/72Dj9lCQ6u6feXoYKhqV2ks86aRxyGIVQIk
        dssh7HJm8dC5K9rD6FRLcXevh/Cz4F00/uGJcsIz7QFQIm3k53Q/vfAaIdrZOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628156452;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ao+WuQoJmqnC5qbYOYclnazqJl7d6GFTKp5LiAiws9M=;
        b=Tkl+UTZzGbXsawiy65feNCKagNEmQqJ27k+bMfLhE45l+b4+7joRtLs6JLPq/m/cAQua8a
        mttpNlqkRZUzh3DA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] Documentation/atomic_t: Document forward progress
 expectations
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YQK9ziyogxTH0m9H@hirez.programming.kicks-ass.net>
References: <YQK9ziyogxTH0m9H@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <162815645175.395.5062439041466804440.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     55bccf1f93e4bf1b3209cc8648ab53f10f4601a5
Gitweb:        https://git.kernel.org/tip/55bccf1f93e4bf1b3209cc8648ab53f10f4601a5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 29 Jul 2021 16:17:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Aug 2021 15:16:47 +02:00

Documentation/atomic_t: Document forward progress expectations

Add a few words on forward progress; there's been quite a bit of
confusion on the subject.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lkml.kernel.org/r/YQK9ziyogxTH0m9H@hirez.programming.kicks-ass.net
---
 Documentation/atomic_t.txt | 53 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+)

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index a9c1e2b..0f1ffa0 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -312,3 +312,56 @@ Usage:
 
 NB. try_cmpxchg() also generates better code on some platforms (notably x86)
 where the function more closely matches the hardware instruction.
+
+
+FORWARD PROGRESS
+----------------
+
+In general strong forward progress is expected of all unconditional atomic
+operations -- those in the Arithmetic and Bitwise classes and xchg(). However
+a fair amount of code also requires forward progress from the conditional
+atomic operations.
+
+Specifically 'simple' cmpxchg() loops are expected to not starve one another
+indefinitely. However, this is not evident on LL/SC architectures, because
+while an LL/SC architecure 'can/should/must' provide forward progress
+guarantees between competing LL/SC sections, such a guarantee does not
+transfer to cmpxchg() implemented using LL/SC. Consider:
+
+  old = atomic_read(&v);
+  do {
+    new = func(old);
+  } while (!atomic_try_cmpxchg(&v, &old, new));
+
+which on LL/SC becomes something like:
+
+  old = atomic_read(&v);
+  do {
+    new = func(old);
+  } while (!({
+    volatile asm ("1: LL  %[oldval], %[v]\n"
+                  "   CMP %[oldval], %[old]\n"
+                  "   BNE 2f\n"
+                  "   SC  %[new], %[v]\n"
+                  "   BNE 1b\n"
+                  "2:\n"
+                  : [oldval] "=&r" (oldval), [v] "m" (v)
+		  : [old] "r" (old), [new] "r" (new)
+                  : "memory");
+    success = (oldval == old);
+    if (!success)
+      old = oldval;
+    success; }));
+
+However, even the forward branch from the failed compare can cause the LL/SC
+to fail on some architectures, let alone whatever the compiler makes of the C
+loop body. As a result there is no guarantee what so ever the cacheline
+containing @v will stay on the local CPU and progress is made.
+
+Even native CAS architectures can fail to provide forward progress for their
+primitive (See Sparc64 for an example).
+
+Such implementations are strongly encouraged to add exponential backoff loops
+to a failed CAS in order to ensure some progress. Affected architectures are
+also strongly encouraged to inspect/audit the atomic fallbacks, refcount_t and
+their locking primitives.
