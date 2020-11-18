Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34F82B8307
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgKRRTR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:19:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56242 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbgKRRSY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:24 -0500
Date:   Wed, 18 Nov 2020 17:18:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mjXLzESJxTHiTUDJr6T4Ge6mdPBydRyMO+K5wFUHbFM=;
        b=bviEZV/ER3wQOPyRb9b2CZyso1BIDJR0abQDOvBrd7DJg4yaTzzrgJkYsBDJtdGlwj4hxs
        WsAkECiTKTooC5sat5sbrQo77ECp7AM/LgOaw0P1d4UTZ+sPh1tURZcXz6Rzxz/nOqNBZ6
        yc5rYBU5i9AnHhBlFJVta6y5iN7Qu4anFQY/VkiCtoyZMf5zJ4+O5zSkUL8aOd+BXhC/kq
        5lRghxzFqtMuERLsKRXQLmKX9Tt8+Idbj6FFK2IthVsbKS2Zi8NDgg+EXP2xFq3Y4yMmqk
        2nsUpj+HKUpryTyGJZpmSoHQK+8xF2P+YJNBRvAFhY7FWsabBSPCD/k1aS3SQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mjXLzESJxTHiTUDJr6T4Ge6mdPBydRyMO+K5wFUHbFM=;
        b=q6TKQdU5tUbaW/Z+wCMOrUD+IjYj4D4UTIMqLn16nft+/76BCIGgPZjl0H6t77aBFZiuOJ
        qS3JwaDWBLUz9OAw==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/vdso: Add support for exception fixup in vDSO functions
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112220135.165028-17-jarkko@kernel.org>
References: <20201112220135.165028-17-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <160571990110.11244.1048088437021042520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     8382c668ce4f367d902f4a340a1bfa9e46096ec1
Gitweb:        https://git.kernel.org/tip/8382c668ce4f367d902f4a340a1bfa9e460=
96ec1
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 13 Nov 2020 00:01:27 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Nov 2020 18:02:50 +01:00

x86/vdso: Add support for exception fixup in vDSO functions

Signals are a horrid little mechanism.  They are especially nasty in
multi-threaded environments because signal state like handlers is global
across the entire process.  But, signals are basically the only way that
userspace can =E2=80=9Cgracefully=E2=80=9D handle and recover from exceptions.

The kernel generally does not like exceptions to occur during execution.
But, exceptions are a fact of life and must be handled in some
circumstances.  The kernel handles them by keeping a list of individual
instructions which may cause exceptions.  Instead of truly handling the
exception and returning to the instruction that caused it, the kernel
instead restarts execution at a *different* instruction.  This makes it
obvious to that thread of execution that the exception occurred and lets
*that* code handle the exception instead of the handler.

This is not dissimilar to the try/catch exceptions mechanisms that some
programming languages have, but applied *very* surgically to single
instructions.  It effectively changes the visible architecture of the
instruction.

Problem
=3D=3D=3D=3D=3D=3D=3D

SGX generates a lot of signals, and the code to enter and exit enclaves and
muck with signal handling is truly horrid.  At the same time, an approach
like kernel exception fixup can not be easily applied to userspace
instructions because it changes the visible instruction architecture.

Solution
=3D=3D=3D=3D=3D=3D=3D=3D

The vDSO is a special page of kernel-provided instructions that run in
userspace.  Any userspace calling into the vDSO knows that it is special.
This allows the kernel a place to legitimately rewrite the user/kernel
contract and change instruction behavior.

Add support for fixing up exceptions that occur while executing in the
vDSO.  This replaces what could traditionally only be done with signal
handling.

This new mechanism will be used to replace previously direct use of SGX
instructions by userspace.

Just introduce the vDSO infrastructure.  Later patches will actually
replace signal generation with vDSO exception fixup.

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Jethro Beekman <jethro@fortanix.com>
Link: https://lkml.kernel.org/r/20201112220135.165028-17-jarkko@kernel.org
---
 arch/x86/entry/vdso/Makefile          |  6 +--
 arch/x86/entry/vdso/extable.c         | 46 ++++++++++++++++++++++++-
 arch/x86/entry/vdso/extable.h         | 28 +++++++++++++++-
 arch/x86/entry/vdso/vdso-layout.lds.S |  9 ++++-
 arch/x86/entry/vdso/vdso2c.h          | 50 +++++++++++++++++++++++++-
 arch/x86/include/asm/vdso.h           |  5 +++-
 6 files changed, 139 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/entry/vdso/extable.c
 create mode 100644 arch/x86/entry/vdso/extable.h

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 2124374..2ad757f 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -29,7 +29,7 @@ vobjs32-y :=3D vdso32/note.o vdso32/system_call.o vdso32/si=
greturn.o
 vobjs32-y +=3D vdso32/vclock_gettime.o
