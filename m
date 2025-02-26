Return-Path: <linux-tip-commits+bounces-3680-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D811EA45FD0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07A13A5EDC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2883B217718;
	Wed, 26 Feb 2025 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HjTYtDKQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bVp3jLHB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA69913C8EA;
	Wed, 26 Feb 2025 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574480; cv=none; b=V1EqFrf7MFKkynNAXKoKMFRxwfN52KEuSmbduV0yAbXG1Y1YRF8g06vuBcXdbRlm+ckacKQezRtsW8No/Okt0N/e80NRYpeBNtwg75TNFO0r369u1nqfFrMneVhwwAVvgVCRNua8PBEkHHKMFVo0+WnsQe8FIAQouNPyzfZuYz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574480; c=relaxed/simple;
	bh=ejyN6qKks5RUix/Cc2THSuWOh8ayRZjBDXUJJFO+JPk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J+4gbCxCTVh9GjhPGZqqHvx+57TdL+K2VHZWP9zlag86kJy/OLmmYw2FFNRVgzUceAXThmt1B5BdsRdgaLyQVzCtcLP7W5nB/GO1aYCoIj/ZGqlgwM1qLltGUrdDDXELKfPb7uKbNavLQzrvDJsVWWFm/xvxwp9OoiKI5tKND+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HjTYtDKQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bVp3jLHB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:54:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740574476;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9h/1weTW5Iki7lhGCOinbo24lGk4/omWwghPLuw5rK8=;
	b=HjTYtDKQryCau7dDPiFwccn55BD5ccuyAqI+aoany/g70oN/jzsnYhhxkxfIHDTN4unty2
	KRRGTnTRNR//szoAURs4SINNayo5FeeX14KOxA8jFHhAHotqfY5xB2xYRkNRcsr39WDXhy
	AiuzMWFfe4IqBkfprk8JOod38+zOlyRiTXZjFw1gpgcqcUrHDlJz1FdMfpQZh0YkLxHItB
	WfOoEFr0IvCHmuqdRj0NeAYQBiQY6G9Ih3LW/7glY6fp5ONTVojGl+E4b5M1ZCj+CB+WOs
	zK/0BUxiHCiUWd85GD9DzrPUDElgyc7bnCwVGmmJLa4EkPyqKLyHpVD1OwcXyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740574476;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9h/1weTW5Iki7lhGCOinbo24lGk4/omWwghPLuw5rK8=;
	b=bVp3jLHBJPjWl4xq5lFRdoXzXF5dXmCzyK9H66Ce81zLlBDvg7znIXjDKOkTb6tR3POrFE
	9cyxpUWbsSgMCZAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Implement FineIBT-BHI mitigation
Cc: Scott Constable <scott.d.constable@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224124200.820402212@infradead.org>
References: <20250224124200.820402212@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057447519.10177.9447726208823079202.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     0c92385dc05ee9637c04372ea95a11bbf6e010ff
Gitweb:        https://git.kernel.org/tip/0c92385dc05ee9637c04372ea95a11bbf6e010ff
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2025 13:37:12 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 13:49:11 +01:00

x86/ibt: Implement FineIBT-BHI mitigation

While WAIT_FOR_ENDBR is specified to be a full speculation stop; it
has been shown that some implementations are 'leaky' to such an extend
that speculation can escape even the FineIBT preamble.

To deal with this, add additional hardening to the FineIBT preamble.

Notably, using a new LLVM feature:

  https://github.com/llvm/llvm-project/commit/e223485c9b38a5579991b8cebb6a200153eee245

which encodes the number of arguments in the kCFI preamble's register.

Using this register<->arity mapping, have the FineIBT preamble CALL
into a stub clobbering the relevant argument registers in the
speculative case.

Scott sayeth thusly:

Microarchitectural attacks such as Branch History Injection (BHI) and
Intra-mode Branch Target Injection (IMBTI) [1] can cause an indirect
call to mispredict to an adversary-influenced target within the same
hardware domain (e.g., within the kernel). Instructions at the
mispredicted target may execute speculatively and potentially expose
kernel data (e.g., to a user-mode adversary) through a
microarchitectural covert channel such as CPU cache state.

