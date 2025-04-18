Return-Path: <linux-tip-commits+bounces-5063-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C65FA93483
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 10:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B98188F384
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 08:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983FB253955;
	Fri, 18 Apr 2025 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3RAbjq6b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v+zoPpOq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B551D5ACE;
	Fri, 18 Apr 2025 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744964194; cv=none; b=bN0Vx/eIDmyS6jZw1k+vfpjgjBEScWmz2vtmd2VR7LLvw0uwYuG2msnX7F/RmT3B831BY9Wro2V1q+cg+d61l2G3zmuYFvLaOqwR3qjqg1WLxsVtqe6pZtBpxqzJq/itD+2kL67/c/ND+bRdW04iFwiM6geq/ktIaSI9JnsT1yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744964194; c=relaxed/simple;
	bh=A/cIS9O9ihetzF82juTc/GeppFS9eo1M3cHFEV89k2o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wq8D7Cvp350VwAYVGBf8w4fFh+JmtKv2ZwdyV2V5piJrR5/CvGx925ShCsDx4OURp9nqDaBJRFkQ43DlMmajJjVfSTOFVPhtrIo5GVVoGO0qmXKcfHUji5obSlG6yL+k8/ptnszI53pctLSL19sLxZFCyh95SbuRI8dF9h/m/tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3RAbjq6b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v+zoPpOq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Apr 2025 08:16:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744964190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JGS99lfdrgA1Vl2luL9p0HsgAfvhOWL6PlH9I7e+0iA=;
	b=3RAbjq6bjy2BISZjtbSBOPvCfEvYqggoxouchu2OenEX02o9KGH4J4TC4je8efxvNarFHa
	I/lKFEqGrsl3U+hkaYTJ0CF//qiQlN4+uLSBatPrXeFa8t5TrKMqPyMff1ZMbUUpHpooML
	r2Ib+5GBrXrEH6FkoKDn4wk6LKRhxx4hAiE+ioBCoP4j6ka5f56IedlZnUMKSJ0B5XePs1
	zd6RQPlO/Edrn9rW6qzImQJgbib/0WLLDti7bxjFdbHT9odxyE+NDSXNvX2ESnlwywy/8M
	rG6wWrXXq0TJifQbI5SgO4ySDHIh/15lht1HXWdeIogZ4QT2do3IwvW0Pzq0jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744964190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JGS99lfdrgA1Vl2luL9p0HsgAfvhOWL6PlH9I7e+0iA=;
	b=v+zoPpOqWgQxzcR/tnjC+5BO1cfKbZ6alctLwx97h3F0GiTgdzoC01sQYop7Ap9VkST11E
	THGRiAgBSC6UxxBw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Remove semicolon from "rep" prefixes
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Martin Mares <mj@ucw.cz>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250418071437.4144391-1-ubizjak@gmail.com>
References: <20250418071437.4144391-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174496418962.31282.13369844056848991237.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     0dcc51477b94d87f23aeb400b78fbdfb09363000
Gitweb:        https://git.kernel.org/tip/0dcc51477b94d87f23aeb400b78fbdfb09363000
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 18 Apr 2025 09:13:50 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 18 Apr 2025 09:32:57 +02:00

x86/boot: Remove semicolon from "rep" prefixes

Minimum version of binutils required to compile the kernel is 2.25.
This version correctly handles the "rep" prefixes, so it is possible
to remove the semicolon, which was used to support ancient versions
of GNU as.

Due to the semicolon, the compiler considers "rep; insn" (or its
alternate "rep\n\tinsn" form) as two separate instructions. Removing
the semicolon makes asm length calculations more accurate, consequently
making scheduling and inlining decisions of the compiler more accurate.

Removing the semicolon also enables assembler checks involving "rep"
prefixes. Trying to assemble e.g. "rep addl %eax, %ebx" results in:

  Error: invalid instruction `add' after `rep'

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Mares <mj@ucw.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250418071437.4144391-1-ubizjak@gmail.com
---
 arch/x86/boot/bioscall.S          | 4 ++--
 arch/x86/boot/boot.h              | 4 ++--
 arch/x86/boot/compressed/string.c | 8 ++++----
 arch/x86/boot/copy.S              | 8 ++++----
 arch/x86/boot/header.S            | 2 +-
 arch/x86/boot/string.c            | 2 +-
 arch/x86/boot/video.c             | 2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/boot/bioscall.S b/arch/x86/boot/bioscall.S
index aa9b964..cf4a615 100644
--- a/arch/x86/boot/bioscall.S
+++ b/arch/x86/boot/bioscall.S
@@ -32,7 +32,7 @@ intcall:
 	movw	%dx, %si
 	movw	%sp, %di
 	movw	$11, %cx
-	rep; movsl
+	rep movsl
 
 	/* Pop full state from the stack */
 	popal
