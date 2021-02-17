Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BADD31DA24
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbhBQNSm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:18:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45258 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbhBQNST (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:19 -0500
Date:   Wed, 17 Feb 2021 13:17:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkZ8LuUrsqYA4tq2kTJlfhYZ/102jkAr/o3Nx9s1tGo=;
        b=r/qehtAoJK4XSNakon0c8CUPFwUoqVj4ZLXYDVTORvx53sgojCXKzbHQuQj3zwEkYHqlYD
        aIXkdt5TOK47fHoxjc55C/WslV11YMxbkI4CjNQt8308Rtu8owJHmC7OA4cOn3JoXwcHFZ
        p93uMQAATcY9AWr/UKlYi85wKNAk1ApwvheBt35FdHjBZojQrLBDm/0iXgF10Dbe0SD3Eh
        yPP28jDuRztZEgMHGa1Sq7v+lzDOorGI96E0u+7K8BuFZq+xSNkboI1FVFAjVWfNF9e+ok
        qAGvD7yYophKudyws40dLvQo1JWO4bDjTozaOEPIEXgvVyMpPvmlJhDTtRiiJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkZ8LuUrsqYA4tq2kTJlfhYZ/102jkAr/o3Nx9s1tGo=;
        b=1wOht9WOXC6Irl0SdvSdL9Rv5KsN1HXOtjfU8mi7VzGQLc8CW9u21d7j/k35zCFjPrejfT
        eEoXr1AxZcD29SAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] static_call: Pull some static_call declarations to
 the type headers
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210118141223.123667-4-frederic@kernel.org>
References: <20210118141223.123667-4-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <161356785577.20312.1824697247700079939.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     880cfed3a012d7863f42251791cea7fe78c39390
Gitweb:        https://git.kernel.org/tip/880cfed3a012d7863f42251791cea7fe78c39390
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 18 Jan 2021 15:12:18 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:08:35 +01:00

static_call: Pull some static_call declarations to the type headers

Some static call declarations are going to be needed on low level header
files. Move the necessary material to the dedicated static call types
header to avoid inclusion dependency hell.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20210118141223.123667-4-frederic@kernel.org
---
 include/linux/static_call.h             | 21 +-------------------
 include/linux/static_call_types.h       | 27 ++++++++++++++++++++++++-
 tools/include/linux/static_call_types.h | 27 ++++++++++++++++++++++++-
 3 files changed, 54 insertions(+), 21 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 695da4c..a2c0645 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -107,26 +107,10 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 
 #define STATIC_CALL_TRAMP_ADDR(name) &STATIC_CALL_TRAMP(name)
 
-/*
- * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
- * the symbol table so that objtool can reference it when it generates the
- * .static_call_sites section.
- */
-#define __static_call(name)						\
-({									\
-	__ADDRESSABLE(STATIC_CALL_KEY(name));				\
-	&STATIC_CALL_TRAMP(name);					\
-})
-
 #else
 #define STATIC_CALL_TRAMP_ADDR(name) NULL
 #endif
 
-
-#define DECLARE_STATIC_CALL(name, func)					\
-	extern struct static_call_key STATIC_CALL_KEY(name);		\
-	extern typeof(func) STATIC_CALL_TRAMP(name);
-
 #define static_call_update(name, func)					\
 ({									\
 	BUILD_BUG_ON(!__same_type(*(func), STATIC_CALL_TRAMP(name)));	\
@@ -174,7 +158,6 @@ extern int static_call_text_reserved(void *start, void *end);
 	};								\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
-#define static_call(name)	__static_call(name)
 #define static_call_cond(name)	(void)__static_call(name)
 
 #define EXPORT_STATIC_CALL(name)					\
@@ -207,7 +190,6 @@ struct static_call_key {
 	};								\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
-#define static_call(name)	__static_call(name)
 #define static_call_cond(name)	(void)__static_call(name)
 
 static inline
@@ -252,9 +234,6 @@ struct static_call_key {
 		.func = NULL,						\
 	}
 
-#define static_call(name)						\
-	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
-
 static inline void __static_call_nop(void) { }
 
 /*
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index 89135bb..08f78b1 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/stringify.h>
+#include <linux/compiler.h>
 
 #define STATIC_CALL_KEY_PREFIX		__SCK__
 #define STATIC_CALL_KEY_PREFIX_STR	__stringify(STATIC_CALL_KEY_PREFIX)
@@ -32,4 +33,30 @@ struct static_call_site {
 	s32 key;
 };
 
+#define DECLARE_STATIC_CALL(name, func)					\
+	extern struct static_call_key STATIC_CALL_KEY(name);		\
+	extern typeof(func) STATIC_CALL_TRAMP(name);
+
+#ifdef CONFIG_HAVE_STATIC_CALL
+
+/*
+ * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
+ * the symbol table so that objtool can reference it when it generates the
+ * .static_call_sites section.
+ */
+#define __static_call(name)						\
+({									\
+	__ADDRESSABLE(STATIC_CALL_KEY(name));				\
+	&STATIC_CALL_TRAMP(name);					\
+})
+
+#define static_call(name)	__static_call(name)
+
+#else
+
+#define static_call(name)						\
+	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
+
+#endif /* CONFIG_HAVE_STATIC_CALL */
+
 #endif /* _STATIC_CALL_TYPES_H */
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index 89135bb..08f78b1 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/stringify.h>
+#include <linux/compiler.h>
 
 #define STATIC_CALL_KEY_PREFIX		__SCK__
 #define STATIC_CALL_KEY_PREFIX_STR	__stringify(STATIC_CALL_KEY_PREFIX)
@@ -32,4 +33,30 @@ struct static_call_site {
 	s32 key;
 };
 
+#define DECLARE_STATIC_CALL(name, func)					\
+	extern struct static_call_key STATIC_CALL_KEY(name);		\
+	extern typeof(func) STATIC_CALL_TRAMP(name);
+
+#ifdef CONFIG_HAVE_STATIC_CALL
+
+/*
+ * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
+ * the symbol table so that objtool can reference it when it generates the
+ * .static_call_sites section.
+ */
+#define __static_call(name)						\
+({									\
+	__ADDRESSABLE(STATIC_CALL_KEY(name));				\
+	&STATIC_CALL_TRAMP(name);					\
+})
+
+#define static_call(name)	__static_call(name)
+
+#else
+
+#define static_call(name)						\
+	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
+
+#endif /* CONFIG_HAVE_STATIC_CALL */
+
 #endif /* _STATIC_CALL_TYPES_H */
