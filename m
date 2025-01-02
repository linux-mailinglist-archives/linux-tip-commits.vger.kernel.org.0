Return-Path: <linux-tip-commits+bounces-3166-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805A59FF913
	for <lists+linux-tip-commits@lfdr.de>; Thu,  2 Jan 2025 13:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09BB1883173
	for <lists+linux-tip-commits@lfdr.de>; Thu,  2 Jan 2025 12:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4C51AF0A4;
	Thu,  2 Jan 2025 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f6eTOvNt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jbn4SIMN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E481AE876;
	Thu,  2 Jan 2025 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735819319; cv=none; b=rWWaMA5e3j4dPzFB+3T2CqOLs2j0rFPASiuziVQdCgZjG3MIY1IIfHZnhPOEarUDeVK3W9Zsov32Hu/VUb3+vMtQAfdMmI0JJC1yeG3H7HgUoJr/rsA53I11OmniIUPY+mb28PLQxMX0XR84HQCIqWoEbHBEcacdWx7GUMFUKfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735819319; c=relaxed/simple;
	bh=XIebtAGOTZpjSeW9OsAIOS0zFTglxEbd2klARMLy5no=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GYhXt0hlCAa+0aV5epI3aruQ40rR7kymKDLrmgFubqhzx+5iibidIxlzhClo7hE9QGPMUIPByXDOeSJgTuT9hxvyXlTcJNdYYzovoTuQ9IwyTBFmAJjdwl1k9f57roPn2UAgkohn5wVCeH7K1PVdMir9ONTyJ/tl6o0EOMmIFOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f6eTOvNt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jbn4SIMN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 02 Jan 2025 12:01:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735819306;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3mZ/Jb042qf7Hw87ftrd/Dr+JsuY9ldNvfG/VeX37Ag=;
	b=f6eTOvNtMBNSgDbIKaBAV7YhrC3Kcn4X8lCLNAAYnMZkj0Xr3aqOmbfwbVkiWEAksx18TP
	hVtQHy1iAa+N4Vfx8e8TDgs2N8/Yzw6YIdP0CLDDZ8c220843cn5I6a1NxZcMA4+dZeZsz
	e9mmykQYY0MRksToOK0AwQ/pSOrdg9aELLU1A0cjZq30AyhkG4mCqjHEyS4wZQ3BXyRnGy
	pUNGslwrfRY/FSfIelZlzjSkgKekg1q/RVUlK7iObe2kNoD4nSJnoYq0aW9EEIpmGP+2TH
	AyZqEdg18desbCg/QGKaSNTqE0WELdHD9FjZAsduG0y+s9rooiHlUeZ//W5uTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735819306;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3mZ/Jb042qf7Hw87ftrd/Dr+JsuY9ldNvfG/VeX37Ag=;
	b=Jbn4SIMNWBf+vN/U8jj+TW0nuv71xlRtPkUGWmEevCeBU3X2QVlXkvodolFcz9H3LapZ4y
	lexWwdLGjPhWhcCQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/sev: Disable UBSAN on SEV code that may execute
 very early
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250101115119.114584-2-ardb@kernel.org>
References: <20250101115119.114584-2-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173581930320.399.2851329983366045803.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     99b863d2e87210c70354a1c75cc5bcc7a3afdc01
Gitweb:        https://git.kernel.org/tip/99b863d2e87210c70354a1c75cc5bcc7a3a=
fdc01
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 01 Jan 2025 12:51:20 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 02 Jan 2025 12:13:13 +01:00

x86/sev: Disable UBSAN on SEV code that may execute very early

Clang 14 and older may emit UBSAN instrumentation into code that is
inlined into functions marked with __no_sanitize_undefined=C2=B9. This may
result in faults when the code is executed very early, which may be the
case for functions annotated as __head. Now that this requirement is
strictly enforced, the build will fail in this case with the following
message

  Absolute reference to symbol '.data' not permitted in .head.text

Work around this by disabling UBSAN instrumentation on all SEV core
code.

=C2=B9 https://lore.kernel.org/r/20250101024348.GA1828419@ax162

  [ bp: Add a footnote with Nathan's detailed explanation and a Fixes
    tag ]

Fixes: 3b6f99a94b04 ("x86/boot: Disable UBSAN in early boot code")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20250101115119.114584-2-ardb@kernel.org
---
 arch/x86/coco/sev/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index 4e375e7..08de375 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -13,3 +13,6 @@ KCOV_INSTRUMENT_core.o	:=3D n
 # With some compiler versions the generated code results in boot hangs, caus=
ed
 # by several compilation units. To be safe, disable all instrumentation.
 KCSAN_SANITIZE		:=3D n
+
+# Clang 14 and older may fail to respect __no_sanitize_undefined when inlini=
ng
+UBSAN_SANITIZE		:=3D n

