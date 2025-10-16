Return-Path: <linux-tip-commits+bounces-6873-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9013FBE2921
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6BA485CE2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE9D320393;
	Thu, 16 Oct 2025 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="abaq8ZPU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4R7LfJ40"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFEE3203B6;
	Thu, 16 Oct 2025 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608361; cv=none; b=Tk9cFHJMQZMRGsVwU3nHzmaCatkT5i2XGkT42O/6l94cMIf8xZoo2KuLOAqn3JXlnW39DD92miwrE9O5x2F4Cc9ByODfCjWG/9x7rcAWBKFz3DXhLwdch1qpb+rfOEEVZrVJc1dAKOYQToRTaSrIh6AuW5Xqzz/2x2RyyiLt+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608361; c=relaxed/simple;
	bh=RO5CeRhn54wHtvOtEcB+I9ZyAnsKSCXbK/RSqXkiF2g=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=f5KZOkpXHm8NfMzzmnWAgNBbuRNw3D1ZF+Naw4tGpL45lOIofn/T5HgC4zJkSAniw5gDXrd3UpyLpXT2jkA9dBwqDHeFVW6kUnKACczw5CiGNklHFPyrPYwlUIcW9PZdBMjemoqQsDKyc/RUKaFVqCUgiq5aWnoBg3Bv1vK3/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=abaq8ZPU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4R7LfJ40; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608334;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1H+LiWem/WomAk5FLCdBgEWFe69oKVPLEx2ZP3I95xU=;
	b=abaq8ZPUOO76tLLKRNLPXmzo+lEmR2RaI0gYY/CJM7mAb9wMVgNjkKtz6tJG045kKb6q9c
	j7auD7XF8S/iW9v8sM91YrkVO+9njbdF1gkf2CHQuyh3WWcY+IhV13ilOYtFXApOmtscLH
	avSyfyXqh/hVx8hg1DVakA8QJWj9iVX7RpANPoO+hOlbzHZegpvg4+YE01+oAQcQeSB8Bs
	K0JGyBNPvMm2B27rlT8nl1eC7uZFOC8axkcSv3iSlkbml0xOBrXB8+RntVTd3pztw2gsK9
	z7GWm9SJ4S2wjES4Bw4teP1m59DOT/mNp8Ko3ZHiZ47gOQ11aXSbv/6z9T9t7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608334;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1H+LiWem/WomAk5FLCdBgEWFe69oKVPLEx2ZP3I95xU=;
	b=4R7LfJ40XD0xBSoGS2zpRFx6NcbeFcHXDvgbhsnCLf3MQUd8IcOaxPbfxYW6/gnFUTGkqS
	h4eh0iKLqlZHE6Cg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Refactor prefix symbol creation code
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060833281.709179.6522569858146312956.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2058f6d1660edc4a9bda9bee627792b352121b10
Gitweb:        https://git.kernel.org/tip/2058f6d1660edc4a9bda9bee627792b3521=
21b10
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:04:02 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:50:18 -07:00

objtool: Refactor prefix symbol creation code

The prefix symbol creation code currently ignores all errors, presumably
because some functions don't have the leading NOPs.

Shuffle the code around a bit, improve the error handling and document
why some errors are ignored.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 57 ++++++++++++++++++++++------
 tools/objtool/elf.c                 | 17 +--------
 tools/objtool/include/objtool/elf.h |  2 +-
 3 files changed, 45 insertions(+), 31 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8d17d93..b2659fb 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -15,6 +15,7 @@
 #include <objtool/special.h>
 #include <objtool/warn.h>
 #include <objtool/checksum.h>
+#include <objtool/util.h>
=20
 #include <linux/objtool_types.h>
 #include <linux/hashtable.h>
@@ -4233,14 +4234,43 @@ static bool ignore_unreachable_insn(struct objtool_fi=
le *file, struct instructio
 	return false;
 }
