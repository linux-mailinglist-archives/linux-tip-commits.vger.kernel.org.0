Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8DF378864
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 May 2021 13:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhEJLVV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 10 May 2021 07:21:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36326 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbhEJLAp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 10 May 2021 07:00:45 -0400
Date:   Mon, 10 May 2021 10:59:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620644380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yD3id9dv8CxdRVNuAL7X9WjllHhVF7OeGCyQU0LLhx0=;
        b=3bPWO/1BHV8Elg91KfTGuCm28cP+u7YlsWdOx75VslAEx2rSBgfVUEC4N+aiN9dFmPvt7e
        W5b3FIR+4MqDQCZ7l77sa1zaTiuzjnxxrtIHieIaN5Zcp/MMNWStePdApMeDmyPeJRkAUg
        ShDLwc3CnuEpvgww3LxcicioBjc45zIdbCH7egnCnlT1E9kedm7D9mXnSdWMNXoKIgkSEq
        VDGT8K4D5FERoPF5y0TciQgzr6RXJRQMZCONFLJzumy+MIINO/tJ6ZAZg4LDCeycVBEoF9
        0mUyCJKZY7S9Ghowv4WAlQ1+jNQdAwmzTHDVBC2d09uI3HsO4VZDya3jarlaQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620644380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yD3id9dv8CxdRVNuAL7X9WjllHhVF7OeGCyQU0LLhx0=;
        b=GiKtvqqgI3M0mg+y8RMGKW5OI/14uo/gDqJKVhzXz0mFGL+pLI7YyJjbVKi6O/BN8VIgrw
        +zkocFBjlruEc7AA==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Have the __ASM_FORM macros handle commas in arguments
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210510090940.924953-2-hpa@zytor.com>
References: <20210510090940.924953-2-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162064437978.29796.11173208105063192798.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     be5bb8021c9731f5593de6419ae35d3f16a3e497
Gitweb:        https://git.kernel.org/tip/be5bb8021c9731f5593de6419ae35d3f16a3e497
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Mon, 10 May 2021 02:09:38 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 10 May 2021 12:33:28 +02:00

x86/asm: Have the __ASM_FORM macros handle commas in arguments

The __ASM_FORM macros are really useful, but in order to be able to
use them to define instructions via .byte directives breaks because of
the necessary commas. Change the macros to handle commas correctly.

[ mingo: Removed stray whitespaces & aligned the definitions vertically. ]

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210510090940.924953-2-hpa@zytor.com
---
 arch/x86/include/asm/asm.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 0603c74..93aad0b 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -3,25 +3,24 @@
 #define _ASM_X86_ASM_H
 
 #ifdef __ASSEMBLY__
-# define __ASM_FORM(x)	x
-# define __ASM_FORM_RAW(x)     x
-# define __ASM_FORM_COMMA(x) x,
+# define __ASM_FORM(x, ...)		x,## __VA_ARGS__
+# define __ASM_FORM_RAW(x, ...)		x,## __VA_ARGS__
+# define __ASM_FORM_COMMA(x, ...)	x,## __VA_ARGS__,
 #else
 #include <linux/stringify.h>
-
-# define __ASM_FORM(x)	" " __stringify(x) " "
-# define __ASM_FORM_RAW(x)     __stringify(x)
-# define __ASM_FORM_COMMA(x) " " __stringify(x) ","
+# define __ASM_FORM(x, ...)		" " __stringify(x,##__VA_ARGS__) " "
+# define __ASM_FORM_RAW(x, ...)		    __stringify(x,##__VA_ARGS__)
+# define __ASM_FORM_COMMA(x, ...)	" " __stringify(x,##__VA_ARGS__) ","
 #endif
 
 #ifndef __x86_64__
 /* 32 bit */
-# define __ASM_SEL(a,b) __ASM_FORM(a)
-# define __ASM_SEL_RAW(a,b) __ASM_FORM_RAW(a)
+# define __ASM_SEL(a,b)		__ASM_FORM(a)
+# define __ASM_SEL_RAW(a,b)	__ASM_FORM_RAW(a)
 #else
 /* 64 bit */
-# define __ASM_SEL(a,b) __ASM_FORM(b)
-# define __ASM_SEL_RAW(a,b) __ASM_FORM_RAW(b)
+# define __ASM_SEL(a,b)		__ASM_FORM(b)
+# define __ASM_SEL_RAW(a,b)	__ASM_FORM_RAW(b)
 #endif
 
 #define __ASM_SIZE(inst, ...)	__ASM_SEL(inst##l##__VA_ARGS__, \
