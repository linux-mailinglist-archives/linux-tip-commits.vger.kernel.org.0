Return-Path: <linux-tip-commits+bounces-8129-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOu9C3rNeWmOzgEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8129-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 09:48:58 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8246F9E636
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 09:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35CE9303FA9C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 08:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0836B3385B6;
	Wed, 28 Jan 2026 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qqw/3B18";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="efS1qzg7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6222F338925;
	Wed, 28 Jan 2026 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769590001; cv=none; b=jcJVFFQUymAc81ZfC83+Obv9w7v8n+yi8gAkkOiF48Whp95+5pMY3x6V7e6zQsvE1FEy+TZmDJjAL1jObOeIuYRmba2MmA++pWzimTBo5KKZVzRpFTKSpCX+OxjxsUfKDRzougcEzpJCIZsI7fQOesM04QOKAdtAtq6FGScByU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769590001; c=relaxed/simple;
	bh=oDEe3Jww9UnJHeeWmQ7qe7DluqM5+1Rd4MLC7TzGtQk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H66PYIo672Q1VS+sGyvOYMoyuVsA5u2RSSP44tOsGkowENb+vQ8aCoH0WfON7rCz7tcngvdXEAIjb/5/qf9umWm5qx08luNihqH6qppY6XZhTXpNOVPkfVOR7g90JpdZtUdLbL5SECm6LW7v2qq7NEVXjvVXLQAoF8ZXONbtXGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qqw/3B18; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=efS1qzg7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Jan 2026 08:46:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769589998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myxLzNqiXC2MrmKqO6Xh2zS6bj+kyT7THPFYXJXqscE=;
	b=qqw/3B18nDFTaDGAnyRa977UnOVwQJ0XmNq/fQF/bYkbJRlHINP4xYK71rUYTyUvHhB3mL
	dZ77gjV12/8MoydNP0K1hSrhaGNokRs5oSwcZRJVvJZq7VTL+XwODAYVP++fQy4GkIBDx8
	97c9+9hsPL+Du4rKVW1tVN1FECKGFwPvbO189nwDTs5Y1dBVgLEMV82zfy2HG1nMh4f020
	9HnJVESh+948OW8o68uD6YCpfyjLkgz3R6ufxsfcKOnW1aOu1M/g4HQBUoLz78Isqke+aX
	ed+Bus/7WtYyFSfI9oV3KsCBbYqH2T4Oqu+wnHSQCMWRQDZohwf+Mg7tCMgsvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769589998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myxLzNqiXC2MrmKqO6Xh2zS6bj+kyT7THPFYXJXqscE=;
	b=efS1qzg72HNs1RD3Fk2qA415o4LZeSFdLIdOZ/4tlDNF6TY8ulo5TVCIlLu+7kjHzoumoW
	/lUsZH9YuB1oCoBQ==
From: "tip-bot2 for Dmitry Safonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Print bfd_vma as unsigned long long on
 ia32-x86_64 cross build
Cc: Dmitry Safonov <dima@arista.com>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260126-objtool-ia32-v1-1-bb6feaf17566@arista.com>
References: <20260126-objtool-ia32-v1-1-bb6feaf17566@arista.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176958999701.510.16609960951894815108.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linutronix.de:dkim,arista.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8129-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 8246F9E636
X-Rspamd-Action: no action

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     fd4eeb30b9e30ca1118a618be0755287bcbb2da9
Gitweb:        https://git.kernel.org/tip/fd4eeb30b9e30ca1118a618be0755287bcb=
b2da9
Author:        Dmitry Safonov <dima@arista.com>
AuthorDate:    Mon, 26 Jan 2026 04:57:35=20
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 27 Jan 2026 08:19:35 -08:00

objtool: Print bfd_vma as unsigned long long on ia32-x86_64 cross build

When objtool is cross-compiled in ia32 container for x86_64 target it
fails with the following errors:

