Return-Path: <linux-tip-commits+bounces-8417-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPeiMhMnr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8417-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 21:01:23 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F56D240892
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 21:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 686DC3034248
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 20:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCBD423141;
	Mon,  9 Mar 2026 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d/kzhlBp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nf4d/DMp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3829A41C0A2;
	Mon,  9 Mar 2026 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086396; cv=none; b=YnknMyECzv3bS9RlM6gYpv68dYC/MSM/ldevR5R1KJb7UlZ9GpuSSaMFlBwdC4UkOSPhQesDSU4ZXNT0uOhN20le0V7iEGkAgoylRk4P6lHkrnipJ6Bhh1e7Raa3RDIBRGPOLYOz245ZfmYll1iOVJz99Sa+VVWCG906uP90ltg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086396; c=relaxed/simple;
	bh=SPCqdYpDje6WkH2PkNqBsc4MXik5obUsUNNk/c0Eri8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j9qv3XwlHpGKXqvFsFyklnr10yuM+SsTo2mN6RDdN3dzjG+v6IkrfvVhY4LIRDmtdXumD67hCeQGaShl0qLbPlMUdjO2wYJwWdy8Nrcm5ka7HQrcbAMqe7PO6L8SO1CuqRXefKv2HnNRS5Dkpir7eknp0Incq0VZs2LcTC1txgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d/kzhlBp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nf4d/DMp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:59:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773086393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qyn3W/6ACOW6EV9mQR+8rGYynaPuF894n05ljUIWDz4=;
	b=d/kzhlBpuifVUPufeMblFi9FbrIHdRoXV3sbErur4+REtDcu5GBlbkuSNX2uGCT3abJKu+
	vnoO8VO0U7U/k0KsRfpKZxBOOgH+6bMrlu8+oUxY+eJtu7Dj95DYk8DzJqgguIgRqujQea
	SgEjwNiJUE9bUfO9xjSRy8oPEOKVaRmOTJk222w+ABz2RoXwEzMqG/+r6Kp7leAcmlqAdX
	yqBa19JN52wTHavPNQ0lDOly0NJbG5RIztwnXinfnN4fA38Q6bQM+P8kpGeSdVWekKwYQK
	jvCBJvGpiaflA+NGeppwRkeCSUBS5M/oYn8BPvKPKtJHM5dPRLdKeHvt7zrxtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773086393;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qyn3W/6ACOW6EV9mQR+8rGYynaPuF894n05ljUIWDz4=;
	b=Nf4d/DMpAj9S95vNuvveZbXDzbiNeREuOfIWEGjjex4rG7V7Gjk7Rkpyad8a9eChGe9vav
	GWXmN5rOYDMXutDg==
From: "tip-bot2 for Wentong Tian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Use section/symbol type helpers
Cc: Wentong Tian <tianwentong2000@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260122144404.40602-1-tianwentong2000@gmail.com>
References: <20260122144404.40602-1-tianwentong2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308639248.1647592.7916593413420343263.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8F56D240892
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8417-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,vger.kernel.org:replyto,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     c19c854b307424c745dd6de73eea8db099c79408
Gitweb:        https://git.kernel.org/tip/c19c854b307424c745dd6de73eea8db099c=
79408
Author:        Wentong Tian <tianwentong2000@gmail.com>
AuthorDate:    Thu, 22 Jan 2026 22:44:04 +08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Fri, 06 Mar 2026 08:08:19 -08:00

objtool: Use section/symbol type helpers

Commit 25eac74b6bdb ("objtool: Add section/symbol type helpers")
introduced several helper macros to improve code readability.

Update the remaining open-coded checks in check.c, disas.c, elf.c,
and klp-diff.c to use these new helpers.

Signed-off-by: Wentong Tian <tianwentong2000@gmail.com>
Link: https://patch.msgid.link/20260122144404.40602-1-tianwentong2000@gmail.c=
om
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c    | 4 ++--
 tools/objtool/disas.c    | 6 +++---
 tools/objtool/elf.c      | 6 +++---
 tools/objtool/klp-diff.c | 8 ++++----
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a30379e..efd4b9c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4293,8 +4293,8 @@ static int validate_retpoline(struct objtool_file *file)
 	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
 		struct symbol *sym =3D insn->sym;
