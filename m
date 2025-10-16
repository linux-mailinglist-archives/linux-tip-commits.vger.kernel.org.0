Return-Path: <linux-tip-commits+bounces-6886-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8CFBE28D0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1152F1A62801
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE97320CA2;
	Thu, 16 Oct 2025 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dUb336KC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t2JHALW/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7934A32ED2B;
	Thu, 16 Oct 2025 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608380; cv=none; b=omn3XkclRl3f0Yuxmo2fQN2oNnrwaPBSvOx4i2qo+APmQfdvlwg9ljVMPDY6VDUP1DyQ7a0ROonKvrTpkwoufVGMNxCXKowjqh3z0oun4A2HakeHggemMARFlXk53Wv3mKcyArr5Kze21UwfLsNNAfaDXC0wZpmAu77xOH1ve7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608380; c=relaxed/simple;
	bh=tombo2CMWoqlCv+cZGgHvoejpyBiH5RIup1hTYO1do4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=WfVrI8KeVmgNZA8Df1sfkfQOIKG5suJFqMKAR+ZA62/eMjH+fkgsQJXehwfr8tSMbXLFwZH75p76yAtFx3qLaNs1Z8AeyT900xnQY9u7JFKINVEp84hEBDhLo0HHdJQGzdPdSdDZMfQ2iUJK6tjtCCsJDhMyXjO80LOwxOuAG+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dUb336KC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t2JHALW/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608366;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qWxz9O8QMdn7ZNQXSbdM7LfrWFiK0GjsrErZU8hLkqs=;
	b=dUb336KCuUhjLpAoS0NVgW0PCEoFRVX1MJSgZZS/R8uboPmkpB0l7YCjmBcylAzUhH5i15
	pHJhrpgOH4REGLvs+FF+oietEg8SuFjtwvQa24TAtoQ4XDKscRDY3hs+HfQoX7FyQXIWpu
	J5W0m2CucEB7n6YYgFO/hdlCnM7gJw00UE8IRp12RDPXU7S7faKnLuJ6ny2jsCQXqWmeQL
	QTnw669vBPivOuIkz/k7Ow8fS9hq6xPUSvvHO3zK1UdOZLNCXQzheCdRXuJBCbUDa7AL+P
	5JrMeDcK819hfA1bMnxWwEAOf35+1G1+vgUsOPW1CX1ON6sw2Yot9CO04UmV9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608366;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qWxz9O8QMdn7ZNQXSbdM7LfrWFiK0GjsrErZU8hLkqs=;
	b=t2JHALW/VzN6LIVjcmY1bjXxkizKdEojUJGqKhahJ02zH4+OwoBeQHV2gDA1Xsybzq1Q/4
	gSdtJvdq42e+rgAg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Mark .cold subfunctions
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060836470.709179.4873817649228378520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     4ea029389bf0cc44da6d3a24a520200e060ce6bf
Gitweb:        https://git.kernel.org/tip/4ea029389bf0cc44da6d3a24a520200e060=
ce6bf
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:37 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:46:46 -07:00

objtool: Mark .cold subfunctions

Introduce a flag to identify .cold subfunctions so they can be detected
easier and faster.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 14 ++++++--------
 tools/objtool/elf.c                 | 19 ++++++++++---------
 tools/objtool/include/objtool/elf.h |  1 +
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f38f4a2..1d28ff7 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1575,7 +1575,9 @@ static int add_jump_destinations(struct objtool_file *f=
ile)
 		/*
 		 * Cross-function jump.
 		 */
-		if (func && insn_func(jump_dest) && func !=3D insn_func(jump_dest)) {
+
+		if (func && insn_func(jump_dest) && !func->cold &&
+		    insn_func(jump_dest)->cold) {
=20
 			/*
 			 * For GCC 8+, create parent/child links for any cold
@@ -1592,11 +1594,8 @@ static int add_jump_destinations(struct objtool_file *=
file)
 			 * case where the parent function's only reference to a
 			 * subfunction is through a jump table.
 			 */
-			if (!strstr(func->name, ".cold") &&
-			    strstr(insn_func(jump_dest)->name, ".cold")) {
-				func->cfunc =3D insn_func(jump_dest);
-				insn_func(jump_dest)->pfunc =3D func;
-			}
+			func->cfunc =3D insn_func(jump_dest);
+			insn_func(jump_dest)->pfunc =3D func;
 		}
=20
 		if (jump_is_sibling_call(file, insn, jump_dest)) {
@@ -4066,9 +4065,8 @@ static bool ignore_unreachable_insn(struct objtool_file=
 *file, struct instructio
 			 * If this hole jumps to a .cold function, mark it ignore too.
 			 */
 			if (insn->jump_dest && insn_func(insn->jump_dest) &&
-			    strstr(insn_func(insn->jump_dest)->name, ".cold")) {
+			    insn_func(insn->jump_dest)->cold)
 				insn_func(insn->jump_dest)->ignore =3D true;
-			}
 		}
=20
 		return false;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d36c0d4..5956838 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -441,6 +441,10 @@ static void elf_add_symbol(struct elf *elf, struct symbo=
l *sym)
 	list_add(&sym->list, entry);
 	elf_hash_add(symbol, &sym->hash, sym->idx);
 	elf_hash_add(symbol_name, &sym->name_hash, str_hash(sym->name));
+
+	if (is_func_sym(sym) && strstr(sym->name, ".cold"))
+		sym->cold =3D 1;
+	sym->pfunc =3D sym->cfunc =3D sym;
 }
=20
 static int read_symbols(struct elf *elf)
@@ -527,18 +531,15 @@ static int read_symbols(struct elf *elf)
 		sec_for_each_sym(sec, sym) {
 			char *pname;
 			size_t pnamelen;
-			if (!is_func_sym(sym))
-				continue;
=20
-			if (sym->pfunc =3D=3D NULL)
-				sym->pfunc =3D sym;
-
-			if (sym->cfunc =3D=3D NULL)
-				sym->cfunc =3D sym;
+			if (!sym->cold)
+				continue;
=20
 			coldstr =3D strstr(sym->name, ".cold");
-			if (!coldstr)
-				continue;
+			if (!coldstr) {
+				ERROR("%s(): cold subfunction without \".cold\"?", sym->name);
+				return -1;
+			}
=20
 			pnamelen =3D coldstr - sym->name;
 			pname =3D strndup(sym->name, pnamelen);
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index f2dbcaa..dbadcc8 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -72,6 +72,7 @@ struct symbol {
 	u8 frame_pointer     : 1;
 	u8 ignore	     : 1;
 	u8 nocfi             : 1;
+	u8 cold		     : 1;
 	struct list_head pv_target;
 	struct reloc *relocs;
 	struct section *group_sec;

