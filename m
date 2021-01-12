Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6A62F3DD1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Jan 2021 01:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436918AbhALVhU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Jan 2021 16:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436725AbhALUMy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Jan 2021 15:12:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AB6C061575;
        Tue, 12 Jan 2021 12:12:14 -0800 (PST)
Date:   Tue, 12 Jan 2021 20:12:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610482332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=snO3IVY4qdhI/+Ul5uPLs2VUli+za8am//xKATLidWU=;
        b=iBFIBAZ27Wqz7d1c6RC9b9Z62Iq71IJiwVWMRAGFo1LekzRxfJEBeVTMC1WNFsTgf5NBSf
        KgG1ITYWzzsXkmzB60RPpSn60PsbQ3kB8Bav2qubGYs08sAntgyj5Nn20EJpz8cQ3t9LJq
        ORoXw/zPttaBdAj9GVkJrMONIJVnZ+jx0Qht6RnyRx4WiqxoG8cvR9ZbgLIoRYWBXrmJdI
        Syt07h7YbnWbFHZb45kPXThPNnmffU9gQGifcp68kUzujana83mfXD3+ObrNnfw5g+Txxf
        TkzjEc8XYgZ13b1U8Ygpe1/DA3wllD1SnVkGneucyDOZcYvtz5RucAzWGG3cbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610482332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=snO3IVY4qdhI/+Ul5uPLs2VUli+za8am//xKATLidWU=;
        b=4FGUVxwzCI+y/PEVU4w19aFCfc4zW39XJiuA3RiZzmeZ3wOSTomRAqv3ize0csfHRFCtNx
        NVcOD3XiRVlXgZDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] locking/lockdep: Avoid noinstr warning for DEBUG_LOCKDEP
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210106144017.652218215@infradead.org>
References: <20210106144017.652218215@infradead.org>
MIME-Version: 1.0
Message-ID: <161048233018.414.13549202418629928003.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     77ca93a6b1223e210e58e1000c09d8d420403c94
Gitweb:        https://git.kernel.org/tip/77ca93a6b1223e210e58e1000c09d8d420403c94
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 06 Jan 2021 15:36:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Jan 2021 21:10:59 +01:00

locking/lockdep: Avoid noinstr warning for DEBUG_LOCKDEP

  vmlinux.o: warning: objtool: lock_is_held_type()+0x60: call to check_flags.part.0() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210106144017.652218215@infradead.org

---
 kernel/locking/lockdep.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 02bc5b8..bdaf482 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5271,12 +5271,15 @@ static void __lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie
 /*
  * Check whether we follow the irq-flags state precisely:
  */
-static void check_flags(unsigned long flags)
+static noinstr void check_flags(unsigned long flags)
 {
 #if defined(CONFIG_PROVE_LOCKING) && defined(CONFIG_DEBUG_LOCKDEP)
 	if (!debug_locks)
 		return;
 
+	/* Get the warning out..  */
+	instrumentation_begin();
+
 	if (irqs_disabled_flags(flags)) {
 		if (DEBUG_LOCKS_WARN_ON(lockdep_hardirqs_enabled())) {
 			printk("possible reason: unannotated irqs-off.\n");
@@ -5304,6 +5307,8 @@ static void check_flags(unsigned long flags)
 
 	if (!debug_locks)
 		print_irqtrace_events(current);
+
+	instrumentation_end();
 #endif
 }
 
