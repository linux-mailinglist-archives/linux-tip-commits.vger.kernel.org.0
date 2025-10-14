Return-Path: <linux-tip-commits+bounces-6796-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DB1BD83DA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 10:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06D0427173
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 08:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70093112B7;
	Tue, 14 Oct 2025 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jzSwo0Cs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gagbq0b+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A489310650;
	Tue, 14 Oct 2025 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431361; cv=none; b=AhJhGSi/uv+arKKetD/iUBGFj7qiohXRqjodDuMKCcJAkjpECfj5dm/0U87iYuR2ubd6qYRYJLqnVA6dL8s0Z7xLqtfX91TaA75HfmNgHAWrMqDbA0Xulbjp53uMLSHqrBJDrT6yq2XGKJ1TGpKqlShUlLsrqshTKgkmb9AsBII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431361; c=relaxed/simple;
	bh=w3lZ1D8L7R6CuVFhFPmbCvFXFlIbt6So0g5Jrjq4TtU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Qb4ISjMyj9QrwRydm0cA1wEyaeaJj+jiG2zMcspNMXd0eWCni1hoPQ3ePLNdfBMHlAHeKctQM7Wo813DFetJpVLYOt2F3OjW+/h7ugGRtRac25JWdIhGEYm/4jLZahce75CgZCcR05nUqRiom+kri+qajx4yFfQ9Qwd7wILeqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jzSwo0Cs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gagbq0b+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 14 Oct 2025 08:42:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760431358;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wSyweCjp1RNqicccrPy9e/LOSI3STDYvSWpwtn5Up0=;
	b=jzSwo0Cs9fdX41AI5BUHM7Jc0xHmlEarhfClCbx+6QtaiYUZyWOLzJRlSASSwCEGiJKHOk
	RfWADdB5aPLiZOTCHDVpzgQgCM98lZ42eTDk5TTpMSM5uNvMeTfFlGtTkIKsAdZVPIoykN
	0IpsHTFGbV5jseuohHRljjWvNBm7BrArkyXb42jvtPNXWqR5abvFRiOcyx+ObOr4+QzJWz
	JVjM16ese1wYOBC1oxkCnj/luMY/c+WQBnniJDYFW/n5/RoYM0IPzGufj59E9I160IQGC8
	VgFRmqewvK+1y+pBgb/AuIYfGs9Yy5evxyk1TV/uX7Q+r3AwWeiwjacDcPRuLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760431358;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wSyweCjp1RNqicccrPy9e/LOSI3STDYvSWpwtn5Up0=;
	b=gagbq0b+k4D7OlOM7vyDZP3nN9E1UFUk1hOMjIqdi+2Wf5JtsiaEraGO8xi+Y1ckTASUbw
	O+3j3MW5FlRuzCDQ==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/alternative: Drop not needed test after call of
 alt_replace_call()
Cc: Juergen Gross <jgross@suse.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250929112947.27267-2-jgross@suse.com>
References: <20250929112947.27267-2-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176043135711.709179.14364106585898871964.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     ad74016b919cbad78d203fa1c459ae18e73ce586
Gitweb:        https://git.kernel.org/tip/ad74016b919cbad78d203fa1c459ae18e73=
ce586
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 29 Sep 2025 13:29:45 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 14 Oct 2025 10:38:11 +02:00

x86/alternative: Drop not needed test after call of alt_replace_call()

alt_replace_call() will never return a negative value, so testing the
return value to be less than zero can be dropped.

This makes it possible to switch the return type of alt_replace_call()
and the type of insn_buff_sz to unsigned int.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8ee5ff5..4f3ea50 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -559,7 +559,7 @@ EXPORT_SYMBOL(BUG_func);
  * Rewrite the "call BUG_func" replacement to point to the target of the
  * indirect pv_ops call "call *disp(%ip)".
  */
-static int alt_replace_call(u8 *instr, u8 *insn_buff, struct alt_instr *a)
+static unsigned int alt_replace_call(u8 *instr, u8 *insn_buff, struct alt_in=
str *a)
 {
 	void *target, *bug =3D &BUG_func;
 	s32 disp;
@@ -643,7 +643,7 @@ void __init_or_module noinline apply_alternatives(struct =
alt_instr *start,
 	 * order.
 	 */
 	for (a =3D start; a < end; a++) {
-		int insn_buff_sz =3D 0;
+		unsigned int insn_buff_sz =3D 0;
=20
 		/*
 		 * In case of nested ALTERNATIVE()s the outer alternative might
@@ -683,11 +683,8 @@ void __init_or_module noinline apply_alternatives(struct=
 alt_instr *start,
 		memcpy(insn_buff, replacement, a->replacementlen);
 		insn_buff_sz =3D a->replacementlen;
=20
-		if (a->flags & ALT_FLAG_DIRECT_CALL) {
+		if (a->flags & ALT_FLAG_DIRECT_CALL)
 			insn_buff_sz =3D alt_replace_call(instr, insn_buff, a);
-			if (insn_buff_sz < 0)
-				continue;
-		}
=20
 		for (; insn_buff_sz < a->instrlen; insn_buff_sz++)
 			insn_buff[insn_buff_sz] =3D 0x90;

