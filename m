Return-Path: <linux-tip-commits+bounces-6920-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE44BE2957
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF73E355633
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4647C33CE9D;
	Thu, 16 Oct 2025 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wfhIv0YH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g1IwdM+l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A078331E0EB;
	Thu, 16 Oct 2025 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608413; cv=none; b=uulO9wsVtxo3Y3GDGUC7VrRL6sqsgmt5SMTapklK2gcq2oe6p2GmLZXBrXUb1/SZZmI3OfUmO//5wNpzLz8+IfjssHLKK/z0T9O9MhHx7+S57I6SM2SYDNeRgmYRr8evCUKcLBd38D4gHFivx5WbvSsvpqn+oLxcBxqTRU9BwgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608413; c=relaxed/simple;
	bh=mDKkWqOLc36HOGHa/iBBaqLP/t1s4ya4uPiscQGHfxs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=PQAHCzwN9gkaaM8gTMukHVZLftfRxU0VEkdRtpN9nuHTeGJWvtXLAr10khyyKLf/qJltpIqziwfxZCe+qZF/2r/goVLhlb0kkVhBmBYSKaIjX/2RVhIhA7SVP1pa1ZmXTHft49uEyBnwehV3bT9/FiaEzCbcU+ZBxQXVsWlKUBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wfhIv0YH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g1IwdM+l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608377;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=QRBLsDmy6rn0U/51PNEsURbFfhL/7CdfzivsssRUsV0=;
	b=wfhIv0YHZFBzHgP4DUWEHmAONEaKb8KDKnQjiO3/zDvK/TAQUHbla70MmErM05NIfvRt8f
	lLTsDtaz1YfXnKKpOF7bz1OwDOceUtf2FSUQbVNdK1oBgY5h6BrDX1MHR8JGs1khMcwdWl
	ehTnS4FtYdTZUH4/vLSQAiY8X84RrRFIHV1hwsNLXAeIaTLgZ2ZcnJoPht0zv1TkKUXF9Z
	gQHwRGpfdOi33NwwEgchvyiLvPJ0cG9WnFJQz4ede/w30moXudDaWXVzGJI7xN0/H/ItrF
	RzUc6cCO4yHyQnN5U5ws73Z2nL73P+QjBUzQZ6ca5k/LaMZ/lwSeOylHbNdrAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608377;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=QRBLsDmy6rn0U/51PNEsURbFfhL/7CdfzivsssRUsV0=;
	b=g1IwdM+lXOVIrsgFV6mY5ZHDAVQmPhjV8fQ/drW2VHr1LI7QEHGc0hSRFFVwsEgIqZQTWr
	AThuviHNJQheR6Cw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix x86 addend calculation
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060837621.709179.3667405784600382812.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     41d24d78589705f85cbe90e5a8c1b55ea05557a2
Gitweb:        https://git.kernel.org/tip/41d24d78589705f85cbe90e5a8c1b55ea05=
557a2
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:28 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:24 -07:00

objtool: Fix x86 addend calculation

On x86, arch_dest_reloc_offset() hardcodes the addend adjustment to
four, but the actual adjustment depends on the relocation type.  Fix
that.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/loongarch/decode.c |  4 ++--
 tools/objtool/arch/powerpc/decode.c   |  4 ++--
 tools/objtool/arch/x86/decode.c       |  9 +++++++--
 tools/objtool/check.c                 | 15 +++++----------
 tools/objtool/include/objtool/arch.h  |  2 +-
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loong=
arch/decode.c
index 2e555c4..77942b9 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -17,9 +17,9 @@ unsigned long arch_jump_destination(struct instruction *ins=
n)
 	return insn->offset + (insn->immediate << 2);
 }
=20
-unsigned long arch_dest_reloc_offset(int addend)
+s64 arch_insn_adjusted_addend(struct instruction *insn, struct reloc *reloc)
 {
-	return addend;
+	return reloc_addend(reloc);
 }
=20
 bool arch_pc_relative_reloc(struct reloc *reloc)
diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc=
/decode.c
index c851c51..9b17885 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -14,9 +14,9 @@ int arch_ftrace_match(char *name)
 	return !strcmp(name, "_mcount");
 }
