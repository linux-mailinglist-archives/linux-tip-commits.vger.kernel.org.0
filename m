Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B367E43F866
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Oct 2021 10:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhJ2IFf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Oct 2021 04:05:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53172 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbhJ2IF3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Oct 2021 04:05:29 -0400
Date:   Fri, 29 Oct 2021 08:02:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635494580;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NEJRKnFBHItDWlScc3JxjQfhZKPVUon/Eu0ZOcUqVx0=;
        b=0hEDo2xSqGwdZ2+94oScFqvxNIwqeSOP+skmuDPCL4K0rNJORIsS48a0d5YKkPc+vQrtK4
        QxbCl4wNW7/NqODETyIw1drTZe563lpLNJ0/GrQ38o/kmLi1JyWN2yCN80oznw4Fc7tqx3
        mBw7pLH9h4NXiBv0QCtvepAMd8Nd4rzeY63Q00VEsh2kR2VYp/gPWhfOWMSeEbu4bNuw8m
        umXiTIE2Yw4Tw1szVewvnTJVDZhILvMiZcx3ARU/Cp465zEgpU/hk2xHXRSj37YqRLUiWA
        j4ukVqjaewNQPog+g5jbRkJ7WvZO/69qiopV/zZvmd9Y+8YB4/9u1JMP6nqKAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635494580;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NEJRKnFBHItDWlScc3JxjQfhZKPVUon/Eu0ZOcUqVx0=;
        b=Ks03biMkuuZP2htEOz053Z8Fa/FU6cElqcqRig7SsDtGbwQ0Mb1MVqfYrF5jnrJZcOioeE
        Iyb7s8B08T7+3JDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/alternative: Implement .retpoline_sites support
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026120310.232495794@infradead.org>
References: <20211026120310.232495794@infradead.org>
MIME-Version: 1.0
Message-ID: <163549457981.626.5663833574137034031.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     7508500900814d14e2e085cdc4e28142721abbdf
Gitweb:        https://git.kernel.org/tip/7508500900814d14e2e085cdc4e28142721abbdf
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 Oct 2021 14:01:42 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 28 Oct 2021 23:25:27 +02:00

x86/alternative: Implement .retpoline_sites support

Rewrite retpoline thunk call sites to be indirect calls for
spectre_v2=off. This ensures spectre_v2=off is as near to a
RETPOLINE=n build as possible.

This is the replacement for objtool writing alternative entries to
ensure the same and achieves feature-parity with the previous
approach.

One noteworthy feature is that it relies on the thunks to be in
machine order to compute the register index.

Specifically, this does not yet address the Jcc __x86_indirect_thunk_*
calls generated by clang, a future patch will add this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/r/20211026120310.232495794@infradead.org
---
 arch/um/kernel/um_arch.c           |   4 +-
 arch/x86/include/asm/alternative.h |   1 +-
 arch/x86/kernel/alternative.c      | 141 +++++++++++++++++++++++++++-
 arch/x86/kernel/module.c           |   9 +-
 4 files changed, 150 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index a149a5e..5444769 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -421,6 +421,10 @@ void __init check_bugs(void)
 	os_check_bugs();
 }
 
+void apply_retpolines(s32 *start, s32 *end)
+{
+}
+
 void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
 {
 }
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index a3c2315..58eee64 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -75,6 +75,7 @@ extern int alternatives_patched;
 
 extern void alternative_instructions(void);
 extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
+extern void apply_retpolines(s32 *start, s32 *end);
 
 struct module;
 
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index e9da3dc..5df4034 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -29,6 +29,7 @@
 #include <asm/io.h>
 #include <asm/fixmap.h>
 #include <asm/paravirt.h>
+#include <asm/asm-prototypes.h>
 
 int __read_mostly alternatives_patched;
 
@@ -113,6 +114,7 @@ static void __init_or_module add_nops(void *insns, unsigned int len)
 	}
 }
 
+extern s32 __retpoline_sites[], __retpoline_sites_end[];
 extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
 void text_poke_early(void *addr, const void *opcode, size_t len);
@@ -221,7 +223,7 @@ static __always_inline int optimize_nops_range(u8 *instr, u8 instrlen, int off)
  * "noinline" to cause control flow change and thus invalidate I$ and
  * cause refetch after modification.
  */
-static void __init_or_module noinline optimize_nops(struct alt_instr *a, u8 *instr)
+static void __init_or_module noinline optimize_nops(u8 *instr, size_t len)
 {
 	struct insn insn;
 	int i = 0;
@@ -239,11 +241,11 @@ static void __init_or_module noinline optimize_nops(struct alt_instr *a, u8 *ins
 		 * optimized.
 		 */
 		if (insn.length == 1 && insn.opcode.bytes[0] == 0x90)
-			i += optimize_nops_range(instr, a->instrlen, i);
+			i += optimize_nops_range(instr, len, i);
 		else
 			i += insn.length;
 
-		if (i >= a->instrlen)
+		if (i >= len)
 			return;
 	}
 }
@@ -331,10 +333,135 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		text_poke_early(instr, insn_buff, insn_buff_sz);
 
 next:
