Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202742824B2
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 Oct 2020 16:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgJCOW1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 3 Oct 2020 10:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgJCOW1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 3 Oct 2020 10:22:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FECC0613D0;
        Sat,  3 Oct 2020 07:22:26 -0700 (PDT)
Date:   Sat, 03 Oct 2020 14:22:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601734945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wZhirwpt1PSn/tdjVw8sKf8GRictB6TaYL8Zm3MnWKU=;
        b=EwJId8sIe0MPWG1+gyOKqVX6yfpVZGeY2+JUA04L2re7wQ0kGyr78ecADjxd+dwuZyAv3Q
        50UB7bF31gOym5yOhVRufQMPbJfyjS5ToMSZgAifQ7A9M4z/NZoXwhN6H4d7/yJBxbIUT5
        ZumcXwVUx2gY3cMdy6aWhy501oEql11OMExCPWNyLomk8JWBCDs322RbGSQduwoW79paiI
        tSY7oLvMA8ndVP3EnNwL5NwU9YSCOffXyXo/XbeSKA71TPt2g+AXs8K24ckmzR7gMXQ84i
        +UodXBG27cEhmGVWU4oKU4rUHpfX2Q0ZqMS3/nZD11d1Q++GCD+30hnyRx1Btw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601734945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wZhirwpt1PSn/tdjVw8sKf8GRictB6TaYL8Zm3MnWKU=;
        b=b17Rx8uGY1voNG9RBPJ6ZuvBhD7togPOs5uVE7IkkOFbp1JEsaWvh8A4MJpBDxxSKfZxuc
        ZHtD1zk4TSkIWTDw==
From:   "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] static_call: Fix return type of static_call_init
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160173494363.7002.10430993422075682487.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     69e0ad37c9f32d5aa1beb02aab4ec0cd055be013
Gitweb:        https://git.kernel.org/tip/69e0ad37c9f32d5aa1beb02aab4ec0cd055be013
Author:        Nathan Chancellor <natechancellor@gmail.com>
AuthorDate:    Mon, 28 Sep 2020 16:09:39 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Oct 2020 21:18:25 +02:00

static_call: Fix return type of static_call_init

Functions that are passed to early_initcall should be of type
initcall_t, which expects a return type of int. This is not currently an
error but a patch in the Clang LTO series could change that in the
future.

Fixes: 9183c3f9ed71 ("static_call: Add inline static call infrastructure")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/lkml/20200903203053.3411268-17-samitolvanen@google.com/
---
 include/linux/static_call.h | 6 +++---
 kernel/static_call.c        | 5 +++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index bfa2ba3..695da4c 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -136,7 +136,7 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
-extern void __init static_call_init(void);
+extern int __init static_call_init(void);
 
 struct static_call_mod {
 	struct static_call_mod *next;
@@ -187,7 +187,7 @@ extern int static_call_text_reserved(void *start, void *end);
 
 #elif defined(CONFIG_HAVE_STATIC_CALL)
 
-static inline void static_call_init(void) { }
+static inline int static_call_init(void) { return 0; }
 
 struct static_call_key {
 	void *func;
@@ -234,7 +234,7 @@ static inline int static_call_text_reserved(void *start, void *end)
 
 #else /* Generic implementation */
 
-static inline void static_call_init(void) { }
+static inline int static_call_init(void) { return 0; }
 
 struct static_call_key {
 	void *func;
diff --git a/kernel/static_call.c b/kernel/static_call.c
index f8362b3..84565c2 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -410,12 +410,12 @@ int static_call_text_reserved(void *start, void *end)
 	return __static_call_mod_text_reserved(start, end);
 }
 
-void __init static_call_init(void)
+int __init static_call_init(void)
 {
 	int ret;
 
 	if (static_call_initialized)
-		return;
+		return 0;
 
 	cpus_read_lock();
 	static_call_lock();
@@ -434,6 +434,7 @@ void __init static_call_init(void)
 #ifdef CONFIG_MODULES
 	register_module_notifier(&static_call_module_nb);
 #endif
+	return 0;
 }
 early_initcall(static_call_init);
 