=20
-static int add_prefix_symbol(struct objtool_file *file, struct symbol *func)
+/*
+ * For FineIBT or kCFI, a certain number of bytes preceding the function may=
 be
+ * NOPs.  Those NOPs may be rewritten at runtime and executed, so give them a
+ * proper function name: __pfx_<func>.
+ *
+ * The NOPs may not exist for the following cases:
+ *
+ *   - compiler cloned functions (*.cold, *.part0, etc)
+ *   - asm functions created with inline asm or without SYM_FUNC_START()
+ *
+ * So return 0 if the NOPs are missing or the function already has a prefix
+ * symbol.
+ */
+static int create_prefix_symbol(struct objtool_file *file, struct symbol *fu=
nc)
 {
 	struct instruction *insn, *prev;
+	char name[SYM_NAME_LEN];
 	struct cfi_state *cfi;
=20
+	if (!is_func_sym(func) || is_prefix_func(func) ||
+	    func->cold || func->static_call_tramp)
+		return 0;
+
+	if ((strlen(func->name) + sizeof("__pfx_") > SYM_NAME_LEN)) {
+		WARN("%s: symbol name too long, can't create __pfx_ symbol",
+		      func->name);
+		return 0;
+	}
+
+	if (snprintf_check(name, SYM_NAME_LEN, "__pfx_%s", func->name))
+		return -1;
+
 	insn =3D find_insn(file, func->sec, func->offset);
-	if (!insn)
+	if (!insn) {
+		WARN("%s: can't find starting instruction", func->name);
 		return -1;
+	}
=20
 	for (prev =3D prev_insn_same_sec(file, insn);
 	     prev;
@@ -4248,22 +4278,27 @@ static int add_prefix_symbol(struct objtool_file *fil=
e, struct symbol *func)
 		u64 offset;
=20
 		if (prev->type !=3D INSN_NOP)
-			return -1;
+			return 0;
=20
 		offset =3D func->offset - prev->offset;
=20
 		if (offset > opts.prefix)
-			return -1;
+			return 0;
=20
 		if (offset < opts.prefix)
 			continue;
=20
-		elf_create_prefix_symbol(file->elf, func, opts.prefix);
+		if (!elf_create_symbol(file->elf, name, func->sec,
+				       GELF_ST_BIND(func->sym.st_info),
+				       GELF_ST_TYPE(func->sym.st_info),
+				       prev->offset, opts.prefix))
+			return -1;
+
 		break;
 	}
=20
 	if (!prev)
-		return -1;
+		return 0;
=20
 	if (!insn->cfi) {
 		/*
@@ -4281,7 +4316,7 @@ static int add_prefix_symbol(struct objtool_file *file,=
 struct symbol *func)
 	return 0;
 }
=20
-static int add_prefix_symbols(struct objtool_file *file)
+static int create_prefix_symbols(struct objtool_file *file)
 {
 	struct section *sec;
 	struct symbol *func;
@@ -4291,10 +4326,8 @@ static int add_prefix_symbols(struct objtool_file *fil=
e)
 			continue;
=20
 		sec_for_each_sym(sec, func) {
-			if (!is_func_sym(func))
-				continue;
-
-			add_prefix_symbol(file, func);
+			if (create_prefix_symbol(file, func))
+				return -1;
 		}
 	}
=20
@@ -4921,7 +4954,7 @@ int check(struct objtool_file *file)
 	}
=20
 	if (opts.prefix) {
-		ret =3D add_prefix_symbols(file);
+		ret =3D create_prefix_symbols(file);
 		if (ret)
 			goto out;
 	}
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index e1daae0..4bb7ce9 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -942,23 +942,6 @@ struct symbol *elf_create_section_symbol(struct elf *elf=
, struct section *sec)
 	return sym;
 }
=20
-struct symbol *
-elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, size_t size)
-{
-	size_t namelen =3D strlen(orig->name) + sizeof("__pfx_");
-	char name[SYM_NAME_LEN];
-	unsigned long offset;
-
-	snprintf(name, namelen, "__pfx_%s", orig->name);
-
-	offset =3D orig->sym.st_value - size;
-
-	return elf_create_symbol(elf, name, orig->sec,
-				 GELF_ST_BIND(orig->sym.st_info),
-				 GELF_ST_TYPE(orig->sym.st_info),
-				 offset, size);
-}
-
 struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
 			     unsigned int reloc_idx, unsigned long offset,
 			     struct symbol *sym, s64 addend, unsigned int type)
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index e2cd817..60f844e 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -148,8 +148,6 @@ struct symbol *elf_create_symbol(struct elf *elf, const c=
har *name,
 				 unsigned int type, unsigned long offset,
 				 size_t size);
 struct symbol *elf_create_section_symbol(struct elf *elf, struct section *se=
c);
-struct symbol *elf_create_prefix_symbol(struct elf *elf, struct symbol *orig,
-					size_t size);
=20
 void *elf_add_data(struct elf *elf, struct section *sec, const void *data,
 		   size_t size);

