Return-Path: <linux-tip-commits+bounces-6895-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3437BBE28F1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3F0335404B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0828D330D5D;
	Thu, 16 Oct 2025 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mHLrv/W3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nWY/kJXU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6650232E755;
	Thu, 16 Oct 2025 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608387; cv=none; b=gYG9Ty+SlEvXaqQGYFTWUROwN+hu6BG5QOQgf+y4qA3hDGsVRFfSqAF3VWGohe8bY9Zpk5Xr3du7Q8kPcSjKMHeBr7J126VgTz5Z4SyerPEfU9ekhwq8cqbrc1ZUccAmJlIokFQOotRTwnoMNTNAiXYy3mfpbcpVSf6PBSPls8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608387; c=relaxed/simple;
	bh=hQZF0cx8FAvPPgo7k+OzQBERYij/4nGSTVHg+LusxB0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=sx6seYgPhCM1BfqDQOguax0QdSNBYQlFG4BdscuBO3jsib79fDUDxY0ZtxDaefiG+8S2d1VcsXbCE1zTc3IbfJJininmkB1nxUEXm3z/0M3khxDQkvvonwnKIUA7ujZWlDYlN0FMKu0Tp0514jDANzPr34p4ANb9tdeFScPV92c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mHLrv/W3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nWY/kJXU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608363;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cq4EeFbpTUBWGz7EBZF6X3Fto1Cf+P7cKmEMb4hhQA4=;
	b=mHLrv/W36E5cP4vrAMsShoXeQWuE53rMWdV25fB0Z8FgYvHTFczAr/51YOkIhGDKSXo/Zr
	xNuJT0Y5fXo037DiUC2GHZhVAfRYaeYeABcZrWjswMaYfRsDPUg/7EtBBLvXaYKafmAwm1
	r7QLPOVNGnmqfdD6SsXFz+yU6vJnj/c3gRF7ZEokMcBkdw6Jhwzupr3ItCiNyQJ8efnQY5
	RuF8NvCy3G9/enNW1IyFk5PWONjDOgogeQK2EG9lSugAhYfPadRxxHA/ZK5gu+6t7K1z9U
	Ga8jTgbPjADZT4uFjEamggWbsAl1oAAcNibak+L0Y6iqWGmtOBka1CaS+J4Bpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608363;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cq4EeFbpTUBWGz7EBZF6X3Fto1Cf+P7cKmEMb4hhQA4=;
	b=nWY/kJXUgAw526LHywlhJLsgU1olb/4S8X0oDXkCEOLn1IZkW/hF8EIM2AunnbvpQ+4TSK
	DmGLO/ziBa/WkwAQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Mark prefix functions
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060836216.709179.1189848202043215341.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     a1526bcfcb6cb7cb601b9ff8e24d08881ef9afb8
Gitweb:        https://git.kernel.org/tip/a1526bcfcb6cb7cb601b9ff8e24d08881ef=
9afb8
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:39 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:46:47 -07:00

objtool: Mark prefix functions

In preparation for the objtool klp diff subcommand, introduce a flag to
identify __pfx_*() and __cfi_*() functions in advance so they don't need
to be manually identified every time a check is needed.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 5 +----
 tools/objtool/elf.c                 | 7 +++++++
 tools/objtool/include/objtool/elf.h | 6 ++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 86f6e4d..46b425f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3568,10 +3568,7 @@ static int validate_branch(struct objtool_file *file, =
struct symbol *func,
=20
 		if (func && insn_func(insn) && func !=3D insn_func(insn)->pfunc) {
 			/* Ignore KCFI type preambles, which always fall through */
-			if (!strncmp(func->name, "__cfi_", 6) ||
-			    !strncmp(func->name, "__pfx_", 6) ||
-			    !strncmp(func->name, "__pi___cfi_", 11) ||
-			    !strncmp(func->name, "__pi___pfx_", 11))
+			if (is_prefix_func(func))
 				return 0;
=20
 			if (file->ignore_unreachables)
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 5956838..775d017 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -442,6 +442,13 @@ static void elf_add_symbol(struct elf *elf, struct symbo=
l *sym)
 	elf_hash_add(symbol, &sym->hash, sym->idx);
 	elf_hash_add(symbol_name, &sym->name_hash, str_hash(sym->name));
=20
+	if (is_func_sym(sym) &&
+	    (strstarts(sym->name, "__pfx_") ||
+	     strstarts(sym->name, "__cfi_") ||
+	     strstarts(sym->name, "__pi___pfx_") ||
+	     strstarts(sym->name, "__pi___cfi_")))
+		sym->prefix =3D 1;
+
 	if (is_func_sym(sym) && strstr(sym->name, ".cold"))
 		sym->cold =3D 1;
 	sym->pfunc =3D sym->cfunc =3D sym;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index dbadcc8..79edf82 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -73,6 +73,7 @@ struct symbol {
 	u8 ignore	     : 1;
 	u8 nocfi             : 1;
 	u8 cold		     : 1;
+	u8 prefix	     : 1;
 	struct list_head pv_target;
 	struct reloc *relocs;
 	struct section *group_sec;
@@ -230,6 +231,11 @@ static inline bool is_local_sym(struct symbol *sym)
 	return sym->bind =3D=3D STB_LOCAL;
 }
=20
+static inline bool is_prefix_func(struct symbol *sym)
+{
+	return sym->prefix;
+}
+
 static inline bool is_reloc_sec(struct section *sec)
 {
 	return sec->sh.sh_type =3D=3D SHT_RELA || sec->sh.sh_type =3D=3D SHT_REL;

