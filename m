Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAACD31DA34
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhBQNTg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbhBQNS7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7A1C0617A7;
        Wed, 17 Feb 2021 05:17:38 -0800 (PST)
Date:   Wed, 17 Feb 2021 13:17:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Az31/4/S4uIc27iSXmqzAhcTOthErYGqh3fu40jhdLI=;
        b=iWJoMBzzFlJBYJzjrGjTkfXuhUS6XtfJH7m3F61SdKCDHkJxkF2H1DM/cREz9P09dQIWIM
        ykvRE+IAYSv9o1j2TA7YekLpUxUw/hhOrD//NmaDBYiZgD7Dphsd9R5xceqCw4EgYAumAs
        sQcHd8TWjHIdcSt2MItt8EQSqfeC5qQeDvBY7iI7XlPaE5K/JXl0Q/ivXwd2POxsNAVRcF
        5WcWqMLGQCjIspqP/a3j5l/XYMhvFV2be29NBzhI2KFH23IgpoEBDrb9cPiurX2yDXYGSX
        /JuqyqLmXa/W91CIw4L/QwqtUkjj/TuvZmO8WtTphUKKpoPmKS5TxaNMhcudpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Az31/4/S4uIc27iSXmqzAhcTOthErYGqh3fu40jhdLI=;
        b=fm4wEIblXrGdCPz/KFW4LHunga0y0haTY2QIlHcokQXu+MaktdK/Hh2FWQ0HyKem7ynN8i
        1S3+J/kGCEBGjDDQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] static_call: Provide DEFINE_STATIC_CALL_RET0()
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210118141223.123667-3-frederic@kernel.org>
References: <20210118141223.123667-3-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <161356785532.20312.1253216296853849315.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     29fd01944b7273bb630c649a2104b7f9e4ef3fa6
Gitweb:        https://git.kernel.org/tip/29fd01944b7273bb630c649a2104b7f9e4ef3fa6
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 18 Jan 2021 15:12:17 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:08:51 +01:00

static_call: Provide DEFINE_STATIC_CALL_RET0()

DECLARE_STATIC_CALL() must pass the original function targeted for a
given static call. But DEFINE_STATIC_CALL() may want to initialize it as
off. In this case we can't pass NULL (for functions without return value)
or __static_call_return0 (for functions returning a value) directly
to DEFINE_STATIC_CALL() as that may trigger a static call redeclaration
with a different function prototype. Type casts neither can work around
that as they don't get along with typeof().

The proper way to do that for functions that don't return a value is
to use DEFINE_STATIC_CALL_NULL(). But functions returning a actual value
don't have an equivalent yet.

Provide DEFINE_STATIC_CALL_RET0() to solve this situation.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20210118141223.123667-3-frederic@kernel.org
---
 include/linux/static_call.h | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index bd6735d..d69dd8b 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -144,13 +144,13 @@ extern int static_call_text_reserved(void *start, void *end);
 
 extern long __static_call_return0(void);
 
-#define DEFINE_STATIC_CALL(name, _func)					\
+#define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = _func,						\
+		.func = _func_init,					\
 		.type = 1,						\
 	};								\
-	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func_init)
 
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
 	DECLARE_STATIC_CALL(name, _func);				\
@@ -178,12 +178,12 @@ struct static_call_key {
 	void *func;
 };
 
-#define DEFINE_STATIC_CALL(name, _func)					\
+#define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = _func,						\
+		.func = _func_init,					\
 	};								\
-	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func_init)
 
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
 	DECLARE_STATIC_CALL(name, _func);				\
@@ -234,10 +234,10 @@ static inline long __static_call_return0(void)
 	return 0;
 }
 
-#define DEFINE_STATIC_CALL(name, _func)					\
+#define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
-		.func = _func,						\
+		.func = _func_init,					\
 	}
 
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
@@ -286,4 +286,10 @@ static inline int static_call_text_reserved(void *start, void *end)
 
 #endif /* CONFIG_HAVE_STATIC_CALL */
 
+#define DEFINE_STATIC_CALL(name, _func)					\
+	__DEFINE_STATIC_CALL(name, _func, _func)
+
+#define DEFINE_STATIC_CALL_RET0(name, _func)				\
+	__DEFINE_STATIC_CALL(name, _func, __static_call_return0)
+
 #endif /* _LINUX_STATIC_CALL_H */
