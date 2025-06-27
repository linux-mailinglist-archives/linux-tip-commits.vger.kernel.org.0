Return-Path: <linux-tip-commits+bounces-5936-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B67AEB7B4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 27 Jun 2025 14:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F198A162E37
	for <lists+linux-tip-commits@lfdr.de>; Fri, 27 Jun 2025 12:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DAF21FF29;
	Fri, 27 Jun 2025 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mk5XWHEr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="teF/KbJV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AEB1E48A;
	Fri, 27 Jun 2025 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751027446; cv=none; b=rfX3wAu5tcILXO4u8HuTsDdHMKFdCslyZw3l5SDJ9OEP0EN7mbfHtDSMrQAiezjKTtwDUr7ru/4D88psG7ZmQnaES7FE9NvZc+NNXu9sdaT4NrCRZGL5q0RHPQHgh31tORKMBh48PEBwrwECoOhO5Ve8CBwIL2dz5ejHI95BsVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751027446; c=relaxed/simple;
	bh=Ok27ndXbgJvGzAwvRibXZyVHRTGL33CZGAg3z69nm2g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rkYFwIV5po13pNwVP31gliCVuzTWUovrQIRKIJA7ACt2xfNxzZsIgSpIpTr9E0gTQ8F9gUIUjh5F0DqEV1LI89IhBhT9j4yxiUf5+DSDTEZOMZqTflsEt3AYZP3X9+KM39nfeef/I+iRNJLhZG3jBkW+N3Bo/6/AqaA1Q48e19c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mk5XWHEr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=teF/KbJV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 27 Jun 2025 12:30:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751027443;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5UuquIOd48LNDRf/YpkEhP7n0TMXAByxXWh/bA6cGs=;
	b=mk5XWHErVVr4pekI58kdZkVIifpvb2JyQCbNlpgmUAUHFfo0iu6wtVhA2hxjxTaETtioFQ
	mKnOyI+683CUrksEcat9uaQg/XATUEFsPEJUshpl6TcnAIBhDWdlxgDaWvhUIITLKaYxOS
	HxkyXRmm1WFMPX5YBZvEeMqgvsWR8hclkgqANRFwwBC5I6DzPGTcJP8q5yefQUyFVJgJAa
	f7OJ2i2a2uNO2qVD00k2JTQzKN53akeh2SBXw0+sK6PIcsptaffiRewJXYcsOx8dj9Ggwy
	WpEfA3A81yVXldZh23yL2DAGXGFYJUwzXbyA01cRZ75HkCs9r/0i3lTRmACg8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751027443;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5UuquIOd48LNDRf/YpkEhP7n0TMXAByxXWh/bA6cGs=;
	b=teF/KbJVTMt7XBUr+Y5J9rA+4LcssstxAZXG8G2nrY6Pv2QLPVzfjvbpcjWgJuEMVEKl2n
	KUpZs2KuZoHZ3iAg==
From: "tip-bot2 for Gerd Hoffmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev/vc: Fix EFI runtime instruction emulation
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Pankaj Gupta <pankaj.gupta@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250626114014.373748-2-kraxel@redhat.com>
References: <20250626114014.373748-2-kraxel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175102744208.406.15035701661646196374.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     7b22e0432981c2fa230f1b493082b7e67112c4aa
Gitweb:        https://git.kernel.org/tip/7b22e0432981c2fa230f1b493082b7e67112c4aa
Author:        Gerd Hoffmann <kraxel@redhat.com>
AuthorDate:    Thu, 26 Jun 2025 13:40:11 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 27 Jun 2025 13:53:12 +02:00

x86/sev/vc: Fix EFI runtime instruction emulation

In case efi_mm is active go use the userspace instruction decoder which
supports fetching instructions from active_mm.  This is needed to make
instruction emulation work for EFI runtime code, so it can use CPUID and
RDMSR.

EFI runtime code uses the CPUID instruction to gather information about
the environment it is running in, such as SEV being enabled or not, and
choose (if needed) the SEV code path for ioport access.

EFI runtime code uses the RDMSR instruction to get the location of the
CAA page (see SVSM spec, section 4.2 - "Post Boot").

The big picture behind this is that the kernel needs to be able to
properly handle #VC exceptions that come from EFI runtime services.
Since EFI runtime services have a special page table mapping for the EFI
virtual address space, the efi_mm context must be used when decoding
instructions during #VC handling.

  [ bp: Massage. ]

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Link: https://lore.kernel.org/20250626114014.373748-2-kraxel@redhat.com
---
 arch/x86/coco/sev/vc-handle.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index 0989d98..faf1fce 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/io.h>
 #include <linux/psp-sev.h>
+#include <linux/efi.h>
 #include <uapi/linux/sev-guest.h>
 
 #include <asm/init.h>
@@ -178,9 +179,15 @@ static enum es_result __vc_decode_kern_insn(struct es_em_ctxt *ctxt)
 		return ES_OK;
 }
 
+/*
+ * User instruction decoding is also required for the EFI runtime. Even though
+ * the EFI runtime is running in kernel mode, it uses special EFI virtual
+ * address mappings that require the use of efi_mm to properly address and
+ * decode.
+ */
 static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 {
-	if (user_mode(ctxt->regs))
+	if (user_mode(ctxt->regs) || mm_is_efi(current->active_mm))
 		return __vc_decode_user_insn(ctxt);
 	else
 		return __vc_decode_kern_insn(ctxt);