> disas.c: In function 'disas_print_addr_sym':
> disas.c:173:38: error: format '%lx' expects argument of type 'long unsigned=
 int', but argument 3 has type 'bfd_vma' {aka 'long long unsigned int'} [-Wer=
ror=3Dformat=3D]
>   173 |                 DINFO_FPRINTF(dinfo, "0x%lx <%s>", addr, symstr);
>       |                                      ^~~~~~~~~~~~  ~~~~
>       |                                                    |
>       |                                                    bfd_vma {aka lon=
g long unsigned int}

Provide a correct printf-fmt depending on sizeof(bfd_vma).

Fixes: 5d859dff266f ("objtool: Print symbol during disassembly")
Signed-off-by: Dmitry Safonov <dima@arista.com>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Link: https://patch.msgid.link/20260126-objtool-ia32-v1-1-bb6feaf17566@arista=
.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/disas.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 2b5059f..26f08d4 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -108,6 +108,8 @@ static int sprint_name(char *str, const char *name, unsig=
ned long offset)
=20
 #define DINFO_FPRINTF(dinfo, ...)	\
 	((*(dinfo)->fprintf_func)((dinfo)->stream, __VA_ARGS__))
+#define bfd_vma_fmt			\
+	__builtin_choose_expr(sizeof(bfd_vma) =3D=3D sizeof(unsigned long), "%#lx <=
%s>", "%#llx <%s>")
=20
 static int disas_result_fprintf(struct disas_context *dctx,
 				const char *fmt, va_list ap)
@@ -170,10 +172,10 @@ static void disas_print_addr_sym(struct section *sec, s=
truct symbol *sym,
=20
 	if (sym) {
 		sprint_name(symstr, sym->name, addr - sym->offset);
-		DINFO_FPRINTF(dinfo, "0x%lx <%s>", addr, symstr);
+		DINFO_FPRINTF(dinfo, bfd_vma_fmt, addr, symstr);
 	} else {
 		str =3D offstr(sec, addr);
-		DINFO_FPRINTF(dinfo, "0x%lx <%s>", addr, str);
+		DINFO_FPRINTF(dinfo, bfd_vma_fmt, addr, str);
 		free(str);
 	}
 }
@@ -252,7 +254,7 @@ static void disas_print_addr_reloc(bfd_vma addr, struct d=
isassemble_info *dinfo)
 		 * example: "lea 0x0(%rip),%rdi". The kernel can reference
 		 * the next IP with _THIS_IP_ macro.
 		 */
-		DINFO_FPRINTF(dinfo, "0x%lx <_THIS_IP_>", addr);
+		DINFO_FPRINTF(dinfo, bfd_vma_fmt, addr, "_THIS_IP_");
 		return;
 	}
=20
@@ -264,11 +266,11 @@ static void disas_print_addr_reloc(bfd_vma addr, struct=
 disassemble_info *dinfo)
 	 */
 	if (reloc->sym->type =3D=3D STT_SECTION) {
 		str =3D offstr(reloc->sym->sec, reloc->sym->offset + offset);
-		DINFO_FPRINTF(dinfo, "0x%lx <%s>", addr, str);
+		DINFO_FPRINTF(dinfo, bfd_vma_fmt, addr, str);
 		free(str);
 	} else {
 		sprint_name(symstr, reloc->sym->name, offset);
-		DINFO_FPRINTF(dinfo, "0x%lx <%s>", addr, symstr);
+		DINFO_FPRINTF(dinfo, bfd_vma_fmt, addr, symstr);
 	}
 }
=20
@@ -311,7 +313,7 @@ static void disas_print_address(bfd_vma addr, struct disa=
ssemble_info *dinfo)
 	 */
 	sym =3D insn_call_dest(insn);
 	if (sym && (sym->offset =3D=3D addr || (sym->offset =3D=3D 0 && is_reloc)))=
 {
-		DINFO_FPRINTF(dinfo, "0x%lx <%s>", addr, sym->name);
+		DINFO_FPRINTF(dinfo, bfd_vma_fmt, addr, sym->name);
 		return;
 	}
=20

