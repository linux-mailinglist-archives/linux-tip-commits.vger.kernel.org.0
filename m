Return-Path: <linux-tip-commits+bounces-8211-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDj+FN7BhGnG4wMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8211-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Feb 2026 17:14:22 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0944FF5123
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Feb 2026 17:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA02F3006104
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Feb 2026 16:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288F7438FF7;
	Thu,  5 Feb 2026 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4nv1YPrn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/cklMBSk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4605438FF2;
	Thu,  5 Feb 2026 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308045; cv=none; b=lzTBmZGMFrYEMYCTnfGF3CXBXKa2LHBhmSmuEQgrISeh/C/vj75hbHJxVD6gV6K3w/lL4y6H/HwkFqQYEiH2pefQpi8e5UohTbZbTr7kEsOGgUfUOAq6k3IOUc3Knz9RTblIPGCdct82Z9OCh7skPGzrLrypq8LCLfUJajmZqzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308045; c=relaxed/simple;
	bh=uL8eQgU7moluYt4vYtvgfywDHyQEcgXv4sQ1iqPsMfE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eH6vBz7mxFu5Kl+mUQrPqpMLJx8sOeimjlQnoGYk8EKLtRaLHCu/b5jNW4ZGWPy9d+pVKjlm3aZx5qC1ZyJHDIH/bcOXc+Gg5pRpvpkGQw3HpKsAFnWU/JoYF11ROOW52jwsFDoM7sA/gY8Qe4kby8pgn77Ez6rB0kY56hRxDz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4nv1YPrn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/cklMBSk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Feb 2026 16:14:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770308043;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0xSEgPnw4oil1eDxMS8+KIc6alktoRuNZdPpPPRiGQ=;
	b=4nv1YPrnCOChfr3SuaYirbn8RE449cMuEw58pxQoN6JS+4ZDxSaLlsY00ltFvj69dW6UsX
	Ira6NMVk/+hRt9UxakaaZ2qAo9a0dEX2mWTJksMZQBQsF8PC3MJO4kykFFvgZJxJPwfJI2
	8EXmzvnYyFzQL1aeqoWOms5FtjrV8X53yCKrzrYtbgTGhsDfa3vgPcoziBvwSMdmOb3Mx0
	Psqf7Xmqj3vGtGPhECrvt2CS9cYTU6+r54H6GkYrlc3NDphZ1roxvuZZ54mz5coAatFOBO
	EmiEBejc4f9dnl4NFcL7GJVd2kil72KSW5ASrzyHT4ygcScHR/3Nn5yJVhzfYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770308043;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o0xSEgPnw4oil1eDxMS8+KIc6alktoRuNZdPpPPRiGQ=;
	b=/cklMBSkeAVEVu6JShTVVQCE8XweoRGyHvdWo68UCwcHN0AJNAGwjsNL7UodJK6IGc/bKh
	D1mPeq9EKgE4dmBA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/urgent] livepatch/klp-build: Require Clang assembler >= 20
Cc: Song Liu <song@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <957fd52e375d0e2cfa3ac729160da995084a7f5e.1769562556.git.jpoimboe@kernel.org>
References:
 <957fd52e375d0e2cfa3ac729160da995084a7f5e.1769562556.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177030804250.2495410.13722330109340992324.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8211-lists,linux-tip-commits=lfdr.de];
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
X-Rspamd-Queue-Id: 0944FF5123
X-Rspamd-Action: no action

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     a8ff29f0ca1d63a215ef445102662850a912d127
Gitweb:        https://git.kernel.org/tip/a8ff29f0ca1d63a215ef445102662850a91=
2d127
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 27 Jan 2026 17:12:05 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Thu, 29 Jan 2026 10:09:26 -08:00

livepatch/klp-build: Require Clang assembler >=3D 20

Some special sections specify their ELF section entsize, for example:

  .pushsection section, "M", @progbits, 8

The entsize (8 in this example) is needed by objtool klp-diff for
extracting individual entries.

Clang assembler versions older than 20 silently ignore the above
construct and set entsize to 0, resulting in the following error:

  .discard.annotate_data: missing special section entsize or annotations

Add a klp-build check to prevent the use of Clang assembler versions
prior to 20.

Fixes: 24ebfcd65a87 ("livepatch/klp-build: Introduce klp-build script for gen=
erating livepatch modules")
Reported-by: Song Liu <song@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Link: https://patch.msgid.link/957fd52e375d0e2cfa3ac729160da995084a7f5e.17695=
62556.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/livepatch/klp-build | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index a73515a..809e198 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -249,6 +249,10 @@ validate_config() {
 	[[ -v CONFIG_GCC_PLUGIN_RANDSTRUCT ]] &&	\
 		die "kernel option 'CONFIG_GCC_PLUGIN_RANDSTRUCT' not supported"
=20
+	[[ -v CONFIG_AS_IS_LLVM ]] &&				\
+		[[ "$CONFIG_AS_VERSION" -lt 200000 ]] &&	\
+		die "Clang assembler version < 20 not supported"
+
 	return 0
 }
=20

