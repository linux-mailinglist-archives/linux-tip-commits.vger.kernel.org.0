Return-Path: <linux-tip-commits+bounces-4586-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5954CA75245
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 23:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E7A1891642
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 22:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE37A1E3DD7;
	Fri, 28 Mar 2025 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yuQKtjkV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IrPNyRsU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487621D8E12;
	Fri, 28 Mar 2025 22:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743199489; cv=none; b=UicgIGwbYK6brdgLF+DY+JdiFzwYNfl3YxmXgxlRo5dlYA4a1MwboQRUemz+Y8zTD0EDTiNezCFz3ccOITeozryYuHEYSMAhMIW/Eq3Ryzs1TGx6nFTU5kWMtZIbIEJb5kG1v1Me1yLyCfOcihfDyNuWrNvvOMNKvbfz203TFOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743199489; c=relaxed/simple;
	bh=jKL0NIghsHDaCrujczl0jzxUwZim3kWRNpmX8vNSmWY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GPsip2+EJiaqQF/Mo5gU8lm/34oCD/EF0ewMixmG9E2Meq1DbotWkoqPKhIkcMC+xPocdwU3NUThFOE7wyv5kO5i/p5AfrBaomElEuii/sEZ/J9XJCuAraOcAVfHCcsS11zIYNP8X1cQAscM3y2NLHgh4RpP7vBD9X/nvJ6Gk0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yuQKtjkV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IrPNyRsU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Mar 2025 22:04:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743199486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2iCxy45/Hfgkhv+fwzFVjto4uLubRBntiK/mIhPcck=;
	b=yuQKtjkV6fiM4ZUlmUPMkQzzY1ef5RGPv1lmiDlQpln48Ymj2E7XbJkdzR/sux3VuO7lRp
	hulXVXX628vIpR+UhThK/QuEzNzNE8AA7+USKIWKkHNVEjbQRnI5mLWZux49FlKtgOwm1w
	rLPcSHABx7IS/dNqQKx/dmaN+R0QsvR2vdasMjQtD3qIq88a4L60SoElTC4eYsI2gSdRd0
	rW/CXjjAQ0PPJxMjmgFT7sTagnr9vJ80fqMPrtOCjRrYbTNo7fICtW2fv2lGIYrvz9U06T
	b2jXXYbgUUMcROZxZn0e9DeIefCJkBsm1rut3SRNtE19JOI27bDoJdTxxktDJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743199486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2iCxy45/Hfgkhv+fwzFVjto4uLubRBntiK/mIhPcck=;
	b=IrPNyRsUnpCBZ2maGIsBsb5xZUY1OMwjb1Dc9FANwOjCiE3AHG4i0X4nBxtBsODdosdlgr
	PZ2T3t1YYboe/gAw==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/tools: Drop duplicate unlikely() definition in
 insn_decoder_test.c
Cc: Nathan Chancellor <nathan@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20250318-x86-decoder-test-fix-unlikely-redef-v1-1-74c84a7bf05b@kernel.org>
References:
 <20250318-x86-decoder-test-fix-unlikely-redef-v1-1-74c84a7bf05b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174319948509.14745.3479499949306417575.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f710202b2a45addea3dcdcd862770ecbaf6597ef
Gitweb:        https://git.kernel.org/tip/f710202b2a45addea3dcdcd862770ecbaf6597ef
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Tue, 18 Mar 2025 15:32:30 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 28 Mar 2025 22:57:44 +01:00

x86/tools: Drop duplicate unlikely() definition in insn_decoder_test.c

After commit c104c16073b7 ("Kunit to check the longest symbol length"),
there is a warning when building with clang because there is now a
definition of unlikely from compiler.h in tools/include/linux, which
conflicts with the one in the instruction decoder selftest:

  arch/x86/tools/insn_decoder_test.c:15:9: warning: 'unlikely' macro redefined [-Wmacro-redefined]

Remove the second unlikely() definition, as it is no longer necessary,
clearing up the warning.

Fixes: c104c16073b7 ("Kunit to check the longest symbol length")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/r/20250318-x86-decoder-test-fix-unlikely-redef-v1-1-74c84a7bf05b@kernel.org
---
 arch/x86/tools/insn_decoder_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
index 6c2986d..08cd913 100644
--- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -12,8 +12,6 @@
 #include <stdarg.h>
 #include <linux/kallsyms.h>
 
-#define unlikely(cond) (cond)
-
 #include <asm/insn.h>
 #include <inat.c>
 #include <insn.c>

