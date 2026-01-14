Return-Path: <linux-tip-commits+bounces-7981-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64904D1E2DA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 11:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40FB3300EE60
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 10:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E922538F948;
	Wed, 14 Jan 2026 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i/FqYXPC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wrSCezXy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65F138B7D1;
	Wed, 14 Jan 2026 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387210; cv=none; b=i60YMsJrE2cjczIWxs1Hzw7rE0b1o32v6C4uMhBBweuyH+2zqYS0EQHpPl/v/UkRRU39Vi+WOZe0kjbw2jLmgUZbY01pNNLh8Ggo5bYtmLV80f9NlR2VzPxSWTJnuRADhloD0V/drYSsXxVPF6TeBGJYhdAHP9CTmXVFI6p8kLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387210; c=relaxed/simple;
	bh=Dci4Rro/MMz5q0rOhLkWQ38odj6o3m+5WfaRNZ1OoAY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VQzbGCTsq7fLkb6+0xKA5yLT3TAekKTtuZG+cOadCz0xXrX5AbRWEt6IU7R0E/M7F9iBLx4wQfGxeuZw1jZFIQv5E6gjR1eQQXLpp8uf0YoRyINKNoQ6e8APwRfHSsX3xDHtC4gaB+WnYaDDSrnvPvL9MFSZ2zuWQs+CV8j6xRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i/FqYXPC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wrSCezXy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 10:40:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768387203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QJedSlzv9EjDtRflwZkoeBCQCPlsKJL3S6yi+Bnm00=;
	b=i/FqYXPCGHLucYOafaH4Tmfi70/ThDwUVW249eYT3jSnzUha5f4wqiGyaEX/XXju7yF9QV
	gs2AFdBR0gAATiyyqiArTpiBgZiLzzjiplXHwpUu1paLJjsFCQzTmIaTT2uFyKtVa8BnBy
	s04cLITL+tBPrf6hqXX/m1WkDbdEWAKd8eXndFNkbNxaenvN0+9jloQPOgF8z2DZ0fVo8V
	slj2T0Ef8iVrhamWVrw6yBGIVdCrnqFPWejAXDwNwq/+BBqBjoz4J8SuPJnD3tjU2mGoyf
	A1dAMa5reGn54ebMK2R9y/EIRKUlgbjw8Zv6F/LYqZdsAonpDo0nsUq/bUGe8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768387203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QJedSlzv9EjDtRflwZkoeBCQCPlsKJL3S6yi+Bnm00=;
	b=wrSCezXyee2QhLAhO0F03p1TjCEzTflwJLh+RajijfylepApEVV4VkSPWo9ajMIeW4ZYOr
	NrQCaXbokRFooYBg==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] objtool: Allow multiple pv_ops arrays
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260105110520.21356-19-jgross@suse.com>
References: <20260105110520.21356-19-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176838720250.510.9232015137455162753.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     f88dc319fcb6d6a155e94469a355ce456dd85441
Gitweb:        https://git.kernel.org/tip/f88dc319fcb6d6a155e94469a355ce456dd=
85441
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 12:05:17 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 13 Jan 2026 13:39:49 +01:00

objtool: Allow multiple pv_ops arrays

Having a single large pv_ops array has the main disadvantage of needing all
prototypes of the single array members in one header file. This is adding up
to the need to include lots of otherwise unrelated headers.

In order to allow multiple smaller pv_ops arrays dedicated to one area of the
kernel each, allow multiple arrays in objtool.

For better performance limit the possible names of the arrays to start with
"pv_ops".

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260105110520.21356-19-jgross@suse.com
---
 tools/objtool/arch/x86/decode.c       |  8 ++-
 tools/objtool/check.c                 | 74 ++++++++++++++++++++------
 tools/objtool/include/objtool/check.h |  1 +-
 3 files changed, 65 insertions(+), 18 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index f4af825..73bfea2 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -711,10 +711,14 @@ int arch_decode_instruction(struct objtool_file *file, =
const struct section *sec
 			immr =3D find_reloc_by_dest(elf, (void *)sec, offset+3);
 			disp =3D find_reloc_by_dest(elf, (void *)sec, offset+7);
=20
-			if (!immr || strcmp(immr->sym->name, "pv_ops"))
+			if (!immr || strncmp(immr->sym->name, "pv_ops", 6))
 				break;
=20
-			idx =3D (reloc_addend(immr) + 8) / sizeof(void *);
+			idx =3D pv_ops_idx_off(immr->sym->name);
+			if (idx < 0)
+				break;
+
+			idx +=3D (reloc_addend(immr) + 8) / sizeof(void *);
=20
 			func =3D disp->sym;
 			if (disp->sym->type =3D=3D STT_SECTION)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 61f3e0c..b3fec88 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -520,21 +520,57 @@ static int decode_instructions(struct objtool_file *fil=
e)
 }
