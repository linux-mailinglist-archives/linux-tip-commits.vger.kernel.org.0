Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB07A232072
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Jul 2020 16:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgG2Ode (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 29 Jul 2020 10:33:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42948 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgG2Odb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:31 -0400
Date:   Wed, 29 Jul 2020 14:33:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033209;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TqKXNngZiFhVq+awtR9H3dRKe/CDQ0+Hgwc+V7U2sRA=;
        b=3njZXrv6Fb168eepwlb5iSDmz2S0PLrPC8fSS5LHJmqzILRiW8pOM+ncWgQuN8iAAql9/y
        kSPdVThAjTMb/aY+cbloWQncb+YeT61mFQOnY01ymFGN+Qqv2CKJI13Ahc8FXYox1Y7hM2
        h6bjrY0hb7qmXzOCob+zYbLgcqgG940q2+eekHQFp5xKaGb70MWN2X6Fq10kapvVACEgKK
        g+LAu8ERvCfLGK5qZvI5T3V/yOiJSXsjhc6YTx5h/O0gz2cV6PwvkbM6pf9AymQQV+gY8a
        zqz4Q2WDEG/+n+8uFrAgYgAtEVXIhVmpScs1sQKQWFAKGmdExnD+50Bru8oCcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033209;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TqKXNngZiFhVq+awtR9H3dRKe/CDQ0+Hgwc+V7U2sRA=;
        b=VB3PtjyKXgmMJLfnmiIyny7lS89vUQRUvdXkGoKQHWR+mId9Hzle7bT+f1lcFy809L2Mn4
        cKB/iHeHqgRzKZBw==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] userfaultfd: Use sequence counter with associated
 spinlock
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-23-a.darwish@linutronix.de>
References: <20200720155530.1173732-23-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603320856.4006.8977304185444747615.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2ca97ac8bdcc31fdc868f40c73c017f0a648dc07
Gitweb:        https://git.kernel.org/tip/2ca97ac8bdcc31fdc868f40c73c017f0a648dc07
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:28 +02:00

userfaultfd: Use sequence counter with associated spinlock

A sequence counter write side critical section must be protected by some
form of locking to serialize writers. A plain seqcount_t does not
contain the information of which lock must be held when entering a write
side critical section.

Use the new seqcount_spinlock_t data type, which allows to associate a
spinlock with the sequence counter. This enables lockdep to verify that
the spinlock used for writer serialization is held when the write side
critical section is entered.

If lockdep is disabled this lock association is compiled out and has
neither storage size nor runtime overhead.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200720155530.1173732-23-a.darwish@linutronix.de
---
 fs/userfaultfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 52de290..26e8b23 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -61,7 +61,7 @@ struct userfaultfd_ctx {
 	/* waitqueue head for events */
 	wait_queue_head_t event_wqh;
 	/* a refile sequence protected by fault_pending_wqh lock */
-	struct seqcount refile_seq;
+	seqcount_spinlock_t refile_seq;
 	/* pseudo fd refcounting */
 	refcount_t refcount;
 	/* userfaultfd syscall flags */
@@ -1998,7 +1998,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 	init_waitqueue_head(&ctx->fault_wqh);
 	init_waitqueue_head(&ctx->event_wqh);
 	init_waitqueue_head(&ctx->fd_wqh);
-	seqcount_init(&ctx->refile_seq);
+	seqcount_spinlock_init(&ctx->refile_seq, &ctx->fault_pending_wqh.lock);
 }
 
 SYSCALL_DEFINE1(userfaultfd, int, flags)
