Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB993131C5
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Feb 2021 13:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhBHMFO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Feb 2021 07:05:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36322 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbhBHMB0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Feb 2021 07:01:26 -0500
Date:   Mon, 08 Feb 2021 12:00:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612785641;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCKvnKwdBITWs+pR/aAENyN98e8CEIfhMSxgk6gy6Ec=;
        b=fKd3E6mSrxN1SWz0k6Q/lTyui6isxdl7KiKTEUhuD2jihfaZ66c0CYI11Vr5ZM2MKn0p+j
        9+ZqHYugQny5NS5O3SkJT/AcJVNbHYD+NN0+c6YRHT9FV6j90EkHea2P/uDumPm+LD05W3
        2Tl0DdkRNKz1hkhugSFa+CRn0Cg4SQApxQ4CIFaP1nZAmOn4hv0LJHc1zq0AoN43Bgpve5
        jeeeVxqHhvcMKnx4g3QCwq+/gtBq3hWAtz9rUEY7guldFmTuZRjDmJ8HfbhgC/CC2/n+dF
        OCbMMqG4ccSNm5LcNA5g+BwKQ0AsQ/OctTDpVV/ppNju3im4gJ8EKdXTJx1knw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612785641;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCKvnKwdBITWs+pR/aAENyN98e8CEIfhMSxgk6gy6Ec=;
        b=3VY7LchirP3fR1MPzEeRtFBID2DwF2H9a7aqNCjN80hjQ12oCTRbNWpM1KFEWlP/z8d0Vh
        N2LnkafNWtSsw0Bg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] static_call: Pull some static_call declarations to
 the type headers
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210118141223.123667-4-frederic@kernel.org>
References: <20210118141223.123667-4-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <161278564067.23325.10974479398151772834.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     407bc881b21d9b6cd14dd9b09adffc2d8e45fbe9
Gitweb:        https://git.kernel.org/tip/407bc881b21d9b6cd14dd9b09adffc2d8e45fbe9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 18 Jan 2021 15:12:18 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 05 Feb 2021 17:19:54 +01:00

static_call: Pull some static_call declarations to the type headers

Some static call declarations are going to be needed on low level header
files. Move the necessary material to the dedicated static call types
header to avoid inclusion dependency hell.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