=20
 /*
- * Read the pv_ops[] .data table to find the static initialized values.
+ * Known pv_ops*[] arrays.
  */
-static int add_pv_ops(struct objtool_file *file, const char *symname)
+static struct {
+	const char *name;
+	int idx_off;
+} pv_ops_tables[] =3D {
+	{ .name =3D "pv_ops", },
+	{ .name =3D NULL, .idx_off =3D -1 }
+};
+
+/*
+ * Get index offset for a pv_ops* array.
+ */
+int pv_ops_idx_off(const char *symname)
+{
+	int idx;
+
+	for (idx =3D 0; pv_ops_tables[idx].name; idx++) {
+		if (!strcmp(symname, pv_ops_tables[idx].name))
+			break;
+	}
+
+	return pv_ops_tables[idx].idx_off;
+}
+
+/*
+ * Read a pv_ops*[] .data table to find the static initialized values.
+ */
+static int add_pv_ops(struct objtool_file *file, int pv_ops_idx)
 {
 	struct symbol *sym, *func;
 	unsigned long off, end;
 	struct reloc *reloc;
-	int idx;
+	int idx, idx_off;
+	const char *symname;
=20
+	symname =3D pv_ops_tables[pv_ops_idx].name;
 	sym =3D find_symbol_by_name(file->elf, symname);
-	if (!sym)
-		return 0;
+	if (!sym) {
+		ERROR("Unknown pv_ops array %s", symname);
+		return -1;
+	}
=20
 	off =3D sym->offset;
 	end =3D off + sym->len;
+	idx_off =3D pv_ops_tables[pv_ops_idx].idx_off;
+	if (idx_off < 0) {
+		ERROR("pv_ops array %s has unknown index offset", symname);
+		return -1;
+	}
+
 	for (;;) {
 		reloc =3D find_reloc_by_dest_range(file->elf, sym->sec, off, end - off);
 		if (!reloc)
@@ -552,7 +588,7 @@ static int add_pv_ops(struct objtool_file *file, const ch=
ar *symname)
 			return -1;
 		}
=20
-		if (objtool_pv_add(file, idx, func))
+		if (objtool_pv_add(file, idx + idx_off, func))
 			return -1;
=20
 		off =3D reloc_offset(reloc) + 1;
@@ -568,11 +604,6 @@ static int add_pv_ops(struct objtool_file *file, const c=
har *symname)
  */
 static int init_pv_ops(struct objtool_file *file)
 {
-	static const char *pv_ops_tables[] =3D {
-		"pv_ops",
-		NULL,
-	};
-	const char *pv_ops;
 	struct symbol *sym;
 	int idx, nr;
=20
@@ -581,11 +612,20 @@ static int init_pv_ops(struct objtool_file *file)
=20
 	file->pv_ops =3D NULL;
=20
-	sym =3D find_symbol_by_name(file->elf, "pv_ops");
-	if (!sym)
+	nr =3D 0;
+	for (idx =3D 0; pv_ops_tables[idx].name; idx++) {
+		sym =3D find_symbol_by_name(file->elf, pv_ops_tables[idx].name);
+		if (!sym) {
+			pv_ops_tables[idx].idx_off =3D -1;
+			continue;
+		}
+		pv_ops_tables[idx].idx_off =3D nr;
+		nr +=3D sym->len / sizeof(unsigned long);
+	}
+
+	if (nr =3D=3D 0)
 		return 0;
=20
-	nr =3D sym->len / sizeof(unsigned long);
 	file->pv_ops =3D calloc(nr, sizeof(struct pv_state));
 	if (!file->pv_ops) {
 		ERROR_GLIBC("calloc");
@@ -595,8 +635,10 @@ static int init_pv_ops(struct objtool_file *file)
 	for (idx =3D 0; idx < nr; idx++)
 		INIT_LIST_HEAD(&file->pv_ops[idx].targets);
=20
-	for (idx =3D 0; (pv_ops =3D pv_ops_tables[idx]); idx++) {
-		if (add_pv_ops(file, pv_ops))
+	for (idx =3D 0; pv_ops_tables[idx].name; idx++) {
+		if (pv_ops_tables[idx].idx_off < 0)
+			continue;
+		if (add_pv_ops(file, idx))
 			return -1;
 	}
=20
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/ob=
jtool/check.h
index 2e1346a..5f2f77b 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -159,5 +159,6 @@ const char *objtool_disas_insn(struct instruction *insn);
=20
 extern size_t sym_name_max_len;
 extern struct disas_context *objtool_disas_ctx;
+int pv_ops_idx_off(const char *symname);
=20
 #endif /* _CHECK_H */

