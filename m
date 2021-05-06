Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D1C37550E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 May 2021 15:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbhEFNtQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 May 2021 09:49:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40434 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbhEFNtQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 May 2021 09:49:16 -0400
Date:   Thu, 06 May 2021 13:48:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620308897;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V+E1jza673rsP7eF2/pxH4zfwde33e7WTNJOHAFJAlQ=;
        b=TS+NLAPCl+zkvWBf0X2OTfBa1mcni0j2pNMzqf6w1tazuxHe0/iaFhihVU4JPP5+qucGKH
        4tOinHfqK0CzWwy6VrNibSpBHQmP2QgbiedFk00owV1//uQ8LLU/LfSWmhpfa56G+N9vI4
        mK4BgIkzZERrq8RGzi14LZPeOprZvio+ROnNFHnOECsrxoqNDluWGgYnz0z8tOSIL31q9r
        s2OCQLtAxPGpCFl8+gE76bU2uW6QHgRYeq2T5PtHLeri9V9Vpdav1YxfoctvC8CHjyJJpQ
        /wxLlDkTiu39cQ4NJAeXeP7RS1hO+KZg1bdrg2u/VghLt40hqDsFQf/qqz/PAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620308897;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V+E1jza673rsP7eF2/pxH4zfwde33e7WTNJOHAFJAlQ=;
        b=AtQNP+3ZaXeZdBHz/rKUGajjdbilvb4DtF0NODBTLSzW7dA3qCsg9Uije6DrMdvy2AtXrZ
        lpvcmykDTiAXT1Dg==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/qrwlock: Cleanup queued_write_lock_slowpath()
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210426185017.19815-1-longman@redhat.com>
References: <20210426185017.19815-1-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <162030889600.29796.9867411555566955804.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     28ce0e70ecc30cc7d558a0304e6b816d70848f9a
Gitweb:        https://git.kernel.org/tip/28ce0e70ecc30cc7d558a0304e6b816d70848f9a
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Mon, 26 Apr 2021 14:50:17 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 06 May 2021 15:33:49 +02:00

locking/qrwlock: Cleanup queued_write_lock_slowpath()

Make the code more readable by replacing the atomic_cmpxchg_acquire()
by an equivalent atomic_try_cmpxchg_acquire() and change atomic_add()
to atomic_or().

For architectures that use qrwlock, I do not find one that has an
atomic_add() defined but not an atomic_or().  I guess it should be fine
by changing atomic_add() to atomic_or().

Note that the previous use of atomic_add() isn't wrong as only one
writer that is the wait_lock owner can set the waiting flag and the
flag will be cleared later on when acquiring the write lock.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20210426185017.19815-1-longman@redhat.com
---
 kernel/locking/qrwlock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index b94f383..ec36b73 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -66,12 +66,12 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 	arch_spin_lock(&lock->wait_lock);
 
 	/* Try to acquire the lock directly if no reader is present */
-	if (!atomic_read(&lock->cnts) &&
-	    (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0))
+	if (!(cnts = atomic_read(&lock->cnts)) &&
+	    atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED))
 		goto unlock;
 
 	/* Set the waiting flag to notify readers that a writer is pending */
-	atomic_add(_QW_WAITING, &lock->cnts);
+	atomic_or(_QW_WAITING, &lock->cnts);
 
 	/* When no more readers or writers, set the locked flag */
 	do {
