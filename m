Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 130181123E1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Dec 2019 08:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfLDHzG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 4 Dec 2019 02:55:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56122 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbfLDHyG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 4 Dec 2019 02:54:06 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icPTt-0004Ra-Ud; Wed, 04 Dec 2019 08:53:54 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 924781C2217;
        Wed,  4 Dec 2019 08:53:53 +0100 (CET)
Date:   Wed, 04 Dec 2019 07:53:53 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf bench: Update the copies of x86's mem{cpy,set}_64.S
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@suse.de>, Jiri Olsa <jolsa@kernel.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-tay3l8x8k11p7y3qcpqh9qh5@git.kernel.org>
References: <tip-tay3l8x8k11p7y3qcpqh9qh5@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157544603345.21853.8418830606062221141.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     bd5c6b81dd6025bd4c6ca7800a580b217d9899b9
Gitweb:        https://git.kernel.org/tip/bd5c6b81dd6025bd4c6ca7800a580b217d9899b9
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 02 Dec 2019 11:40:57 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 02 Dec 2019 11:40:57 -03:00

perf bench: Update the copies of x86's mem{cpy,set}_64.S

And update linux/linkage.h, which requires in turn that we make these
files switch from ENTRY()/ENDPROC() to SYM_FUNC_START()/SYM_FUNC_END():

  tools/perf/arch/arm64/tests/regs_load.S
  tools/perf/arch/arm/tests/regs_load.S
  tools/perf/arch/powerpc/tests/regs_load.S
  tools/perf/arch/x86/tests/regs_load.S

We also need to switch SYM_FUNC_START_LOCAL() to SYM_FUNC_START() for
the functions used directly by 'perf bench', and update
tools/perf/check_headers.sh to ignore those changes when checking if the
kernel original files drifted from the copies we carry.

This is to get the changes from:

  6dcc5627f6ae ("x86/asm: Change all ENTRY+ENDPROC to SYM_FUNC_*")
  ef1e03152cb0 ("x86/asm: Make some functions local")
  e9b9d020c487 ("x86/asm: Annotate aliases")

And address these tools/perf build warnings:

  Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
  diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
  Warning: Kernel ABI header at 'tools/arch/x86/lib/memset_64.S' differs from latest version at 'arch/x86/lib/memset_64.S'
  diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_64.S

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-tay3l8x8k11p7y3qcpqh9qh5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/lib/memcpy_64.S          | 20 ++---
 tools/arch/x86/lib/memset_64.S          | 16 ++--
 tools/perf/arch/arm/tests/regs_load.S   |  4 +-
 tools/perf/arch/arm64/tests/regs_load.S |  4 +-
 tools/perf/arch/x86/tests/regs_load.S   |  8 +-
 tools/perf/check-headers.sh             |  4 +-
 tools/perf/util/include/linux/linkage.h | 89 +++++++++++++++++++++++-
 7 files changed, 114 insertions(+), 31 deletions(-)

diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
index 9274866..df767af 100644
--- a/tools/arch/x86/lib/memcpy_64.S
+++ b/tools/arch/x86/lib/memcpy_64.S
@@ -28,8 +28,8 @@
  * Output:
  * rax original destination
  */
-ENTRY(__memcpy)
-ENTRY(memcpy)
+SYM_FUNC_START_ALIAS(__memcpy)
+SYM_FUNC_START_LOCAL(memcpy)
 	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memcpy_erms", X86_FEATURE_ERMS
 
@@ -41,8 +41,8 @@ ENTRY(memcpy)
 	movl %edx, %ecx
 	rep movsb
 	ret
-ENDPROC(memcpy)
-ENDPROC(__memcpy)
+SYM_FUNC_END(memcpy)
+SYM_FUNC_END_ALIAS(__memcpy)
 EXPORT_SYMBOL(memcpy)
 EXPORT_SYMBOL(__memcpy)
 
@@ -50,14 +50,14 @@ EXPORT_SYMBOL(__memcpy)
  * memcpy_erms() - enhanced fast string memcpy. This is faster and
  * simpler than memcpy. Use memcpy_erms when possible.
  */
-ENTRY(memcpy_erms)
+SYM_FUNC_START(memcpy_erms)
 	movq %rdi, %rax
 	movq %rdx, %rcx
 	rep movsb
 	ret
-ENDPROC(memcpy_erms)
+SYM_FUNC_END(memcpy_erms)
 
-ENTRY(memcpy_orig)
+SYM_FUNC_START(memcpy_orig)
 	movq %rdi, %rax
 
 	cmpq $0x20, %rdx
@@ -182,7 +182,7 @@ ENTRY(memcpy_orig)
 
 .Lend:
 	retq
-ENDPROC(memcpy_orig)
+SYM_FUNC_END(memcpy_orig)
 
 #ifndef CONFIG_UML
 
@@ -193,7 +193,7 @@ MCSAFE_TEST_CTL
  * Note that we only catch machine checks when reading the source addresses.
  * Writes to target are posted and don't generate machine checks.
  */
