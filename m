Return-Path: <linux-tip-commits+bounces-8409-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA5hFLsmr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8409-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:59:55 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9B624081F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D37AE30FD722
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7337421894;
	Mon,  9 Mar 2026 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jDO1W5I9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ghXkFSCb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B16441C303;
	Mon,  9 Mar 2026 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086062; cv=none; b=FAwMxy4aD/J7f7jqTJRmM/OilWtvwSodrNGQJt6gUZAPqaoIVYsC5J3xX1R0EkhSz6y4TLfj4ceG72XZMYK/E0ApN1Bx1sY52bGK98nAZXG81ODqbAvkQJz9umW6CWzJnR6JC9sznNcaREx0GRv/QMgnr4r4/SG6oZVhxWil9c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086062; c=relaxed/simple;
	bh=zXSGxJl5rcA/1iIy2be0V03hC7lRAtsnMKfdP+NBhJM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jOXL5F4aSXvH4ZLbx8yXGozQJ9c0TRGPCpbif7wVSrRuJx5/gY6jEF9uaIJ6xY5qxMIvramdFtGUUYPKTN2Ammf3rmHQM8bQX3VRswTqPrYW0cGIkFMqzdoPssykic46EmPZWvDwepWlgJgku95h2y7+HlWThPh7jMDRUxyXuTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jDO1W5I9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ghXkFSCb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:54:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773086059;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VN1SznBvwxq0jBmGATGGJiQdxOUBgu2zD1IPByXEBcA=;
	b=jDO1W5I9KwgfCK+nK4vqlGsfR2ZZvaPEhtZaqBfN+SJtEfokJg/Ns7XBLxk5axkIV3ib6q
	3sz2fctPtDaksiSVwyLYswg1onHnXejoBi5bgWNPN1vTR3YuG3qTApPYWz2ISixif9QjHB
	08qoBSLgMSpw3zCVZoQvwqocGNIRxDREspoGJfkgtbbXE3pH9tl8EIDDnOlel7nr9iFAQ5
	xYfM6zAOHjpJ2Lf7dKE6NGSzjdA+i4BJtAloVVpWe8qHKbVsM4aZo0dw/sI0pPI0jXRazE
	csa9FKqXmoHlK3wtkZvxzf/uVE10WGGaspSjIPXdPHBw4merDmNW0q5BSmWB9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773086059;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VN1SznBvwxq0jBmGATGGJiQdxOUBgu2zD1IPByXEBcA=;
	b=ghXkFSCbwrrULmFaOqG19wyaHamK7jpOutR/Fd3KmmG6EjJy1+732FWvh6X4u5/TW0WkQv
	Ikb+42ZAJU0cOIAw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool/klp: Fix detection of corrupt static
 branch/call entries
Cc: Song Liu <song@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <124ad747b751df0df1725eff89de8332e3fb26d6.1770759954.git.jpoimboe@kernel.org>
References:
 <124ad747b751df0df1725eff89de8332e3fb26d6.1770759954.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308605870.1647592.3945362278453825963.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9F9B624081F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8409-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:dkim,vger.kernel.org:replyto,msgid.link:url];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     f9fb44b0ecefc1f218db56661ed66d4e8d67317d
Gitweb:        https://git.kernel.org/tip/f9fb44b0ecefc1f218db56661ed66d4e8d6=
7317d
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 10 Feb 2026 13:50:09 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Fri, 06 Mar 2026 07:47:10 -08:00

objtool/klp: Fix detection of corrupt static branch/call entries

Patching a function which references a static key living in a kernel
module is unsupported due to ordering issues inherent to late module
patching:

  1) Load a livepatch module which has a __jump_table entry which needs
     a klp reloc to reference static key K which lives in module M.

  2) The __jump_table klp reloc does *not* get resolved because module M
     is not yet loaded.

  3) jump_label_add_module() corrupts memory (or causes a panic) when
     dereferencing the uninitialized pointer to key K.

validate_special_section_klp_reloc() intends to prevent that from ever
happening by catching it at build time.  However, it incorrectly assumes
the special section entry's reloc symbol references have already been
converted from section symbols to object symbols, causing the validation
to miss corruption in extracted static branch/call table entries.

Make sure the references have been properly converted before doing the
validation.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing =
object files")
Reported-by: Song Liu <song@kernel.org>
Reviewed-and-tested-by: Song Liu <song@kernel.org>
Link: https://patch.msgid.link/124ad747b751df0df1725eff89de8332e3fb26d6.17707=
59954.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/klp-diff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 9f1f401..d94632e 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1364,6 +1364,9 @@ static int validate_special_section_klp_reloc(struct el=
fs *e, struct symbol *sym
 		const char *sym_modname;
 		struct export *export;
=20
+		if (convert_reloc_sym(e->patched, reloc))
+			continue;
+
 		/* Static branch/call keys are always STT_OBJECT */
 		if (reloc->sym->type !=3D STT_OBJECT) {
=20

