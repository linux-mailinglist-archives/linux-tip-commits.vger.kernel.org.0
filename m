Return-Path: <linux-tip-commits+bounces-8407-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BKNMZQmr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8407-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:59:16 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F17B2407DD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D905D3077CC8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208F241C2FA;
	Mon,  9 Mar 2026 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vJKBuRsV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T0tiJ5V2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284DC41B36D;
	Mon,  9 Mar 2026 19:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086061; cv=none; b=TpOnQynfsDr7oOV1DOr75hgIwHXNiW4ikxWLPHS2WpLtt91bZdV/BzHpLNOTIgCLlZJgq2r3X6IG2MaC7XVpNkLhyZX1yZww15LGo+wMjInshfk0BAEbVH2nlSLOuLimfooX35uU8CzhkGfI5DhYHqp2GG2zbOcij+furBxdMzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086061; c=relaxed/simple;
	bh=39I/xiWdMkxAT59IsC1hCBTyQvo40wHCvBAxK58HCRw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pJOy22gz9gEeBxKr+mw6p7neosy+IQl96nCsZBHsSNGPA4Xj7E5a+Eqd+68BrQfEiTJQENlEOvjquXMcfRHmbDdA0i5KIps9lQszXBf9Ah/7d8SW0Q8yFR/gqr78xKAe3Zum1ycOY04Vr3n6KM6N8HN3reSG7BsAr5oWPa6Maqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vJKBuRsV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T0tiJ5V2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:54:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773086057;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiB75QpMU75h6EYZA2pc/qyMUfUXkNIe9SjjMcQZ2VQ=;
	b=vJKBuRsV+LohTjDOBADPEyyy5xYxotNPwT75VeX09DOtekGIl13rdpg1iJaGX/T6E9f0TO
	3+h5o8whk9PafWF/TT6/SusvMxNs6+X/NuxgP80Y7mBn1u87kcOgHfBJcqxD4vsHAlMfNf
	MaZFcLNVcgXojB+6JvonrxP2djpBb4uZN3FiyuVkloRNZlEBoKPy//kg68+eIyGvKv1DbT
	ssRrekRz/CRe7jTkDa1AaFAMaW4Zvl1kqz5PdzySMqJ2PkhCzoyfNVbvgigOFbAicQJTMJ
	WTfng4ox4brgoBl5ccmMI3wEMFZ6xO4zGsnKNdZLXSPsRuSiMj9QoRXnZB65/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773086057;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiB75QpMU75h6EYZA2pc/qyMUfUXkNIe9SjjMcQZ2VQ=;
	b=T0tiJ5V2KPc1ab2wqCAtfJu4tbLh6l4eqF6rOgDlGAxhe5TbPspRmRt+XwU8OoNSKHoKFT
	FwAZ3BwYVpw+5FBQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool/klp: Avoid NULL pointer dereference
 when printing code symbol name
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <64116517bc93851a98fe366ea0a4d807f4c70aab.1770759954.git.jpoimboe@kernel.org>
References:
 <64116517bc93851a98fe366ea0a4d807f4c70aab.1770759954.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308605665.1647592.5541036486670705441.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7F17B2407DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8407-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:replyto,msgid.link:url]
X-Rspamd-Action: no action

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     11c2adcd1fa2a9380a507db1e57c8542bfc81827
Gitweb:        https://git.kernel.org/tip/11c2adcd1fa2a9380a507db1e57c8542bfc=
81827
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 10 Feb 2026 13:50:11 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Fri, 06 Mar 2026 07:47:11 -08:00

objtool/klp: Avoid NULL pointer dereference when printing code symbol name

Fix a hypothetical NULL pointer defereference of the 'code_sym'
variable.  In theory this should never happen.

Reviewed-and-tested-by: Song Liu <song@kernel.org>
Link: https://patch.msgid.link/64116517bc93851a98fe366ea0a4d807f4c70aab.17707=
59954.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 9ff65b0..a3198a6 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1352,7 +1352,7 @@ static int validate_special_section_klp_reloc(struct el=
fs *e, struct symbol *sym
 {
 	bool static_branch =3D !strcmp(sym->sec->name, "__jump_table");
 	bool static_call   =3D !strcmp(sym->sec->name, ".static_call_sites");
-	struct symbol *code_sym =3D NULL;
+	const char *code_sym =3D NULL;
 	unsigned long code_offset =3D 0;
 	struct reloc *reloc;
 	int ret =3D 0;
@@ -1372,7 +1372,7 @@ static int validate_special_section_klp_reloc(struct el=
fs *e, struct symbol *sym
=20
 			/* Save code location which can be printed below */
 			if (reloc->sym->type =3D=3D STT_FUNC && !code_sym) {
-				code_sym =3D reloc->sym;
+				code_sym =3D reloc->sym->name;
 				code_offset =3D reloc_addend(reloc);
 			}
=20
@@ -1395,23 +1395,26 @@ static int validate_special_section_klp_reloc(struct =
elfs *e, struct symbol *sym
 		if (!strcmp(sym_modname, "vmlinux"))
 			continue;
=20
+		if (!code_sym)
+			code_sym =3D "<unknown>";
+
 		if (static_branch) {
 			if (strstarts(reloc->sym->name, "__tracepoint_")) {
 				WARN("%s: disabling unsupported tracepoint %s",
-				     code_sym->name, reloc->sym->name + 13);
+				     code_sym, reloc->sym->name + 13);
 				ret =3D 1;
 				continue;
 			}
=20
 			if (strstr(reloc->sym->name, "__UNIQUE_ID_ddebug_")) {
 				WARN("%s: disabling unsupported pr_debug()",
-				     code_sym->name);
+				     code_sym);
 				ret =3D 1;
 				continue;
 			}
=20
 			ERROR("%s+0x%lx: unsupported static branch key %s.  Use static_key_enable=
d() instead",
-			      code_sym->name, code_offset, reloc->sym->name);
+			      code_sym, code_offset, reloc->sym->name);
 			return -1;
 		}
=20
@@ -1422,7 +1425,7 @@ static int validate_special_section_klp_reloc(struct el=
fs *e, struct symbol *sym
 		}
=20
 		ERROR("%s()+0x%lx: unsupported static call key %s.  Use KLP_STATIC_CALL() =
instead",
-		      code_sym->name, code_offset, reloc->sym->name);
+		      code_sym, code_offset, reloc->sym->name);
 		return -1;
 	}
=20

