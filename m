Return-Path: <linux-tip-commits+bounces-6549-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFCCB52A24
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 09:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192C63B90A8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 07:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1B2274B5A;
	Thu, 11 Sep 2025 07:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HFHhcRmt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ex7Ewt0+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2C927281C;
	Thu, 11 Sep 2025 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576100; cv=none; b=F/Lfmc3ZFgibRUMjSplkWGVEW6Nf+HUpKxOkKQRass1ou+qYE+SeH6UY1diVp5UfOxChd/TLM3JSYp8xdHvRsJnM2/gz5nodF8mxziQzsmmWptui2m3oaopncqU5unH2X0yQsKnGbNgGxPuzpIuwHTDt75C0HcjH3AP2DP6AV14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576100; c=relaxed/simple;
	bh=gEQyQjHieNiAMFUyzM2PRIMx4YHVv9oVXK8jQfZR2os=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=SmQ/Fbjr1T9rYwajBpXP3ba7xO8NsNbsvTgJt4P+wn8Rg+T2xl0HQuIRrhiXC3CClWzxMXN7CiIG15dRRikEiOnl/28dgllg4QJciJZ7bxgwIr/eH0diXs7vTn1rzlFOJ7l967GZZCSLv1t1UnUb6nkwJdyuXuTKtdtfKTZevLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HFHhcRmt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ex7Ewt0+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 07:34:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757576094;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7NJMDA5pABB5Sb3ClKBreqstS+zBUal+/TE5Hp530Rc=;
	b=HFHhcRmtQdfGCHk66lNW75/mjJdHv3IqYFaz8D98hOsYSvL6BY9MzqMeaKNEp6EwYjaVL8
	3sYQDStcfR4O80U4j4cZxIO6//Dgw+8Q2dHSaqUjqVE8TY6/eUzM44S019niR6R0L0EVXV
	0aH5Ppq0slshlZ74htjrgIOwohlBNVNtDTD+rjrnTIjeUQi5/TlsetRDB4JkFb6RHZt8EZ
	JbeMXp4R0T9aDrrPdKEaWhJgYKL4+1drZC3xNtRa+u8VulF4FLgwGiKT9jRVbTQgOgefjQ
	l1a8kEQWp6+CXklybTFGZrJrJx+gxRS2+KN+kLo3+uyzAW/KDJPfY+Bo8KrwHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757576094;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7NJMDA5pABB5Sb3ClKBreqstS+zBUal+/TE5Hp530Rc=;
	b=ex7Ewt0+Kxs3r1dAnmMoH+Sk83I0BzBneTV414CynzmKXzFqlDrjZIOuVHdNiqUs0XccpV
	uRPnmnZPm+bDMbAg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86,ibt: Use UDB instead of 0xEA
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175757609319.709179.3361221692582333399.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     85a2d4a890dce3cfc9c14aa91afc3dd7af8e3bf5
Gitweb:        https://git.kernel.org/tip/85a2d4a890dce3cfc9c14aa91afc3dd7af8=
e3bf5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 01 Sep 2025 12:49:58 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Sep 2025 21:59:09 +02:00

x86,ibt: Use UDB instead of 0xEA

A while ago [0] FineIBT started using the 0xEA instruction to raise #UD.
All existing parts will generate #UD in 64bit mode on that instruction.

However; Intel/AMD have not blessed using this instruction, it is on
their 'reserved' opcode list for future use.

Peter Anvin worked the committees and got use of 0xD6 blessed, it
shall be called UDB (per the next SDM or so), and it being a single
byte instruction is easy to slip into a single byte immediate -- as
is done by this very patch.

Reworking the FineIBT code to use UDB wasn't entirely trivial. Notably
the FineIBT-BHI1 case ran out of bytes. In order to condense the
encoding some it was required to move the hash register from R10D to
EAX (thanks hpa!).

Per the x86_64 ABI, RAX is used to pass the number of vector registers
for vararg function calls -- something that should not happen in the
kernel. More so, the kernel is built with -mskip-rax-setup, which
should leave RAX completely unused, allowing its re-use.

 [ For BPF; while the bpf2bpf tail-call uses RAX in its calling
   convention, that does not use CFI and is unaffected. Only the
   'regular' C->BPF transition is covered by CFI. ]

The ENDBR poison value is changed from 'OSP NOP3' to 'NOPL -42(%RAX)',
this is basically NOP4 but with UDB as its immediate. As such it is
still a non-standard NOP value unique to prior ENDBR sites, but now
also provides UDB.

Per Agner Fog's optimization guide, Jcc is assumed not-taken. That is,
the expected path should be the fallthrough case for improved
throughput.