CET-IBT [2] is a coarse-grained control-flow integrity (CFI) ISA
extension that enforces that each indirect call (or indirect jump)
must land on an ENDBR (end branch) instruction, even speculatively*.
FineIBT is a software technique that refines CET-IBT by associating
each function type with a 32-bit hash and enforcing (at the callee)
that the hash of the caller's function pointer type matches the hash
of the callee's function type. However, recent research [3] has
demonstrated that the conditional branch that enforces FineIBT's hash
check can be coerced to mispredict, potentially allowing an adversary
to speculatively bypass the hash check:

__cfi_foo:
  ENDBR64
  SUB R10d, 0x01234567
  JZ foo    # Even if the hash check fails and ZF=0, this branch could still mispredict as taken
  UD2
foo:
  ...

The techniques demonstrated in [3] require the attacker to be able to
control the contents of at least one live register at the mispredicted
target. Therefore, this patch set introduces a sequence of CMOV
instructions at each indirect-callable target that poisons every live
register with data that the attacker cannot control whenever the
FineIBT hash check fails, thus mitigating any potential attack.

The security provided by this scheme has been discussed in detail on
an earlier thread [4].

 [1] https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/branch-history-injection.html
 [2] Intel Software Developer's Manual, Volume 1, Chapter 18
 [3] https://www.vusec.net/projects/native-bhi/
 [4] https://lore.kernel.org/lkml/20240927194925.707462984@infradead.org/
 *There are some caveats for certain processors, see [1] for more info

Suggested-by: Scott Constable <scott.d.constable@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20250224124200.820402212@infradead.org
---
 Makefile                      |   3 +-
 arch/x86/Kconfig              |   8 ++-
 arch/x86/include/asm/cfi.h    |   6 ++-
 arch/x86/kernel/alternative.c | 107 +++++++++++++++++++++++++++++----
 arch/x86/net/bpf_jit_comp.c   |  29 ++++++---
 5 files changed, 134 insertions(+), 19 deletions(-)

diff --git a/Makefile b/Makefile
index 96407c1..f19431f 100644
--- a/Makefile
+++ b/Makefile
@@ -1014,6 +1014,9 @@ CC_FLAGS_CFI	:= -fsanitize=kcfi
 ifdef CONFIG_CFI_ICALL_NORMALIZE_INTEGERS
 	CC_FLAGS_CFI	+= -fsanitize-cfi-icall-experimental-normalize-integers
 endif
+ifdef CONFIG_FINEIBT_BHI
+	CC_FLAGS_CFI	+= -fsanitize-kcfi-arity
+endif
 ifdef CONFIG_RUST
 	# Always pass -Zsanitizer-cfi-normalize-integers as CONFIG_RUST selects
 	# CONFIG_CFI_ICALL_NORMALIZE_INTEGERS.
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c4175f4..5c27726 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2473,6 +2473,10 @@ config CC_HAS_RETURN_THUNK
 config CC_HAS_ENTRY_PADDING
 	def_bool $(cc-option,-fpatchable-function-entry=16,16)
 
+config CC_HAS_KCFI_ARITY
+	def_bool $(cc-option,-fsanitize=kcfi -fsanitize-kcfi-arity)
+	depends on CC_IS_CLANG && !RUST
+
 config FUNCTION_PADDING_CFI
 	int
 	default 59 if FUNCTION_ALIGNMENT_64B
@@ -2498,6 +2502,10 @@ config FINEIBT
 	depends on X86_KERNEL_IBT && CFI_CLANG && MITIGATION_RETPOLINE
 	select CALL_PADDING
 
+config FINEIBT_BHI
+	def_bool y
+	depends on FINEIBT && CC_HAS_KCFI_ARITY
+
 config HAVE_CALL_THUNKS
 	def_bool y
 	depends on CC_HAS_ENTRY_PADDING && MITIGATION_RETHUNK && OBJTOOL
diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 7c15c4b..2f6a01f 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -100,6 +100,7 @@ enum cfi_mode {
 };
 
 extern enum cfi_mode cfi_mode;
+extern bool cfi_bhi;
 
 typedef u8 bhi_thunk[32];
 extern bhi_thunk __bhi_args[];
