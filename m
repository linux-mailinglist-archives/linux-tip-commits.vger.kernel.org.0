Return-Path: <linux-tip-commits+bounces-8208-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAlpGc/BhGnG4wMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8208-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Feb 2026 17:14:07 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08829F510C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Feb 2026 17:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D564030058F4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Feb 2026 16:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F8A43635B;
	Thu,  5 Feb 2026 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ML37cw8U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Aq2BOF6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D092742DFF9;
	Thu,  5 Feb 2026 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308042; cv=none; b=mycsR5eb/jojgdOj5w5VRmCed5WTnE4fn2/8LgVifIK1xejg3A0b3y+7Nb4TxILyCIUI3b3HFtwfvga2hNMssJY/XDPztJ7bhBLOrMCxmK1FOWTOQwMCEnp9Glg8CW/WVRyjRhBN6P2KwSxpLHGfAG0UFH5T7uf/Tx/OybExqy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308042; c=relaxed/simple;
	bh=7mLyDq9yFUWa08JtKtWnS+m5qmYIB+5L33nq3/rKvvY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lOqc5htmVH15gaFk0kk18TzGNNdq2l6nfph+SwjDQyAi5t/pbIz2eBh7l8IEB3HdGHbw2c7mil5C1C2ukwAbcc3NdVNOi/RS8TVOkZXJXkNFTEux2G3YykhZFG5yXcQ0qx3pV5niQ4YsdVuzaD/sSBGKQOQwXkma/dOtXWi9iGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ML37cw8U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Aq2BOF6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Feb 2026 16:13:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770308040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cK90Is/3z/v9eXCoCDxnUJ+slka4BR7mBbtpRv0f6/s=;
	b=ML37cw8UlfeBP7tedAAHVHSUr5vqv9dNheB3Dr2lfnw7IEC7uMgkkdnk0k7DJWwgsZyO9Q
	4cI1EbYxagC2SCrz5aLlXlLS9YA6XjodoUMP1t5jhBVaUDl6hgWXRS1kvNy0/9TDKyxeIW
	bSCrfQOBZoVhqYM4vtdPMZz4w0q9Ex3CmPAelPO8UL7Qd+U1+AkCa+KhZde654hoRoTzE6
	/0V6WG04coyh9YuV6v9wpXGgxgTtNKBjtMWPSfw0k5lgDaeWR/duM1BiM9j4sw3GJI7Doc
	mB3haD2ZM2MhV/Zzw8VqrBFLIP6Ve7u8bHWOtP3w2IcPXTvi+upe1iqd6/0uRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770308040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cK90Is/3z/v9eXCoCDxnUJ+slka4BR7mBbtpRv0f6/s=;
	b=0Aq2BOF6GLl+Go555up2psb8GxtY5DJY+vVQbnXAIFCBB9a27+NI52hG8d2sUkqXKuYiou
	/tZqecyJHqGsyoCw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool/klp: Fix symbol correlation for
 orphaned local symbols
Cc: Song Liu <song@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <e21ec1141fc749b5f538d7329b531c1ab63a6d1a.1770055235.git.jpoimboe@kernel.org>
References:
 <e21ec1141fc749b5f538d7329b531c1ab63a6d1a.1770055235.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177030803937.2495410.5916359410799013375.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8208-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 08829F510C
X-Rspamd-Action: no action

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     18328546dd59b6adc111cf84a0ee4cdd3a867611
Gitweb:        https://git.kernel.org/tip/18328546dd59b6adc111cf84a0ee4cdd3a8=
67611
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 02 Feb 2026 10:01:08 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Thu, 05 Feb 2026 08:00:45 -08:00

objtool/klp: Fix symbol correlation for orphaned local symbols

When compiling with CONFIG_LTO_CLANG_THIN, vmlinux.o has
__irf_[start|end] before the first FILE entry:

  $ readelf -sW vmlinux.o
  Symbol table '.symtab' contains 597706 entries:
     Num:    Value          Size Type    Bind   Vis      Ndx Name
       0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
       1: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT   18 __irf_start
       2: 0000000000000200     0 NOTYPE  LOCAL  DEFAULT   18 __irf_end
       3: 0000000000000000     0 SECTION LOCAL  DEFAULT   17 .text
       4: 0000000000000000     0 SECTION LOCAL  DEFAULT   18 .init.ramfs

This causes klp-build warnings like:

  vmlinux.o: warning: objtool: no correlation: __irf_start
  vmlinux.o: warning: objtool: no correlation: __irf_end

The problem is that Clang LTO is stripping the initramfs_data.o FILE
symbol, causing those two symbols to be orphaned and not noticed by
klp-diff's correlation logic.  Add a loop to correlate any symbols found
before the first FILE symbol.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing =
object files")
Reported-by: Song Liu <song@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Link: https://patch.msgid.link/e21ec1141fc749b5f538d7329b531c1ab63a6d1a.17700=
55235.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 1e649a3..9f1f401 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -364,11 +364,40 @@ static int correlate_symbols(struct elfs *e)
 	struct symbol *file1_sym, *file2_sym;
 	struct symbol *sym1, *sym2;
=20
-	/* Correlate locals */
-	for (file1_sym =3D first_file_symbol(e->orig),
-	     file2_sym =3D first_file_symbol(e->patched); ;
-	     file1_sym =3D next_file_symbol(e->orig, file1_sym),
-	     file2_sym =3D next_file_symbol(e->patched, file2_sym)) {
+	file1_sym =3D first_file_symbol(e->orig);
+	file2_sym =3D first_file_symbol(e->patched);
+
+	/*
+	 * Correlate any locals before the first FILE symbol.  This has been
+	 * seen when LTO inexplicably strips the initramfs_data.o FILE symbol
+	 * due to the file only containing data and no code.
+	 */
+	for_each_sym(e->orig, sym1) {
+		if (sym1 =3D=3D file1_sym || !is_local_sym(sym1))
+			break;
+
+		if (dont_correlate(sym1))
+			continue;
+
+		for_each_sym(e->patched, sym2) {
+			if (sym2 =3D=3D file2_sym || !is_local_sym(sym2))
+				break;
+
+			if (sym2->twin || dont_correlate(sym2))
+				continue;
+
+			if (strcmp(sym1->demangled_name, sym2->demangled_name))
+				continue;
+
+			sym1->twin =3D sym2;
+			sym2->twin =3D sym1;
+			break;
+		}
+	}
+
+	/* Correlate locals after the first FILE symbol */
+	for (; ; file1_sym =3D next_file_symbol(e->orig, file1_sym),
+		 file2_sym =3D next_file_symbol(e->patched, file2_sym)) {
=20
 		if (!file1_sym && file2_sym) {
 			ERROR("FILE symbol mismatch: NULL !=3D %s", file2_sym->name);