Since the preamble now relies on the ENDBR poison to provide UDB, the
code is changed to write the poison right along with the initial
preamble -- this is possible because the ITS mitigation already
disabled IBT over rewriting the CFI scheme.

The scheme in detail:

Preamble:

  FineIBT			FineIBT-BHI1			FineIBT-BHI

  __cfi_\func:			__cfi_\func:			__cfi_\func:
    endbr			  endbr				  endbr
    subl       $0x12345678, %eax  subl      $0x12345678, %eax	  subl       $0=
x12345678, %eax
    jne.d32,np \func+3		  cmovne    %rax, %rdi		  cs cs call __bhi_args_N
                                  jne.d8,np \func+3
  \func:			\func:				\func:
    nopl       -42(%rax)	  nopl      -42(%rax)		  nopl       -42(%rax)

Notably there are 7 bytes available after the SUBL; this enables the
BHI1 case to fit without the nasty overlapping case it had previously.
The !BHI case uses Jcc.d32,np to consume all 7 bytes without the need
for an additional NOP, while the BHI case uses CS padding to align the
CALL with the end of the preamble such that it returns to \func+0.

Caller:

  FineIBT				Paranoid-FineIBT

  fineibt_caller:			fineibt_caller:
    mov     $0x12345678, %eax		  mov    $0x12345678, %eax
    lea     -10(%r11), %r11		  cmp    -0x11(%r11), %eax
    nop5				  cs lea -0x10(%r11), %r11
  retpoline:				retpoline:
    cs call __x86_indirect_thunk_r11	  jne    fineibt_caller+0xd
					  call   *%r11
					  nop

Notably this is before apply_retpolines() which will fix up the
retpoline call -- since all parts with IBT also have eIBRS (lets
ignore ITS). Typically the retpoline site is rewritten (when still
intact) into:

    call *%r11
    nop3

[0] 06926c6cdb95 ("x86/ibt: Optimize the FineIBT instruction sequence")

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250901191307.GI4067720@noisy.programming.ki=
cks-ass.net
---
 arch/x86/include/asm/bug.h    |   9 +-
 arch/x86/include/asm/cfi.h    |  14 +--
 arch/x86/include/asm/ibt.h    |  10 +--
 arch/x86/kernel/alternative.c | 217 ++++++++++++++++++---------------
 arch/x86/kernel/traps.c       |   8 +-
 arch/x86/lib/bhi.S            |  58 ++++-----
 arch/x86/lib/retpoline.S      |   4 +-
 arch/x86/net/bpf_jit_comp.c   |   6 +-
 8 files changed, 178 insertions(+), 148 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 20fcb85..880ca15 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -5,14 +5,19 @@
 #include <linux/stringify.h>
 #include <linux/instrumentation.h>
 #include <linux/objtool.h>
+#include <asm/asm.h>
=20
 /*
  * Despite that some emulators terminate on UD2, we use it for WARN().
  */
-#define ASM_UD2		".byte 0x0f, 0x0b"
+#define ASM_UD2		_ASM_BYTES(0x0f, 0x0b)
 #define INSN_UD2	0x0b0f
 #define LEN_UD2		2
=20
+#define ASM_UDB		_ASM_BYTES(0xd6)
+#define INSN_UDB	0xd6
+#define LEN_UDB		1
+
 /*
  * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
  */
@@ -26,7 +31,7 @@
 #define BUG_UD2			0xfffe
 #define BUG_UD1			0xfffd
 #define BUG_UD1_UBSAN		0xfffc
-#define BUG_EA			0xffea
+#define BUG_UDB			0xffd6
 #define BUG_LOCK		0xfff0
=20
 #ifdef CONFIG_GENERIC_BUG
diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 1751f1e..3fcfdd9 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -71,12 +71,10 @@
  *
  * __cfi_foo:
  *   endbr64
- *   subl 0x12345678, %r10d
- *   jz   foo
- *   ud2
- *   nop
+ *   subl 0x12345678, %eax
+ *   jne.32,pn foo+3
  * foo:
- *   osp nop3			# was endbr64
+ *   nopl -42(%rax)		# was endbr64
  *   ... code here ...
  *   ret
  *
@@ -86,9 +84,9 @@
  * indirect caller:
  *   lea foo(%rip), %r11
  *   ...
- *   movl $0x12345678, %r10d
- *   subl $16, %r11
- *   nop4
+ *   movl $0x12345678, %eax
+ *   lea  -0x10(%r11), %r11
+ *   nop5
  *   call *%r11
  *
  */