=20
 # files to link into kernel
-obj-y				+=3D vma.o
+obj-y				+=3D vma.o extable.o
 KASAN_SANITIZE_vma.o		:=3D y
 UBSAN_SANITIZE_vma.o		:=3D y
 KCSAN_SANITIZE_vma.o		:=3D y
@@ -128,8 +128,8 @@ $(obj)/%-x32.o: $(obj)/%.o FORCE
=20
 targets +=3D vdsox32.lds $(vobjx32s-y)
=20
-$(obj)/%.so: OBJCOPYFLAGS :=3D -S
-$(obj)/%.so: $(obj)/%.so.dbg FORCE
+$(obj)/%.so: OBJCOPYFLAGS :=3D -S --remove-section __ex_table
+$(obj)/%.so: $(obj)/%.so.dbg
 	$(call if_changed,objcopy)
=20
 $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
diff --git a/arch/x86/entry/vdso/extable.c b/arch/x86/entry/vdso/extable.c
new file mode 100644
index 0000000..afcf5b6
--- /dev/null
+++ b/arch/x86/entry/vdso/extable.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/err.h>
+#include <linux/mm.h>
+#include <asm/current.h>
+#include <asm/traps.h>
+#include <asm/vdso.h>
+
+struct vdso_exception_table_entry {
+	int insn, fixup;
+};
+
+bool fixup_vdso_exception(struct pt_regs *regs, int trapnr,
+			  unsigned long error_code, unsigned long fault_addr)
+{
+	const struct vdso_image *image =3D current->mm->context.vdso_image;
+	const struct vdso_exception_table_entry *extable;
+	unsigned int nr_entries, i;
+	unsigned long base;
+
+	/*
+	 * Do not attempt to fixup #DB or #BP.  It's impossible to identify
+	 * whether or not a #DB/#BP originated from within an SGX enclave and
+	 * SGX enclaves are currently the only use case for vDSO fixup.
+	 */
+	if (trapnr =3D=3D X86_TRAP_DB || trapnr =3D=3D X86_TRAP_BP)
+		return false;
+
+	if (!current->mm->context.vdso)
+		return false;
+
+	base =3D  (unsigned long)current->mm->context.vdso + image->extable_base;
+	nr_entries =3D image->extable_len / (sizeof(*extable));
+	extable =3D image->extable;
+
+	for (i =3D 0; i < nr_entries; i++) {
+		if (regs->ip =3D=3D base + extable[i].insn) {
+			regs->ip =3D base + extable[i].fixup;
+			regs->di =3D trapnr;
+			regs->si =3D error_code;
+			regs->dx =3D fault_addr;
+			return true;
+		}
+	}
+
+	return false;
+}
diff --git a/arch/x86/entry/vdso/extable.h b/arch/x86/entry/vdso/extable.h
new file mode 100644
index 0000000..b56f6b0
--- /dev/null
+++ b/arch/x86/entry/vdso/extable.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_EXTABLE_H
+#define __VDSO_EXTABLE_H
+
+/*
+ * Inject exception fixup for vDSO code.  Unlike normal exception fixup,
+ * vDSO uses a dedicated handler the addresses are relative to the overall
+ * exception table, not each individual entry.
+ */
+#ifdef __ASSEMBLY__
+#define _ASM_VDSO_EXTABLE_HANDLE(from, to)	\
+	ASM_VDSO_EXTABLE_HANDLE from to
+
+.macro ASM_VDSO_EXTABLE_HANDLE from:req to:req
+	.pushsection __ex_table, "a"
+	.long (\from) - __ex_table
+	.long (\to) - __ex_table
+	.popsection
+.endm
+#else
+#define _ASM_VDSO_EXTABLE_HANDLE(from, to)	\
+	".pushsection __ex_table, \"a\"\n"      \
+	".long (" #from ") - __ex_table\n"      \
+	".long (" #to ") - __ex_table\n"        \
+	".popsection\n"
+#endif
+
+#endif /* __VDSO_EXTABLE_H */
diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso=
-layout.lds.S
index 4d15293..dc8da76 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -75,11 +75,18 @@ SECTIONS
 	 * stuff that isn't used at runtime in between.
 	 */
=20
-	.text		: { *(.text*) }			:text	=3D0x90909090,
+	.text		: {
+		*(.text*)
+		*(.fixup)
+	}						:text	=3D0x90909090,
+
+
=20
 	.altinstructions	: { *(.altinstructions) }	:text
 	.altinstr_replacement	: { *(.altinstr_replacement) }	:text
