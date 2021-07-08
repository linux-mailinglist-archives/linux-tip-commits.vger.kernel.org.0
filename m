Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E13C3BF6F9
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Jul 2021 10:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhGHIpU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Jul 2021 04:45:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50156 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhGHIpR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Jul 2021 04:45:17 -0400
Date:   Thu, 08 Jul 2021 08:42:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625733754;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1tiXnXA2geNuqo5yihtFM0roznMTk9XKuXE3x9JbFXw=;
        b=c3Z7hv2UWo2bHRDJtPivG7xswgWTRyAU+7nBE+XfJGeCjrSHPmEDz/hej5s/Ks7b9wwp7D
        1Hnilkq697lrbTFnwc8jKurIjnPilYJp9YvCKB1jLrFm57Q3GHLXZuBSJmk96b+wzK8QCq
        JZGwE5rYUXINss4cqz4iC3id1yX1CCAxEbySX81NnNp5K5FXz4mbWYfGpPObCqVIvC7GHk
        ddbzS5y+/Tr8rf+r4a6mjqF/mVDOo79pxj0fH7DJgWGeG0FE/kDmwjFiZyGFnnGksvwIEe
        ZY79AmUsx9aCgs6181XVnb35ptrdl+leZlvUH4gAbBX+bNQ+WTTY3NekZtP7bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625733754;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1tiXnXA2geNuqo5yihtFM0roznMTk9XKuXE3x9JbFXw=;
        b=ksoUo3Y67VgQeht09b1G9Bj6VHrrzHCIERi7P5G8R84GF3n6HOejs8sofv/dHBrnlSKO3h
        PoJUAPYEsA2l+3BQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] Documentation/atomic_t: Document cmpxchg() vs
 try_cmpxchg()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YOMgPeMOmmiK3tXO@hirez.programming.kicks-ass.net>
References: <YOMgPeMOmmiK3tXO@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <162573375370.395.17829380230599129573.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d1bbfd0c7c9f985e57795a7e0cefc209ebf689c0
Gitweb:        https://git.kernel.org/tip/d1bbfd0c7c9f985e57795a7e0cefc209ebf689c0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 05 Jul 2021 17:00:24 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Jul 2021 13:53:25 +02:00

Documentation/atomic_t: Document cmpxchg() vs try_cmpxchg()

There seems to be a significant amount of confusion around the new
try_cmpxchg(), despite this being more like the C11
atomic_compare_exchange_*() family. Add a few words of clarification
on how cmpxchg() and try_cmpxchg() relate to one another.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/YOMgPeMOmmiK3tXO@hirez.programming.kicks-ass.net
---
 Documentation/atomic_t.txt | 41 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+)

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index 0f1fded..a9c1e2b 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -271,3 +271,44 @@ WRITE_ONCE.  Thus:
 			SC *y, t;
 
 is allowed.
+
+
+CMPXCHG vs TRY_CMPXCHG
+----------------------
+
+  int atomic_cmpxchg(atomic_t *ptr, int old, int new);
+  bool atomic_try_cmpxchg(atomic_t *ptr, int *oldp, int new);
+
+Both provide the same functionality, but try_cmpxchg() can lead to more
+compact code. The functions relate like:
+
+  bool atomic_try_cmpxchg(atomic_t *ptr, int *oldp, int new)
+  {
+    int ret, old = *oldp;
+    ret = atomic_cmpxchg(ptr, old, new);
+    if (ret != old)
+      *oldp = ret;
+    return ret == old;
+  }
+
+and:
+
+  int atomic_cmpxchg(atomic_t *ptr, int old, int new)
+  {
+    (void)atomic_try_cmpxchg(ptr, &old, new);
+    return old;
+  }
+
+Usage:
+
+  old = atomic_read(&v);			old = atomic_read(&v);
+  for (;;) {					do {
+    new = func(old);				  new = func(old);
+    tmp = atomic_cmpxchg(&v, old, new);		} while (!atomic_try_cmpxchg(&v, &old, new));
+    if (tmp == old)
+      break;
+    old = tmp;
+  }
+
+NB. try_cmpxchg() also generates better code on some platforms (notably x86)
+where the function more closely matches the hardware instruction.
