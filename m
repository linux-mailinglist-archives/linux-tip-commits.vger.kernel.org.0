Return-Path: <linux-tip-commits+bounces-5062-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4472AA93482
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 10:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599B217ACF5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 08:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB32207A03;
	Fri, 18 Apr 2025 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="niOkBkw8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hRQCddYD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1778462;
	Fri, 18 Apr 2025 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744964194; cv=none; b=hsQjON5B76mHTUkuPCKHJe6aCSgY2jUDR+NICamZYsXpzlTQ13c4s1jLICCN7l0OFNljQ6d942q00QGgMoGGiSQymkHRdii+BHhlhe2BsDBK6xbu95OcIiyPzEd+PQ8f8ULUrvlPLdiDMM7N60WAlYi5KmKri4dAJ/Hk8nKix78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744964194; c=relaxed/simple;
	bh=b1v7wArF1lvwHihNwU9yynU4fzYs9Nr3nh3dv8jMQ6k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r53baBmZzlLvwUzVSXOOBiAm22MckfBLynhtbsEwNeHHC45NNGuLJfva+5O0qwSg1H3iW9g7Ly9bcRYT8P4gVyPwyOIcGja9j7Ij5BwZ/MyRZvfn7YLZtVKEZtndSxoHxMBQFcrFMwKSlGM4ROWWDPpCFUrEiR1ChNNFHzHAdg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=niOkBkw8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hRQCddYD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Apr 2025 08:16:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744964189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dasFm6/U/2X9gs/f3MsAA+0XOFG6E/Yq5yaqy7xH6Ec=;
	b=niOkBkw84XLh8p/d0B4XWrsPGRlUGD1KtXKXqI+3SF3JRR5nrkQtoYTUTFhvqSenX+jqyW
	uTCo1S1Dgeo3sRAf/IDH6A5XDRcUeJlQ5mSV58uWP8Q1luNi9TqMFn1ZxUZD+Bh+5AqXsF
	EkUayr+NfzT0yV7QuBymfT6AWjbLXPKsM1GiOYB2ZU/fvgi0vyw6R50IgPv2DGFSeRVd4w
	npzQN3wwLqrpCnnq6aweg0bwKF/attgG59v21dFTmiZt7y2RQXXXtcOODzFyJ3HnaGI/AJ
	KUUNY8eFihpp+xKSXpDd6o2Nb1+/PHbGA6zSsJQixdnuw8I/trFYS0thGRYteA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744964189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dasFm6/U/2X9gs/f3MsAA+0XOFG6E/Yq5yaqy7xH6Ec=;
	b=hRQCddYDQtrum7gPtzW97/nfer1mmejotrBOYByVUskrMyW4gMLd20R0SXu2E45UHKJ920
	rsVZd7XKIWtHzcAg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Remove semicolon from "rep" prefixes
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Pavel Machek <pavel@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250418071437.4144391-2-ubizjak@gmail.com>
References: <20250418071437.4144391-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174496418809.31282.5072163940722114745.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     42c782fae38f0559e6355707ee0afde9ac16dcc3
Gitweb:        https://git.kernel.org/tip/42c782fae38f0559e6355707ee0afde9ac16dcc3
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 18 Apr 2025 09:13:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 18 Apr 2025 09:33:33 +02:00

