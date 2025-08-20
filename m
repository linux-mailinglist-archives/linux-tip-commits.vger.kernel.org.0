Return-Path: <linux-tip-commits+bounces-6286-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE0EB2D924
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 11:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F28F1C81E3D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 09:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6962E2667;
	Wed, 20 Aug 2025 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l0QRTfqg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="woKPzR9Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31812E22BB;
	Wed, 20 Aug 2025 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682750; cv=none; b=W3RjhxIjei5WJPCNcnTF2kOjHHDpghVe4RYtjhW60ae+EtFSdmPjPvsE3PPd/0uqKOTkx9NIILIP7N3bLOr9BsY/5Ta+rozzmscDXdO7jpMBYCnjK+Y1lrfxnv222Q09ArTO6utADetVJSHCEcF+elLsqI3yucvljJCBwM4Z/zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682750; c=relaxed/simple;
	bh=fWzpzrzhDtBDZHqD8tUXXrEpvYDcKx/lDccUfecWm6Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HBsBrEMoqChweHx11icbbKUkkxUDegHJNhM2eZbsOVqYILl64+Km8Z6TIxZmLnVju6nz3Y3ZNe2OadoAwR/YR0NYWyizwcs5PuNKitbO9LNwpSdMyvH/vry2vqXoe1Ntr+ic3ZJHeyU4KHgkWj65h1bEdk6nwVPxlOe/8Ne+nPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l0QRTfqg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=woKPzR9Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 09:39:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755682745;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w29dChitJ3Rbr4QSJXLkRMpLlwJxcrFbkuJA3UgbiVg=;
	b=l0QRTfqg5syHR7U5jRRssEjSNd7PdFzHzt65Nr3viyd/ByLv0m5J3zX+7Ra/wO9urXZYlD
	S9ztDj1TLrmpcXM+xbfWaXbjPGIg5esjf/ZersdN5hrl71UNm1hEMHYOkvYRNmremAQkW7
	qb1lz/UFTiahSIDNJ6nqlRkZVDwrdiLSXnFcBpEoQXNhwCOcClqPGw6jhMpJJLNZ1KjzjK
	cECYowBHGYZt/FusaoQP0o8mMGsewAAHOykdo9q9uJLBor2nxT5eMm34iR4hijUhNPUJXW
	+FGP/T94KAIWmfhmIv8cCT4bvW9eVV3iJt9Ft2b80gidk5EeLdKsGcD7N6HcDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755682745;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w29dChitJ3Rbr4QSJXLkRMpLlwJxcrFbkuJA3UgbiVg=;
	b=woKPzR9YZ2VLyxckqZu9viHeomy3ffWIW68CJrBWfSYORSKUXYp7PtyXy6OmhaDcx13cH8
	VnqMY9aLynrJcWCA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Validate kCFI calls
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Sean Christopherson <seanjc@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250714103441.496787279@infradead.org>
References: <20250714103441.496787279@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175568274311.1420.7251101635125319598.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     894af4a1cde61c3401f237184fb770f72ff12df8
Gitweb:        https://git.kernel.org/tip/894af4a1cde61c3401f237184fb770f72ff=
12df8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 12 Apr 2025 13:56:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 18 Aug 2025 14:23:09 +02:00

objtool: Validate kCFI calls

Validate that all indirect calls adhere to kCFI rules. Notably doing
nocfi indirect call to a cfi function is broken.

Apparently some Rust 'core' code violates this and explodes when ran
with FineIBT.

