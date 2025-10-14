Return-Path: <linux-tip-commits+bounces-6801-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18F3BD91B6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 13:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA89544132
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356E93112B8;
	Tue, 14 Oct 2025 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pP1tfXN7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gFNHLXzq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790FA3101D4;
	Tue, 14 Oct 2025 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442485; cv=none; b=amoVhynbo8Chdfc1ISXttxX9XjqtwfWIngvpc12nH6gsJ/Wv6F6ZBSt0syl3PljEfTntwJSMoGnNP0v/6UYP2OkYsY1dkBY1hQ9nKd8iUqMq0v6q+wKbSP04vfpxlrLwVvZe/VUcjx/vdVwZkwyslMPO7uYSvkggDMe97iYC1Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442485; c=relaxed/simple;
	bh=BmojH/UDBqBHXL27Degxuqg1aXonJBEFF28NTYP/vTA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PN3UQL4M67YJUZ6IYcJew0E/BQbQ/RrY1G5akIGVEhXRERhfnNh6S+G1UKGsRW1aPCuSINTmDuOi9zM7mkVUDOn3cD59npgvhfeE3pMKZKL95wVPMjzleerFcQDoU0gmTryRgh+X/VxlOnIMYv1bVJv/u/DO/o0vv7fEZbtGQSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pP1tfXN7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gFNHLXzq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 Oct 2025 11:47:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760442479;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmTj2SaJSRMejzNPzQjd8bNs8Ag1mXbPlxjacpozOt4=;
	b=pP1tfXN7GFpsn0g662ng/ieKCkwl97RZklMU1v1kFqJTapREMEF21a9dfu/g0L8Nq+dwMz
	4Q8aAzsh57xVUHYANhKtiiVZN1j2mh5zXcuKdpXbqDaMtpX7WcD9IzeD8S69ag04v/bRt4
	NlpIeN+c9t/iiuEwwZ99TUxB9g5xUWVG/JvEJwm8b5OsEmPtY75hT6j+TL6Ycv1l71+VdT
	jcWcZEi1GMi6heb+K1fZox4HjGEnom31pTdVd3KX/DeN8OJLi6TaMpRTRqiUjD+Wnb0S4C
	W/UvsJsX7MWxDPSm4SG95Bu5sL9ZEcDC1RXYgoGpqJ4R5b57NFS8et4VD1j3YQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760442479;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmTj2SaJSRMejzNPzQjd8bNs8Ag1mXbPlxjacpozOt4=;
	b=gFNHLXzqD/1y5x1CLq2hdSgpuw/HFmxn/xQ3YfohM8tvaLwQklU12Bp6iIHaRFqdQ+EbK9
	PEd9pR3mK4+FiIAQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool/x86: Remove 0xea hack
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250924134643.907226869@infradead.org>
References: <20250924134643.907226869@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176044247866.709179.12504013113809585079.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     c5df4e1ab8c00c4dc13094fa44e219bc48d910f4
Gitweb:        https://git.kernel.org/tip/c5df4e1ab8c00c4dc13094fa44e219bc48d=
910f4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 24 Sep 2025 15:22:46 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 14 Oct 2025 13:43:10 +02:00

objtool/x86: Remove 0xea hack

Was properly fixed in the decoder with commit 4b626015e1bf ("x86/insn:
Stop decoding i64 instructions in x86-64 mode at opcode")

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/arch/x86/decode.c |  9 ---------
 1 file changed, 9 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 0ad5cc7..ce16fb2 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -189,15 +189,6 @@ int arch_decode_instruction(struct objtool_file *file, c=
onst struct section *sec
 	op2 =3D ins.opcode.bytes[1];
 	op3 =3D ins.opcode.bytes[2];
=20
-	/*
-	 * XXX hack, decoder is buggered and thinks 0xea is 7 bytes long.
-	 */
-	if (op1 =3D=3D 0xea) {
-		insn->len =3D 1;
-		insn->type =3D INSN_BUG;
-		return 0;
-	}
-
 	if (ins.rex_prefix.nbytes) {
 		rex =3D ins.rex_prefix.bytes[0];
 		rex_w =3D X86_REX_W(rex) >> 3;

