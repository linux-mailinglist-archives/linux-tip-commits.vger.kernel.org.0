Return-Path: <linux-tip-commits+bounces-3668-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A19BA45E45
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 499087A27A2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFA524E014;
	Wed, 26 Feb 2025 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RK4eXwr0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xBmKh/Jp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49FA235362;
	Wed, 26 Feb 2025 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571493; cv=none; b=ZEtLgDRzHp+mwvHUwcqUXLyVRRNUQQjPboMAcF229rjTE1894JOJ1+9Tjrcatqrgbdf2QsxBO8t/eVuKyfx2CLFIslGLMX3to8gqyJPbpxi9Vpydbt6gpg4UiYZTzXd7g0gEQn2n5x3pw5FS8bEGn7cp1PSH7ZxxCvZuRqOsHJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571493; c=relaxed/simple;
	bh=7u7qDL3AUV9lFZYDf96IH+Z08ePa3apNnD6Ysrdoh+s=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=DZtWUUTM3Hl0N86CRJMiWWV70R9tD8wy4Zm4Z9jmbuOfMcnU6BMJ7IMyJE5OuZT05yANtQrZ6YBiXKgjGNkPjGVV9RJOQd+INjeptaOYYaJVbGQZ4EG9eH4jJ+CK+82yVwNOYiTbegoJRzIS/6E2zqIj9FPz6ikFPYbyAlMhemA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RK4eXwr0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xBmKh/Jp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:04:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740571489;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lw3USrelmIzSzZwwAkW0i93TZR9Xx5/67/Wm2JJHPFQ=;
	b=RK4eXwr018+9efhqKe+v9PokP+wt0OMI5e6V0P9g6HnOrSE2EIiv5W0eBKzR99STMzk3ye
	wp0BBjgKw/JNaaQylwkt23zTG0hHRjvtKiuhr1t9lu0EX6Q3XuFcEGB8bMvEgsxJqsrY1Q
	VCp5cN/NMyzJqbzH4CXJfKvS6/3L4AE1e5tn4F4UAxrO/dwgAwmvVFZWpMHThp/6l5kL4u
	9BVHwt3dyijctI/c5SrjTr3IHfbvcQesEhWThQbSeNSBCwLnSwW7bEH5kVEBJ8x2gONejH
	UyICAcYxRDLA0EH26pmbpYbsXRcTgjVSOOBdqC3hXDDY1GZJfjcrDMhYJxOmdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740571489;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lw3USrelmIzSzZwwAkW0i93TZR9Xx5/67/Wm2JJHPFQ=;
	b=xBmKh/JptEbhQqERWOKtKnBJcaN8vym5Z4Sl6LIuHlJSs5nfy0Hr6azEKshtYkgg4WpfBX
	DYruy6Yb2fRA6aAQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/alternatives: Clean up preprocessor conditional
 block comments
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057148849.10177.13934770176706315375.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     5d703825fde301677e8a79b0738927490407f435
Gitweb:        https://git.kernel.org/tip/5d703825fde301677e8a79b0738927490407f435
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 26 Feb 2025 12:15:15 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 12:15:15 +01:00

x86/alternatives: Clean up preprocessor conditional block comments

When in the middle of a kernel source code file a kernel developer
sees a lone #else or #endif:

   ...

   #else

   ...

It's not obvious at a glance what those preprocessor blocks are
conditional on, if the starting #ifdef is outside visible range.

So apply the standard pattern we use in such cases elsewhere in
the kernel for large preprocessor blocks:

  #ifdef CONFIG_XXX
  ...
  ...
  ...
  #endif /* CONFIG_XXX */

  ...

  #ifdef CONFIG_XXX
  ...
  ...
  ...
  #else /* !CONFIG_XXX: */
  ...
  ...
  ...
  #endif /* !CONFIG_XXX */

( Note that in the  #else case we use the /* !CONFIG_XXX */ marker
  in the final #endif, not /* CONFIG_XXX */, which serves as an easy
  visual marker to differentiate #else or #elif related #endif closures
  from singular #ifdef/#endif blocks. )

Also clean up __CFI_DEFAULT definition with a bit more vertical alignment
applied, and a pointless tab converted to the standard space we use in
such definitions.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 83316ea..ea68f0e 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -839,16 +839,16 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
 		}
 	}
 }
-#else
+#else /* !CONFIG_MITIGATION_RETHUNK: */
 void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
-#endif /* CONFIG_MITIGATION_RETHUNK */
+#endif /* !CONFIG_MITIGATION_RETHUNK */
 
 #else /* !CONFIG_MITIGATION_RETPOLINE || !CONFIG_OBJTOOL */
 
 void __init_or_module noinline apply_retpolines(s32 *start, s32 *end) { }
 void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
 
-#endif /* CONFIG_MITIGATION_RETPOLINE && CONFIG_OBJTOOL */
+#endif /* !CONFIG_MITIGATION_RETPOLINE || !CONFIG_OBJTOOL */
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
@@ -916,18 +916,18 @@ void __init_or_module noinline apply_seal_endbr(s32 *start, s32 *end)
 	}
 }
 
-#else
+#else /* !CONFIG_X86_KERNEL_IBT: */
 
 void __init_or_module apply_seal_endbr(s32 *start, s32 *end) { }
 
-#endif /* CONFIG_X86_KERNEL_IBT */
+#endif /* !CONFIG_X86_KERNEL_IBT */
 
 #ifdef CONFIG_CFI_AUTO_DEFAULT
-#define __CFI_DEFAULT	CFI_AUTO
+# define __CFI_DEFAULT CFI_AUTO
 #elif defined(CONFIG_CFI_CLANG)
-#define __CFI_DEFAULT	CFI_KCFI
+# define __CFI_DEFAULT CFI_KCFI
 #else
-#define __CFI_DEFAULT	CFI_OFF
+# define __CFI_DEFAULT CFI_OFF
 #endif
 
 enum cfi_mode cfi_mode __ro_after_init = __CFI_DEFAULT;
@@ -1457,7 +1457,7 @@ Efault:
 	return false;
 }
 
-#else
+#else /* !CONFIG_FINEIBT: */
 
 static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 			    s32 *start_cfi, s32 *end_cfi, bool builtin)
@@ -1468,7 +1468,7 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 static void poison_cfi(void *addr) { }
 #endif
 
-#endif
+#endif /* !CONFIG_FINEIBT */
 
 void apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 		   s32 *start_cfi, s32 *end_cfi)

