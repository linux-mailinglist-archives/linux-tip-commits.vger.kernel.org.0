Return-Path: <linux-tip-commits+bounces-8414-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAGJBhkor2nHOwIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8414-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 21:05:45 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8568D2409EF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 21:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8DD8309E79C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 20:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDDF421892;
	Mon,  9 Mar 2026 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OzxKmjeo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IvSMF+w1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63B841B363;
	Mon,  9 Mar 2026 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086393; cv=none; b=UNFE+0yjUvWq6hELGRlVvCaefYuseznmMBtpT9rXWLPqGn6wVGhjbO3xOXXw9yFy8ESDXJY63qouSHn6Tux1ZidtAGn+fkmmuRSQ5P2XlK27oR4gsW/Ni9oucfdkIn5H6iutlEa1zSSDwIel6wDG0luWhZ9zO55AcDx7iCB8iCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086393; c=relaxed/simple;
	bh=KOo1ww9Kq3T/zgac3212kr/1J1IH3MNXRgdODDyPbAQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WFVQ0AltGtvIxmvnHAVUmkucJ/Soqkb0N+G1DEpz54h5cg9yOLuM7YAVGDCYEZkoKW9Pf/9P30sL/Gf0t4jqdPRs5/CHgfSmxDjutgOug0Md4csk1rHHVuNdO/Tn3a951K/ej+VWGWhirtQosbB1qssTScJxc2dcxSRFyewKoaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OzxKmjeo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IvSMF+w1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:59:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773086390;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7V4dKACxC4SnVqD9LigdiVe7G+1mtXUDQxs3tpOhL5s=;
	b=OzxKmjeoJ0VX+hZspz4rDOT+CZC7wg/Xq2q5DzSjlrtDmAFNFwcRelvvjWX5EVYANQYOmR
	T2ehhAOqSyUe70A3Vv5ZveUDQJLaD00rFSFvb3kjL8IDHJgDpju2SEs9OuulAjU2HRYUD+
	PiA96Ck1M9FXSdZtLXG5XQkPmZaHe609I1XdDBfJHVU8lM4/ehwdm28SI5VDYIRXzkc5J3
	39ajLhQPobHbwgIwWLjL3qO5M7kMfu1HFRuobSgN7n1Nk5fH9S6CwC0lvZ08weY9Is4x0t
	8idjv+1TDB7V61XdU7GS4wiQzhkso/677UFIvTCtg9kWFbx2nZu4+O6fW2ZToA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773086390;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7V4dKACxC4SnVqD9LigdiVe7G+1mtXUDQxs3tpOhL5s=;
	b=IvSMF+w13XUt7CZCtxulzBODVoRHmfYb90U+4iEnX0sgOj43Nxuhl3MfunbdJEjrSW7reE
	v0c3gES/Oo7DRVBg==
From: "tip-bot2 for Song Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool/klp: Use sym->demangled_name for symbol_name hash
Cc: Song Liu <song@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260305231531.3847295-4-song@kernel.org>
References: <20260305231531.3847295-4-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308638925.1647592.13884581571415044033.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8568D2409EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8414-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,linutronix.de:dkim,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     0b8fc6adc3d9bdf161fc8ad0a1de191dba293b39
Gitweb:        https://git.kernel.org/tip/0b8fc6adc3d9bdf161fc8ad0a1de191dba2=
93b39
Author:        Song Liu <song@kernel.org>
AuthorDate:    Thu, 05 Mar 2026 15:15:27 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Fri, 06 Mar 2026 08:08:32 -08:00

objtool/klp: Use sym->demangled_name for symbol_name hash

For klp-build with LTO, it is necessary to correlate demangled symbols,
e.g., correlate foo.llvm.<num 1> and foo.llvm.<num 2>. However, these two
symbols do not have the same str_hash(name). To be able to correlate the
two symbols, calculate hash based on demanged_name, so that these two
symbols have the same hash.

No functional changes intended.

Signed-off-by: Song Liu <song@kernel.org>
Link: https://patch.msgid.link/20260305231531.3847295-4-song@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 58 ++++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index fe6e66d..b2d73c4 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -26,11 +26,18 @@
 #include <objtool/elf.h>
 #include <objtool/warn.h>
=20
+static ssize_t demangled_name_len(const char *name);
+
 static inline u32 str_hash(const char *str)
 {
 	return jhash(str, strlen(str), 0);
 }
