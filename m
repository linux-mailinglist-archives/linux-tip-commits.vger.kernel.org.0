Return-Path: <linux-tip-commits+bounces-4339-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC680A68AA1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933D93B32EE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130D82561AA;
	Wed, 19 Mar 2025 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L+5y9omw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/7jpNZXe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFCA2561AD;
	Wed, 19 Mar 2025 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382220; cv=none; b=lh97oKcQMaeattNEyf4ggO3dpXId7RGgt8RV4sDH0Oh7VFScP8us6cw43zeM5Swdpn5/utsVzYvcBSb/n5Hb9A5iuByRubTA8san/CjRVH4k2MUFFtAoGh3a3euYjiHFyYbF+Z2DVWwQGXXJJDuoEohsyQH69GQhkmCyY8rN6fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382220; c=relaxed/simple;
	bh=gRuYIYfDfqf2R85j2VNJ4OHzuWMxhYJ/HlasgQZUsBc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=abuybfQDypBbVuqp+UuG/AqYO+RJFItQEVxfJzuMO+uoVojpJohq8YFq3AM0NGMgD+xjIzJ9Mbr0tdQmmtSnsStFucmzSYKqlENjyh/dvTl/+13qyWgIxxVChmjBFCIe2mtGIaN7oLGl+IIDFGHaQHw7JhnAWVhddL7AhtwmA24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L+5y9omw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/7jpNZXe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382217;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftPJuIwJfuAWrzIbV6ZGF75SdN0UU51ONPstpDN5rQE=;
	b=L+5y9omwnXHXwMbqMvKi6WejTAvDzJbsxDJTGWgcnEgs2Ia48r+I2441H3Gr7Tm12XH1R2
	r/cJDnfztBVeYtAmjLYi0y8EZiUaYCbhiDKOTYQ6tWlWpAB971bgB/hlx9LuewSVUIUI4n
	pzFhQ0ag5zpzzOHvf2Q4aNXDAz6YLC9gT87pr8BtnJqA0CC1MijpS7e4A+KsLxpNeCi5nR
	ZAFVXCdEVIB4Ja+6BzuMfYNz8rcbflvpVnMUZbXVxOGTgezs7ODCHeiExutCTkcHh3JxsV
	aph/NRPOpRM98TC5OpZNKyplG9KW75DiUIOVPbkB4lC9zKcnHvxRiPfCKgm3kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382217;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftPJuIwJfuAWrzIbV6ZGF75SdN0UU51ONPstpDN5rQE=;
	b=/7jpNZXe8Y0M54EbW8m0s6uAdRKiFHLS1zaYo9EMZnq8I6ixifbTKv9RpPDqzP7n6V+7Qk
	7u/VCZcvZ4au4sAg==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/runtime-const: Add the RUNTIME_CONST_PTR assembly macro
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250304153342.2016569-1-kirill.shutemov@linux.intel.com>
References: <20250304153342.2016569-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238221664.14745.2387967000526920606.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     bd72baff229920da1d57c14364c11ecdbaf5b458
Gitweb:        https://git.kernel.org/tip/bd72baff229920da1d57c14364c11ecdbaf5b458
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 04 Mar 2025 17:33:42 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:26:24 +01:00

x86/runtime-const: Add the RUNTIME_CONST_PTR assembly macro

Add an assembly macro to refer runtime cost. It hides linker magic and
makes assembly more readable.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250304153342.2016569-1-kirill.shutemov@linux.intel.com
---
 arch/x86/include/asm/runtime-const.h | 13 +++++++++++++
 arch/x86/lib/getuser.S               |  7 ++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
index 6652ebd..8d983cf 100644
--- a/arch/x86/include/asm/runtime-const.h
+++ b/arch/x86/include/asm/runtime-const.h
@@ -2,6 +2,18 @@
 #ifndef _ASM_RUNTIME_CONST_H
 #define _ASM_RUNTIME_CONST_H
 
+#ifdef __ASSEMBLY__
+
+.macro RUNTIME_CONST_PTR sym reg
+	movq	$0x0123456789abcdef, %\reg
+	1:
+	.pushsection runtime_ptr_\sym, "a"
+	.long	1b - 8 - .
+	.popsection
+.endm
+
+#else /* __ASSEMBLY__ */
+
 #define runtime_const_ptr(sym) ({				\
 	typeof(sym) __ret;					\
 	asm_inline("mov %1,%0\n1:\n"				\
@@ -58,4 +70,5 @@ static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
 	}
 }
 
+#endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 71d8e7d..9d5654b 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -35,16 +35,13 @@
 #include <asm/thread_info.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
+#include <asm/runtime-const.h>
 
 #define ASM_BARRIER_NOSPEC ALTERNATIVE "", "lfence", X86_FEATURE_LFENCE_RDTSC
 
 .macro check_range size:req
 .if IS_ENABLED(CONFIG_X86_64)
-	movq $0x0123456789abcdef,%rdx
-  1:
-  .pushsection runtime_ptr_USER_PTR_MAX,"a"
-	.long 1b - 8 - .
-  .popsection
+	RUNTIME_CONST_PTR USER_PTR_MAX, rdx
 	cmp %rdx, %rax
 	cmova %rdx, %rax
 .else