diff --git a/arch/x86/include/asm/ibt.h b/arch/x86/include/asm/ibt.h
index 28d8452..5e45d64 100644
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -59,10 +59,10 @@ static __always_inline __attribute_const__ u32 gen_endbr(=
void)
 static __always_inline __attribute_const__ u32 gen_endbr_poison(void)
 {
 	/*
-	 * 4 byte NOP that isn't NOP4 (in fact it is OSP NOP3), such that it
-	 * will be unique to (former) ENDBR sites.
+	 * 4 byte NOP that isn't NOP4, such that it will be unique to (former)
+	 * ENDBR sites. Additionally it carries UDB as immediate.
 	 */
-	return 0x001f0f66; /* osp nopl (%rax) */
+	return 0xd6401f0f; /* nopl -42(%rax) */
 }
=20
 static inline bool __is_endbr(u32 val)
@@ -70,10 +70,6 @@ static inline bool __is_endbr(u32 val)
 	if (val =3D=3D gen_endbr_poison())
 		return true;
=20
-	/* See cfi_fineibt_bhi_preamble() */
-	if (IS_ENABLED(CONFIG_FINEIBT_BHI) && val =3D=3D 0x001f0ff5)
-		return true;
-
 	val &=3D ~0x01000000U; /* ENDBR32 -> ENDBR64 */
 	return val =3D=3D gen_endbr();
 }
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 7d4a992..3d6a884 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -147,10 +147,10 @@ static void *its_init_thunk(void *thunk, int reg)
 		/*
 		 * When ITS uses indirect branch thunk the fineibt_paranoid
 		 * caller sequence doesn't fit in the caller site. So put the
-		 * remaining part of the sequence (<ea> + JNE) into the ITS
+		 * remaining part of the sequence (UDB + JNE) into the ITS
 		 * thunk.
 		 */
-		bytes[i++] =3D 0xea; /* invalid instruction */
+		bytes[i++] =3D 0xd6; /* UDB */
 		bytes[i++] =3D 0x75; /* JNE */
 		bytes[i++] =3D 0xfd;
=20
@@ -163,7 +163,7 @@ static void *its_init_thunk(void *thunk, int reg)
 		reg -=3D 8;
 	}
 	bytes[i++] =3D 0xff;
-	bytes[i++] =3D 0xe0 + reg; /* jmp *reg */
+	bytes[i++] =3D 0xe0 + reg; /* JMP *reg */
 	bytes[i++] =3D 0xcc;
=20
 	return thunk + offset;
@@ -970,7 +970,7 @@ void __init_or_module noinline apply_retpolines(s32 *star=
t, s32 *end)
 		case JMP32_INSN_OPCODE:
 			/* Check for cfi_paranoid + ITS */
 			dest =3D addr + insn.length + insn.immediate.value;
