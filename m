Return-Path: <linux-tip-commits+bounces-7503-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC4CC7F888
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48EAE344233
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17622FF160;
	Mon, 24 Nov 2025 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ClxNAN+Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z8UEoXwk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A12FBE1D;
	Mon, 24 Nov 2025 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975524; cv=none; b=r9+FK56LGOWT/YdZuroP+E3wO8f2PdgEb2WKZbqd5RVGwqvS34D3eg/DQzsi7gJdNNrcch9ja4h6IWN8AU2q15SsDDL2Tq8EKmfh2o1BdCCIWU9rmGkCs9/69gGiv8B2HajvFvIjY+rXVzYo93gDpc3/Hzw3wHvyqtnX7L5SXLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975524; c=relaxed/simple;
	bh=QGbHI6wQ46sUcFz/h7qRvvlkewrxBhD7wKP8FKjrnnM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KF/c1+Ie+yb9Xxbh+YHuiOb/NUaPYkeJFqlv92tN1hjay7kjrdym+z8VLQL6m7FbXofdf6pOD7j7420BpWw3rgHkMFPozoL0/KkPSZ6JqP7yVaeLFg1XnuyWNTfrlmxwV2oVHi4Exv7BLkdfGTYAaocp3R3HigtHhYkpIgKq5yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ClxNAN+Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z8UEoXwk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975520;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/y/hrvM9CD73uXclHeAdgrCmCBWhZgjU8AgWItQwvWw=;
	b=ClxNAN+QJuzAan4p3LNf/GFWqGUGoyV0huckNTq2VaRr0YxPlydPp1JmZ3N2MY9UVHIqhz
	zfnrj6ZfmrdUNxBQ/7EyRj8dRKn8KkT4RBdNZSNEKb0fBDi/zqimfsUiy660L8Neo7BaZs
	MlbmR6Hz3G3h1QVnuWuOLgwNtIGDIH+oix31kV5lutJloxzfaEkYPA/M3ZdfzvlOQfz3C+
	84N/9hPzsdt93edzn/hrqMINo8LYNBSFyPY1GF4/g1NtrW5ibe3iczHHwnDIr1l6DZoCwn
	pyxOc4EKvLX6sOE8IAMD5J8ORdKU5Dyyy1G/oGq232XbDAWhEw8eMM4A7MMqyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975520;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/y/hrvM9CD73uXclHeAdgrCmCBWhZgjU8AgWItQwvWw=;
	b=z8UEoXwkzAm7M2eUuBjglDOxsY3adhO9pwLK9rfxV1D2wvTW2M2w/8A/++0EJQ2+2L64yI
	rMhXgyCrHONZVfBA==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Print symbol during disassembly
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-6-alexandre.chartre@oracle.com>
References: <20251121095340.464045-6-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397551929.498.12553129252099302199.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     5d859dff266f7e57664dc6bcf80ef2c66547c58a
Gitweb:        https://git.kernel.org/tip/5d859dff266f7e57664dc6bcf80ef2c6654=
7c58a
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:15 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:07 +01:00

objtool: Print symbol during disassembly