=20
+	__ex_table		: { *(__ex_table) }		:text
+
 	/DISCARD/ : {
 		*(.discard)
 		*(.discard.*)
diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 6f46e11..1c7cfac 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -5,6 +5,41 @@
  * are built for 32-bit userspace.
  */
=20
+static void BITSFUNC(copy)(FILE *outfile, const unsigned char *data, size_t =
len)
+{
+	size_t i;
+
+	for (i =3D 0; i < len; i++) {
+		if (i % 10 =3D=3D 0)
+			fprintf(outfile, "\n\t");
+		fprintf(outfile, "0x%02X, ", (int)(data)[i]);
+	}
+}
+
+
+/*
+ * Extract a section from the input data into a standalone blob.  Used to
+ * capture kernel-only data that needs to persist indefinitely, e.g. the
+ * exception fixup tables, but only in the kernel, i.e. the section can
+ * be stripped from the final vDSO image.
+ */
+static void BITSFUNC(extract)(const unsigned char *data, size_t data_len,
+			      FILE *outfile, ELF(Shdr) *sec, const char *name)
+{
+	unsigned long offset;
+	size_t len;
+
+	offset =3D (unsigned long)GET_LE(&sec->sh_offset);
+	len =3D (size_t)GET_LE(&sec->sh_size);
+
+	if (offset + len > data_len)
+		fail("section to extract overruns input data");
+
+	fprintf(outfile, "static const unsigned char %s[%lu] =3D {", name, len);
+	BITSFUNC(copy)(outfile, data + offset, len);
+	fprintf(outfile, "\n};\n\n");
+}
+
 static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 			 void *stripped_addr, size_t stripped_len,
 			 FILE *outfile, const char *image_name)
@@ -15,7 +50,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	ELF(Ehdr) *hdr =3D (ELF(Ehdr) *)raw_addr;
 	unsigned long i, syms_nr;
 	ELF(Shdr) *symtab_hdr =3D NULL, *strtab_hdr, *secstrings_hdr,
-		*alt_sec =3D NULL;
+		*alt_sec =3D NULL, *extable_sec =3D NULL;
 	ELF(Dyn) *dyn =3D 0, *dyn_end =3D 0;
 	const char *secstrings;
 	INT_BITS syms[NSYMS] =3D {};
@@ -77,6 +112,8 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		if (!strcmp(secstrings + GET_LE(&sh->sh_name),
 			    ".altinstructions"))
 			alt_sec =3D sh;
+		if (!strcmp(secstrings + GET_LE(&sh->sh_name), "__ex_table"))
+			extable_sec =3D sh;
 	}
=20
 	if (!symtab_hdr)
@@ -155,6 +192,9 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 			(int)((unsigned char *)stripped_addr)[i]);
 	}
 	fprintf(outfile, "\n};\n\n");
+	if (extable_sec)
+		BITSFUNC(extract)(raw_addr, raw_len, outfile,
+				  extable_sec, "extable");
=20
 	fprintf(outfile, "const struct vdso_image %s =3D {\n", image_name);
 	fprintf(outfile, "\t.data =3D raw_data,\n");
@@ -165,6 +205,14 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		fprintf(outfile, "\t.alt_len =3D %lu,\n",
 			(unsigned long)GET_LE(&alt_sec->sh_size));
 	}
+	if (extable_sec) {
+		fprintf(outfile, "\t.extable_base =3D %lu,\n",
+			(unsigned long)GET_LE(&extable_sec->sh_offset));
+		fprintf(outfile, "\t.extable_len =3D %lu,\n",
+			(unsigned long)GET_LE(&extable_sec->sh_size));
+		fprintf(outfile, "\t.extable =3D extable,\n");
+	}
+
 	for (i =3D 0; i < NSYMS; i++) {
 		if (required_syms[i].export && syms[i])
 			fprintf(outfile, "\t.sym_%s =3D %" PRIi64 ",\n",
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index bbcdc7b..b5d2347 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -15,6 +15,8 @@ struct vdso_image {
 	unsigned long size;   /* Always a multiple of PAGE_SIZE */
=20
 	unsigned long alt, alt_len;
+	unsigned long extable_base, extable_len;
+	const void *extable;
=20
 	long sym_vvar_start;  /* Negative offset to the vvar area */
=20
@@ -45,6 +47,9 @@ extern void __init init_vdso_image(const struct vdso_image =
*image);
=20
 extern int map_vdso_once(const struct vdso_image *image, unsigned long addr);
=20
+extern bool fixup_vdso_exception(struct pt_regs *regs, int trapnr,
+				 unsigned long error_code,
+				 unsigned long fault_addr);
 #endif /* __ASSEMBLER__ */
=20
 #endif /* _ASM_X86_VDSO_H */