=20
-		if (sym && (sym->type =3D=3D STT_NOTYPE ||
-			    sym->type =3D=3D STT_FUNC) && !sym->nocfi) {
+		if (sym && (is_notype_sym(sym) ||
+			    is_func_sym(sym)) && !sym->nocfi) {
 			struct instruction *prev =3D
 				prev_insn_same_sym(file, insn);
=20
diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 26f08d4..5909023 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -264,7 +264,7 @@ static void disas_print_addr_reloc(bfd_vma addr, struct d=
isassemble_info *dinfo)
 	 * If the relocation symbol is a section name (for example ".bss")
 	 * then we try to further resolve the name.
 	 */
-	if (reloc->sym->type =3D=3D STT_SECTION) {
+	if (is_sec_sym(reloc->sym)) {
 		str =3D offstr(reloc->sym->sec, reloc->sym->offset + offset);
 		DINFO_FPRINTF(dinfo, bfd_vma_fmt, addr, str);
 		free(str);
@@ -580,7 +580,7 @@ static size_t disas_insn_common(struct disas_context *dct=
x,
 	 */
 	dinfo->buffer =3D insn->sec->data->d_buf;
 	dinfo->buffer_vma =3D 0;
-	dinfo->buffer_length =3D insn->sec->sh.sh_size;
+	dinfo->buffer_length =3D sec_size(insn->sec);
=20
 	return disasm(insn->offset, &dctx->info);
 }
@@ -1231,7 +1231,7 @@ void disas_funcs(struct disas_context *dctx)
=20
 	for_each_sec(dctx->file->elf, sec) {
=20
-		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
+		if (!is_text_sec(sec))
 			continue;
=20
 		sec_for_each_sym(sec, sym) {
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 2c02c7b..a634b22 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -614,7 +614,7 @@ static int read_symbols(struct elf *elf)
 		if (elf_add_symbol(elf, sym))
 			return -1;
=20
-		if (sym->type =3D=3D STT_FILE)
+		if (is_file_sym(sym))
 			file =3D sym;
 		else if (sym->bind =3D=3D STB_LOCAL)
 			sym->file =3D file;
@@ -1335,7 +1335,7 @@ unsigned int elf_add_string(struct elf *elf, struct sec=
tion *strtab, const char=20
 		return -1;
 	}
=20
-	offset =3D ALIGN(strtab->sh.sh_size, strtab->sh.sh_addralign);
+	offset =3D ALIGN(sec_size(strtab), strtab->sh.sh_addralign);
=20
 	if (!elf_add_data(elf, strtab, str, strlen(str) + 1))
 		return -1;
@@ -1377,7 +1377,7 @@ void *elf_add_data(struct elf *elf, struct section *sec=
, const void *data, size_
 	sec->data->d_size =3D size;
 	sec->data->d_align =3D 1;
=20
-	offset =3D ALIGN(sec->sh.sh_size, sec->sh.sh_addralign);
+	offset =3D ALIGN(sec_size(sec), sec->sh.sh_addralign);
 	sec->sh.sh_size =3D offset + size;
=20
 	mark_sec_changed(elf, sec, true);
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 9f1f401..885775f 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -271,7 +271,7 @@ static bool is_uncorrelated_static_local(struct symbol *s=
ym)
  */
 static bool is_clang_tmp_label(struct symbol *sym)
 {
-	return sym->type =3D=3D STT_NOTYPE &&
+	return is_notype_sym(sym) &&
 	       is_text_sec(sym->sec) &&
 	       strstarts(sym->name, ".Ltmp") &&
 	       isdigit(sym->name[5]);
@@ -480,7 +480,7 @@ static unsigned long find_sympos(struct elf *elf, struct =
symbol *sym)
 	if (sym->bind !=3D STB_LOCAL)
 		return 0;
=20
-	if (vmlinux && sym->type =3D=3D STT_FUNC) {
+	if (vmlinux && is_func_sym(sym)) {
 		/*
 		 * HACK: Unfortunately, symbol ordering can differ between
 		 * vmlinux.o and vmlinux due to the linker script emitting
@@ -1046,8 +1046,8 @@ static int clone_reloc_klp(struct elfs *e, struct reloc=
 *patched_reloc,
 		   sec->name, offset, patched_sym->name,				\
 		   addend >=3D 0 ? "+" : "-", labs(addend),				\
 		   sym_type(patched_sym),						\
-		   patched_sym->type =3D=3D STT_SECTION ? "" : " ",				\
-		   patched_sym->type =3D=3D STT_SECTION ? "" : sym_bind(patched_sym),	\
+		   is_sec_sym(patched_sym) ? "" : " ",					\
+		   is_sec_sym(patched_sym) ? "" : sym_bind(patched_sym),		\
 		   is_undef_sym(patched_sym) ? " UNDEF" : "",				\
 		   export ? " EXPORTED" : "",						\
 		   klp ? " KLP" : "")