x86/asm: Remove semicolon from "rep" prefixes

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
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@kernel.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/r/20250418071437.4144391-2-ubizjak@gmail.com
---
 arch/x86/include/asm/io.h            |  6 +++---
 arch/x86/include/asm/string_32.h     | 15 ++++++---------
 arch/x86/kernel/head_32.S            |  8 +++-----
 arch/x86/kernel/relocate_kernel_32.S |  6 +++---
 arch/x86/kernel/relocate_kernel_64.S |  6 +++---
 arch/x86/lib/iomem.c                 |  2 +-
 arch/x86/lib/string_32.c             | 17 ++++++-----------
 arch/x86/lib/strstr_32.c             |  6 ++----
 arch/x86/lib/usercopy_32.c           | 18 +++++++++---------
 arch/x86/platform/pvh/head.S         |  3 +--
 arch/x86/power/hibernate_asm_32.S    |  3 +--
 arch/x86/power/hibernate_asm_64.S    |  3 +--
 12 files changed, 39 insertions(+), 54 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index e889c3b..ca309a3 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -217,7 +217,7 @@ void memset_io(volatile void __iomem *, int, size_t);
 static inline void __iowrite32_copy(void __iomem *to, const void *from,
 				    size_t count)
 {
-	asm volatile("rep ; movsl"
+	asm volatile("rep movsl"
 		     : "=&c"(count), "=&D"(to), "=&S"(from)
 		     : "0"(count), "1"(to), "2"(from)
 		     : "memory");
@@ -282,7 +282,7 @@ static inline void outs##bwl(u16 port, const void *addr, unsigned long count) \
 			count--;					\
 		}							\
 	} else {							\
-		asm volatile("rep; outs" #bwl				\
+		asm volatile("rep outs" #bwl				\
 			     : "+S"(addr), "+c"(count)			\
 			     : "d"(port) : "memory");			\
 	}								\
@@ -298,7 +298,7 @@ static inline void ins##bwl(u16 port, void *addr, unsigned long count)	\
 			count--;					\
 		}							\
 	} else {							\
-		asm volatile("rep; ins" #bwl				\
+		asm volatile("rep ins" #bwl				\
 			     : "+D"(addr), "+c"(count)			\
 			     : "d"(port) : "memory");			\
 	}								\
diff --git a/arch/x86/include/asm/string_32.h b/arch/x86/include/asm/string_32.h
index 32c0d98..e9cce16 100644
--- a/arch/x86/include/asm/string_32.h
+++ b/arch/x86/include/asm/string_32.h
@@ -33,11 +33,11 @@ extern size_t strlen(const char *s);
 static __always_inline void *__memcpy(void *to, const void *from, size_t n)
 {
 	int d0, d1, d2;
-	asm volatile("rep ; movsl\n\t"
+	asm volatile("rep movsl\n\t"
 		     "movl %4,%%ecx\n\t"
 		     "andl $3,%%ecx\n\t"
 		     "jz 1f\n\t"
-		     "rep ; movsb\n\t"
+		     "rep movsb\n\t"
 		     "1:"
 		     : "=&c" (d0), "=&D" (d1), "=&S" (d2)
 		     : "0" (n / 4), "g" (n), "1" ((long)to), "2" ((long)from)
@@ -89,7 +89,7 @@ static __always_inline void *__constant_memcpy(void *to, const void *from,
 	if (n >= 5 * 4) {
 		/* large block: use rep prefix */
 		int ecx;
-		asm volatile("rep ; movsl"
+		asm volatile("rep movsl"
 			     : "=&c" (ecx), "=&D" (edi), "=&S" (esi)
 			     : "0" (n / 4), "1" (edi), "2" (esi)
 			     : "memory"
@@ -165,8 +165,7 @@ extern void *memchr(const void *cs, int c, size_t count);
 static inline void *__memset_generic(void *s, char c, size_t count)
 {
 	int d0, d1;
-	asm volatile("rep\n\t"
-		     "stosb"
+	asm volatile("rep stosb"
 		     : "=&c" (d0), "=&D" (d1)
 		     : "a" (c), "1" (s), "0" (count)
 		     : "memory");
@@ -199,8 +198,7 @@ extern void *memset(void *, int, size_t);
 static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
 {
 	int d0, d1;
-	asm volatile("rep\n\t"
-		     "stosw"
+	asm volatile("rep stosw"
 		     : "=&c" (d0), "=&D" (d1)
 		     : "a" (v), "1" (s), "0" (n)
 		     : "memory");
@@ -211,8 +209,7 @@ static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
 static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
 {
 	int d0, d1;
-	asm volatile("rep\n\t"
-		     "stosl"
+	asm volatile("rep stosl"
 		     : "=&c" (d0), "=&D" (d1)
 		     : "a" (v), "1" (s), "0" (n)
 		     : "memory");
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 2e42056..76743df 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -86,7 +86,7 @@ SYM_CODE_START(startup_32)
 	movl $pa(__bss_stop),%ecx
 	subl %edi,%ecx
 	shrl $2,%ecx
-	rep ; stosl
+	rep stosl
 /*
  * Copy bootup parameters out of the way.
  * Note: %esi still has the pointer to the real-mode data.
@@ -98,15 +98,13 @@ SYM_CODE_START(startup_32)
 	movl $pa(boot_params),%edi
 	movl $(PARAM_SIZE/4),%ecx
 	cld
-	rep
-	movsl
+	rep movsl
 	movl pa(boot_params) + NEW_CL_POINTER,%esi
 	andl %esi,%esi
 	jz 1f			# No command line
 	movl $pa(boot_command_line),%edi
 	movl $(COMMAND_LINE_SIZE/4),%ecx
-	rep
-	movsl
+	rep movsl
 1:
 
 #ifdef CONFIG_OLPC
diff --git a/arch/x86/kernel/relocate_kernel_32.S b/arch/x86/kernel/relocate_kernel_32.S
index c7c4b19..57276f1 100644
--- a/arch/x86/kernel/relocate_kernel_32.S
+++ b/arch/x86/kernel/relocate_kernel_32.S
@@ -263,17 +263,17 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 
 	movl	%edx, %edi
 	movl    $1024, %ecx
-	rep ; movsl
+	rep movsl
 
 	movl	%ebp, %edi
 	movl	%eax, %esi
 	movl	$1024, %ecx
-	rep ; movsl
+	rep movsl
 
 	movl	%eax, %edi
 	movl	%edx, %esi
 	movl	$1024, %ecx
-	rep ; movsl
+	rep movsl
 
 	lea	PAGE_SIZE(%ebp), %esi
 	jmp     0b
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 3062cb3..1d63552 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -363,20 +363,20 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	/* copy source page to swap page */
 	movq	kexec_pa_swap_page(%rip), %rdi
 	movl	$512, %ecx
-	rep ; movsq
+	rep movsq
 
 	/* copy destination page to source page */
 	movq	%rax, %rdi
 	movq	%rdx, %rsi
 	movl	$512, %ecx
-	rep ; movsq
+	rep movsq
 
 	/* copy swap page to destination page */
 	movq	%rdx, %rdi
 	movq	kexec_pa_swap_page(%rip), %rsi
 .Lnoswap:
 	movl	$512, %ecx
-	rep ; movsq
+	rep movsq
 
 	lea	PAGE_SIZE(%rax), %rsi
 	jmp	.Lloop
diff --git a/arch/x86/lib/iomem.c b/arch/x86/lib/iomem.c
index 5eecb45..c20e047 100644
--- a/arch/x86/lib/iomem.c
+++ b/arch/x86/lib/iomem.c
@@ -10,7 +10,7 @@
 static __always_inline void rep_movs(void *to, const void *from, size_t n)
 {
 	unsigned long d0, d1, d2;
-	asm volatile("rep ; movsl\n\t"
+	asm volatile("rep movsl\n\t"
 		     "testb $2,%b4\n\t"
 		     "je 1f\n\t"
 		     "movsw\n"
diff --git a/arch/x86/lib/string_32.c b/arch/x86/lib/string_32.c
index 53b3f20..f87ec24 100644
--- a/arch/x86/lib/string_32.c
+++ b/arch/x86/lib/string_32.c
@@ -40,8 +40,7 @@ char *strncpy(char *dest, const char *src, size_t count)
 		"stosb\n\t"
 		"testb %%al,%%al\n\t"
 		"jne 1b\n\t"
-		"rep\n\t"
-		"stosb\n"
+		"rep stosb\n"
 		"2:"
 		: "=&S" (d0), "=&D" (d1), "=&c" (d2), "=&a" (d3)
 		: "0" (src), "1" (dest), "2" (count) : "memory");
@@ -54,8 +53,7 @@ EXPORT_SYMBOL(strncpy);
 char *strcat(char *dest, const char *src)
 {
 	int d0, d1, d2, d3;
-	asm volatile("repne\n\t"
-		"scasb\n\t"
+	asm volatile("repne scasb\n\t"
 		"decl %1\n"
 		"1:\tlodsb\n\t"
 		"stosb\n\t"
@@ -72,8 +70,7 @@ EXPORT_SYMBOL(strcat);
 char *strncat(char *dest, const char *src, size_t count)
 {
 	int d0, d1, d2, d3;
-	asm volatile("repne\n\t"
-		"scasb\n\t"
+	asm volatile("repne scasb\n\t"
 		"decl %1\n\t"
 		"movl %8,%3\n"
 		"1:\tdecl %3\n\t"
@@ -167,8 +164,7 @@ size_t strlen(const char *s)
 {
 	int d0;
 	size_t res;
-	asm volatile("repne\n\t"
-		"scasb"
+	asm volatile("repne scasb"
 		: "=c" (res), "=&D" (d0)
 		: "1" (s), "a" (0), "0" (0xffffffffu)
 		: "memory");
@@ -184,8 +180,7 @@ void *memchr(const void *cs, int c, size_t count)
 	void *res;
 	if (!count)
 		return NULL;
-	asm volatile("repne\n\t"
-		"scasb\n\t"
+	asm volatile("repne scasb\n\t"
 		"je 1f\n\t"
 		"movl $1,%0\n"
 		"1:\tdecl %0"
@@ -202,7 +197,7 @@ void *memscan(void *addr, int c, size_t size)
 {
 	if (!size)
 		return addr;
-	asm volatile("repnz; scasb\n\t"
+	asm volatile("repnz scasb\n\t"
 	    "jnz 1f\n\t"
 	    "dec %%edi\n"
 	    "1:"
diff --git a/arch/x86/lib/strstr_32.c b/arch/x86/lib/strstr_32.c
index 38f37df..2826798 100644
--- a/arch/x86/lib/strstr_32.c
+++ b/arch/x86/lib/strstr_32.c
@@ -8,16 +8,14 @@ int	d0, d1;
 register char *__res;
 __asm__ __volatile__(
 	"movl %6,%%edi\n\t"
-	"repne\n\t"
-	"scasb\n\t"
+	"repne scasb\n\t"
 	"notl %%ecx\n\t"
 	"decl %%ecx\n\t"	/* NOTE! This also sets Z if searchstring='' */
 	"movl %%ecx,%%edx\n"
 	"1:\tmovl %6,%%edi\n\t"
 	"movl %%esi,%%eax\n\t"
 	"movl %%edx,%%ecx\n\t"
-	"repe\n\t"
-	"cmpsb\n\t"
+	"repe cmpsb\n\t"
 	"je 2f\n\t"		/* also works for empty string, see above */
 	"xchgl %%eax,%%esi\n\t"
 	"incl %%esi\n\t"
diff --git a/arch/x86/lib/usercopy_32.c b/arch/x86/lib/usercopy_32.c
index 422257c..f6f436f 100644
--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -38,9 +38,9 @@ do {									\
 	might_fault();							\
 	__asm__ __volatile__(						\
 		ASM_STAC "\n"						\
-		"0:	rep; stosl\n"					\
+		"0:	rep stosl\n"					\
 		"	movl %2,%0\n"					\
-		"1:	rep; stosb\n"					\
+		"1:	rep stosb\n"					\
 		"2: " ASM_CLAC "\n"					\
 		_ASM_EXTABLE_TYPE_REG(0b, 2b, EX_TYPE_UCOPY_LEN4, %2)	\
 		_ASM_EXTABLE_UA(1b, 2b)					\
@@ -140,9 +140,9 @@ __copy_user_intel(void __user *to, const void *from, unsigned long size)
 		       "       shrl  $2, %0\n"
 		       "       andl  $3, %%eax\n"
 		       "       cld\n"
-		       "99:    rep; movsl\n"
+		       "99:    rep movsl\n"
 		       "36:    movl %%eax, %0\n"
-		       "37:    rep; movsb\n"
+		       "37:    rep movsb\n"
 		       "100:\n"
 		       _ASM_EXTABLE_UA(1b, 100b)
 		       _ASM_EXTABLE_UA(2b, 100b)
@@ -242,9 +242,9 @@ static unsigned long __copy_user_intel_nocache(void *to,
 	       "        shrl  $2, %0\n"
 	       "        andl $3, %%eax\n"
 	       "        cld\n"
-	       "6:      rep; movsl\n"
+	       "6:      rep movsl\n"
 	       "        movl %%eax,%0\n"
-	       "7:      rep; movsb\n"
+	       "7:      rep movsb\n"
 	       "8:\n"
 	       _ASM_EXTABLE_UA(0b, 8b)
 	       _ASM_EXTABLE_UA(1b, 8b)
@@ -293,14 +293,14 @@ do {									\
 		"	negl %0\n"					\
 		"	andl $7,%0\n"					\
 		"	subl %0,%3\n"					\
-		"4:	rep; movsb\n"					\
+		"4:	rep movsb\n"					\
 		"	movl %3,%0\n"					\
 		"	shrl $2,%0\n"					\
 		"	andl $3,%3\n"					\
 		"	.align 2,0x90\n"				\
-		"0:	rep; movsl\n"					\
+		"0:	rep movsl\n"					\
 		"	movl %3,%0\n"					\
-		"1:	rep; movsb\n"					\
+		"1:	rep movsb\n"					\
 		"2:\n"							\
 		_ASM_EXTABLE_TYPE_REG(4b, 2b, EX_TYPE_UCOPY_LEN1, %3)	\
 		_ASM_EXTABLE_TYPE_REG(0b, 2b, EX_TYPE_UCOPY_LEN4, %3)	\
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index cfa18ec..1d78e56 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -87,8 +87,7 @@ SYM_CODE_START(pvh_start_xen)
 	mov %ebx, %esi
 	movl rva(pvh_start_info_sz)(%ebp), %ecx
 	shr $2,%ecx
-	rep
-	movsl
+	rep movsl
 
 	leal rva(early_stack_end)(%ebp), %esp
 
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index 5606a15..fb910d9 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -69,8 +69,7 @@ copy_loop:
 	movl	pbe_orig_address(%edx), %edi
 
 	movl	$(PAGE_SIZE >> 2), %ecx
-	rep
-	movsl
+	rep movsl
 
 	movl	pbe_next(%edx), %edx
 	jmp	copy_loop
diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index 8c534c3..f5bda01 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -138,8 +138,7 @@ SYM_FUNC_START(core_restore_code)
 	movq	pbe_address(%rdx), %rsi
 	movq	pbe_orig_address(%rdx), %rdi
 	movq	$(PAGE_SIZE >> 3), %rcx
-	rep
-	movsq
+	rep movsq
 
 	/* progress to the next pbe */
 	movq	pbe_next(%rdx), %rdx

