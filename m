Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31606338BFD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Mar 2021 12:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhCLLyu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Mar 2021 06:54:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46938 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhCLLym (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Mar 2021 06:54:42 -0500
Date:   Fri, 12 Mar 2021 11:54:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615550081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l7zdWWOTLjKwHJaa+xt2VeY3hYYG7OxHPwh0lylBVDw=;
        b=1bDTcxT7iuvwrx36DI9F3FbxWyipHQEnTPGEVI/UY1FsW+jsNyNOIZSNl73Y8IYdph5i2D
        1z1trQTrC3Id8FDz/s43kLSGrHteNK8yyghrAV6UlZWUMnpaCPrO47Eyzfz9BSUWzyKHFt
        iN2hvIaSkTWZCIhCLS/NDhwM9kKgM3O0vHZq9754GCNhTCXtlqhSK1+nC8P740hPAzsfE6
        cRYBTy3uKJuK06FMkYU+B/4Kkii9n7O/I7b05PZLCdB3D3xAutfHrYCi5K44yyBnrP5C6f
        OuPCkrDYYBXVor68J+xFhTokntCOlOOHfZzx+cb1OJL6cvh4bhpGXrKynCccxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615550081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l7zdWWOTLjKwHJaa+xt2VeY3hYYG7OxHPwh0lylBVDw=;
        b=6JLRm9VeOpqA+VyTf2UxEWtWZbvcAz77j/j+IhW7EsVa5Ek+A4DVGFexdyh14MAzMFXKEl
        do8Y+dFJHsZ/k+CQ==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] static_call: Move struct static_call_key
 definition to static_call_types.h
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210311142319.4723-3-jgross@suse.com>
References: <20210311142319.4723-3-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <161555008087.398.7857329716500822432.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     b046664872dd78a8bebe3d5f3bb9da9baa93f5ca
Gitweb:        https://git.kernel.org/tip/b046664872dd78a8bebe3d5f3bb9da9baa93f5ca
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Thu, 11 Mar 2021 15:23:07 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 11 Mar 2021 16:04:39 +01:00

static_call: Move struct static_call_key definition to static_call_types.h

Having the definition of static_call() in static_call_types.h makes
no sense as long struct static_call_key isn't defined there, as the
generic implementation of static_call() is referencing this structure.

So move the definition of struct static_call_key to static_call_types.h.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210311142319.4723-3-jgross@suse.com
---
 include/linux/static_call.h             | 18 ------------------
 include/linux/static_call_types.h       | 18 ++++++++++++++++++
 tools/include/linux/static_call_types.h | 18 ++++++++++++++++++
 3 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 85ecc78..76b8812 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -128,16 +128,6 @@ struct static_call_mod {
 	struct static_call_site *sites;
 };
 
-struct static_call_key {
-	void *func;
-	union {
-		/* bit 0: 0 = mods, 1 = sites */
-		unsigned long type;
-		struct static_call_mod *mods;
-		struct static_call_site *sites;
-	};
-};
-
 /* For finding the key associated with a trampoline */
 struct static_call_tramp_key {
 	s32 tramp;
@@ -187,10 +177,6 @@ extern long __static_call_return0(void);
 
 static inline int static_call_init(void) { return 0; }
 
-struct static_call_key {
-	void *func;
-};
-
 #define __DEFINE_STATIC_CALL(name, _func, _func_init)			\
 	DECLARE_STATIC_CALL(name, _func);				\
 	struct static_call_key STATIC_CALL_KEY(name) = {		\
@@ -243,10 +229,6 @@ static inline long __static_call_return0(void)
 
 static inline int static_call_init(void) { return 0; }
 
-struct static_call_key {
-	void *func;
-};
-
 static inline long __static_call_return0(void)
 {
 	return 0;
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
index ae5662d..5a00b8b 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -58,11 +58,25 @@ struct static_call_site {
 	__raw_static_call(name);					\
 })
 
+struct static_call_key {
+	void *func;
+	union {
+		/* bit 0: 0 = mods, 1 = sites */
+		unsigned long type;
+		struct static_call_mod *mods;
+		struct static_call_site *sites;
+	};
+};
+
 #else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
 
 #define __STATIC_CALL_ADDRESSABLE(name)
 #define __static_call(name)	__raw_static_call(name)
 
+struct static_call_key {
+	void *func;
+};
+
 #endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
 
 #ifdef MODULE
@@ -77,6 +91,10 @@ struct static_call_site {
 
 #else
 
+struct static_call_key {
+	void *func;
+};
+
 #define static_call(name)						\
 	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
 
diff --git a/tools/include/linux/static_call_types.h b/tools/include/linux/static_call_types.h
index ae5662d..5a00b8b 100644
--- a/tools/include/linux/static_call_types.h
+++ b/tools/include/linux/static_call_types.h
@@ -58,11 +58,25 @@ struct static_call_site {
 	__raw_static_call(name);					\
 })
 
+struct static_call_key {
+	void *func;
+	union {
+		/* bit 0: 0 = mods, 1 = sites */
+		unsigned long type;
+		struct static_call_mod *mods;
+		struct static_call_site *sites;
+	};
+};
+
 #else /* !CONFIG_HAVE_STATIC_CALL_INLINE */
 
 #define __STATIC_CALL_ADDRESSABLE(name)
 #define __static_call(name)	__raw_static_call(name)
 
+struct static_call_key {
+	void *func;
+};
+
 #endif /* CONFIG_HAVE_STATIC_CALL_INLINE */
 
 #ifdef MODULE
@@ -77,6 +91,10 @@ struct static_call_site {
 
 #else
 
+struct static_call_key {
+	void *func;
+};
+
 #define static_call(name)						\
 	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
 