-ENTRY(__memcpy_mcsafe)
+SYM_FUNC_START(__memcpy_mcsafe)
 	cmpl $8, %edx
 	/* Less than 8 bytes? Go to byte copy loop */
 	jb .L_no_whole_words
@@ -260,7 +260,7 @@ ENTRY(__memcpy_mcsafe)
 	xorl %eax, %eax
 .L_done:
 	ret
-ENDPROC(__memcpy_mcsafe)
+SYM_FUNC_END(__memcpy_mcsafe)
 EXPORT_SYMBOL_GPL(__memcpy_mcsafe)
 
 	.section .fixup, "ax"
diff --git a/tools/arch/x86/lib/memset_64.S b/tools/arch/x86/lib/memset_64.S
index f8f3dc0..fd5d25a 100644
--- a/tools/arch/x86/lib/memset_64.S
+++ b/tools/arch/x86/lib/memset_64.S
@@ -18,8 +18,8 @@
  *
  * rax   original destination
  */
-ENTRY(memset)
-ENTRY(__memset)
+SYM_FUNC_START_ALIAS(memset)
+SYM_FUNC_START(__memset)
 	/*
 	 * Some CPUs support enhanced REP MOVSB/STOSB feature. It is recommended
 	 * to use it when possible. If not available, use fast string instructions.
@@ -42,8 +42,8 @@ ENTRY(__memset)
 	rep stosb
 	movq %r9,%rax
 	ret
-ENDPROC(memset)
-ENDPROC(__memset)
+SYM_FUNC_END(__memset)
+SYM_FUNC_END_ALIAS(memset)
 
 /*
  * ISO C memset - set a memory block to a byte value. This function uses
@@ -56,16 +56,16 @@ ENDPROC(__memset)
  *
  * rax   original destination
  */
-ENTRY(memset_erms)
+SYM_FUNC_START(memset_erms)
 	movq %rdi,%r9
 	movb %sil,%al
 	movq %rdx,%rcx
 	rep stosb
 	movq %r9,%rax
 	ret
-ENDPROC(memset_erms)
+SYM_FUNC_END(memset_erms)
 
-ENTRY(memset_orig)
+SYM_FUNC_START(memset_orig)
 	movq %rdi,%r10
 
 	/* expand byte value  */
@@ -136,4 +136,4 @@ ENTRY(memset_orig)
 	subq %r8,%rdx
 	jmp .Lafter_bad_alignment
 .Lfinal:
-ENDPROC(memset_orig)
+SYM_FUNC_END(memset_orig)
diff --git a/tools/perf/arch/arm/tests/regs_load.S b/tools/perf/arch/arm/tests/regs_load.S
index 6e2495c..4284307 100644
--- a/tools/perf/arch/arm/tests/regs_load.S
+++ b/tools/perf/arch/arm/tests/regs_load.S
@@ -37,7 +37,7 @@
 
 .text
 .type perf_regs_load,%function
