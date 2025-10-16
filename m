Return-Path: <linux-tip-commits+bounces-6902-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B01BE29E2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38E9485ABB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA02331AF36;
	Thu, 16 Oct 2025 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p4Fe0HEU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S5p9Oasd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1B532F74A;
	Thu, 16 Oct 2025 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608399; cv=none; b=RXXHPmHEWi0OdV8TdQbkZ37ogfJdU/+DxrzEfgY/h6Gn8hNCXxX3vR8ixiBOgX0ZZWyDsw4AF0/NwKJPIzUAPn9dSLY2l015nqcC6S9Q4ohQ82rZLhgwcCRMqOeS1mCcLzX2MT8c6r8T0n3qcZkUMDi+TnzxVhIQPNaFql9o8Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608399; c=relaxed/simple;
	bh=L5LvO9oPanEblbk0BuwNZ2qbm8Lvmo2uGtyKaVBMO0U=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=nrF2PQ1bMUuN7XIxPeuTXxeJ01ZIS0KoErCBTj7kirXItFsdcPV7HxaB0tD6SfxoUv6M4k8rR4+w8yuUQkUjq5chU97Df9k/h0VJUFCafsc9gcbImV0gqGVnlAppF6yEQzCmzKSmxBJM0l9Rn+IqRLF35lYfNmVJ4Np9zEEQMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p4Fe0HEU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S5p9Oasd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608371;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DYBaAcy8wCNwcs0y+QDd41hRJJ0e14raFOkJHD5XGgc=;
	b=p4Fe0HEUGJD+o+X+ItRT/c+sFeDGXw5jA1as3GeAR5r20Ylbk2YIFO27d/h2jfWogWu5YV
	8cHmHbpNTYhwyBSYR9kH3sXRX0JNVPz26OQkEnH7tVW4eDHoSvdZJjO5zZCFLvCbPIcGqe
	189yP/vU311tLvjTLbGBfGYcHkeoK/3JXM5pw9Kg8o2qgLyN3C1ioLa5TV9Ewa6Imxo0lb
	TwPn38C9E9OxvMgdPwe7wnmlBrb+NzpgySnKjaCxUnNCSXY3cMF2f45TDprMsk2/gGIPaG
	hnlIYvL2VkryM6zTmVN1JEm8XyGruG1gvC2JzfekMYtdFxbu83znAQ7eTeD3Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608371;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DYBaAcy8wCNwcs0y+QDd41hRJJ0e14raFOkJHD5XGgc=;
	b=S5p9Oasdze5yAno02zSXX/mmBMZSv4+z/eQ5OZz7f8W8Dx4KYk9uoN7cFkbjaN6CYYeDo4
	BWdv8itCpiNRpKAQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Clean up compiler flag usage
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060836997.709179.13931188511280026282.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     31eca25f3a3b0de960ca9a478e5a4b2d0b2e8558
Gitweb:        https://git.kernel.org/tip/31eca25f3a3b0de960ca9a478e5a4b2d0b2=
e8558
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:33 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:24 -07:00

objtool: Clean up compiler flag usage

KBUILD_HOSTCFLAGS and KBUILD_HOSTLDFLAGS aren't defined when objtool is
built standalone.  Also, the EXTRA_WARNINGS flags are rather arbitrary.

Make things simpler and more consistent by specifying compiler flags
explicitly and tweaking the warnings.  Also make a few code tweaks to
make the new warnings happy.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Makefile | 15 ++++++++++-----
 tools/objtool/check.c  |  4 ++--
 tools/objtool/elf.c    |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 8c20361..fc82d47 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -23,6 +23,11 @@ LIBELF_LIBS  :=3D $(shell $(HOSTPKG_CONFIG) libelf --libs =
2>/dev/null || echo -lel
=20
 all: $(OBJTOOL)
=20
+WARNINGS :=3D -Werror -Wall -Wextra -Wmissing-prototypes			\
+	    -Wmissing-declarations -Wwrite-strings			\
+	    -Wno-implicit-fallthrough -Wno-sign-compare			\
+	    -Wno-unused-parameter
+
 INCLUDES :=3D -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/include/uapi \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
@@ -30,11 +35,11 @@ INCLUDES :=3D -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/objtool/include \
 	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include \
 	    -I$(LIBSUBCMD_OUTPUT)/include
-# Note, EXTRA_WARNINGS here was determined for CC and not HOSTCC, it
-# is passed here to match a legacy behavior.
-WARNINGS :=3D $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-pa=
cked -Wno-nested-externs
-OBJTOOL_CFLAGS :=3D -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) =
$(LIBELF_FLAGS)
-OBJTOOL_LDFLAGS :=3D $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
+
+OBJTOOL_CFLAGS  :=3D -std=3Dgnu11 -fomit-frame-pointer -O2 -g \
+		   $(WARNINGS) $(INCLUDES) $(LIBELF_FLAGS) $(HOSTCFLAGS)
+
+OBJTOOL_LDFLAGS :=3D $(LIBSUBCMD) $(LIBELF_LIBS) $(HOSTLDFLAGS)
=20
 # Allow old libelf to be used:
 elfshdr :=3D $(shell echo '$(pound)include <libelf.h>' | $(HOSTCC) $(OBJTOOL=
_CFLAGS) -x c -E - 2>/dev/null | grep elf_getshdr)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 49d2db7..2bd35d1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -461,7 +461,7 @@ static int decode_instructions(struct objtool_file *file)
=20
 		for (offset =3D 0; offset < sec->sh.sh_size; offset +=3D insn->len) {
 			if (!insns || idx =3D=3D INSN_CHUNK_MAX) {
-				insns =3D calloc(sizeof(*insn), INSN_CHUNK_SIZE);
+				insns =3D calloc(INSN_CHUNK_SIZE, sizeof(*insn));
 				if (!insns) {
 					ERROR_GLIBC("calloc");
 					return -1;
@@ -607,7 +607,7 @@ static int init_pv_ops(struct objtool_file *file)
 		return 0;
=20
 	nr =3D sym->len / sizeof(unsigned long);
-	file->pv_ops =3D calloc(sizeof(struct pv_state), nr);
+	file->pv_ops =3D calloc(nr, sizeof(struct pv_state));
 	if (!file->pv_ops) {
 		ERROR_GLIBC("calloc");
 		return -1;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 2ea6d59..c27edee 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -736,7 +736,7 @@ static int elf_update_symbol(struct elf *elf, struct sect=
ion *symtab,
 	}
=20
 	/* setup extended section index magic and write the symbol */
-	if ((shndx >=3D SHN_UNDEF && shndx < SHN_LORESERVE) || is_special_shndx) {
+	if (shndx < SHN_LORESERVE || is_special_shndx) {
 		sym->sym.st_shndx =3D shndx;
 		if (!shndx_data)
 			shndx =3D 0;