-		optimize_nops(a, instr);
+		optimize_nops(instr, a->instrlen);
 	}
 }
 
+#if defined(CONFIG_RETPOLINE) && defined(CONFIG_STACK_VALIDATION)
+
+/*
+ * CALL/JMP *%\reg
+ */
+static int emit_indirect(int op, int reg, u8 *bytes)
+{
+	int i = 0;
+	u8 modrm;
+
+	switch (op) {
+	case CALL_INSN_OPCODE:
+		modrm = 0x10; /* Reg = 2; CALL r/m */
+		break;
+
+	case JMP32_INSN_OPCODE:
+		modrm = 0x20; /* Reg = 4; JMP r/m */
+		break;
+
+	default:
+		WARN_ON_ONCE(1);
+		return -1;
+	}
+
+	if (reg >= 8) {
+		bytes[i++] = 0x41; /* REX.B prefix */
+		reg -= 8;
+	}
+
+	modrm |= 0xc0; /* Mod = 3 */
+	modrm += reg;
+
+	bytes[i++] = 0xff; /* opcode */
+	bytes[i++] = modrm;
+
+	return i;
+}
+
+/*
+ * Rewrite the compiler generated retpoline thunk calls.
+ *
+ * For spectre_v2=off (!X86_FEATURE_RETPOLINE), rewrite them into immediate
+ * indirect instructions, avoiding the extra indirection.
+ *
+ * For example, convert:
+ *
+ *   CALL __x86_indirect_thunk_\reg
+ *
+ * into:
+ *
+ *   CALL *%\reg
+ *
+ */
+static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
+{
+	retpoline_thunk_t *target;
+	int reg, i = 0;
+
+	target = addr + insn->length + insn->immediate.value;
+	reg = target - __x86_indirect_thunk_array;
+
+	if (WARN_ON_ONCE(reg & ~0xf))
+		return -1;
+
+	/* If anyone ever does: CALL/JMP *%rsp, we're in deep trouble. */
+	BUG_ON(reg == 4);
+
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
+		return -1;
+
+	i = emit_indirect(insn->opcode.bytes[0], reg, bytes);
+	if (i < 0)
+		return i;
+
+	for (; i < insn->length;)
+		bytes[i++] = BYTES_NOP1;
+
+	return i;
+}
+
+/*
+ * Generated by 'objtool --retpoline'.
+ */
+void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
+{
+	s32 *s;
+
+	for (s = start; s < end; s++) {
+		void *addr = (void *)s + *s;
+		struct insn insn;
+		int len, ret;
+		u8 bytes[16];
+		u8 op1, op2;
+
+		ret = insn_decode_kernel(&insn, addr);
+		if (WARN_ON_ONCE(ret < 0))
+			continue;
+
+		op1 = insn.opcode.bytes[0];
+		op2 = insn.opcode.bytes[1];
+
+		switch (op1) {
+		case CALL_INSN_OPCODE:
+		case JMP32_INSN_OPCODE:
+			break;
+
+		default:
+			WARN_ON_ONCE(1);
+			continue;
+		}
+
+		len = patch_retpoline(addr, &insn, bytes);
+		if (len == insn.length) {
+			optimize_nops(bytes, len);
+			text_poke_early(addr, bytes, len);
+		}
+	}
+}
+
+#else /* !RETPOLINES || !CONFIG_STACK_VALIDATION */
+
+void __init_or_module noinline apply_retpolines(s32 *start, s32 *end) { }
+
+#endif /* CONFIG_RETPOLINE && CONFIG_STACK_VALIDATION */
+
 #ifdef CONFIG_SMP
 static void alternatives_smp_lock(const s32 *start, const s32 *end,
 				  u8 *text, u8 *text_end)
@@ -643,6 +770,12 @@ void __init alternative_instructions(void)
 	apply_paravirt(__parainstructions, __parainstructions_end);
 
 	/*
+	 * Rewrite the retpolines, must be done before alternatives since
+	 * those can rewrite the retpoline thunks.
+	 */
+	apply_retpolines(__retpoline_sites, __retpoline_sites_end);
+
+	/*
 	 * Then patch alternatives, such that those paravirt calls that are in
 	 * alternatives can be overwritten by their immediate fragments.
 	 */
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 5e9a34b..169fb6f 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -251,7 +251,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    struct module *me)
 {
 	const Elf_Shdr *s, *text = NULL, *alt = NULL, *locks = NULL,
-		*para = NULL, *orc = NULL, *orc_ip = NULL;
+		*para = NULL, *orc = NULL, *orc_ip = NULL,
+		*retpolines = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
@@ -267,8 +268,14 @@ int module_finalize(const Elf_Ehdr *hdr,
 			orc = s;
 		if (!strcmp(".orc_unwind_ip", secstrings + s->sh_name))
 			orc_ip = s;
+		if (!strcmp(".retpoline_sites", secstrings + s->sh_name))
+			retpolines = s;
 	}
 
+	if (retpolines) {
+		void *rseg = (void *)retpolines->sh_addr;
+		apply_retpolines(rseg, rseg + retpolines->sh_size);
+	}
 	if (alt) {
 		/* patch .altinstructions */
 		void *aseg = (void *)alt->sh_addr;