@@ -67,7 +67,7 @@ intcall:
 	jz	4f
 	movw	%sp, %si
 	movw	$11, %cx
-	rep; movsl
+	rep movsl
 4:	addw	$44, %sp
 
 	/* Restore state and return */
diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 38f17a1..f3771a6 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -155,14 +155,14 @@ static inline void wrgs32(u32 v, addr_t addr)
 static inline bool memcmp_fs(const void *s1, addr_t s2, size_t len)
 {
 	bool diff;
-	asm volatile("fs; repe; cmpsb" CC_SET(nz)
+	asm volatile("fs repe cmpsb" CC_SET(nz)
 		     : CC_OUT(nz) (diff), "+D" (s1), "+S" (s2), "+c" (len));
 	return diff;
 }
 static inline bool memcmp_gs(const void *s1, addr_t s2, size_t len)
 {
 	bool diff;
-	asm volatile("gs; repe; cmpsb" CC_SET(nz)
+	asm volatile("gs repe cmpsb" CC_SET(nz)
 		     : CC_OUT(nz) (diff), "+D" (s1), "+S" (s2), "+c" (len));
 	return diff;
 }
diff --git a/arch/x86/boot/compressed/string.c b/arch/x86/boot/compressed/string.c
index 81fc1ea..9af19d9 100644
--- a/arch/x86/boot/compressed/string.c
+++ b/arch/x86/boot/compressed/string.c
@@ -15,9 +15,9 @@ static void *____memcpy(void *dest, const void *src, size_t n)
 {
 	int d0, d1, d2;
 	asm volatile(
-		"rep ; movsl\n\t"
+		"rep movsl\n\t"
 		"movl %4,%%ecx\n\t"
-		"rep ; movsb\n\t"
+		"rep movsb"
 		: "=&c" (d0), "=&D" (d1), "=&S" (d2)
 		: "0" (n >> 2), "g" (n & 3), "1" (dest), "2" (src)
 		: "memory");
@@ -29,9 +29,9 @@ static void *____memcpy(void *dest, const void *src, size_t n)
 {
 	long d0, d1, d2;
 	asm volatile(
-		"rep ; movsq\n\t"
+		"rep movsq\n\t"
 		"movq %4,%%rcx\n\t"
-		"rep ; movsb\n\t"
+		"rep movsb"
 		: "=&c" (d0), "=&D" (d1), "=&S" (d2)
 		: "0" (n >> 3), "g" (n & 7), "1" (dest), "2" (src)
 		: "memory");
diff --git a/arch/x86/boot/copy.S b/arch/x86/boot/copy.S
index 6afd05e..3973a67 100644
--- a/arch/x86/boot/copy.S
+++ b/arch/x86/boot/copy.S
@@ -22,10 +22,10 @@ SYM_FUNC_START_NOALIGN(memcpy)
 	movw	%dx, %si
 	pushw	%cx
 	shrw	$2, %cx
-	rep; movsl
+	rep movsl
 	popw	%cx
 	andw	$3, %cx
-	rep; movsb
+	rep movsb
 	popw	%di
 	popw	%si
 	retl
@@ -38,10 +38,10 @@ SYM_FUNC_START_NOALIGN(memset)
 	imull	$0x01010101,%eax
 	pushw	%cx
 	shrw	$2, %cx
-	rep; stosl
+	rep stosl
 	popw	%cx
 	andw	$3, %cx
-	rep; stosb
+	rep stosb
 	popw	%di
 	retl
 SYM_FUNC_END(memset)
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b5c79f4..9cb9142 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -585,7 +585,7 @@ start_of_setup:
 	xorl	%eax, %eax
 	subw	%di, %cx
 	shrw	$2, %cx
-	rep; stosl
+	rep stosl
 
 # Jump to C code (should not return)
 	calll	main
diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index 84f7a88..f35369b 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -32,7 +32,7 @@
 int memcmp(const void *s1, const void *s2, size_t len)
 {
 	bool diff;
-	asm("repe; cmpsb" CC_SET(nz)
+	asm("repe cmpsb" CC_SET(nz)
 	    : CC_OUT(nz) (diff), "+D" (s1), "+S" (s2), "+c" (len));
 	return diff;
 }
diff --git a/arch/x86/boot/video.c b/arch/x86/boot/video.c
index f2e9690..0641c8c 100644
--- a/arch/x86/boot/video.c
+++ b/arch/x86/boot/video.c
@@ -292,7 +292,7 @@ static void restore_screen(void)
 			     "shrw %%cx ; "
 			     "jnc 1f ; "
 			     "stosw \n\t"
-			     "1: rep;stosl ; "
+			     "1: rep stosl ; "
 			     "popw %%es"
 			     : "+D" (dst), "+c" (npad)
 			     : "bdS" (video_segment),

