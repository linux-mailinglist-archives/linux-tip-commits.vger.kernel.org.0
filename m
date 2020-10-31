Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990A32A157D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Oct 2020 12:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgJaLag (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 31 Oct 2020 07:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgJaLaf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 31 Oct 2020 07:30:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06FFC0613D7;
        Sat, 31 Oct 2020 04:30:34 -0700 (PDT)
Date:   Sat, 31 Oct 2020 11:30:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604143833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WPebnvNRiqX7QhCj9a2SOjvwfUZxd5GMQdlKZqwMIGc=;
        b=hwFcqJhTNL8TPLQYQouKKnNKxmPhQc6+Qgba7oPDQeBKNZrgvuB5RjEuzIf7YJPjGeqeLh
        mOZthXNxDHtZh1kw+djSwJpxHewutRUSenY4mrBjCTJRG+z2Cb7hjDtDOE6o1uEAxQEgf2
        2xIBo8EZf6P0ddbGkDoV7vNST1StMoW1IycXKV646BwiFAPqLjmvophbZyWRKmxqzoyMMl
        bXJnRQl5ydFH8cCD3ZqyPot139QCQSBUlS26yKeRhTcBkVuCdzdmJuPxlVBJXSi9bhQpE0
        P8v+fyxGMBaeCiY+ZNrekvLWEkZqAEedyJKL3PduYRVSt3tySqV5iRdJ461CIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604143833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WPebnvNRiqX7QhCj9a2SOjvwfUZxd5GMQdlKZqwMIGc=;
        b=fCDRGst3JYHVnCkxOrH560KuHhWI5u5WL1wPTGYSwmd9aAh3nmmsYpdQPxfjZMlKOy/tBQ
        X9NkUa7zuSl9N5Aw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/lockdep: Remove more raw_cpu_read() usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201026152256.GB2651@hirez.programming.kicks-ass.net>
References: <20201026152256.GB2651@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160414383224.397.2729117464840782339.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     d48e3850030623e1c20785bceaaf78f916d0b1a3
Gitweb:        https://git.kernel.org/tip/d48e3850030623e1c20785bceaaf78f916d0b1a3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 26 Oct 2020 16:22:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 30 Oct 2020 17:07:18 +01:00

locking/lockdep: Remove more raw_cpu_read() usage

I initially thought raw_cpu_read() was OK, since if it is !0 we have
IRQs disabled and can't get migrated, so if we get migrated both CPUs
must have 0 and it doesn't matter which 0 we read.

And while that is true; it isn't the whole store, on pretty much all
architectures (except x86) this can result in computing the address for
one CPU, getting migrated, the old CPU continuing execution with another
task (possibly setting recursion) and then the new CPU reading the value
of the old CPU, which is no longer 0.

Similer to:

  baffd723e44d ("lockdep: Revert "lockdep: Use raw_cpu_*() for per-cpu variables"")

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201026152256.GB2651@hirez.programming.kicks-ass.net
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index fc206ae..1102849 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -84,7 +84,7 @@ static inline bool lockdep_enabled(void)
 	if (!debug_locks)
 		return false;
 
-	if (raw_cpu_read(lockdep_recursion))
+	if (this_cpu_read(lockdep_recursion))
 		return false;
 
 	if (current->lockdep_recursion)
