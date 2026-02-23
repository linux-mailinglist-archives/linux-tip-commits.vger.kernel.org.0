Return-Path: <linux-tip-commits+bounces-8232-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8La1L40tnGlkAgQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8232-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:35:57 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B678174F71
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B50530C7F87
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 10:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058B5363C52;
	Mon, 23 Feb 2026 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J6ehlwyn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R1+3H9hG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11DA3624D3;
	Mon, 23 Feb 2026 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842333; cv=none; b=X3pQzJGOz0+OeXCSYM5iV5okfhP22CMLTnYPn3fdaiQu3sutykkmzFJnpMHaBAo0TJ9wMNqKU5wK08W+6W1pU5m2aepVCEJ3TZEcSYeoZovJQCLP4zyyaA1DXhkdqw4xbzmwlZcvAneQ1GY+zKcBC6fMmxU/8EBVgCd993PolfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842333; c=relaxed/simple;
	bh=sRAZr3+tYRm7Sv5I5JTyoPDolVvOnyHLuz7OHoj+cSo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dOhNT43Kh+L6CpTGa2eLmwSP4tyQA0SPVbFgiixS0jukOKrS7wybFJ4vjI8fLmo/DPdkfmzPwghj6j23aX2b3kohSkEeIlz5Tqo8pYbgF0d22eeboBTmLcvLmcdwsP3GhClcXRbnI82+JQacqgLS4+tik/WDSO/0yw4d2Jk0ba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J6ehlwyn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R1+3H9hG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Feb 2026 10:25:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771842331;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZ+SYpdG0ieEyPv63JNMjscTuGVK2VJmE0YEYTdzlRU=;
	b=J6ehlwynqIRAFzcjkiNmObhNtxFFHh0UDbf7XcPkxeGHxAachgafoVwJ1ldXHFI3DttrhT
	eTujPPz8LUM67ud6Ur0i2NM+I3Wxqfbc8zUlQsOu67ciI2oYHOhWOZ+SMfPjGwVi8IlrIq
	BboaG6oXIn9Ej4y1y3/LjoToqti6rTBZD5um9p7xHM+HB1pBJjhgE9Pw7Zq9M7P6U2xCNE
	ayJYcwt7hWb5Z7nBnsVa1ggZOS2Q9qlY63vFGZ7tTW8+212nCsE9QzFr9lfqYttze0RXNs
	mxfDrA3WYErtZ6VsP/FczwydSY34193n3bj2YJLi9ghyFTalwaw0UFpj+dkcOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771842331;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZ+SYpdG0ieEyPv63JNMjscTuGVK2VJmE0YEYTdzlRU=;
	b=R1+3H9hGXjjZO3eIynHKuHDhJ77UJyZTX8jpTqSOwjaVTjOwMYul35itgIQ17Clts7hawD
	cWpdh0JRVM4N0PAg==
From: "tip-bot2 for Andrew Cooper" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/fred: Correct speculative safety in fred_extint()
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260106131504.679932-1-andrew.cooper3@citrix.com>
References: <20260106131504.679932-1-andrew.cooper3@citrix.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177184233035.1647592.16603666600863959192.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8232-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,vger.kernel.org:replyto,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,citrix.com:email,msgid.link:url];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 1B678174F71
X-Rspamd-Action: no action

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     aa280a08e7d8fae58557acc345b36b3dc329d595
Gitweb:        https://git.kernel.org/tip/aa280a08e7d8fae58557acc345b36b3dc32=
9d595
Author:        Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate:    Tue, 06 Jan 2026 13:15:04=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 11:19:11 +01:00

x86/fred: Correct speculative safety in fred_extint()

array_index_nospec() is no use if the result gets spilled to the stack, as
it makes the believed safe-under-speculation value subject to memory
predictions.

For all practical purposes, this means array_index_nospec() must be used in
the expression that accesses the array.

As the code currently stands, it's the wrong side of irqentry_enter(), and
'index' is put into %ebp across the function call.

Remove the index variable and reposition array_index_nospec(), so it's
calculated immediately before the array access.

Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260106131504.679932-1-andrew.cooper3@citrix.=
com
---
 arch/x86/entry/entry_fred.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index a9b7299..88c757a 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -160,8 +160,6 @@ void __init fred_complete_exception_setup(void)
 static noinstr void fred_extint(struct pt_regs *regs)
 {
 	unsigned int vector =3D regs->fred_ss.vector;
-	unsigned int index =3D array_index_nospec(vector - FIRST_SYSTEM_VECTOR,
-						NR_SYSTEM_VECTORS);
=20
 	if (WARN_ON_ONCE(vector < FIRST_EXTERNAL_VECTOR))
 		return;
@@ -170,7 +168,8 @@ static noinstr void fred_extint(struct pt_regs *regs)
 		irqentry_state_t state =3D irqentry_enter(regs);
=20
 		instrumentation_begin();
-		sysvec_table[index](regs);
+		sysvec_table[array_index_nospec(vector - FIRST_SYSTEM_VECTOR,
+						NR_SYSTEM_VECTORS)](regs);
 		instrumentation_end();
 		irqentry_exit(regs, state);
 	} else {

