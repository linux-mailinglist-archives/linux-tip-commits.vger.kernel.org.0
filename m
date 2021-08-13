Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EBF3EB25F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Aug 2021 10:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239785AbhHMIMh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 13 Aug 2021 04:12:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35452 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239784AbhHMIMg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 13 Aug 2021 04:12:36 -0400
Date:   Fri, 13 Aug 2021 08:12:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628842329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kiGssYmJWifNSL0LTgOD5QX+8xwLadt3DKw2Hxa10IQ=;
        b=26TJiJuZAljXXPIv0E/MvMlxsEV+H0jhbMhpgXONGfnAtYYv4gOAEWzPafTajMefYs5hci
        F3ato2u/bSKJwlGOLK8gXcUed32i1OaiN1NLlETse49T12lnoUxqHyX9FrnVxidbDKFM0s
        lwB8vsbVzGc/4BQN9TZDORzZVmd3Z1Ri26wmn3qV354mjxz95Um+WPRoDQ6kGT/rOREYgA
        k3J2Wjin/F09soxIo4yhVrBqeaAX2AeHhha+VZ/LGpBv4/U2ppoJWBBKqK7QJa8RvRrJ68
        pjwocZAE0uZFIbKzMtuj1QfDcWtHQZqdiwzlJ2C4ioQxHFBJhHnRYk31eS0Fzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628842329;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kiGssYmJWifNSL0LTgOD5QX+8xwLadt3DKw2Hxa10IQ=;
        b=GPKuvd7qq01jpkcJd838iJukEAiEJhUpAWuWjRxU55NcPuxEhxhhWXsEVORKI5yMGlfAgh
        Maepe4bZl75yiqCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Make them PREEMPT_RT aware
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87sfzehdnl.ffs@tglx>
References: <87sfzehdnl.ffs@tglx>
MIME-Version: 1.0
Message-ID: <162884232829.395.5057138139418300894.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     4bedcc28469a24fe481a8a31b3584e6070457ddb
Gitweb:        https://git.kernel.org/tip/4bedcc28469a24fe481a8a31b3584e6070457ddb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 12 Aug 2021 17:43:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 13 Aug 2021 10:07:44 +02:00

debugobjects: Make them PREEMPT_RT aware

On PREEMPT_RT enabled kernels it is not possible to refill the object pool
from atomic context (preemption or interrupts disabled) as the allocator
might acquire 'sleeping' spinlocks.

Guard the invocation of fill_pool() accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/87sfzehdnl.ffs@tglx

---
 lib/debugobjects.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 9e14ae0..6946f8e 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -557,7 +557,12 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
 	struct debug_obj *obj;
 	unsigned long flags;
 
-	fill_pool();
+	/*
+	 * On RT enabled kernels the pool refill must happen in preemptible
+	 * context:
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
+		fill_pool();
 
 	db = get_bucket((unsigned long) addr);
 
