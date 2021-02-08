Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32B53131C2
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Feb 2021 13:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbhBHMEo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Feb 2021 07:04:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36320 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbhBHMBX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Feb 2021 07:01:23 -0500
Date:   Mon, 08 Feb 2021 12:00:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612785640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7wbrJ0+ogR0lTF3Z7V1ZkFjcGjRMt3dTQAKlyMVbM4=;
        b=2sGakl9R1BW+eh97THZAj+92Da2Pnvi+ydReGCuZ6STnQ85IgvZ+SOizaelSspTCJ8tRBN
        GZuQio6uPTJD1hSmIh3q7klgqprWsO1ULQnt4yE5VSAb8+0p4FiuIVogLaGeH0MY5uPKj7
        MaUliJhgDIvib4a+4HMBdC4jKRsJmVyJ3LNnr84u/1rqNnGlVepWEEqE6C9GSQaHKKY0xQ
        tRPzUToxirm6aIeeI46GpvLIX2/9FQkyCFDNtzxDcZNFM0agfJ7aRlWkkzPnJ+iuYlvz6/
        RYx96GGOf68WZZRs6zYcuwi6KM2vrH3N77/4x1m7VnG+xPtIQItc6tFvaDiw6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612785640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7wbrJ0+ogR0lTF3Z7V1ZkFjcGjRMt3dTQAKlyMVbM4=;
        b=v/JUfufRzNe9p0xuAJCLD/uZWd2Nn8CLemM80G24fcXN8x95/VPySxVidqkatngGythsTA
        fiML7GZT9gf+SDAw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] static_call: Provide DEFINE_STATIC_CALL_RET0()
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210118141223.123667-3-frederic@kernel.org>
References: <20210118141223.123667-3-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <161278564018.23325.14384880539197440259.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     50ace20f2cfecd90c88edaf58400b362f42f2960
Gitweb:        https://git.kernel.org/tip/50ace20f2cfecd90c88edaf58400b362f42f2960
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 18 Jan 2021 15:12:17 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 05 Feb 2021 17:19:55 +01:00

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
