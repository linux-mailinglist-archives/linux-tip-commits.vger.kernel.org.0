Return-Path: <linux-tip-commits+bounces-8380-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3KR2Jk3KrWnj7QEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8380-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sun, 08 Mar 2026 20:13:17 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D82231D95
	for <lists+linux-tip-commits@lfdr.de>; Sun, 08 Mar 2026 20:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A301300CFC3
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Mar 2026 19:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2F3394482;
	Sun,  8 Mar 2026 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Q30KndO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1SWW6xWj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A809438E10C;
	Sun,  8 Mar 2026 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772997194; cv=none; b=jrDP8ICc9saXMvOsyhPpfUSDFDu8OXjlDq49dgn2fcXGP+Sy46HOklDPHGyxAryyYD/sVUFneuTM4M0dmYp6DNlnGmSP0jNsYwITGMeM+bjY/a0Mu2G9JDO6qt5UmaiFYSRfEz6U4VTe3jk58UQbAPmiwZjXvMXVA5gVA5ooQZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772997194; c=relaxed/simple;
	bh=8ZEE2+IXdOWX6cgq/J8dnPpPOTUJgl1vWwzob6gubbs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uK+o4uzU8gSIvAY10LnVTtLlujh5HskRgBRnToqxy4TkbAFJFBHdIJFjkkB6gWKLTP9+NlrMg1vxtvprq+WIIJclb6tcfMiyvDXA/jS+1H+zv/Dq/LZ9xKuPQAK+3ZYVt+d2COtu81FsbgZ0yTU+6iK2A7FsDENIUwV4//mnf50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Q30KndO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1SWW6xWj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 08 Mar 2026 19:13:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772997186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDX+NG7mgzvS6wXbJehWk6iIMXI8etPYJRuQW3IetN4=;
	b=0Q30KndOUO9KQkHrAPlGpxEp8HnkVsD97TDYQve+BFSsitnr9PEJa6FVvv5cRAahoucSNA
	rlxB2GQ95LpRKqQmev08UcG/1B6h9Q17dA3lvq0F6rqUAcuWdV+lMMiog9jP22OCYdIRBZ
	lqQMn6m7til76K2OITwZwl6ziu35P4/teDj/JFCAug/Ga9WxpOFlWnkpwvjmSVjsa4Wf27
	/bzX3fZ7qLZNK2gJe91WVGJvKqSbCDIf+Eqmia+XA9CI3giXJl/Oo2onQMzMmuUDxCcI0N
	UzF3vC1JzzAXoVlENpxPQ+t9hkuQPM0CMLt9Qt95xEpZabLClwfIo92JN0Djow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772997186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDX+NG7mgzvS6wXbJehWk6iIMXI8etPYJRuQW3IetN4=;
	b=1SWW6xWjZLXn+y1TTuQJfdiaqZdBf7i5lPXJ7iuD1ca5i5w0p38jbi4guVPPGGYmDD5cTA
	+Oq30B8/web5hhDA==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/local: Remove trailing semicolon from
 _ASM_XADD in local_add_return()
Cc: Uros Bizjak <ubizjak@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260308171250.7278-1-ubizjak@gmail.com>
References: <20260308171250.7278-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177299718452.1647592.532324403432778675.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 10D82231D95
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8380-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,alien8.de,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     ceea7868b594ccf376562af40b9463d9f2fb7dd0
Gitweb:        https://git.kernel.org/tip/ceea7868b594ccf376562af40b9463d9f2f=
b7dd0
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sun, 08 Mar 2026 18:12:35 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 08 Mar 2026 19:56:49 +01:00

x86/local: Remove trailing semicolon from _ASM_XADD in local_add_return()

Remove the trailing semicolon from the inline assembly statement in
local_add_return().

The _ASM_XADD macro already expands to a complete instruction, making
the extra semicolon unnecessary. More importantly, the stray semicolon
causes GCC to treat the inline asm as containing multiple instructions,
which can skew its internal instruction count estimation and affect
optimization heuristics.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260308171250.7278-1-ubizjak@gmail.com
---
 arch/x86/include/asm/local.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/local.h b/arch/x86/include/asm/local.h
index 59aa966..4957018 100644
--- a/arch/x86/include/asm/local.h
+++ b/arch/x86/include/asm/local.h
@@ -106,7 +106,7 @@ static inline bool local_add_negative(long i, local_t *l)
 static inline long local_add_return(long i, local_t *l)
 {
 	long __i =3D i;
-	asm volatile(_ASM_XADD "%0, %1;"
+	asm volatile(_ASM_XADD "%0, %1"
 		     : "+r" (i), "+m" (l->a.counter)
 		     : : "memory");
 	return i + __i;

