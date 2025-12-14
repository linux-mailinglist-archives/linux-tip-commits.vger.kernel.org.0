Return-Path: <linux-tip-commits+bounces-7685-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1229CBB832
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 09:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B0C03006737
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AAB2E3B1C;
	Sun, 14 Dec 2025 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qVOIIfUH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iAYrGuTB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF32DCC1C;
	Sun, 14 Dec 2025 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765701466; cv=none; b=VhGyYQz10SW98ojqDgcRicFZkDeVlswrInDfaSBADvlIpNUB0Wb69yQ2aBlLDsx4vEq8XtUeTfUTUhuzbTnxiHPkzSrG8q3+jL9cG7xogzvByoB28Sfg5sbOlWS5znMftyb63N4682ljJYJHw0WMXlNGSksu+7urJZUJfwe/hOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765701466; c=relaxed/simple;
	bh=ps5UnEFAfx0UkwYB8waeFaNvlqe3bFdLJ+XI/L5znW8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lm9IroFQUa5Nq/ailGbhCtkZ9bIIiox6V1H06US/AV9ZDRETQagKHQo37wD898BBS9U+wmAQVtugP/TyIoA+OMLUvaofaKkr4JSBir6uuiDUnBMSJZOz/P6idtynv/i/ER7cY8XaQrKd5v4vLSoIPgc7+ur3AcQBs52W8m5cSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qVOIIfUH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iAYrGuTB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 08:37:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765701462;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPrc46zU6kk3tVHFpkUA4Awnd+dkTToYAS8//9jJ5ww=;
	b=qVOIIfUHBrJaXMHf9CHHs7jL6p0vrs7MzDrldrJOP5GhtXdXd9tFWsoTbPG4XmV92Djoh+
	rBAf6eiFUjlid911IsiLNxChLJW5pDQFUIt95A1JP0vjBm2zKoyFogkOJ9VDzt0NZrI9zU
	FF0OOGtSdboFpc4WFVioAkJ6n978PknrtC9ScFuRuPHSoI2u0jD9JIRpl7QMJ8NTkoVtab
	6jz6xBfU2abygFSX+F3QFYE9CjcRFpAZoXBHbKpE40gCgG2QbjChQDufh3Q2+er1YRR3fM
	PSR4SjkUurFLqvoAA8KvUfAevB42dK4b/qoOQ0daiFLRbfcJof7PT3FJgbvxmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765701462;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPrc46zU6kk3tVHFpkUA4Awnd+dkTToYAS8//9jJ5ww=;
	b=iAYrGuTB9QTEuDKjmr6Fl92Nh/U+rHlQ+OVWtFMH4F/FBwtB6DdT/xtuV6hsCWxesmsq++
	qQtSFTCGiRXjYxAQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot/e820: Call the PCI gap a 'gap' in the boot
 log printout
Cc: Ingo Molnar <mingo@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Juergen Gross <jgross@suse.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 David Woodhouse <dwmw@amazon.co.uk>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515120549.2820541-10-mingo@kernel.org>
References: <20250515120549.2820541-10-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176570146083.498.5412780529928581243.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     1d7bc219e2b6176eac361ed2eb11c7a70387644c
Gitweb:        https://git.kernel.org/tip/1d7bc219e2b6176eac361ed2eb11c7a7038=
7644c
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 15 May 2025 14:05:25 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 09:19:38 +01:00

x86/boot/e820: Call the PCI gap a 'gap' in the boot log printout

It is a bit weird and inconsistent that the PCI gap is
advertised during bootup as 'mem'ory:

  [mem 0xc0000000-0xfed1bfff] available for PCI devices
   ^^^

It's not really memory, it's a gap that PCI devices can decode
and use and they often do not map it to any memory themselves.

So advertise it for what it is, a gap:

  [gap 0xc0000000-0xfed1bfff] available for PCI devices

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://patch.msgid.link/20250515120549.2820541-10-mingo@kernel.org
---
 arch/x86/kernel/e820.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index b0efa4b..96840fa 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -699,7 +699,7 @@ __init void e820__setup_pci_gap(void)
 	 */
 	pci_mem_start =3D gapstart;
=20
-	pr_info("[mem %#010lx-%#010lx] available for PCI devices\n",
+	pr_info("[gap %#010lx-%#010lx] available for PCI devices\n",
 		gapstart, gapstart + gapsize - 1);
 }
=20

