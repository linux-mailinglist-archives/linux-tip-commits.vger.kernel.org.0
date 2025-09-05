Return-Path: <linux-tip-commits+bounces-6496-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3344BB463AA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 21:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6086CA66CEE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 19:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234D8281351;
	Fri,  5 Sep 2025 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DQOXoiFF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M13YITVe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777A1272E51;
	Fri,  5 Sep 2025 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100792; cv=none; b=UEr2J36FG/+7Tdw10I1/ApFdV0NOWI9GnRXSovHilCsu1nTBQ36vjBinwEaX8olTUKkl5v+q/gYcR/vwmjWb11evsat1sjii/jDK+CIn0dEF/MKvQom30Zaz6Pgbc49E2uAW6m5JPA+PymLw9N8xgQH2XGaOxwtWKm4J6DMOacI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100792; c=relaxed/simple;
	bh=HQaD2W2Xc5u31yEFJ1XLSvhjXIVEmh+a3X6m3/kvUSE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=irYqfN2c8UEmXdOva+KekltTaPE4lfX3Gigcwt35eWgvyDPS96/w0+m156hMpsZMBfDF6y21lnAabPrBlpDZGEEEUokOkm50IJh1o0iQaACO9SvPPKEu4DNgkrrVGRWP5krDv1s2T6cFYPlK5pG6wArjpjQIJdBKuJLNEUHFzo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DQOXoiFF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M13YITVe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Sep 2025 19:33:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757100788;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9s3a7ouN/KoalsBG0NQB5BDyUWtLYPS7ck0g6wFXwno=;
	b=DQOXoiFFH0WSuW2tJAu0ytz4zdWDq3uIG7U7QXfGC/FU87w9J5sGUrwIxW6ZqtApLihIN6
	8StDd0L05lP9TAy4foX13i9jnmyWlO2ZuC0QwPZTkaEXoKmY4BHV+uVH0ZUFYedVUQIvrO
	18mFHL3RTuZMbmgsz7EHqibI/RqIepT4X2VUTPI/CjKjjkV+Ruq4e3iWJfMEFyN/yw3fm8
	8ewYXORLYNGI24ppnlLyuXnMXM3wHpm+Eo3SbcUgjI5TwwlGXAPmIwZFh/amsF0/uKGZYf
	02YH74ndquawKp5gAJrON+2Uiqysz4vur3agJlVghGUqTThgV/OFu+mMwU062A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757100788;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9s3a7ouN/KoalsBG0NQB5BDyUWtLYPS7ck0g6wFXwno=;
	b=M13YITVe9o250LOiL7EQUJG0iTlyN2VqhogahYkC1eXnRXU3dPvjSXJLxov9Un0GJJjiK8
	iks+iV1NLml8irCQ==
From: "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Remove the !KEXEC_CORE dependency
Cc: Kai Huang <kai.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Farrah Chen <farrah.chen@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175710078713.1920.3219480283836156265.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     80804847269eba880dc8c1bc64d70082692f72cd
Gitweb:        https://git.kernel.org/tip/80804847269eba880dc8c1bc64d70082692=
f72cd
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Mon, 01 Sep 2025 18:09:28 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 05 Sep 2025 10:40:40 -07:00

x86/virt/tdx: Remove the !KEXEC_CORE dependency

During kexec it is now guaranteed that all dirty cachelines of TDX
private memory are flushed before jumping to the new kernel.  The TDX
private memory from the old kernel will remain as TDX private memory in
the new kernel, but it is OK because kernel read/write to TDX private
memory will never cause machine check, except on the platforms with the
TDX partial write erratum, which has already been handled.

It is safe to allow kexec to work together with TDX now.  Remove the
!KEXEC_CORE dependency.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Link: https://lore.kernel.org/all/20250901160930.1785244-6-pbonzini%40redhat.=
com
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890f..e2cbfb0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1896,7 +1896,6 @@ config INTEL_TDX_HOST
 	depends on X86_X2APIC
 	select ARCH_KEEP_MEMBLOCK
 	depends on CONTIG_ALLOC
-	depends on !KEXEC_CORE
 	depends on X86_MCE
 	help
 	  Intel Trust Domain Extensions (TDX) protects guest VMs from malicious