All the ANNOTATE_NOCFI_SYM sites are prime targets for attackers.

 - runtime EFI is especially henous because it also needs to disable
   IBT. Basically calling unknown code without CFI protection at
   runtime is a massice security issue.

 - Kexec image handover; if you can exploit this, you get to keep it :-)

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lkml.kernel.org/r/20250714103441.496787279@infradead.org
---
 arch/x86/kernel/machine_kexec_64.c  |  4 +++-
 arch/x86/kvm/vmx/vmenter.S          |  4 +++-
 arch/x86/platform/efi/efi_stub_64.S |  4 +++-
 drivers/misc/lkdtm/perms.c          |  5 +++-
 include/linux/objtool.h             | 10 +++++++-
 include/linux/objtool_types.h       |  1 +-
 tools/include/linux/objtool_types.h |  1 +-
 tools/objtool/check.c               | 42 ++++++++++++++++++++++++++++-
 tools/objtool/include/objtool/elf.h |  1 +-
 9 files changed, 72 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kex=
ec_64.c
index 697fb99..8593760 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -453,6 +453,10 @@ void __nocfi machine_kexec(struct kimage *image)
=20
 	__ftrace_enabled_restore(save_ftrace_enabled);
 }
+/*
+ * Handover to the next kernel, no CFI concern.
+ */
+ANNOTATE_NOCFI_SYM(machine_kexec);
=20
 /* arch-dependent functionality related to kexec file-based syscall */
=20
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 0a6cf5b..bc255d7 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -361,6 +361,10 @@ SYM_FUNC_END(vmread_error_trampoline)
=20
 .section .text, "ax"
=20
+#ifndef CONFIG_X86_FRED
+
 SYM_FUNC_START(vmx_do_interrupt_irqoff)
 	VMX_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
 SYM_FUNC_END(vmx_do_interrupt_irqoff)
+
+#endif
diff --git a/arch/x86/platform/efi/efi_stub_64.S b/arch/x86/platform/efi/efi_=
stub_64.S
index 2206b8b..f0a5fba 100644
--- a/arch/x86/platform/efi/efi_stub_64.S
+++ b/arch/x86/platform/efi/efi_stub_64.S
@@ -11,6 +11,10 @@
 #include <asm/nospec-branch.h>
=20
 SYM_FUNC_START(__efi_call)
+	/*
+	 * The EFI code doesn't have any CFI, annotate away the CFI violation.
+	 */
+	ANNOTATE_NOCFI_SYM
 	pushq %rbp
 	movq %rsp, %rbp
 	and $~0xf, %rsp
diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 6c24426..e1f5e9a 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -9,6 +9,7 @@
 #include <linux/vmalloc.h>
 #include <linux/mman.h>
 #include <linux/uaccess.h>
+#include <linux/objtool.h>
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
=20
@@ -86,6 +87,10 @@ static noinline __nocfi void execute_location(void *dst, b=
ool write)
 	func();
 	pr_err("FAIL: func returned\n");
 }
