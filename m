Return-Path: <linux-tip-commits+bounces-8340-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBQhAEu9pWn8FQAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8340-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 02 Mar 2026 17:39:39 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B16A01DD0BC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 02 Mar 2026 17:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0EA9F30371BC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Mar 2026 16:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49703FD15F;
	Mon,  2 Mar 2026 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VMDYwafo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RX4X85LH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6F1239E88;
	Mon,  2 Mar 2026 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469497; cv=none; b=AOqeIAhkkg7ZRjP6P3B61QXpafxrUmrYzP2uZE2vKLArkC/lAIXvsymeNe350mfv9Glon63q982un/RyZ884/miSYKGGShd+uTgjW4XwwGxnYd89TUTp4Rbsyt77CE8USptad7KfvxwVQym0IeOU3qJ5KyR9jL8WG6DYykgJX4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469497; c=relaxed/simple;
	bh=NVXD9LJWotQu5Ot8oZ59j1Thcb3ehgE0sEsLCd6gRhw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DWVL3tCuCLaqE3xNJXfnmAkZ5kN3R0kc2Wmov9I3Bc1wcAfCJifrcEnbLAw0VJigIg+5duKZ0lkPxvMRI9eW8yNg9tx6NsLanBvxHQClOx/8V2BG3oJNRwJ5NNsrRRlLoExUTpJvyzQrG4FJNTnyhclQbfqQ3AulbwG8jO5l+DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VMDYwafo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RX4X85LH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Mar 2026 16:38:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772469494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zpSd6m1Oj2/kuPYizt5OreLeiaQhW+7XgS0MxPZIb8c=;
	b=VMDYwafoh3R7fs+Xh4fx8zwRoL2xHMGMVXSfHwEO2PEy3Bg+trpoKrkkEtWd2ZgbkUiuC0
	WLnsjy2uSgN4z2Y3u6qAX5uOW4KfFPhUgoENKCH0CUpUKP0KY/QEj+Ls/d7easYaqESNab
	+k1PkoytCuV0/Jz4oMZGi9uavOxoTU7mQ4ySmT3qEOM7LdMC9fpzgEgqcIs652MKS42lpr
	hfxg7DKLPRpC/WnsewFNrFSkKRnyoLGpqCQpfTLNfq9/04qQJwiebfo152+QiUDfWK5LgV
	IMOYzWJmmBX3cAmAmv2/XGzdPC8vzV9+NOD27cd/weqQiRbdjXdwjJHaOtNDJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772469494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zpSd6m1Oj2/kuPYizt5OreLeiaQhW+7XgS0MxPZIb8c=;
	b=RX4X85LHrWtnf+KSe7ye9QPhusCM2C5NshOQwaVQqoeun3h9sZuYC2DEnbPwhpLmWHwzjy
	qlUcOVlNRff9XuBA==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/mtrr: Use kstrtoul() in parse_mtrr_spare_reg()
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260302135341.3473-2-thorsten.blum@linux.dev>
References: <20260302135341.3473-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177246949341.1647592.264049873956344439.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B16A01DD0BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8340-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     9a4af5a00a8bff84d8d499e43d3424173835173c
Gitweb:        https://git.kernel.org/tip/9a4af5a00a8bff84d8d499e43d342417383=
5173c
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Mon, 02 Mar 2026 14:53:40 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 02 Mar 2026 17:25:31 +01:00

x86/mtrr: Use kstrtoul() in parse_mtrr_spare_reg()

Replace the deprecated simple_strtoul()=C2=B9 with kstrtoul() for parsing the=
 early
boot parameter mtrr_spare_reg_nr. simple_strtoul() silently sets
nr_mtrr_spare_reg to 0 for invalid input instead of rejecting it and keeping
the default value.

Return kstrtoul()'s retval directly to propagate parsing failures instead of
treating them as success. Also return -EINVAL when '=3D' is missing from the
boot parameter and 'arg' is NULL.

  =C2=B9 https://www.kernel.org/doc/html/latest/process/deprecated.html#simpl=
e-strtol-simple-strtoll-simple-strtoul-simple-strtoull

  [ bp: Massage commit message. ]

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20260302135341.3473-2-thorsten.blum@linux.dev
---
 arch/x86/kernel/cpu/mtrr/cleanup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cl=
eanup.c
index 763534d..e3eee9a 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -437,9 +437,10 @@ static unsigned long nr_mtrr_spare_reg __initdata =3D
=20
 static int __init parse_mtrr_spare_reg(char *arg)
 {
-	if (arg)
-		nr_mtrr_spare_reg =3D simple_strtoul(arg, NULL, 0);
-	return 0;
+	if (!arg)
+		return -EINVAL;
+
+	return kstrtoul(arg, 0, &nr_mtrr_spare_reg);
 }
 early_param("mtrr_spare_reg_nr", parse_mtrr_spare_reg);
=20

