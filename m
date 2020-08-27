Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2325253FA2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Aug 2020 09:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgH0HyU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 27 Aug 2020 03:54:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36518 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgH0HyS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:18 -0400
Date:   Thu, 27 Aug 2020 07:54:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qhGDvei9gErvqmlFt/FJv9xd+obZJwYjc4EEC1d0S2Y=;
        b=r/qvwVucZ4oQNopx6Tv/yKFXgcgrD1cvOmdGx855CwUdyQ7EKfwzcKCAu/FsId4IHcQv7y
        4/OU1FLfYkG5Gt2Dhm1sZcF+aq1UYw4AI2Y7bxCh6jCxC3Gm1TwItSNpQ0mOYazKBkUUth
        PEAVs3PyqrIQxZsQYepQgwn+qsrgoFExkEBkGsiqHknZF75it47BBmaS31rbWLYIxmq0ZH
        uF+WER67dBg8NuV0/z//POl9njZovRE0yOOO5gMswh+yXOMwti3p8j1FZFTMNw1Vkcwed4
        eb4/9PDMHPzAHgPUr2Kf8QmcojA5N6f8D/jnCw1FMzCmxTcqvM6U5WmLLCGGxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qhGDvei9gErvqmlFt/FJv9xd+obZJwYjc4EEC1d0S2Y=;
        b=db9TDiPvVw0fWeTZ/UJaqUSTiSQ4rA+c27ffzI3Vc1du2PzLAtRd65OGske4Nq4qK6eERP
        M0TLN9BvqiSZBuAA==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] Revert "locking/lockdep/selftests: Fix mixed
 read-write ABBA tests"
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807074238.1632519-18-boqun.feng@gmail.com>
References: <20200807074238.1632519-18-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <159851485554.20229.17074046423465428430.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     108dc42ed3507fe06214d51ab15fca7771df8bbd
Gitweb:        https://git.kernel.org/tip/108dc42ed3507fe06214d51ab15fca7771df8bbd
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Aug 2020 15:42:36 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:07 +02:00

Revert "locking/lockdep/selftests: Fix mixed read-write ABBA tests"

This reverts commit d82fed75294229abc9d757f08a4817febae6c4f4.

Since we now could handle mixed read-write deadlock detection well, the
self tests could be detected as expected, no need to use this
work-around.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200807074238.1632519-18-boqun.feng@gmail.com
---
 lib/locking-selftest.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 76c314a..4264cf4 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2273,14 +2273,6 @@ void locking_selftest(void)
 	print_testname("mixed read-lock/lock-write ABBA");
 	pr_cont("             |");
 	dotest(rlock_ABBA1, FAILURE, LOCKTYPE_RWLOCK);
-#ifdef CONFIG_PROVE_LOCKING
-	/*
-	 * Lockdep does indeed fail here, but there's nothing we can do about
-	 * that now.  Don't kill lockdep for it.
-	 */
-	unexpected_testcase_failures--;
-#endif
-
 	pr_cont("             |");
 	dotest(rwsem_ABBA1, FAILURE, LOCKTYPE_RWSEM);
 