-ENTRY(perf_regs_load)
+SYM_FUNC_START(perf_regs_load)
 	str r0, [r0, #R0]
 	str r1, [r0, #R1]
 	str r2, [r0, #R2]
@@ -56,4 +56,4 @@ ENTRY(perf_regs_load)
 	str lr, [r0, #PC]	// store pc as lr in order to skip the call
 	                        //  to this function
 	mov pc, lr
-ENDPROC(perf_regs_load)
+SYM_FUNC_END(perf_regs_load)
diff --git a/tools/perf/arch/arm64/tests/regs_load.S b/tools/perf/arch/arm64/tests/regs_load.S
index 0704251..d49de40 100644
--- a/tools/perf/arch/arm64/tests/regs_load.S
+++ b/tools/perf/arch/arm64/tests/regs_load.S
@@ -7,7 +7,7 @@
 #define LDR_REG(r)	ldr x##r, [x0, 8 * r]
 #define SP	(8 * 31)
 #define PC	(8 * 32)
-ENTRY(perf_regs_load)
+SYM_FUNC_START(perf_regs_load)
 	STR_REG(0)
 	STR_REG(1)
 	STR_REG(2)
@@ -44,4 +44,4 @@ ENTRY(perf_regs_load)
 	str x30, [x0, #PC]
 	LDR_REG(1)
 	ret
-ENDPROC(perf_regs_load)
+SYM_FUNC_END(perf_regs_load)
diff --git a/tools/perf/arch/x86/tests/regs_load.S b/tools/perf/arch/x86/tests/regs_load.S
index bbe5a0d..80f14f5 100644
--- a/tools/perf/arch/x86/tests/regs_load.S
+++ b/tools/perf/arch/x86/tests/regs_load.S
@@ -28,7 +28,7 @@
 
 .text
 #ifdef HAVE_ARCH_X86_64_SUPPORT
-ENTRY(perf_regs_load)
+SYM_FUNC_START(perf_regs_load)
 	movq %rax, AX(%rdi)
 	movq %rbx, BX(%rdi)
 	movq %rcx, CX(%rdi)
@@ -60,9 +60,9 @@ ENTRY(perf_regs_load)
 	movq %r14, R14(%rdi)
 	movq %r15, R15(%rdi)
 	ret
-ENDPROC(perf_regs_load)
+SYM_FUNC_END(perf_regs_load)
 #else
-ENTRY(perf_regs_load)
+SYM_FUNC_START(perf_regs_load)
 	push %edi
 	movl 8(%esp), %edi
 	movl %eax, AX(%edi)
@@ -88,7 +88,7 @@ ENTRY(perf_regs_load)
 	movl $0, FS(%edi)
 	movl $0, GS(%edi)
 	ret
-ENDPROC(perf_regs_load)
+SYM_FUNC_END(perf_regs_load)
 #endif
 
 /*
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index a1dc167..68039a9 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -110,8 +110,8 @@ for i in $FILES; do
 done
 
 # diff with extra ignore lines
-check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"'
-check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"'
+check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memcpy_\(erms\|orig\))"'
+check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
 check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 check include/linux/ctype.h	      '-I "isdigit("'
diff --git a/tools/perf/util/include/linux/linkage.h b/tools/perf/util/include/linux/linkage.h
index f01d48a..b8a5159 100644
--- a/tools/perf/util/include/linux/linkage.h
+++ b/tools/perf/util/include/linux/linkage.h
@@ -5,10 +5,93 @@
 
 /* linkage.h ... for including arch/x86/lib/memcpy_64.S */
 
-#define ENTRY(name)				\
-	.globl name;				\
+/* Some toolchains use other characters (e.g. '`') to mark new line in macro */
+#ifndef ASM_NL
+#define ASM_NL		 ;
+#endif
+
+#ifndef __ALIGN
+#define __ALIGN		.align 4,0x90
+#define __ALIGN_STR	".align 4,0x90"
+#endif
+
+/* SYM_T_FUNC -- type used by assembler to mark functions */
+#ifndef SYM_T_FUNC
+#define SYM_T_FUNC				STT_FUNC
+#endif
+
+/* SYM_A_* -- align the symbol? */
+#define SYM_A_ALIGN				ALIGN
+
+/* SYM_L_* -- linkage of symbols */
+#define SYM_L_GLOBAL(name)			.globl name
+#define SYM_L_LOCAL(name)			/* nothing */
+
+#define ALIGN __ALIGN
+
+/* === generic annotations === */
+
+/* SYM_ENTRY -- use only if you have to for non-paired symbols */
+#ifndef SYM_ENTRY
+#define SYM_ENTRY(name, linkage, align...)		\
+	linkage(name) ASM_NL				\
+	align ASM_NL					\
 	name:
+#endif
+
+/* SYM_START -- use only if you have to */
+#ifndef SYM_START
+#define SYM_START(name, linkage, align...)		\
+	SYM_ENTRY(name, linkage, align)
+#endif
+
+/* SYM_END -- use only if you have to */
+#ifndef SYM_END
+#define SYM_END(name, sym_type)				\
+	.type name sym_type ASM_NL			\
+	.size name, .-name
+#endif
+
+/*
+ * SYM_FUNC_START_ALIAS -- use where there are two global names for one
+ * function
+ */
+#ifndef SYM_FUNC_START_ALIAS
+#define SYM_FUNC_START_ALIAS(name)			\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
+#endif
+
+/* SYM_FUNC_START -- use for global functions */
+#ifndef SYM_FUNC_START
+/*
+ * The same as SYM_FUNC_START_ALIAS, but we will need to distinguish these two
+ * later.
+ */
+#define SYM_FUNC_START(name)				\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
+#endif
+
+/* SYM_FUNC_START_LOCAL -- use for local functions */
+#ifndef SYM_FUNC_START_LOCAL
+/* the same as SYM_FUNC_START_LOCAL_ALIAS, see comment near SYM_FUNC_START */
+#define SYM_FUNC_START_LOCAL(name)			\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
+#endif
+
+/* SYM_FUNC_END_ALIAS -- the end of LOCAL_ALIASed or ALIASed function */
+#ifndef SYM_FUNC_END_ALIAS
+#define SYM_FUNC_END_ALIAS(name)			\
+	SYM_END(name, SYM_T_FUNC)
+#endif
 
-#define ENDPROC(name)
+/*
+ * SYM_FUNC_END -- the end of SYM_FUNC_START_LOCAL, SYM_FUNC_START,
+ * SYM_FUNC_START_WEAK, ...
+ */
+#ifndef SYM_FUNC_END
+/* the same as SYM_FUNC_END_ALIAS, see comment near SYM_FUNC_START */
+#define SYM_FUNC_END(name)				\
+	SYM_END(name, SYM_T_FUNC)
+#endif
 
 #endif	/* PERF_LINUX_LINKAGE_H_ */
