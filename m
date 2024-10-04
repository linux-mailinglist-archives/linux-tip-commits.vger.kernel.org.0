Return-Path: <linux-tip-commits+bounces-2348-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4CC990FD8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Oct 2024 22:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13011F20F00
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Oct 2024 20:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D2E1DED70;
	Fri,  4 Oct 2024 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UIQ45bRO"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1704D1DD877;
	Fri,  4 Oct 2024 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070684; cv=none; b=QWea9CMufQPIyf4dpeTMOrTuh5KbYsTfWMZZT5kJnIep/O3Ohuzt7WaBMOELM4AFPWW46W7Wb42AYEKRGjAnIMxcC8D89+BZvpxcVm4nWyJoVygu8r01/M7tUODG0Vv/Go6VPmXXGHJaStteMdnHMfnmXz8Fe4+xcRwjDzVG4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070684; c=relaxed/simple;
	bh=3dnulebnt36xEt7t92LjcZtY2SfY5UFlrjmJRjNwX18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZuNJEzLAtaa80DVhu+3o3qBETHeuChbDLVU5yDZEFpEhyMMAIufMokBXUCVVDfuKWxTwGhnGxyvQ5o5AALkytIncvSo8fusl1E6gOvPjBsAABAaDg4mKhhHuQwfeSIOgKhCdfFPOgLWHNy5ACFP5CPHI9Xm3XJgSOObgFilws4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UIQ45bRO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c4d+dcl3hioQSc5gkGdG14DOVk0MLhEjcUXGDu7UaKY=; b=UIQ45bROz5p+FU7LWlRSS7Yfhw
	rq5f624lN1fL/sXfu81FDJYAod+3Qc7jKaTMy8rtdjA/lZ9qlI5mGVEit61ZaH+0IGdArqzo2IMFs
	J2y1RgMA6PzmXzrLmZTKLU2jWNuCmXY06zmcazKE9lNEOMrR2upUacgNmyI7rrn70fAx8pCbwIn66
	8anzFtz2n4D4GxEhP0r8BdM7zCAqOb4ddB5d6EhaEExvQUuYgHbJ1ejsUvsGgAggwNrqlJeuva+Pv
	4IEDYcjofZn8wosqm4HIgWxbSfjkJ0Mvt5ky0UDUicjDdjrqwH8XXQlmBev477qP4Jz4qX0V+iUAU
	aluMkU1g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1swo7g-0000000B9nS-1h96;
	Fri, 04 Oct 2024 19:37:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 07F2A30083E; Fri,  4 Oct 2024 21:37:56 +0200 (CEST)
Date: Fri, 4 Oct 2024 21:37:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	David Kaplan <david.kaplan@amd.com>, x86@kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [tip: x86/bugs] Revert "x86/retpoline: Ensure default return
 thunk isn't used at runtime"
Message-ID: <20241004193755.GV18071@noisy.programming.kicks-ass.net>
References: <20231018175531.GEZTAcE2p92U1AuVp1@fat_crate.local>
 <169770844376.3135.9436969789797102205.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169770844376.3135.9436969789797102205.tip-bot2@tip-bot2>

On Thu, Oct 19, 2023 at 09:40:43AM -0000, tip-bot2 for Borislav Petkov (AMD) wrote:
> The following commit has been merged into the x86/bugs branch of tip:
> 
> Commit-ID:     08ec7e82c1e3ebcd79ab8d2d0d11faad0f07e71c
> Gitweb:        https://git.kernel.org/tip/08ec7e82c1e3ebcd79ab8d2d0d11faad0f07e71c
> Author:        Borislav Petkov (AMD) <bp@alien8.de>
> AuthorDate:    Thu, 19 Oct 2023 11:04:27 +02:00
> Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> CommitterDate: Thu, 19 Oct 2023 11:08:22 +02:00
> 
> Revert "x86/retpoline: Ensure default return thunk isn't used at runtime"
> 
> This reverts commit 91174087dcc7565d8bf0d576544e42d5b1de6f39.
> 
> It turns out that raising an undefined opcode exception due to unpatched
> return thunks is not visible to users in every possible scenario (not
> being able to catch dmesg, slow console, etc.).
> 
> Thus, it is not very friendly to them when the box explodes without even
> saying why.

