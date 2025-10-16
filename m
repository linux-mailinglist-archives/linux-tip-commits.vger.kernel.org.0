Return-Path: <linux-tip-commits+bounces-6917-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCA8BE2942
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55161A62949
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB8C33A02F;
	Thu, 16 Oct 2025 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CMkyeApc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jZ/wO1Oq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A34432E758;
	Thu, 16 Oct 2025 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608410; cv=none; b=dzYiP/DxQASQKLPR56MirDIGwTvAGnTaaArz7mrSE4yqfCNpLWXk5OhJAvfHqZi8TiBniYsKplUtE5amkSbfViWK8CFnDmA/Bl0s1E4HPSRCRSa1ymSTzIsqLPZcM7a1g/cvS3wH8+X1xQd9vOikC9i/ihg8Nl0XNksZ+pSoBt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608410; c=relaxed/simple;
	bh=Rbv4sLhpj3y55d4kusVUyJ1AVOWMVwMz/WQse5wv5EI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=k2yf3vZ8ZNmRe+7sLsLJkFE0H0eLwGdJApFrrCC5QuLfA5GPcmf4HA1CaQMDhsLakDhrccU1yRpPxKn3cWf+DROC+RpZQzxK500ANRfNdK86ZkyCAFmnu4wsXrt1PwgMqzqIDeDpbyYcd1fjfkzpPF9F/g3IcHBsgaM7rN4Novk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CMkyeApc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jZ/wO1Oq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608364;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=LUnmSBZNEh3fhDBok8Q9crKVUVnjxGCLft6pp84kSpo=;
	b=CMkyeApcjI41H9fApAGmxqCYu+NowWMhuHzWGigSTfTU1VubPjR5azS5AwAJnMgsQUm9Wf
	LedM/dcOnb5C56dSFLxCxIAx0XrDho67vqcu4th+O0QKC72hsWbfaR5Do8t/SmcQ+WSYoa
	JdN+7PIcJANvVt1XnJr972Xi5l9RJOtuZLw3XaWcZTFDtUpqdZhiDaPp+A7sGKGddEyXJe
	qaAEI813BhWtSFO2CRWu6djeFz+UjnzEbgLxH+iifyc+AUNjjBbhz0EPpaAwWvdu+8rZ4T
	OCdwomnjXxsZO7RO4rYPgffiUmtGhhlApj4o9248igQi17CGN4co6rwIx8McWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608364;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=LUnmSBZNEh3fhDBok8Q9crKVUVnjxGCLft6pp84kSpo=;
	b=jZ/wO1OqrHy/DyxVrFZUNzIP4Id1AgH/d1b4vTznw62Lytf12KIV72Vgb2tTJ99vuA/k4q
	FxfwtiWkwLA//vDQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix weak symbol hole detection for .cold
 functions
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060836342.709179.15914566929059147032.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     c9e9b85d41f9079d6a10faabf70a0b18d5c0f177
Gitweb:        https://git.kernel.org/tip/c9e9b85d41f9079d6a10faabf70a0b18d5c=
0f177
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:38 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:46:47 -07:00

objtool: Fix weak symbol hole detection for .cold functions

When ignore_unreachable_insn() looks for weak function holes which jump
to their .cold functions, it assumes the parent function comes before
the corresponding .cold function in the symbol table.  That's not
necessarily the case with -ffunction-sections.

Mark all the holes beforehand (including .cold functions) so the
ordering of the discovery doesn't matter.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c                 | 84 +++++++++++++-------------
 tools/objtool/include/objtool/check.h |  3 +-
 2 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1d28ff7..86f6e4d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2507,6 +2507,44 @@ static void mark_rodata(struct objtool_file *file)
 	file->rodata =3D found;
 }
=20
+static void mark_holes(struct objtool_file *file)
+{
+	struct instruction *insn;
+	bool in_hole =3D false;
+
+	if (!opts.link)
+		return;
+
+	/*
+	 * Whole archive runs might encounter dead code from weak symbols.
+	 * This is where the linker will have dropped the weak symbol in
+	 * favour of a regular symbol, but leaves the code in place.
+	 */
+	for_each_insn(file, insn) {
+		if (insn->sym || !find_symbol_hole_containing(insn->sec, insn->offset)) {
+			in_hole =3D false;
+			continue;
+		}
+
+		/* Skip function padding and pfx code */
+		if (!in_hole && insn->type =3D=3D INSN_NOP)
+			continue;
+
+		in_hole =3D true;
+		insn->hole =3D 1;
+
+		/*
+		 * If this hole jumps to a .cold function, mark it ignore.
+		 */
+		if (insn->jump_dest) {
+			struct symbol *dest_func =3D insn_func(insn->jump_dest);
+
+			if (dest_func && dest_func->cold)
+				dest_func->ignore =3D true;
+		}
+	}
+}
+
 static int decode_sections(struct objtool_file *file)
 {
 	mark_rodata(file);
@@ -2560,6 +2598,9 @@ static int decode_sections(struct objtool_file *file)
 	if (read_unwind_hints(file))
 		return -1;
=20
+	/* Must be after add_jump_destinations() */
+	mark_holes(file);
+
 	/*
 	 * Must be after add_call_destinations() such that it can override
 	 * dead_end_function() marks.
@@ -4021,7 +4062,8 @@ static bool ignore_unreachable_insn(struct objtool_file=
 *file, struct instructio
 	struct instruction *prev_insn;
 	int i;
=20
-	if (insn->type =3D=3D INSN_NOP || insn->type =3D=3D INSN_TRAP || (func && f=
unc->ignore))
+	if (insn->type =3D=3D INSN_NOP || insn->type =3D=3D INSN_TRAP ||
+	    insn->hole || (func && func->ignore))
 		return true;
=20
 	/*
@@ -4032,46 +4074,6 @@ static bool ignore_unreachable_insn(struct objtool_fil=
e *file, struct instructio
 	    !strcmp(insn->sec->name, ".altinstr_aux"))
 		return true;
=20
-	/*
-	 * Whole archive runs might encounter dead code from weak symbols.
-	 * This is where the linker will have dropped the weak symbol in
-	 * favour of a regular symbol, but leaves the code in place.
-	 *
-	 * In this case we'll find a piece of code (whole function) that is not
-	 * covered by a !section symbol. Ignore them.
-	 */
-	if (opts.link && !func) {
-		int size =3D find_symbol_hole_containing(insn->sec, insn->offset);
-		unsigned long end =3D insn->offset + size;
-
-		if (!size) /* not a hole */
-			return false;
-
-		if (size < 0) /* hole until the end */
-			return true;
-
-		sec_for_each_insn_continue(file, insn) {
-			/*
-			 * If we reach a visited instruction at or before the
-			 * end of the hole, ignore the unreachable.
-			 */
-			if (insn->visited)
-				return true;
-
-			if (insn->offset >=3D end)
-				break;
-
-			/*
-			 * If this hole jumps to a .cold function, mark it ignore too.
-			 */
-			if (insn->jump_dest && insn_func(insn->jump_dest) &&
-			    insn_func(insn->jump_dest)->cold)
-				insn_func(insn->jump_dest)->ignore =3D true;
-		}
-
-		return false;
-	}
-
 	if (!func)
 		return false;
=20
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/ob=
jtool/check.h
index 00fb745..0f4e7ac 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -64,7 +64,8 @@ struct instruction {
 	    noendbr		: 1,
 	    unret		: 1,
 	    visited		: 4,
-	    no_reloc		: 1;
+	    no_reloc		: 1,
+	    hole		: 1;
 		/* 10 bit hole */
=20
 	struct alt_group *alt_group;