-			if (dest[-1] =3D=3D 0xea && (dest[0] & 0xf0) =3D=3D 0x70) {
+			if (dest[-1] =3D=3D 0xd6 && (dest[0] & 0xf0) =3D=3D 0x70) {
 				WARN_ON_ONCE(cfi_mode !=3D CFI_FINEIBT);
 				continue;
 			}
@@ -1303,9 +1303,8 @@ early_param("cfi", cfi_parse_cmdline);
  *
  * __cfi_\func:					__cfi_\func:
  *	movl   $0x12345678,%eax		// 5	     endbr64			// 4
- *	nop					     subl   $0x12345678,%r10d   // 7
- *	nop					     jne    __cfi_\func+6	// 2
- *	nop					     nop3			// 3
+ *	nop					     subl   $0x12345678,%eax    // 5
+ *	nop					     jne.d32,pn \func+3		// 7
  *	nop
  *	nop
  *	nop
@@ -1314,34 +1313,45 @@ early_param("cfi", cfi_parse_cmdline);
  *	nop
  *	nop
  *	nop
+ *	nop
+ * \func:					\func:
+ *	endbr64					     nopl -42(%rax)
  *
  *
  * caller:					caller:
- *	movl	$(-0x12345678),%r10d	 // 6	     movl   $0x12345678,%r10d	// 6
+ *	movl	$(-0x12345678),%r10d	 // 6	     movl   $0x12345678,%eax	// 5
  *	addl	$-15(%r11),%r10d	 // 4	     lea    -0x10(%r11),%r11	// 4
- *	je	1f			 // 2	     nop4			// 4
+ *	je	1f			 // 2	     nop5			// 5
  *	ud2				 // 2
  * 1:	cs call	__x86_indirect_thunk_r11 // 6	     call   *%r11; nop3;	// 6
  *
+ *
+ * Notably, the FineIBT sequences are crafted such that branches are presumed
+ * non-taken. This is based on Agner Fog's optimization manual, which states:
+ *
+ *  "Make conditional jumps most often not taken: The efficiency and through=
put
+ *   for not-taken branches is better than for taken branches on most
+ *   processors. Therefore, it is good to place the most frequent branch fir=
st"
  */
=20
 /*
  * <fineibt_preamble_start>:
  *  0:   f3 0f 1e fa             endbr64
- *  4:   41 81 <ea> 78 56 34 12  sub    $0x12345678, %r10d
- *  b:   75 f9                   jne    6 <fineibt_preamble_start+0x6>
- *  d:   0f 1f 00                nopl   (%rax)
+ *  4:   2d 78 56 34 12          sub    $0x12345678, %eax
+ *  9:   2e 0f 85 03 00 00 00    jne,pn 13 <fineibt_preamble_start+0x13>
+ * 10:   0f 1f 40 d6             nopl   -0x2a(%rax)
  *
- * Note that the JNE target is the 0xEA byte inside the SUB, this decodes as
- * (bad) on x86_64 and raises #UD.
+ * Note that the JNE target is the 0xD6 byte inside the NOPL, this decodes as
+ * UDB on x86_64 and raises #UD.
  */
 asm(	".pushsection .rodata				\n"
 	"fineibt_preamble_start:			\n"
 	"	endbr64					\n"
-	"	subl	$0x12345678, %r10d		\n"
+	"	subl	$0x12345678, %eax		\n"
 	"fineibt_preamble_bhi:				\n"
-	"	jne	fineibt_preamble_start+6	\n"
-	ASM_NOP3
+	"	cs jne.d32 fineibt_preamble_start+0x13	\n"
+	"#fineibt_func:					\n"
+	"	nopl	-42(%rax)			\n"
 	"fineibt_preamble_end:				\n"
 	".popsection\n"
 );
@@ -1352,20 +1362,20 @@ extern u8 fineibt_preamble_end[];
=20
 #define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_start)
 #define fineibt_preamble_bhi  (fineibt_preamble_bhi - fineibt_preamble_start)
-#define fineibt_preamble_ud   6
-#define fineibt_preamble_hash 7
+#define fineibt_preamble_ud   0x13
+#define fineibt_preamble_hash 5
=20
 /*
  * <fineibt_caller_start>:
- *  0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
- *  6:   4d 8d 5b f0             lea    -0x10(%r11), %r11
- *  a:   0f 1f 40 00             nopl   0x0(%rax)
+ *  0:   b8 78 56 34 12          mov    $0x12345678, %eax
+ *  5:   4d 8d 5b f0             lea    -0x10(%r11), %r11
+ *  9:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
  */
 asm(	".pushsection .rodata			\n"
 	"fineibt_caller_start:			\n"
-	"	movl	$0x12345678, %r10d	\n"
+	"	movl	$0x12345678, %eax	\n"
 	"	lea	-0x10(%r11), %r11	\n"
-	ASM_NOP4
+	ASM_NOP5
 	"fineibt_caller_end:			\n"
 	".popsection				\n"
 );
@@ -1374,7 +1384,7 @@ extern u8 fineibt_caller_start[];
 extern u8 fineibt_caller_end[];
=20
 #define fineibt_caller_size (fineibt_caller_end - fineibt_caller_start)
-#define fineibt_caller_hash 2
+#define fineibt_caller_hash 1
=20
 #define fineibt_caller_jmp (fineibt_caller_size - 2)
=20
@@ -1391,9 +1401,9 @@ extern u8 fineibt_caller_end[];
  * of adding a load.
  *
  * <fineibt_paranoid_start>:
- *  0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
- *  6:   45 3b 53 f7             cmp    -0x9(%r11), %r10d
- *  a:   4d 8d 5b <f0>           lea    -0x10(%r11), %r11
+ *  0:   b8 78 56 34 12          mov    $0x12345678, %eax
+ *  5:   41 3b 43 f5             cmp    -0x11(%r11), %eax
+ *  9:   2e 4d 8d 5b <f0>        cs lea -0x10(%r11), %r11
  *  e:   75 fd                   jne    d <fineibt_paranoid_start+0xd>
  * 10:   41 ff d3                call   *%r11
  * 13:   90                      nop
@@ -1405,9 +1415,10 @@ extern u8 fineibt_caller_end[];
  */
 asm(	".pushsection .rodata				\n"
 	"fineibt_paranoid_start:			\n"
-	"	movl	$0x12345678, %r10d		\n"
-	"	cmpl	-9(%r11), %r10d			\n"
-	"	lea	-0x10(%r11), %r11		\n"
+	"	mov	$0x12345678, %eax		\n"
+	"	cmpl	-11(%r11), %eax			\n"
+	"	cs lea	-0x10(%r11), %r11		\n"
+	"#fineibt_caller_size:                          \n"
 	"	jne	fineibt_paranoid_start+0xd	\n"
 	"fineibt_paranoid_ind:				\n"
 	"	call	*%r11				\n"
@@ -1523,51 +1534,67 @@ static int cfi_rand_preamble(s32 *start, s32 *end)
 	return 0;
 }
=20
+/*
+ * Inline the bhi-arity 1 case:
+ *
+ * __cfi_foo:
+ *  0: f3 0f 1e fa             endbr64
+ *  4: 2d 78 56 34 12          sub    $0x12345678, %eax
+ *  9: 49 0f 45 fa             cmovne %rax, %rdi
+ *  d: 2e 75 03                jne,pn    foo+0x3
+ *
+ * foo:
+ * 10: 0f 1f 40 <d6>           nopl -42(%rax)
+ *
+ * Notably, this scheme is incompatible with permissive CFI
+ * because the CMOVcc is unconditional and RDI will have been
+ * clobbered.
+ */
+asm(	".pushsection .rodata				\n"
+	"fineibt_bhi1_start:				\n"
+	"	cmovne %rax, %rdi			\n"
+	"	cs jne fineibt_bhi1_func + 0x3		\n"
+	"fineibt_bhi1_func:				\n"
+	"	nopl -42(%rax)				\n"
+	"fineibt_bhi1_end:				\n"
+	".popsection					\n"
+);
+
+extern u8 fineibt_bhi1_start[];
+extern u8 fineibt_bhi1_end[];
+
+#define fineibt_bhi1_size (fineibt_bhi1_end - fineibt_bhi1_start)
+
 static void cfi_fineibt_bhi_preamble(void *addr, int arity)
 {
+	u8 bytes[MAX_INSN_SIZE];
+
 	if (!arity)
 		return;
=20
 	if (!cfi_warn && arity =3D=3D 1) {
-		/*
-		 * Crazy scheme to allow arity-1 inline:
-		 *
-		 * __cfi_foo:
-		 *  0: f3 0f 1e fa             endbr64
-		 *  4: 41 81 <ea> 78 56 34 12  sub     0x12345678, %r10d
-		 *  b: 49 0f 45 fa             cmovne  %r10, %rdi
-		 *  f: 75 f5                   jne     __cfi_foo+6
-		 * 11: 0f 1f 00                nopl    (%rax)
-		 *
-		 * Code that direct calls to foo()+0, decodes the tail end as:
-		 *
-		 * foo:
-		 *  0: f5                      cmc
-		 *  1: 0f 1f 00                nopl    (%rax)
-		 *
-		 * which clobbers CF, but does not affect anything ABI
-		 * wise.
-		 *
-		 * Notably, this scheme is incompatible with permissive CFI
-		 * because the CMOVcc is unconditional and RDI will have been
-		 * clobbered.
-		 */
-		const u8 magic[9] =3D {
-			0x49, 0x0f, 0x45, 0xfa,
-			0x75, 0xf5,
-			BYTES_NOP3,
-		};
-
-		text_poke_early(addr + fineibt_preamble_bhi, magic, 9);
-
+		text_poke_early(addr + fineibt_preamble_bhi,
+				fineibt_bhi1_start, fineibt_bhi1_size);
 		return;
 	}
=20
-	text_poke_early(addr + fineibt_preamble_bhi,
-			text_gen_insn(CALL_INSN_OPCODE,
-				      addr + fineibt_preamble_bhi,
-				      __bhi_args[arity]),
-			CALL_INSN_SIZE);
+	/*
+	 * Replace the bytes at fineibt_preamble_bhi with a CALL instruction
+	 * that lines up exactly with the end of the preamble, such that the
+	 * return address will be foo+0.
+	 *
+	 * __cfi_foo:
+	 *  0: f3 0f 1e fa             endbr64
+	 *  4: 2d 78 56 34 12          sub    $0x12345678, %eax
+	 *  9: 2e 2e e8 DD DD DD DD    cs cs call __bhi_args[arity]
+	 */
+	bytes[0] =3D 0x2e;
+	bytes[1] =3D 0x2e;
+	__text_gen_insn(bytes + 2, CALL_INSN_OPCODE,
+			addr + fineibt_preamble_bhi + 2,
+			__bhi_args[arity], CALL_INSN_SIZE);
+
+	text_poke_early(addr + fineibt_preamble_bhi, bytes, 7);
 }
=20
 static int cfi_rewrite_preamble(s32 *start, s32 *end)
@@ -1658,8 +1685,6 @@ static int cfi_rewrite_callers(s32 *start, s32 *end)
 {
 	s32 *s;
=20
-	BUG_ON(fineibt_paranoid_size !=3D 20);
-
 	for (s =3D start; s < end; s++) {
 		void *addr =3D (void *)s + *s;
 		struct insn insn;
@@ -1712,13 +1737,18 @@ static int cfi_rewrite_callers(s32 *start, s32 *end)
=20
 #define pr_cfi_debug(X...) if (cfi_debug) pr_info(X)
=20
+#define FINEIBT_WARN(_f, _v) \
+	WARN_ONCE((_f) !=3D (_v), "FineIBT: " #_f " %ld !=3D %d\n", _f, _v)
+
 static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 			    s32 *start_cfi, s32 *end_cfi, bool builtin)
 {
 	int ret;
=20
-	if (WARN_ONCE(fineibt_preamble_size !=3D 16,
-		      "FineIBT preamble wrong size: %ld", fineibt_preamble_size))
+	if (FINEIBT_WARN(fineibt_preamble_size, 20)			||
+	    FINEIBT_WARN(fineibt_preamble_bhi + fineibt_bhi1_size, 20)	||
+	    FINEIBT_WARN(fineibt_caller_size, 14)			||
+	    FINEIBT_WARN(fineibt_paranoid_size, 20))
 		return;
=20
 	if (cfi_mode =3D=3D CFI_AUTO) {
@@ -1839,11 +1869,11 @@ static void poison_cfi(void *addr)
=20
 		/*
 		 * __cfi_\func:
-		 *	osp nopl (%rax)
-		 *	subl	$0, %r10d
-		 *	jz	1f
-		 *	ud2
-		 * 1:	nop
+		 *	nopl	-42(%rax)
+		 *	sub	$0, %eax
+		 *	jne	\func+3
+		 * \func:
+		 *	nopl	-42(%rax)
 		 */
 		poison_endbr(addr);
 		poison_hash(addr + fineibt_preamble_hash);
@@ -1869,12 +1899,14 @@ static void poison_cfi(void *addr)
 	}
 }
=20
+#define fineibt_prefix_size (fineibt_preamble_size - ENDBR_INSN_SIZE)
+
 /*
- * When regs->ip points to a 0xEA byte in the FineIBT preamble,
+ * When regs->ip points to a 0xD6 byte in the FineIBT preamble,
  * return true and fill out target and type.
  *
  * We check the preamble by checking for the ENDBR instruction relative to t=
he
- * 0xEA instruction.
+ * UDB instruction.
  */
 static bool decode_fineibt_preamble(struct pt_regs *regs, unsigned long *tar=
get, u32 *type)
 {
@@ -1884,10 +1916,10 @@ static bool decode_fineibt_preamble(struct pt_regs *r=
egs, unsigned long *target,
 	if (!exact_endbr((void *)addr))
 		return false;
=20
-	*target =3D addr + fineibt_preamble_size;
+	*target =3D addr + fineibt_prefix_size;
=20
 	__get_kernel_nofault(&hash, addr + fineibt_preamble_hash, u32, Efault);
-	*type =3D (u32)regs->r10 + hash;
+	*type =3D (u32)regs->ax + hash;
=20
 	/*
 	 * Since regs->ip points to the middle of an instruction; it cannot
@@ -1925,12 +1957,12 @@ static bool decode_fineibt_bhi(struct pt_regs *regs, =
unsigned long *target, u32=20
 	__get_kernel_nofault(&addr, regs->sp, unsigned long, Efault);
 	*target =3D addr;
=20
-	addr -=3D fineibt_preamble_size;
+	addr -=3D fineibt_prefix_size;
 	if (!exact_endbr((void *)addr))
 		return false;
=20
 	__get_kernel_nofault(&hash, addr + fineibt_preamble_hash, u32, Efault);
-	*type =3D (u32)regs->r10 + hash;
+	*type =3D (u32)regs->ax + hash;
=20
 	/*
 	 * The UD2 sites are constructed with a RET immediately following,
@@ -1947,7 +1979,7 @@ static bool is_paranoid_thunk(unsigned long addr)
 	u32 thunk;
=20
 	__get_kernel_nofault(&thunk, (u32 *)addr, u32, Efault);
-	return (thunk & 0x00FFFFFF) =3D=3D 0xfd75ea;
+	return (thunk & 0x00FFFFFF) =3D=3D 0xfd75d6;
=20
 Efault:
 	return false;
@@ -1955,8 +1987,7 @@ Efault:
=20
 /*
  * regs->ip points to a LOCK Jcc.d8 instruction from the fineibt_paranoid_st=
art[]
- * sequence, or to an invalid instruction (0xea) + Jcc.d8 for cfi_paranoid +=
 ITS
- * thunk.
+ * sequence, or to UDB + Jcc.d8 for cfi_paranoid + ITS thunk.
  */
 static bool decode_fineibt_paranoid(struct pt_regs *regs, unsigned long *tar=
get, u32 *type)
 {
@@ -1966,8 +1997,8 @@ static bool decode_fineibt_paranoid(struct pt_regs *reg=
s, unsigned long *target,
 		return false;
=20
 	if (is_cfi_trap(addr + fineibt_caller_size - LEN_UD2)) {
-		*target =3D regs->r11 + fineibt_preamble_size;
-		*type =3D regs->r10;
+		*target =3D regs->r11 + fineibt_prefix_size;
+		*type =3D regs->ax;
=20
 		/*
 		 * Since the trapping instruction is the exact, but LOCK prefixed,
@@ -1979,14 +2010,14 @@ static bool decode_fineibt_paranoid(struct pt_regs *r=
egs, unsigned long *target,
 	/*
 	 * The cfi_paranoid + ITS thunk combination results in:
 	 *
-	 *  0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
-	 *  6:   45 3b 53 f7             cmp    -0x9(%r11), %r10d
-	 *  a:   4d 8d 5b f0             lea    -0x10(%r11), %r11
+	 *  0:   b8 78 56 34 12          mov    $0x12345678, %eax
+	 *  5:   41 3b 43 f7             cmp    -11(%r11), %eax
+	 *  a:   2e 3d 8d 5b f0          cs lea -0x10(%r11), %r11
 	 *  e:   2e e8 XX XX XX XX	 cs call __x86_indirect_paranoid_thunk_r11
 	 *
 	 * Where the paranoid_thunk looks like:
 	 *
-	 *  1d:  <ea>                    (bad)
+	 *  1d:  <d6>                    udb
 	 *  __x86_indirect_paranoid_thunk_r11:
 	 *  1e:  75 fd                   jne 1d
 	 *  __x86_indirect_its_thunk_r11:
@@ -1995,8 +2026,8 @@ static bool decode_fineibt_paranoid(struct pt_regs *reg=
s, unsigned long *target,
 	 *
 	 */
 	if (is_paranoid_thunk(regs->ip)) {
-		*target =3D regs->r11 + fineibt_preamble_size;
-		*type =3D regs->r10;
+		*target =3D regs->r11 + fineibt_prefix_size;
+		*type =3D regs->ax;
=20
 		regs->ip =3D *target;
 		return true;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 36354b4..6b22611 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -97,7 +97,7 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
  * Check for UD1 or UD2, accounting for Address Size Override Prefixes.
  * If it's a UD1, further decode to determine its use:
  *
- * FineIBT:      ea                      (bad)
+ * FineIBT:      d6                      udb
  * FineIBT:      f0 75 f9                lock jne . - 6
  * UBSan{0}:     67 0f b9 00             ud1    (%eax),%eax
  * UBSan{10}:    67 0f b9 40 10          ud1    0x10(%eax),%eax
@@ -130,9 +130,9 @@ __always_inline int decode_bug(unsigned long addr, s32 *i=
mm, int *len)
 		WARN_ON_ONCE(!lock);
 		return BUG_LOCK;
=20
-	case 0xea:
+	case 0xd6:
 		*len =3D addr - start;
-		return BUG_EA;
+		return BUG_UDB;
=20
 	case OPCODE_ESCAPE:
 		break;
@@ -341,7 +341,7 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 		}
 		fallthrough;
=20
-	case BUG_EA:
+	case BUG_UDB:
 	case BUG_LOCK:
 		if (handle_cfi_failure(regs) =3D=3D BUG_TRAP_TYPE_WARN) {
 			handled =3D true;
diff --git a/arch/x86/lib/bhi.S b/arch/x86/lib/bhi.S
index 5889168..aad1e58 100644
--- a/arch/x86/lib/bhi.S
+++ b/arch/x86/lib/bhi.S
@@ -5,7 +5,7 @@
 #include <asm/nospec-branch.h>
=20
 /*
- * Notably, the FineIBT preamble calling these will have ZF set and r10 zero.
+ * Notably, the FineIBT preamble calling these will have ZF set and eax zero.
  *
  * The very last element is in fact larger than 32 bytes, but since its the
  * last element, this does not matter,
@@ -36,7 +36,7 @@ SYM_INNER_LABEL(__bhi_args_1, SYM_L_LOCAL)
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	jne .Lud_1
-	cmovne %r10, %rdi
+	cmovne %rax, %rdi
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
@@ -53,8 +53,8 @@ SYM_INNER_LABEL(__bhi_args_2, SYM_L_LOCAL)
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	jne .Lud_1
-	cmovne %r10, %rdi
-	cmovne %r10, %rsi
+	cmovne %rax, %rdi
+	cmovne %rax, %rsi
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
@@ -64,9 +64,9 @@ SYM_INNER_LABEL(__bhi_args_3, SYM_L_LOCAL)
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	jne .Lud_1
-	cmovne %r10, %rdi
-	cmovne %r10, %rsi
-	cmovne %r10, %rdx
+	cmovne %rax, %rdi
+	cmovne %rax, %rsi
+	cmovne %rax, %rdx
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
@@ -76,10 +76,10 @@ SYM_INNER_LABEL(__bhi_args_4, SYM_L_LOCAL)
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	jne .Lud_2
-	cmovne %r10, %rdi
-	cmovne %r10, %rsi
-	cmovne %r10, %rdx
-	cmovne %r10, %rcx
+	cmovne %rax, %rdi
+	cmovne %rax, %rsi
+	cmovne %rax, %rdx
+	cmovne %rax, %rcx
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
@@ -89,11 +89,11 @@ SYM_INNER_LABEL(__bhi_args_5, SYM_L_LOCAL)
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	jne .Lud_2
-	cmovne %r10, %rdi
-	cmovne %r10, %rsi
-	cmovne %r10, %rdx
-	cmovne %r10, %rcx
-	cmovne %r10, %r8
+	cmovne %rax, %rdi
+	cmovne %rax, %rsi
+	cmovne %rax, %rdx
+	cmovne %rax, %rcx
+	cmovne %rax, %r8
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
@@ -110,12 +110,12 @@ SYM_INNER_LABEL(__bhi_args_6, SYM_L_LOCAL)
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	jne .Lud_2
-	cmovne %r10, %rdi
-	cmovne %r10, %rsi
-	cmovne %r10, %rdx
-	cmovne %r10, %rcx
-	cmovne %r10, %r8
-	cmovne %r10, %r9
+	cmovne %rax, %rdi
+	cmovne %rax, %rsi
+	cmovne %rax, %rdx
+	cmovne %rax, %rcx
+	cmovne %rax, %r8
+	cmovne %rax, %r9
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
@@ -125,13 +125,13 @@ SYM_INNER_LABEL(__bhi_args_7, SYM_L_LOCAL)
 	ANNOTATE_NOENDBR
 	UNWIND_HINT_FUNC
 	jne .Lud_2
-	cmovne %r10, %rdi
-	cmovne %r10, %rsi
-	cmovne %r10, %rdx
-	cmovne %r10, %rcx
-	cmovne %r10, %r8
-	cmovne %r10, %r9
-	cmovne %r10, %rsp
+	cmovne %rax, %rdi
+	cmovne %rax, %rsi
+	cmovne %rax, %rdx
+	cmovne %rax, %rcx
+	cmovne %rax, %r8
+	cmovne %rax, %r9
+	cmovne %rax, %rsp
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index d78d769..24b7aca 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -373,10 +373,10 @@ SYM_FUNC_END(call_depth_return_thunk)
 .macro ITS_THUNK reg
=20
 /*
- * If CFI paranoid is used then the ITS thunk starts with opcodes (0xea; jne=
 1b)
+ * If CFI paranoid is used then the ITS thunk starts with opcodes (1: udb; j=
ne 1b)
  * that complete the fineibt_paranoid caller sequence.
  */
-1:	.byte 0xea
+1:	ASM_UDB
 SYM_INNER_LABEL(__x86_indirect_paranoid_thunk_\reg, SYM_L_GLOBAL)
 	UNWIND_HINT_UNDEFINED
 	ANNOTATE_NOENDBR
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 7e3fca1..5178ef1 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -419,12 +419,12 @@ static void emit_fineibt(u8 **pprog, u8 *ip, u32 hash, =
int arity)
 	u8 *prog =3D *pprog;
=20
 	EMIT_ENDBR();
-	EMIT3_off32(0x41, 0x81, 0xea, hash);		/* subl $hash, %r10d	*/
+	EMIT1_off32(0x2d, hash);			/* subl $hash, %eax	*/
 	if (cfi_bhi) {
+		EMIT2(0x2e, 0x2e);			/* cs cs */
 		emit_call(&prog, __bhi_args[arity], ip + 11);
 	} else {
-		EMIT2(0x75, 0xf9);			/* jne.d8 .-7		*/
-		EMIT3(0x0f, 0x1f, 0x00);		/* nop3			*/
+		EMIT3_off32(0x2e, 0x0f, 0x85, 3);	/* jne.d32,pn 3		*/
 	}
 	EMIT_ENDBR_POISON();
=20