@@ -129,6 +130,7 @@ static inline int cfi_get_offset(void)
 #define cfi_get_offset cfi_get_offset
 
 extern u32 cfi_get_func_hash(void *func);
+extern int cfi_get_func_arity(void *func);
 
 #ifdef CONFIG_FINEIBT
 extern bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type);
@@ -152,6 +154,10 @@ static inline u32 cfi_get_func_hash(void *func)
 {
 	return 0;
 }
+static inline int cfi_get_func_arity(void *func)
+{
+	return 0;
+}
 #endif /* CONFIG_CFI_CLANG */
 
 #if HAS_KERNEL_IBT == 1
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index c698c9e..b8d65d5 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -936,6 +936,7 @@ void __init_or_module apply_seal_endbr(s32 *start, s32 *end) { }
 #endif
 
 enum cfi_mode cfi_mode __ro_after_init = __CFI_DEFAULT;
+bool cfi_bhi __ro_after_init = false;
 
 #ifdef CONFIG_CFI_CLANG
 struct bpf_insn;
@@ -996,6 +997,21 @@ u32 cfi_get_func_hash(void *func)
 
 	return hash;
 }
+
+int cfi_get_func_arity(void *func)
+{
+	bhi_thunk *target;
+	s32 disp;
+
+	if (cfi_mode != CFI_FINEIBT && !cfi_bhi)
+		return 0;
+
+	if (get_kernel_nofault(disp, func - 4))
+		return 0;
+
+	target = func + disp;
+	return target - __bhi_args;
+}
 #endif
 
 #ifdef CONFIG_FINEIBT
@@ -1053,6 +1069,12 @@ static __init int cfi_parse_cmdline(char *str)
 			} else {
 				pr_err("Ignoring paranoid; depends on fineibt.\n");
 			}
+		} else if (!strcmp(str, "bhi")) {
+			if (cfi_mode == CFI_FINEIBT) {
+				cfi_bhi = true;
+			} else {
+				pr_err("Ignoring bhi; depends on fineibt.\n");
+			}
 		} else {
 			pr_err("Ignoring unknown cfi option (%s).", str);
 		}
