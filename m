Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01ECE2BAA61
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Nov 2020 13:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgKTMow (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Nov 2020 07:44:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40512 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgKTMov (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Nov 2020 07:44:51 -0500
Date:   Fri, 20 Nov 2020 12:44:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605876290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUevGj4SXsv9BZC05AUHz8YZO5bWtlYKzhjznNnYcrs=;
        b=1daLPaundw+noodYFy69kgenmpFqxpVUD06rDf5iMQVrhkZwCOLawJGvyYD1sD7UjMYv5B
        UcA1ESdrwo7L/7iSb+VWSswbGdVQlcnPjZlDKwaPGN+BnVmIVqqs7ub7vcerDVjc9GbQlA
        IVHRcg1TucVkH9hkc9afT3EGzpvabd9nQxXF5Z64UDLbKmy1jh+LDdFC9ohyEGpR+ImYrF
        p/K+NqG01gXfrExzTSpu36pqRRoDdbSknJ0IhLiKv5NaXoS0PS94aTOB+7cxdAt40vb24r
        Q5IBSBxHqs8iCzMWmZPClsK1XpUfY0BtLxFmkhGgGGFn1G4/9D3WQ2FUKRYPfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605876290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUevGj4SXsv9BZC05AUHz8YZO5bWtlYKzhjznNnYcrs=;
        b=th+C0iUMr+fKq7q3RF/VJ3+W8mH6nzsn0YCWK9bFLI8iVQd/xULnqxVAcD9qz9d3QJnUa3
        6p9AJh3b0XLZUnDw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] context_tracking: Only define schedule_user() on
 !HAVE_CONTEXT_TRACKING_OFFSTACK archs
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201117151637.259084-5-frederic@kernel.org>
References: <20201117151637.259084-5-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <160587628920.11244.3698496906243266018.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     6775de4984ea83ce39f19a40c09f8813d7423831
Gitweb:        https://git.kernel.org/tip/6775de4984ea83ce39f19a40c09f8813d7423831
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 17 Nov 2020 16:16:36 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 Nov 2020 11:25:42 +01:00

context_tracking: Only define schedule_user() on !HAVE_CONTEXT_TRACKING_OFFSTACK archs

schedule_user() was traditionally used by the entry code's tail to
preempt userspace after the call to user_enter(). Indeed the call to
user_enter() used to be performed upon syscall exit slow path which was
right before the last opportunity to schedule() while resuming to
userspace. The context tracking state had to be saved on the task stack
and set back to CONTEXT_KERNEL temporarily in order to safely switch to
another task.

Only a few archs use it now (namely sparc64 and powerpc64) and those
implementing HAVE_CONTEXT_TRACKING_OFFSTACK definetly can't rely on it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201117151637.259084-5-frederic@kernel.org
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c23d7cb..44426e5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4631,7 +4631,7 @@ void __sched schedule_idle(void)
 	} while (need_resched());
 }
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#if defined(CONFIG_CONTEXT_TRACKING) && !defined(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK)
 asmlinkage __visible void __sched schedule_user(void)
 {
 	/*