=20
-unsigned long arch_dest_reloc_offset(int addend)
+s64 arch_insn_adjusted_addend(struct instruction *insn, struct reloc *reloc)
 {
-	return addend;
+	return reloc_addend(reloc);
 }
=20
 bool arch_callee_saved_reg(unsigned char reg)
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 0ad5cc7..6742002 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -68,9 +68,14 @@ bool arch_callee_saved_reg(unsigned char reg)
 	}
 }
=20
-unsigned long arch_dest_reloc_offset(int addend)
+s64 arch_insn_adjusted_addend(struct instruction *insn, struct reloc *reloc)
 {
-	return addend + 4;
+	s64 addend =3D reloc_addend(reloc);
+
+	if (arch_pc_relative_reloc(reloc))
+		addend +=3D insn->offset + insn->len - reloc_offset(reloc);
+
+	return addend;
 }
=20
 unsigned long arch_jump_destination(struct instruction *insn)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 02c3e2d..65eb900 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1499,7 +1499,7 @@ static int add_jump_destinations(struct objtool_file *f=
ile)
 			dest_off =3D arch_jump_destination(insn);
 		} else if (reloc->sym->type =3D=3D STT_SECTION) {
 			dest_sec =3D reloc->sym->sec;
-			dest_off =3D arch_dest_reloc_offset(reloc_addend(reloc));
+			dest_off =3D arch_insn_adjusted_addend(insn, reloc);
 		} else if (reloc->sym->retpoline_thunk) {
 			if (add_retpoline_call(file, insn))
 				return -1;
@@ -1518,7 +1518,7 @@ static int add_jump_destinations(struct objtool_file *f=
ile)
 		} else if (reloc->sym->sec->idx) {
 			dest_sec =3D reloc->sym->sec;
 			dest_off =3D reloc->sym->sym.st_value +
-				   arch_dest_reloc_offset(reloc_addend(reloc));
+				   arch_insn_adjusted_addend(insn, reloc);
 		} else {
 			/* non-func asm code jumping to another file */
 			continue;
@@ -1663,7 +1663,7 @@ static int add_call_destinations(struct objtool_file *f=
ile)
 			}
=20
 		} else if (reloc->sym->type =3D=3D STT_SECTION) {
-			dest_off =3D arch_dest_reloc_offset(reloc_addend(reloc));
+			dest_off =3D arch_insn_adjusted_addend(insn, reloc);
 			dest =3D find_call_destination(reloc->sym->sec, dest_off);
 			if (!dest) {
 				ERROR_INSN(insn, "can't find call dest symbol at %s+0x%lx",
@@ -3315,7 +3315,7 @@ static bool pv_call_dest(struct objtool_file *file, str=
uct instruction *insn)
 	if (!reloc || strcmp(reloc->sym->name, "pv_ops"))
 		return false;
=20
-	idx =3D (arch_dest_reloc_offset(reloc_addend(reloc)) / sizeof(void *));
+	idx =3D arch_insn_adjusted_addend(insn, reloc) / sizeof(void *);
=20
 	if (file->pv_ops[idx].clean)
 		return true;
@@ -4396,12 +4396,7 @@ static int validate_ibt_insn(struct objtool_file *file=
, struct instruction *insn
 					      reloc_offset(reloc) + 1,
 					      (insn->offset + insn->len) - (reloc_offset(reloc) + 1))) {
=20
-		off =3D reloc->sym->offset;
-		if (reloc_type(reloc) =3D=3D R_X86_64_PC32 ||
-		    reloc_type(reloc) =3D=3D R_X86_64_PLT32)
-			off +=3D arch_dest_reloc_offset(reloc_addend(reloc));
-		else
-			off +=3D reloc_addend(reloc);
+		off =3D reloc->sym->offset + arch_insn_adjusted_addend(insn, reloc);
=20
 		dest =3D find_insn(file, reloc->sym->sec, off);
 		if (!dest)
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/obj=
tool/arch.h
index be33c7b..6866462 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -83,7 +83,7 @@ bool arch_callee_saved_reg(unsigned char reg);
=20
 unsigned long arch_jump_destination(struct instruction *insn);
=20
-unsigned long arch_dest_reloc_offset(int addend);
+s64 arch_insn_adjusted_addend(struct instruction *insn, struct reloc *reloc);
=20
 const char *arch_nop_insn(int len);
 const char *arch_ret_insn(int len);