Print symbols referenced during disassembly instead of just printing
raw addresses. Also handle address relocation.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-6-alexandre.chartre@orac=
le.com
---
 tools/objtool/check.c                 |   9 +--
 tools/objtool/disas.c                 | 134 +++++++++++++++++++++++++-
 tools/objtool/include/objtool/check.h |   9 ++-
 3 files changed, 143 insertions(+), 9 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 21d45a3..0999717 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -134,15 +134,6 @@ static struct instruction *prev_insn_same_sym(struct obj=
tool_file *file,
 	for (insn =3D next_insn_same_sec(file, insn); insn;		\
 	     insn =3D next_insn_same_sec(file, insn))
=20
-static inline struct symbol *insn_call_dest(struct instruction *insn)
-{
-	if (insn->type =3D=3D INSN_JUMP_DYNAMIC ||
-	    insn->type =3D=3D INSN_CALL_DYNAMIC)
-		return NULL;
-
-	return insn->_call_dest;
-}
-
 static inline struct reloc *insn_jump_table(struct instruction *insn)
 {
 	if (insn->type =3D=3D INSN_JUMP_DYNAMIC ||
diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 11ac2ec..dee10ab 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -14,13 +14,144 @@
=20
 struct disas_context {
 	struct objtool_file *file;
+	struct instruction *insn;
 	disassembler_ftype disassembler;
 	struct disassemble_info info;
 };
=20
+static int sprint_name(char *str, const char *name, unsigned long offset)
+{
+	int len;
+
+	if (offset)
+		len =3D sprintf(str, "%s+0x%lx", name, offset);
+	else
+		len =3D sprintf(str, "%s", name);
+
+	return len;
+}
+
 #define DINFO_FPRINTF(dinfo, ...)	\
 	((*(dinfo)->fprintf_func)((dinfo)->stream, __VA_ARGS__))
=20
+static void disas_print_addr_sym(struct section *sec, struct symbol *sym,
+				 bfd_vma addr, struct disassemble_info *dinfo)
+{
+	char symstr[1024];
+	char *str;
+
+	if (sym) {
+		sprint_name(symstr, sym->name, addr - sym->offset);
+		DINFO_FPRINTF(dinfo, "0x%lx <%s>", addr, symstr);
+	} else {
+		str =3D offstr(sec, addr);
+		DINFO_FPRINTF(dinfo, "0x%lx <%s>", addr, str);
+		free(str);
+	}
+}
+
+static void disas_print_addr_noreloc(bfd_vma addr,
+				     struct disassemble_info *dinfo)
+{
+	struct disas_context *dctx =3D dinfo->application_data;
+	struct instruction *insn =3D dctx->insn;
+	struct symbol *sym =3D NULL;
+
+	if (insn->sym && addr >=3D insn->sym->offset &&
+	    addr < insn->sym->offset + insn->sym->len) {
+		sym =3D insn->sym;
+	}
+
+	disas_print_addr_sym(insn->sec, sym, addr, dinfo);
+}
+
+static void disas_print_addr_reloc(bfd_vma addr, struct disassemble_info *di=
nfo)
+{
+	struct disas_context *dctx =3D dinfo->application_data;
+	struct instruction *insn =3D dctx->insn;
+	unsigned long offset;
+	struct reloc *reloc;
+	char symstr[1024];
+	char *str;
+
+	reloc =3D find_reloc_by_dest_range(dctx->file->elf, insn->sec,
+					 insn->offset, insn->len);
+	if (!reloc) {
+		/*
+		 * There is no relocation for this instruction although
+		 * the address to resolve points to the next instruction.
+		 * So this is an effective reference to the next IP, for
+		 * example: "lea 0x0(%rip),%rdi". The kernel can reference
+		 * the next IP with _THIS_IP_ macro.
+		 */
+		DINFO_FPRINTF(dinfo, "0x%lx <_THIS_IP_>", addr);
+		return;
+	}
+
+	offset =3D arch_insn_adjusted_addend(insn, reloc);
+
+	/*
+	 * If the relocation symbol is a section name (for example ".bss")
+	 * then we try to further resolve the name.
+	 */
+	if (reloc->sym->type =3D=3D STT_SECTION) {
+		str =3D offstr(reloc->sym->sec, reloc->sym->offset + offset);
+		DINFO_FPRINTF(dinfo, "0x%lx <%s>", addr, str);
+		free(str);
+	} else {
+		sprint_name(symstr, reloc->sym->name, offset);
+		DINFO_FPRINTF(dinfo, "0x%lx <%s>", addr, symstr);
+	}
+}
+
+/*
+ * Resolve an address into a "<symbol>+<offset>" string.
+ */
+static void disas_print_address(bfd_vma addr, struct disassemble_info *dinfo)
+{
+	struct disas_context *dctx =3D dinfo->application_data;
+	struct instruction *insn =3D dctx->insn;
+	struct instruction *jump_dest;
+	struct symbol *sym;
+	bool is_reloc;
+
+	/*
+	 * If the instruction is a call/jump and it references a
+	 * destination then this is likely the address we are looking
+	 * up. So check it first.
+	 */
+	jump_dest =3D insn->jump_dest;
+	if (jump_dest && jump_dest->sym && jump_dest->offset =3D=3D addr) {
+		disas_print_addr_sym(jump_dest->sec, jump_dest->sym,
+				     addr, dinfo);
+		return;
+	}
+
+	/*
+	 * If the address points to the next instruction then there is
+	 * probably a relocation. It can be a false positive when the
+	 * current instruction is referencing the address of the next
+	 * instruction. This particular case will be handled in
+	 * disas_print_addr_reloc().
+	 */
+	is_reloc =3D (addr =3D=3D insn->offset + insn->len);
+
+	/*
+	 * The call destination offset can be the address we are looking
+	 * up, or 0 if there is a relocation.
+	 */
+	sym =3D insn_call_dest(insn);
+	if (sym && (sym->offset =3D=3D addr || (sym->offset =3D=3D 0 && is_reloc)))=
 {
+		DINFO_FPRINTF(dinfo, "0x%lx <%s>", addr, sym->name);
+		return;
+	}
+
+	if (!is_reloc)
+		disas_print_addr_noreloc(addr, dinfo);
+	else
+		disas_print_addr_reloc(addr, dinfo);
+}
+
 /*
  * Initialize disassemble info arch, mach (32 or 64-bit) and options.
  */
@@ -69,6 +200,7 @@ struct disas_context *disas_context_create(struct objtool_=
file *file)
 				     fprintf_styled);
=20
 	dinfo->read_memory_func =3D buffer_read_memory;
+	dinfo->print_address_func =3D disas_print_address;
 	dinfo->application_data =3D dctx;
=20
 	/*
@@ -121,6 +253,8 @@ static size_t disas_insn(struct disas_context *dctx,
 	disassembler_ftype disasm =3D dctx->disassembler;
 	struct disassemble_info *dinfo =3D &dctx->info;
=20
+	dctx->insn =3D insn;
+
 	if (insn->type =3D=3D INSN_NOP) {
 		DINFO_FPRINTF(dinfo, "nop%d", insn->len);
 		return insn->len;
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/ob=
jtool/check.h
index 674f574..ad9c735 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -117,6 +117,15 @@ static inline bool is_jump(struct instruction *insn)
 	return is_static_jump(insn) || is_dynamic_jump(insn);
 }
=20
+static inline struct symbol *insn_call_dest(struct instruction *insn)
+{
+	if (insn->type =3D=3D INSN_JUMP_DYNAMIC ||
+	    insn->type =3D=3D INSN_CALL_DYNAMIC)
+		return NULL;
+
+	return insn->_call_dest;
+}
+
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset);
=20

