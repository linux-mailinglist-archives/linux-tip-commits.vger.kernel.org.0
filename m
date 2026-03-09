Return-Path: <linux-tip-commits+bounces-8404-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K/lJpgmr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8404-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:59:20 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 399C62407E4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8E5F3073A69
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6907341160B;
	Mon,  9 Mar 2026 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sC4IciYt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9t54qVTU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221FD410D39;
	Mon,  9 Mar 2026 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086057; cv=none; b=JoR1nmRVY0XrkqLiPEq7IXQpVHGNoFVg9Z0hel/jDRlNIOE0vzriIZkKryPDm40c5wKO7RAi1zB7ugUA0ZfBnzjMdgWJRmaO48BjErZXtGQtX9tK7ykOd7mzopcNGU6JK6GAHx2Wby1elpgy22zUu7fw8JffS/AuwZiNTgVRZrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086057; c=relaxed/simple;
	bh=2vuJ3eT1bL4/K68+v9Bh0CRk+cdTIhSOlS9twFB4LZU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RG/oDDDGRKcP9/ulDaMQ19aeUXuPVVUi1cq6aSy4gQ6X1fjQa1ylJb2K25semvfPCrw9bOOseq0AgCcdmjhe871mtjYQ8WU2/LS39d2JvaCpYfkfkM7y+vq0mqo3h8zOAeMHBX3MYePaddRjDOMxosBd2LnoOy7vjW2edUc+EjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sC4IciYt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9t54qVTU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:54:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773086054;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ShFBrtUSvq3VxQxJHdvilh8HxARtK6bCoY199+Af36g=;
	b=sC4IciYtwyjFUP8vGv7V/2MuLZGb/Iwd4vToeltCr1RPOekTGFzE0AAxGa8pcO8LCTAR1f
	Hy01odCPrt+BO9dZ4yXOivWCzKEnCNUV7AIZq+GHLF3h3CwPyrLQOrreLcZR7qd/OAOD0Z
	MO+aaFNTOLprVOsHhgijcZALgshjEQihmL4dMEbllAvSB0j68ubE3dmaR5oCWex29PEBIS
	ewz1STdWNqfVrBdT66MZDhjhbkkxiiiVxO3XcOXJwxF3LGY5f5yg8WiauuxVOBtlVb3pJW
	Ojzp3MlEMLZ+bi5P35M5GiyNAKO8keX7P49675Bv51eaoarlamkueeL3oSv5fA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773086054;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ShFBrtUSvq3VxQxJHdvilh8HxARtK6bCoY199+Af36g=;
	b=9t54qVTU0LAqh+WU6VhF2VESNs8QDbeKWpXPXSY2BUcRfVePf53JyFuE5sB0QZsOJRNJmQ
	nyNZfnJLg7/Mo9BA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix ERROR_INSN() error message
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <c4fe793bb3d23fac2c636b2511059af1158410e2.1772681234.git.jpoimboe@kernel.org>
References:
 <c4fe793bb3d23fac2c636b2511059af1158410e2.1772681234.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308605350.1647592.6790507846877444925.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 399C62407E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8404-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:dkim,vger.kernel.org:replyto,msgid.link:url]
X-Rspamd-Action: no action

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     1fd1dc41724319406b0aff221a352a400b0ddfc5
Gitweb:        https://git.kernel.org/tip/1fd1dc41724319406b0aff221a352a400b0=
ddfc5
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 04 Mar 2026 19:31:21 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Fri, 06 Mar 2026 07:53:37 -08:00

objtool: Fix ERROR_INSN() error message

Confusingly, ERROR_INSN() shows "warning:" instead of "error:".  Fix that.

Link: https://patch.msgid.link/c4fe793bb3d23fac2c636b2511059af1158410e2.17726=
81234.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/include/objtool/warn.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/obj=
tool/warn.h
index 2b27b54..fa8b7d2 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -107,7 +107,7 @@ static inline char *offstr(struct section *sec, unsigned =
long offset)
 #define ERROR_ELF(format, ...) __WARN_ELF(ERROR_STR, format, ##__VA_ARGS__)
 #define ERROR_GLIBC(format, ...) __WARN_GLIBC(ERROR_STR, format, ##__VA_ARGS=
__)
 #define ERROR_FUNC(sec, offset, format, ...) __WARN_FUNC(ERROR_STR, sec, off=
set, format, ##__VA_ARGS__)
-#define ERROR_INSN(insn, format, ...) WARN_FUNC(insn->sec, insn->offset, for=
mat, ##__VA_ARGS__)
+#define ERROR_INSN(insn, format, ...) ERROR_FUNC(insn->sec, insn->offset, fo=
rmat, ##__VA_ARGS__)
=20
 extern bool debug;
 extern int indent;