@@ -1105,6 +1127,7 @@ asm(	".pushsection .rodata				\n"
 	"fineibt_preamble_start:			\n"
 	"	endbr64					\n"
 	"	subl	$0x12345678, %r10d		\n"
+	"fineibt_preamble_bhi:				\n"
 	"	jne	fineibt_preamble_start+6	\n"
 	ASM_NOP3
 	"fineibt_preamble_end:				\n"
@@ -1112,9 +1135,11 @@ asm(	".pushsection .rodata				\n"
 );
 
 extern u8 fineibt_preamble_start[];
+extern u8 fineibt_preamble_bhi[];
 extern u8 fineibt_preamble_end[];
 
 #define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_start)
+#define fineibt_preamble_bhi  (fineibt_preamble_bhi - fineibt_preamble_start)
 #define fineibt_preamble_ud   6
 #define fineibt_preamble_hash 7
 
@@ -1187,13 +1212,16 @@ extern u8 fineibt_paranoid_end[];
 #define fineibt_paranoid_ind  (fineibt_paranoid_ind - fineibt_paranoid_start)
 #define fineibt_paranoid_ud   0xd
 
-static u32 decode_preamble_hash(void *addr)
+static u32 decode_preamble_hash(void *addr, int *reg)
 {
 	u8 *p = addr;
 
-	/* b8 78 56 34 12          mov    $0x12345678,%eax */
-	if (p[0] == 0xb8)
+	/* b8+reg 78 56 34 12          movl    $0x12345678,\reg */
+	if (p[0] >= 0xb8 && p[0] < 0xc0) {
+		if (reg)
+			*reg = p[0] - 0xb8;
 		return *(u32 *)(addr + 1);
+	}
 
 	return 0; /* invalid hash value */
 }
@@ -1202,11 +1230,11 @@ static u32 decode_caller_hash(void *addr)
 {
 	u8 *p = addr;
 
-	/* 41 ba 78 56 34 12       mov    $0x12345678,%r10d */
+	/* 41 ba 88 a9 cb ed       mov    $(-0x12345678),%r10d */
 	if (p[0] == 0x41 && p[1] == 0xba)
 		return -*(u32 *)(addr + 2);
 
-	/* e8 0c 78 56 34 12	   jmp.d8  +12 */
+	/* e8 0c 88 a9 cb ed	   jmp.d8  +12 */
 	if (p[0] == JMP8_INSN_OPCODE && p[1] == fineibt_caller_jmp)
 		return -*(u32 *)(addr + 2);
 
@@ -1271,7 +1299,7 @@ static int cfi_rand_preamble(s32 *start, s32 *end)
 		void *addr = (void *)s + *s;
 		u32 hash;
 
-		hash = decode_preamble_hash(addr);
+		hash = decode_preamble_hash(addr, NULL);
 		if (WARN(!hash, "no CFI hash found at: %pS %px %*ph\n",
 			 addr, addr, 5, addr))
 			return -EINVAL;
@@ -1289,6 +1317,7 @@ static int cfi_rewrite_preamble(s32 *start, s32 *end)
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
+		int arity;
 		u32 hash;
 
 		/*
@@ -1299,7 +1328,7 @@ static int cfi_rewrite_preamble(s32 *start, s32 *end)
 		if (!is_endbr(addr + 16))
 			continue;
 
-		hash = decode_preamble_hash(addr);
+		hash = decode_preamble_hash(addr, &arity);
 		if (WARN(!hash, "no CFI hash found at: %pS %px %*ph\n",
 			 addr, addr, 5, addr))
 			return -EINVAL;
@@ -1307,6 +1336,19 @@ static int cfi_rewrite_preamble(s32 *start, s32 *end)
 		text_poke_early(addr, fineibt_preamble_start, fineibt_preamble_size);
 		WARN_ON(*(u32 *)(addr + fineibt_preamble_hash) != 0x12345678);
 		text_poke_early(addr + fineibt_preamble_hash, &hash, 4);
+
+		WARN_ONCE(!IS_ENABLED(CONFIG_FINEIBT_BHI) && arity,
+			  "kCFI preamble has wrong register at: %pS %*ph\n",
+			  addr, 5, addr);
+
+		if (!cfi_bhi || !arity)
+			continue;
+
+		text_poke_early(addr + fineibt_preamble_bhi,
+				text_gen_insn(CALL_INSN_OPCODE,
+					      addr + fineibt_preamble_bhi,
+					      __bhi_args[arity]),
+				CALL_INSN_SIZE);
 	}
 
 	return 0;
@@ -1474,8 +1516,9 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 		cfi_rewrite_endbr(start_cfi, end_cfi);
 
 		if (builtin) {
-			pr_info("Using %sFineIBT CFI\n",
-				cfi_paranoid ? "paranoid " : "");
+			pr_info("Using %sFineIBT%s CFI\n",
+				cfi_paranoid ? "paranoid " : "",
+				cfi_bhi ? "+BHI" : "");
 		}
 		return;
 
@@ -1526,7 +1569,7 @@ static void poison_cfi(void *addr)
 		/*
 		 * kCFI prefix should start with a valid hash.
 		 */
-		if (!decode_preamble_hash(addr))
+		if (!decode_preamble_hash(addr, NULL))
 			break;
 
 		/*
@@ -1575,6 +1618,47 @@ Efault:
 }
 
 /*
+ * regs->ip points to one of the UD2 in __bhi_args[].
+ */
+static bool decode_fineibt_bhi(struct pt_regs *regs, unsigned long *target, u32 *type)
+{
+	unsigned long addr;
+	u32 hash;
+
+	if (!cfi_bhi)
+		return false;
+
+	if (regs->ip < (unsigned long)__bhi_args ||
+	    regs->ip >= (unsigned long)__bhi_args_end)
+		return false;
+
+	/*
+	 * Fetch the return address from the stack, this points to the
+	 * FineIBT preamble. Since the CALL instruction is in the 5 last
+	 * bytes of the preamble, the return address is in fact the target
+	 * address.
+	 */
+	__get_kernel_nofault(&addr, regs->sp, unsigned long, Efault);
+	*target = addr;
+
+	addr -= fineibt_preamble_size;
+	if (!exact_endbr((void *)addr))
+		return false;
+
+	__get_kernel_nofault(&hash, addr + fineibt_preamble_hash, u32, Efault);
+	*type = (u32)regs->r10 + hash;
+
+	/*
+	 * The UD2 sites are constructed with a RET immediately following,
+	 * as such the non-fatal case can use the regular fixup.
+	 */
+	return true;
+
+Efault:
+	return false;
+}
+
+/*
  * regs->ip points to a LOCK Jcc.d8 instruction from the fineibt_paranoid_start[]
  * sequence.
  */
@@ -1605,6 +1689,9 @@ bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
 	if (decode_fineibt_paranoid(regs, target, type))
 		return true;
 
+	if (decode_fineibt_bhi(regs, target, type))
+		return true;
+
 	return decode_fineibt_preamble(regs, target, type);
 }
 
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ce033e6..72776dc 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -410,15 +410,20 @@ static void emit_nops(u8 **pprog, int len)
  * Emit the various CFI preambles, see asm/cfi.h and the comments about FineIBT
  * in arch/x86/kernel/alternative.c
  */
+static int emit_call(u8 **prog, void *func, void *ip);
 
-static void emit_fineibt(u8 **pprog, u32 hash)
+static void emit_fineibt(u8 **pprog, u8 *ip, u32 hash, int arity)
 {
 	u8 *prog = *pprog;
 
 	EMIT_ENDBR();
 	EMIT3_off32(0x41, 0x81, 0xea, hash);		/* subl $hash, %r10d	*/
-	EMIT2(0x75, 0xf9);				/* jne.d8 .-7		*/
-	EMIT3(0x0f, 0x1f, 0x00);			/* nop3			*/
+	if (cfi_bhi) {
+		emit_call(&prog, __bhi_args[arity], ip + 11);
+	} else {
+		EMIT2(0x75, 0xf9);			/* jne.d8 .-7		*/
+		EMIT3(0x0f, 0x1f, 0x00);		/* nop3			*/
+	}
 	EMIT_ENDBR_POISON();
 
 	*pprog = prog;
@@ -447,13 +452,13 @@ static void emit_kcfi(u8 **pprog, u32 hash)
 	*pprog = prog;
 }
 
-static void emit_cfi(u8 **pprog, u32 hash)
+static void emit_cfi(u8 **pprog, u8 *ip, u32 hash, int arity)
 {
 	u8 *prog = *pprog;
 
 	switch (cfi_mode) {
 	case CFI_FINEIBT:
-		emit_fineibt(&prog, hash);
+		emit_fineibt(&prog, ip, hash, arity);
 		break;
 
 	case CFI_KCFI:
@@ -504,13 +509,17 @@ static void emit_prologue_tail_call(u8 **pprog, bool is_subprog)
  * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
  * while jumping to another program
  */
-static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
+static void emit_prologue(u8 **pprog, u8 *ip, u32 stack_depth, bool ebpf_from_cbpf,
 			  bool tail_call_reachable, bool is_subprog,
 			  bool is_exception_cb)
 {
 	u8 *prog = *pprog;
 
-	emit_cfi(&prog, is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash);
+	if (is_subprog) {
+		emit_cfi(&prog, ip, cfi_bpf_subprog_hash, 5);
+	} else {
+		emit_cfi(&prog, ip, cfi_bpf_hash, 1);
+	}
 	/* BPF trampoline can be made to work without these nops,
 	 * but let's waste 5 bytes for now and optimize later
 	 */
@@ -1479,7 +1488,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 
 	detect_reg_usage(insn, insn_cnt, callee_regs_used);
 
-	emit_prologue(&prog, stack_depth,
+	emit_prologue(&prog, image, stack_depth,
 		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
 		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
 	/* Exception callback will clobber callee regs for its own use, and
@@ -3046,7 +3055,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		/*
 		 * Indirect call for bpf_struct_ops
 		 */
-		emit_cfi(&prog, cfi_get_func_hash(func_addr));
+		emit_cfi(&prog, image,
+			 cfi_get_func_hash(func_addr),
+			 cfi_get_func_arity(func_addr));
 	} else {
 		/*
 		 * Direct-call fentry stub, as such it needs accounting for the