+/*
+ * Explicitly doing the wrong thing for testing.
+ */
+ANNOTATE_NOCFI_SYM(execute_location);
=20
 static void execute_user_location(void *dst)
 {
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 366ad00..46ebaa4 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -184,6 +184,15 @@
  * WARN using UD2.
  */
 #define ANNOTATE_REACHABLE(label)	__ASM_ANNOTATE(label, ANNOTYPE_REACHABLE)
+/*
+ * This should not be used; it annotates away CFI violations. There are a few
+ * valid use cases like kexec handover to the next kernel image, and there is
+ * no security concern there.
+ *
+ * There are also a few real issues annotated away, like EFI because we can't
+ * control the EFI code.
+ */
+#define ANNOTATE_NOCFI_SYM(sym)		asm(__ASM_ANNOTATE(sym, ANNOTYPE_NOCFI))
=20
 #else
 #define ANNOTATE_NOENDBR		ANNOTATE type=3DANNOTYPE_NOENDBR
@@ -194,6 +203,7 @@
 #define ANNOTATE_INTRA_FUNCTION_CALL	ANNOTATE type=3DANNOTYPE_INTRA_FUNCTION=
_CALL
 #define ANNOTATE_UNRET_BEGIN		ANNOTATE type=3DANNOTYPE_UNRET_BEGIN
 #define ANNOTATE_REACHABLE		ANNOTATE type=3DANNOTYPE_REACHABLE
+#define ANNOTATE_NOCFI_SYM		ANNOTATE type=3DANNOTYPE_NOCFI
 #endif
=20
 #if defined(CONFIG_NOINSTR_VALIDATION) && \
diff --git a/include/linux/objtool_types.h b/include/linux/objtool_types.h
index df5d9fa..aceac94 100644
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -65,5 +65,6 @@ struct unwind_hint {
 #define ANNOTYPE_IGNORE_ALTS		6
 #define ANNOTYPE_INTRA_FUNCTION_CALL	7
 #define ANNOTYPE_REACHABLE		8
+#define ANNOTYPE_NOCFI			9
=20
 #endif /* _LINUX_OBJTOOL_TYPES_H */
diff --git a/tools/include/linux/objtool_types.h b/tools/include/linux/objtoo=
l_types.h
index df5d9fa..aceac94 100644
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -65,5 +65,6 @@ struct unwind_hint {
 #define ANNOTYPE_IGNORE_ALTS		6
 #define ANNOTYPE_INTRA_FUNCTION_CALL	7
 #define ANNOTYPE_REACHABLE		8
+#define ANNOTYPE_NOCFI			9
=20
 #endif /* _LINUX_OBJTOOL_TYPES_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d14f20e..79eab61 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2392,6 +2392,8 @@ static int __annotate_ifc(struct objtool_file *file, in=
t type, struct instructio
=20
 static int __annotate_late(struct objtool_file *file, int type, struct instr=
uction *insn)
 {
+	struct symbol *sym;
+
 	switch (type) {
 	case ANNOTYPE_NOENDBR:
 		/* early */
@@ -2433,6 +2435,15 @@ static int __annotate_late(struct objtool_file *file, =
int type, struct instructi
 		insn->dead_end =3D false;
 		break;
=20
+	case ANNOTYPE_NOCFI:
+		sym =3D insn->sym;
+		if (!sym) {
+			ERROR_INSN(insn, "dodgy NOCFI annotation");
+			return -1;
+		}
+		insn->sym->nocfi =3D 1;
+		break;
+
 	default:
 		ERROR_INSN(insn, "Unknown annotation type: %d", type);
 		return -1;
@@ -4002,6 +4013,37 @@ static int validate_retpoline(struct objtool_file *fil=
e)
 		warnings++;
 	}
=20
+	if (!opts.cfi)
+		return warnings;
+
+	/*
+	 * kCFI call sites look like:
+	 *
+	 *     movl $(-0x12345678), %r10d
+	 *     addl -4(%r11), %r10d
+	 *     jz 1f
+	 *     ud2
+	 *  1: cs call __x86_indirect_thunk_r11
+	 *
+	 * Verify all indirect calls are kCFI adorned by checking for the
+	 * UD2. Notably, doing __nocfi calls to regular (cfi) functions is
+	 * broken.
+	 */
+	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
+		struct symbol *sym =3D insn->sym;
+
+		if (sym && (sym->type =3D=3D STT_NOTYPE ||
+			    sym->type =3D=3D STT_FUNC) && !sym->nocfi) {
+			struct instruction *prev =3D
+				prev_insn_same_sym(file, insn);
+
+			if (!prev || prev->type !=3D INSN_BUG) {
+				WARN_INSN(insn, "no-cfi indirect call!");
+				warnings++;
+			}
+		}
+	}
+
 	return warnings;
 }
=20
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index 0a2fa3a..df8434d 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -70,6 +70,7 @@ struct symbol {
 	u8 local_label       : 1;
 	u8 frame_pointer     : 1;
 	u8 ignore	     : 1;
+	u8 nocfi             : 1;
 	struct list_head pv_target;
 	struct reloc *relocs;
 	struct section *group_sec;

