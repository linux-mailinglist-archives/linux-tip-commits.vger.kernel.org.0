Return-Path: <linux-tip-commits+bounces-3237-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FDDA11D62
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59C73A3852
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FEB2500B1;
	Wed, 15 Jan 2025 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MJjK/a/b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2FE/p1zJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AC01FC0F1;
	Wed, 15 Jan 2025 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932675; cv=none; b=JcBf5g1lLqdZfs5mbPjqikdkYz5WIMydf7Vs0HoxtVQjztIkK2/IrRGcUpCbPu835Z77HJVrG71qKxvHqYD70iJxNQ8njX0EXz0+FogjCj/pEXhnnt8Shezan9GdcbtuPIQpL5cJ6UWkOsCz19Zse0QsYKvb6Rhq1fZkT4qeyx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932675; c=relaxed/simple;
	bh=HhVinshpzPXF+Y4KRgrlBbXnzussNIWXTZrn9NtSSlU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YwH4Z1HZ38iyKYsGvycftu/r2YecAOAES67PxdGMVYRLGdsP3qsQdxw7LcaLluMaYG2n3uAPrLLS0yLYSLFpjNnEgkgKujHD6QEUJHLjkHj21nAtqITmunAMYwStTrYCL71vudIuj7Vrilbd4LoZvDBoGahGv1gulQsv+sVsylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MJjK/a/b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2FE/p1zJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUv6OdXunkHbFjt4Ljsv2kLWjNlPIlm69/yqap6IbYo=;
	b=MJjK/a/bixNIpOjZxGIqYMKbCChy9b9nP6vi2MIc/ZXBrOL3OiXYlXrntenwqTCREtxdhN
	URiAEz0+sZm/I+378sY6WktFtaWUsVjDXsqT9n6aeeChh3NihP6YFuNlp8bwtmsDaNXdEm
	CtPr7KZ+T71UMHnoo9IGNcsJEro70CCOJFbAaUgym4Bbv2sIjNXb4zDaH3V2oaC59zVWkp
	1Ch6oTwRG6hWdfWf1f+svDbZaE4kLa/dRnEhfeV9Q36/dv2vVmFpVmF6L/HXrM3dVlhB/z
	iI7BTu54XqywXZmovC5jZa1UhIGtPHieuj/2xXQNz73qm1Y1CUdu8GjuIy30tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUv6OdXunkHbFjt4Ljsv2kLWjNlPIlm69/yqap6IbYo=;
	b=2FE/p1zJMALka7P3xHrLkzDKX7e/xcPVWVRGMWuWl2EwMfNLqqK7ZgfnAQ1+ZagJl083Y1
	g4AFE5AkENFpMgBg==
From: "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/kexec: Mark machine_kexec() with __nocfi
Cc: Nathan Chancellor <nathan@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250109140757.2841269-7-dwmw2@infradead.org>
References: <20250109140757.2841269-7-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693267219.31546.15758183573184177131.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     2114796ca041f0d3e79e5dd165219b940b23c540
Gitweb:        https://git.kernel.org/tip/2114796ca041f0d3e79e5dd165219b940b2=
3c540
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Thu, 09 Jan 2025 14:04:18=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 14 Jan 2025 13:02:40 +01:00

x86/kexec: Mark machine_kexec() with __nocfi

A recent commit caused the relocate_kernel() function to be invoked through
a function pointer, but it does not have CFI information. The resulting trap
occurs after the IDT and GDT have been invalidated, leading to a triple-fault
if CONFIG_CFI_CLANG is enabled.

Using SYM_TYPED_FUNC_START() to provide the CFI information looks like it will
require a prolonged battle with objtool. And is fairly pointless anyway, as
the actual signature comes from a __kcfi_typeid_=E2=80=A6 symbol emitted from=
 the
C code based on the function prototype it thinks that relocate_kernel has,
rendering the check somewhat tautological.

The simple fix is just to mark machine_kexec() with __nocfi.

Fixes: eeebbde57113 ("x86/kexec: Invoke copy of relocate_kernel() instead of =
the original")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250109140757.2841269-7-dwmw2@infradead.org
---
 arch/x86/kernel/machine_kexec_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kex=
ec_64.c
index 9232ad1..1440f79 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -342,7 +342,7 @@ void machine_kexec_cleanup(struct kimage *image)
  * Do not allocate memory (or fail in any way) in machine_kexec().
  * We are past the point of no return, committed to rebooting now.
  */
-void machine_kexec(struct kimage *image)
+void __nocfi machine_kexec(struct kimage *image)
 {
 	unsigned long (*relocate_kernel_ptr)(unsigned long indirection_page,
 					     unsigned long pa_control_page,

