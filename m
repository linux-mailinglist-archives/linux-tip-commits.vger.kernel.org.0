Return-Path: <linux-tip-commits+bounces-7452-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2350C7856D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 11:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F46735D4EC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 10:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD52346FAA;
	Fri, 21 Nov 2025 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UnfLiS6p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8bAvvP1N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D345B345CCC;
	Fri, 21 Nov 2025 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719084; cv=none; b=owSg0rCfGkRUoNKO6DdXP3xLrDT7GlMfSaZjrdxC/4YJf6gucYbgcbKtdTyvWQyiAlbbInxoxebCYpJspzaZejVslWyhEuQ54vRT7wOBvrlPKWOhWrELZvA4/IAoShP1TpQZ8rvbIcNF4J1SNScDEHeJJLU0YUYdjUkl6+PVVfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719084; c=relaxed/simple;
	bh=Ob5ZZfrT+76JCpsw9eIX56zEDMWamj0C0GTGkfGafGI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jR4htIMQW5O0eKVTxeYWmR1JXlpE6joh5JWhukHy3sPAR+8Xduk2FhiLm3ojfbnYzS79qc8V+wV00iu7EdaCAIT+Bagk5ucVfPHOIbY5YSddt+gu5N9djybSES5+RzAMx5MYRsL7HB1ua8jM7jS4MierIqL0es9sIh82xtn0e6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UnfLiS6p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8bAvvP1N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Nov 2025 09:57:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763719081;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wdhbby0JmoHv374OK4LEcDxvHPU823HXCQlNgRBwVYA=;
	b=UnfLiS6p/+hJeTlWVdMtyiu9TjElc5UloUgM3zQnEHd1Ltv5YH9dp+0ViTsjp0YZQqfsZR
	2r7Xi0TJxCrmv3fGQtk6283O+pGgOEZpihb2CERBOYfRePttlZCJ+NCg1U+Z5p06b2TutX
	aOG916T20Lar3uU/wHx30qmCGEAdiUT00UNhReGIDVYWgznw33DxJNCYJHvNdGnUH8faUI
	eMKZAZWR/cJR3i3VULw6zOGb4JzoPvL9EM9mIBQ1vFxT5tX6uTkQuSfzcF/dB3VPqa3r3v
	St3pRE4Pq44zTaTeMYBRcAIZiG9Ir3PiLwkiNX1c+ptHK0X3IC7jSHpikf880Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763719081;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wdhbby0JmoHv374OK4LEcDxvHPU823HXCQlNgRBwVYA=;
	b=8bAvvP1N9L3JAkUNlo3vXos0N2qkxcyJhWvM8JBHFwpvYnerdytuR2KFfQiVGl9/9mJlRD
	H8BaKQ1v8tdqtTAA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix .cold function detection for
 duplicate symbols
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <82c7b52e40efa75dd10e1c550cc75c1ce10ac2c9.1763671318.git.jpoimboe@kernel.org>
References:
 <82c7b52e40efa75dd10e1c550cc75c1ce10ac2c9.1763671318.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176371907982.498.1222124194340102338.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2c2acca2eabf53a954ed5aacef987bbf909b9f12
Gitweb:        https://git.kernel.org/tip/2c2acca2eabf53a954ed5aacef987bbf909=
b9f12
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 20 Nov 2025 12:52:16 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 10:04:07 +01:00

objtool: Fix .cold function detection for duplicate symbols

The objtool .cold child/parent correlation is done in two phases: first
in elf_add_symbol() and later in add_jump_destinations().

The first phase is rather crude and can pick the wrong parent if there
are duplicates with the same name.

The second phase usually fixes that, but only if the parent has a direct
jump to the child.  It does *not* work if the only branch from the
parent to the child is an alternative or jump table entry.

Make the first phase more robust by looking for the parent in the same
STT_FILE as the child.

Fixes the following objtool warnings in an AutoFDO build with a large
CLANG_AUTOFDO_PROFILE profile:

  vmlinux.o: warning: objtool: rdev_add_key() falls through to next function =
rdev_add_key.cold()
  vmlinux.o: warning: objtool: rdev_set_default_key() falls through to next f=
unction rdev_set_default_key.cold()

Fixes: 13810435b9a7 ("objtool: Support GCC 8's cold subfunctions")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/82c7b52e40efa75dd10e1c550cc75c1ce10ac2c9.17636=
71318.git.jpoimboe@kernel.org
---
 tools/objtool/elf.c                 | 28 ++++++++++++++++++++++++++--
 tools/objtool/include/objtool/elf.h |  2 +-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 7895f65..fffca31 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -288,6 +288,23 @@ struct symbol *find_symbol_by_name(const struct elf *elf=
, const char *name)
 	return NULL;
 }
=20
+/* Find local symbol with matching STT_FILE */
+static struct symbol *find_local_symbol_by_file_and_name(const struct elf *e=
lf,
+							 struct symbol *file,
+							 const char *name)
+{
+	struct symbol *sym;
+
+	elf_hash_for_each_possible(symbol_name, sym, name_hash, str_hash(name)) {
+		if (sym->bind =3D=3D STB_LOCAL && sym->file =3D=3D file &&
+		    !strcmp(sym->name, name)) {
+			return sym;
+		}
+	}
+
+	return NULL;
+}
+
 struct symbol *find_global_symbol_by_name(const struct elf *elf, const char =
*name)
 {
 	struct symbol *sym;
@@ -524,7 +541,7 @@ static int elf_add_symbol(struct elf *elf, struct symbol =
*sym)
 static int read_symbols(struct elf *elf)
 {
 	struct section *symtab, *symtab_shndx, *sec;
-	struct symbol *sym, *pfunc;
+	struct symbol *sym, *pfunc, *file =3D NULL;
 	int symbols_nr, i;
 	char *coldstr;
 	Elf_Data *shndx_data =3D NULL;
@@ -597,6 +614,11 @@ static int read_symbols(struct elf *elf)
=20
 		if (elf_add_symbol(elf, sym))
 			return -1;
+
+		if (sym->type =3D=3D STT_FILE)
+			file =3D sym;
+		else if (sym->bind =3D=3D STB_LOCAL)
+			sym->file =3D file;
 	}
=20
 	if (opts.stats) {
@@ -626,7 +648,9 @@ static int read_symbols(struct elf *elf)
 				return -1;
 			}
=20
-			pfunc =3D find_symbol_by_name(elf, pname);
+			pfunc =3D find_local_symbol_by_file_and_name(elf, sym->file, pname);
+			if (!pfunc)
+				pfunc =3D find_global_symbol_by_name(elf, pname);
 			free(pname);
=20
 			if (!pfunc) {
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index 21d8b82..e12c516 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -69,7 +69,7 @@ struct symbol {
 	unsigned int idx, len;
 	unsigned long offset;
 	unsigned long __subtree_last;
-	struct symbol *pfunc, *cfunc, *alias;
+	struct symbol *pfunc, *cfunc, *alias, *file;
 	unsigned char bind, type;
 	u8 uaccess_safe      : 1;
 	u8 static_call_tramp : 1;