=20
+static inline u32 str_hash_demangled(const char *str)
+{
+	return jhash(str, demangled_name_len(str), 0);
+}
+
 #define __elf_table(name)	(elf->name##_hash)
 #define __elf_bits(name)	(elf->name##_bits)
=20
@@ -294,7 +301,7 @@ static struct symbol *find_local_symbol_by_file_and_name(=
const struct elf *elf,
 {
 	struct symbol *sym;
=20
-	elf_hash_for_each_possible(symbol_name, sym, name_hash, str_hash(name)) {
+	elf_hash_for_each_possible(symbol_name, sym, name_hash, str_hash_demangled(=
name)) {
 		if (sym->bind =3D=3D STB_LOCAL && sym->file =3D=3D file &&
 		    !strcmp(sym->name, name)) {
 			return sym;
@@ -308,7 +315,7 @@ struct symbol *find_global_symbol_by_name(const struct el=
f *elf, const char *nam
 {
 	struct symbol *sym;
=20
-	elf_hash_for_each_possible(symbol_name, sym, name_hash, str_hash(name)) {
+	elf_hash_for_each_possible(symbol_name, sym, name_hash, str_hash_demangled(=
name)) {
 		if (!strcmp(sym->name, name) && !is_local_sym(sym))
 			return sym;
 	}
@@ -442,6 +449,28 @@ static int read_sections(struct elf *elf)
 }
=20
 /*
+ * Returns desired length of the demangled name.
+ * If name doesn't need demangling, return strlen(name).
+ */
+static ssize_t demangled_name_len(const char *name)
+{
+	ssize_t idx;
+
+	if (!strstarts(name, "__UNIQUE_ID_") && !strchr(name, '.'))
+		return strlen(name);
+
+	for (idx =3D strlen(name) - 1; idx >=3D 0; idx--) {
+		char c =3D name[idx];
+
+		if (!isdigit(c) && c !=3D '.' && c !=3D '_')
+			break;
+	}
+	if (idx <=3D 0)
+		return strlen(name);
+	return idx + 1;
+}
+
+/*
  * Remove number suffix of a symbol.
  *
  * Specifically, remove trailing numbers for "__UNIQUE_ID_" symbols and
@@ -457,6 +486,7 @@ static int read_sections(struct elf *elf)
 static const char *demangle_name(struct symbol *sym)
 {
 	char *str;
+	ssize_t len;
=20
 	if (!is_local_sym(sym))
 		return sym->name;
@@ -464,24 +494,16 @@ static const char *demangle_name(struct symbol *sym)
 	if (!is_func_sym(sym) && !is_object_sym(sym))
 		return sym->name;
=20
-	if (!strstarts(sym->name, "__UNIQUE_ID_") && !strchr(sym->name, '.'))
+	len =3D demangled_name_len(sym->name);
+	if (len =3D=3D strlen(sym->name))
 		return sym->name;
=20
-	str =3D strdup(sym->name);
+	str =3D strndup(sym->name, len);
 	if (!str) {
 		ERROR_GLIBC("strdup");
 		return NULL;
 	}
=20
-	for (int i =3D strlen(str) - 1; i >=3D 0; i--) {
-		char c =3D str[i];
-
-		if (!isdigit(c) && c !=3D '.' && c !=3D '_') {
-			str[i + 1] =3D '\0';
-			break;
-		}
-	}
-
 	return str;
 }
=20
@@ -517,9 +539,13 @@ static int elf_add_symbol(struct elf *elf, struct symbol=
 *sym)
 		entry =3D &sym->sec->symbol_list;
 	list_add(&sym->list, entry);
=20
+	sym->demangled_name =3D demangle_name(sym);
+	if (!sym->demangled_name)
+		return -1;
+
 	list_add_tail(&sym->global_list, &elf->symbols);
 	elf_hash_add(symbol, &sym->hash, sym->idx);
-	elf_hash_add(symbol_name, &sym->name_hash, str_hash(sym->name));
+	elf_hash_add(symbol_name, &sym->name_hash, str_hash(sym->demangled_name));
=20
 	if (is_func_sym(sym) &&
 	    (strstarts(sym->name, "__pfx_") ||
@@ -543,10 +569,6 @@ static int elf_add_symbol(struct elf *elf, struct symbol=
 *sym)
=20
 	sym->pfunc =3D sym->cfunc =3D sym;
=20
-	sym->demangled_name =3D demangle_name(sym);
-	if (!sym->demangled_name)
-		return -1;
-
 	return 0;
 }
=20

