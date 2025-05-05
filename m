Return-Path: <linux-tip-commits+bounces-5234-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EE1AA8BAD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 07:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCCC1881DED
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 05:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F8B19D8BC;
	Mon,  5 May 2025 05:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kLU/gXsz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ko+AlvuB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41991684AC;
	Mon,  5 May 2025 05:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746423135; cv=none; b=Ju6qwPc/fMuUTyF2lSv7imV4eKb+dqsL/BnRcJW3CoAElV0fL32hztFv68taVdDbEhDkOmC1QEHJ4OO1UtzgixiieiIRTOhkmpJBHxQgg8WV6hyxD3Om8a5nHWA/WMY/8wHkyulRbG9CMMTwayloBTw30OL52c4eqzJs/FBQYsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746423135; c=relaxed/simple;
	bh=li/db/eXsSUQbDbD1JB7isHAc6qWAGYJUMUXkxQntHc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ibz2d4slON84KDcMkLQ96hb20PaJaimrKwX/VfyD2MeY8HijXiGSW/agjuwqZlGkg4weM16+lanp4QPia4qc1UkK84118iApGETEYgqZp1ht2L3cYTgJ09lSqwwcgHbF4OQY3XSSvJhFkBMpzKg9oVgIJ2+mLs5qq2mmLSV++zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kLU/gXsz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ko+AlvuB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 May 2025 05:32:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746423132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BrZZeRC+UgETDMVfG32+o+o3TDYszKOTKkC2EmNU3iI=;
	b=kLU/gXszSmu9Vc2bot63+g0AiYlUSiv7lkXtaES2GwORW3Hmma0CBTRvx5VtBn5q1UNYI6
	/vNLZrunwNgJ+W+u266KZr4g3uGDP2tp3jnylZjZBpyAfScnwmThTe3jUxLin++jSHK1xU
	v9Dwi2FtLluDrPiW/VVxR6s91mlPMq+akEXuDNM/QubvvD8tJh53E0+/zfEdXNiakcWBpS
	7oXAJPZ7ud7i6cN6SQCF1zFUOSs7I2Rv20QhAECTHGAbL3L+LpFXG/t1NLtZNHgXhClucz
	OTNQb+/CE/6UnbIXyg0MgnGHri0wa/XsMK1R1a9ED62Ps9CiwIw6zy9cl4eGmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746423132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BrZZeRC+UgETDMVfG32+o+o3TDYszKOTKkC2EmNU3iI=;
	b=ko+AlvuBJkVMQ58sJf44SmmWpkitjs3fon8U+1CWU9zH9dVSZ0Pb0MNfWLP575zmY+eLuh
	KkvbeLcO7YDCfFAA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Add microcode_loader_disabled()
 storage class for the !CONFIG_MICROCODE case
Cc: Ingo Molnar <mingo@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <aBhJVJDTlw2Y8owu@gmail.com>
References: <aBhJVJDTlw2Y8owu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174642313133.22196.1399999155495550414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     e26d770a995f6f1ddb7c0c6d24f1aa81fb41eaa4
Gitweb:        https://git.kernel.org/tip/e26d770a995f6f1ddb7c0c6d24f1aa81fb4=
1eaa4
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 05 May 2025 07:15:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 05 May 2025 07:15:27 +02:00

x86/microcode: Add microcode_loader_disabled() storage class for the !CONFIG_=
MICROCODE case

Fix this build bug:

  ./arch/x86/include/asm/microcode.h:27:13: warning: no previous prototype fo=
r =E2=80=98microcode_loader_disabled=E2=80=99 [-Wmissing-prototypes]

by adding the 'static' storage class to the !CONFIG_MICROCODE
prototype.

Also, while at it, add all the other storage classes as well for this
block of prototypes, 'extern' and 'static', respectively.

( Omitting 'extern' just because it's technically not needed
  is a bad habit for header prototypes and leads to bugs like
  this one. )

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>
Link: https://lore.kernel.org/r/aBhJVJDTlw2Y8owu@gmail.com
---
 arch/x86/include/asm/microcode.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcod=
e.h
index d53148f..af33bbf 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -14,15 +14,15 @@ struct ucode_cpu_info {
 };
=20
 #ifdef CONFIG_MICROCODE
-void load_ucode_bsp(void);
-void load_ucode_ap(void);
-void microcode_bsp_resume(void);
-bool __init microcode_loader_disabled(void);
+extern void load_ucode_bsp(void);
+extern void load_ucode_ap(void);
+extern void microcode_bsp_resume(void);
+extern bool __init microcode_loader_disabled(void);
 #else
 static inline void load_ucode_bsp(void)	{ }
 static inline void load_ucode_ap(void) { }
 static inline void microcode_bsp_resume(void) { }
-bool __init microcode_loader_disabled(void) { return false; }
+static inline bool __init microcode_loader_disabled(void) { return false; }
 #endif
=20
 extern unsigned long initrd_start_early;