This is what we have __bug_table for...

Turns out asm/bug.h doesn't currently have nice helpers for __ASSMEBLY__
so I botched it a bit...

---
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index d9feadffa972..003379049924 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -10,8 +10,6 @@
 #include <asm/segment.h>
 #include <asm/cache.h>
 
-#include "calling.h"
-
 .pushsection .noinstr.text, "ax"
 
 SYM_FUNC_START(entry_ibpb)
@@ -45,4 +43,3 @@ EXPORT_SYMBOL_GPL(mds_verw_sel);
 
 .popsection
 
-THUNK warn_thunk_thunk, __warn_thunk
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index ff5f1ecc7d1e..547cde3db276 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -387,8 +387,6 @@ extern void clear_bhb_loop(void);
 
 extern void (*x86_return_thunk)(void);
 
-extern void __warn_thunk(void);
-
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 extern void call_depth_return_thunk(void);
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d1915427b4ff..b86048f31a0c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -3025,8 +3025,3 @@ ssize_t cpu_show_reg_file_data_sampling(struct device *dev, struct device_attrib
 	return cpu_show_common(dev, attr, buf, X86_BUG_RFDS);
 }
 #endif
-
-void __warn_thunk(void)
-{
-	WARN_ONCE(1, "Unpatched return thunk in use. This should not happen!\n");
-}
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 391059b2c6fb..469bf27287a1 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -12,9 +12,39 @@
 #include <asm/percpu.h>
 #include <asm/frame.h>
 #include <asm/nops.h>
+#include <linux/objtool.h>
 
-	.section .text..__x86.indirect_thunk
+// this should probably go in asm/bug.h
+
+#ifdef CONFIG_X86_32
+#define __BUG_REL(val)	.long	val
+#else
+#define __BUG_REL(val)	.long	val - .
+#endif
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+#define __BUG_VERBOSE()						\
+	__BUG_REL(0) ;						\
+	.word 0 ;
+#else
+#define __BUG_VERBOSE()
+#endif
 
+#define _BUG_FLAGS(flags)					\
+	1: ;							\
+	.pushsection __bug_table, "aw" ;			\
+	2: __BUG_REL(1b) ;					\
+	__BUG_VERBOSE() ;					\
+	.word flags ;						\
+	.org 2b+(6+6*IS_ENABLED(CONFIG_DEBUG_BUGVERBOSE)) ;	\
+	.popsection
+
+#define WARN_ONCE						\
+	_BUG_FLAGS(3) ;						\
+	ALTERNATIVE "", "ud2", X86_FEATURE_ALWAYS ;		\
+	REACHABLE
+
+	.section .text..__x86.indirect_thunk
 
 .macro POLINE reg
 	ANNOTATE_INTRA_FUNCTION_CALL
@@ -37,9 +67,15 @@ SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
 	UNWIND_HINT_UNDEFINED
 	ANNOTATE_NOENDBR
 
+#ifdef CONFIG_X86_32
 	ALTERNATIVE_2 __stringify(RETPOLINE \reg), \
 		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg; int3), X86_FEATURE_RETPOLINE_LFENCE, \
 		      __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), ALT_NOT(X86_FEATURE_RETPOLINE)
+#else
+	WARN_ONCE
+	ANNOTATE_RETPOLINE_SAFE
+	jmp *%\reg
+#endif
 
 .endm
 
@@ -382,16 +418,15 @@ SYM_FUNC_END(call_depth_return_thunk)
 SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
-#if defined(CONFIG_MITIGATION_UNRET_ENTRY) || \
-    defined(CONFIG_MITIGATION_SRSO) || \
-    defined(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)
-	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE; ret), \
-		   "jmp warn_thunk_thunk", X86_FEATURE_ALWAYS
-#else
+
+#ifdef CONFIG_X86_64
+	WARN_ONCE
+#endif
+
 	ANNOTATE_UNRET_SAFE
 	ret
-#endif
 	int3
+
 SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)
 


