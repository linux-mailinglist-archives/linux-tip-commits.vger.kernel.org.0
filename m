Return-Path: <linux-tip-commits+bounces-6896-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 851A4BE28F4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68ED318986A9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE0F320CCC;
	Thu, 16 Oct 2025 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VKRfo9OQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="etnFqhHX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856ED319601;
	Thu, 16 Oct 2025 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608387; cv=none; b=uNo5KrN7g6sOuQjcpUXpJoSTY5N/5Yo1f41HE8vbDldudJq0P45Q9QKIqOoORNNYzoTvyx7ORhUwb4kLZdoxVPU4u9sVVzsUV0sQa59GoiC640IyWZ2ukd0RumY3Y6CXRStk2pYeEkuAMkNaGKoWnitZmy7yQWnYV61G5a1GcBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608387; c=relaxed/simple;
	bh=wE2Et4v4XMW1oAPDXV5AffBqHEwu5RIpS4K1t14HtkY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=hY1E0YKXI49eSQBPfuIHmDZxFzhIK/XuM/jTLzSUAi4LPlwUww6PhtXR+ZlrZkgiT9bTsp3ddZmNOGTn9IIjzXYBZY7yKxWvS9L/6+KkUKCDarHsHyXTUPAAp1eAqN1d79j8cDZoz0MMDyyt+KFUISag4jgpgSqurgS2kKTLMzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VKRfo9OQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=etnFqhHX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608372;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ESH8fvpa8LLxyNR1tcXEJp3KhyeOfoY28gYhwuLT9S8=;
	b=VKRfo9OQVl9mB6bKNEWpbEtzLKAqLqgsd0Hq4p8Z2PPcZyLTr8FQcYS4RnmaBNPida3mfH
	i0H3vXnBBhHn3/+R7k22TOAMfOerCN0dtct0guJQGuTpY84V2ZexQP2lrGXFUZ5DmOrrP4
	tRpRXi5j2HEv7MEtaIOk9Dq1HSDzIeCfsjbgwyLNfauvenXVGUmT4grNzlr4pvHPQyTiMq
	WSpbeBNaeTjbHnkzIoaXtCcAgaVOdST09hB4tjR0O6rmhCobbuc4C7LcM3WpUWAvRol80w
	lFwOEBNN5kzb7/09uq4MSObKfrSczZae350JIsBBAx/SOmdlzVgyp/spGdkDzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608372;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ESH8fvpa8LLxyNR1tcXEJp3KhyeOfoY28gYhwuLT9S8=;
	b=etnFqhHXutq9p2YqpyFnxfQKkDAGOp2W2aKJDEXopnTaCN5AdIYw3OenVY7l79UeMHoACS
	FEGlg3F9dKga7zAA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Const string cleanup
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060837119.709179.3869682979140292678.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     34244f784c6d062af184944a25f40ab50dfdb67a
Gitweb:        https://git.kernel.org/tip/34244f784c6d062af184944a25f40ab50df=
db67a
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:32 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:24 -07:00

objtool: Const string cleanup

Use 'const char *' where applicable.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/loongarch/decode.c | 2 +-
 tools/objtool/arch/powerpc/decode.c   | 2 +-
 tools/objtool/arch/x86/decode.c       | 2 +-
 tools/objtool/elf.c                   | 6 +++---
 tools/objtool/include/objtool/arch.h  | 2 +-
 tools/objtool/include/objtool/elf.h   | 6 +++---
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loong=
arch/decode.c
index 77942b9..0115b97 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -7,7 +7,7 @@
 #include <linux/objtool_types.h>
 #include <arch/elf.h>
=20
-int arch_ftrace_match(char *name)
+int arch_ftrace_match(const char *name)
 {
 	return !strcmp(name, "_mcount");
 }
diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc=
/decode.c
index 9b17885..d4cb021 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -9,7 +9,7 @@
 #include <objtool/builtin.h>
 #include <objtool/endianness.h>
=20
-int arch_ftrace_match(char *name)
+int arch_ftrace_match(const char *name)
 {
 	return !strcmp(name, "_mcount");
 }
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index b10200c..6bb46d9 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -23,7 +23,7 @@
 #include <objtool/builtin.h>
 #include <arch/elf.h>
=20
-int arch_ftrace_match(char *name)
+int arch_ftrace_match(const char *name)
 {
 	return !strcmp(name, "__fentry__");
 }
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d7fb3d0..2ea6d59 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -853,7 +853,7 @@ elf_create_section_symbol(struct elf *elf, struct section=
 *sec)
 	return sym;
 }
=20
-static int elf_add_string(struct elf *elf, struct section *strtab, char *str=
);
+static int elf_add_string(struct elf *elf, struct section *strtab, const cha=
r *str);
=20
 struct symbol *
 elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long size)
@@ -1086,7 +1086,7 @@ err:
 	return NULL;
 }
=20
-static int elf_add_string(struct elf *elf, struct section *strtab, char *str)
+static int elf_add_string(struct elf *elf, struct section *strtab, const cha=
r *str)
 {
 	Elf_Data *data;
 	Elf_Scn *s;
@@ -1111,7 +1111,7 @@ static int elf_add_string(struct elf *elf, struct secti=
on *strtab, char *str)
 		return -1;
 	}
=20
-	data->d_buf =3D str;
+	data->d_buf =3D strdup(str);
 	data->d_size =3D strlen(str) + 1;
 	data->d_align =3D 1;
=20
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/obj=
tool/arch.h
index 6866462..a450294 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -71,7 +71,7 @@ struct stack_op {
=20
 struct instruction;
=20
-int arch_ftrace_match(char *name);
+int arch_ftrace_match(const char *name);
=20
 void arch_initial_func_cfi_state(struct cfi_init_state *state);
=20
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index df8434d..74ce454 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -40,7 +40,7 @@ struct section {
 	struct section *base, *rsec;
 	struct symbol *sym;
 	Elf_Data *data;
-	char *name;
+	const char *name;
 	int idx;
 	bool _changed, text, rodata, noinstr, init, truncate;
 	struct reloc *relocs;
@@ -53,7 +53,7 @@ struct symbol {
 	struct elf_hash_node name_hash;
 	GElf_Sym sym;
 	struct section *sec;
-	char *name;
+	const char *name;
 	unsigned int idx, len;
 	unsigned long offset;
 	unsigned long __subtree_last;
@@ -88,7 +88,7 @@ struct elf {
 	GElf_Ehdr ehdr;
 	int fd;
 	bool changed;
-	char *name;
+	const char *name;
 	unsigned int num_files;
 	struct list_head sections;
 	unsigned long num_relocs;

