Return-Path: <linux-tip-commits+bounces-7621-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAF5CB18D9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Dec 2025 01:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05C3D300AFC7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Dec 2025 00:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B764A1EBA19;
	Wed, 10 Dec 2025 00:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="10WEw61G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ea2Wmk33"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF21E1C02;
	Wed, 10 Dec 2025 00:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765328042; cv=none; b=WnoLiIN1rkIFYc0G6plKFOPjpGntcIQTzI98aIJI4jRSN3vjZyvoilUE/B+MRJVDGFmf3D/lVk9E6szti6h9UzYNySILdmZgwnx+/FU7oJz2K0nYC9Pw5Va+jXKhqXIERFkYLoM8Ae6aKoF8VJt+9nQc+cEvWAmkdktNQi7k7f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765328042; c=relaxed/simple;
	bh=jD6TaafYjJ4//QKotzRHaYUtSD0NlIngrqB+IfoTkmg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K2VSYDFzPMy/P7SB0a//CC+tWgXv5r8h0QG/ioJRUJfMdU4HeJbICYx4sMIeLa3QqB8Ip1hkrQ3YwBP8eZ3G4mnybu73bjw4HHZfIKQQ8D/3frlHsB8wrlXfPJxkM5z6f2xPOLuNda/7IP6cTSzo0QzC3QvdlqJ6gqs7j2eiL6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=10WEw61G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ea2Wmk33; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Dec 2025 00:53:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765328038;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xIqQF1aCai/CtaU2XxqGP4O7T+4oqNTI8DC90gu8lOw=;
	b=10WEw61GGzF3ZiXiH33eWc/D/7FvK3fq9dCR2Iv2Z7HU/USeXUmOignezV0Cr3LmsxhBAS
	bP1CQ/+yyugbwg1q2pfq/tg21sKHOgxwvU6SxCNkKBDKvsd+8MEbAo2SbCNf2rE7zeXo9H
	Wn4VM4VCZXkiSLboquR9EklgVFVyPj19NIHlXzJ/WsO4yrq9ILCoYVxTH+oCfYHklAgxK5
	eKQHnCSCevyFbc/hdZ0IP4OfkWOuvpcCP/6B7NTgY3alk8ChY2gmtdFpSl9Pc/LhpmBfdE
	YwqU4ckewONfMEseImaqiwYqEQW2o0ndLTViqJqvto1LlHnuHWP4bijx1L5yLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765328038;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xIqQF1aCai/CtaU2XxqGP4O7T+4oqNTI8DC90gu8lOw=;
	b=ea2Wmk33UqJuM7AjQDDTs+j+aod7TClfYsSa50F7hlekJBjzbV/W8P4kw/n5fSol3UoOi+
	APgC5+vgQieVswCw==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq: Allow NULL affinity for setup_percpu_irq()
Cc: Daniel Thompson <danielt@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251205091814.3944205-1-maz@kernel.org>
References: <20251205091814.3944205-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176532803439.498.6937974797536964150.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     89acaa5537a29c742d7a6ed7241fc4cf5e2ef818
Gitweb:        https://git.kernel.org/tip/89acaa5537a29c742d7a6ed7241fc4cf5e2=
ef818
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 05 Dec 2025 09:18:14=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Dec 2025 09:47:33 +09:00

genirq: Allow NULL affinity for setup_percpu_irq()

setup_percpu_irq() was forgotten when the percpu_devid infrastructure was
updated to deal with CPU affinities.

In order to keep ignoring users of this legacy API, provide sensible
defaults by setting the affinity to cpu_online_mask if none was provided by
the caller.

Fixes: bdf4e2ac295fe ("genirq: Allow per-cpu interrupt sharing for non-overla=
pping affinities")
Reported-by: Daniel Thompson <danielt@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251205091814.3944205-1-maz@kernel.org
Closes: https://lore.kernel.org/r/aTFozefMQRg7lYxh@aspen.lan
---
 kernel/irq/manage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 0bb2931..8b1b4c8 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2470,6 +2470,9 @@ int setup_percpu_irq(unsigned int irq, struct irqaction=
 *act)
 	if (retval < 0)
 		return retval;
=20
+	if (!act->affinity)
+		act->affinity =3D cpu_online_mask;
+
 	retval =3D __setup_irq(irq, desc, act);
=20
 	if (retval)

