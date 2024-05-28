Return-Path: <linux-tip-commits+bounces-1301-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBC98D22F3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 May 2024 20:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFC41C232C6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 May 2024 18:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72F0481DD;
	Tue, 28 May 2024 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="beSIONyO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GHe4JmNt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468E645C14;
	Tue, 28 May 2024 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919510; cv=none; b=mIhPKRQ/v2gwxtvIhJ8hB+scqYTRROpdQvcTiwSAnRDpmDE7/U/wy8YG1CGON+DD6GfULuhcfNlOGeir+JufN3ibBDUpfBe2Iq7iHERYa8iH0pwjSzr+mPj+lSkNBa12TbBauu8XKfr7YsZsfKYciY5TdQstW2v+hH8ImpGJ7cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919510; c=relaxed/simple;
	bh=KqbT6BGd1Rvq6b8FYm1Yqg1MVJYjdI+XNxUZORm5anM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=jZ26oTIW1uTvsJnBiKC12LiOwrQ8GYPoj5IDoLqNgFC5vul4KrWCb6j1dje8Clu7vOBjfFwocqeOMXVL4C9fD5ccYzdxzBMv4AYk7FnioqTpeow3f7cZXTPJPDurR0HSlrbsTs9jE0KnJiCwUHBcqiH8tJ1GGLyIHEEzZApedpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=beSIONyO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GHe4JmNt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 May 2024 18:05:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716919507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=E0bbcDFGhMgIUhv2fY6dmxwOX2Cc5oryhf23zUQpKMk=;
	b=beSIONyOuztQFLifQdgl/ZwjEOvDSxaSUK+lFWoJCifAOiAZQD40Y1KZAUTtxlmQJYsNYF
	t9n9NBHpnz7fAT2REDuMlXMDj/Nt0QmC7k2czSdlqA+J827DtsQZ77ggDBid0Ug3GbADqB
	btOqozGfZGA/wF/txotFRbr67jBpGuNfl3e0i/TF81fFVqt+fDWBDPyEDkMXcGNyipsqoO
	RsHdfduMEHCIExQhSZh0KrAWJRrpTb4N2qha+Cizd0dG9vj2qWe/+Qk4rM+sHKFS5n4lQJ
	pTDg0pb2jQZDB61fm6BniHNjyPz4fOZg/ft2y8fZZQIksaFomBDFYgGdHwyHaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716919507;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=E0bbcDFGhMgIUhv2fY6dmxwOX2Cc5oryhf23zUQpKMk=;
	b=GHe4JmNtnu3yyTJZWZxwPTXG9CXaM962R1oqnkUT7/PPec3Y7AgoNplcKTV9e1zlDHqbQ0
	muTzBzBxCAbtBXBw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/virt/tdx: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171691950749.10875.7832968008761486489.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     189e8d4b98495a9145301a3594f4fb56118211e8
Gitweb:        https://git.kernel.org/tip/189e8d4b98495a9145301a3594f4fb56118211e8
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 20 May 2024 15:46:01 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 28 May 2024 10:59:02 -07:00

x86/virt/tdx: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240520224620.9480-31-tony.luck%40intel.com
---
 arch/x86/virt/vmx/tdx/tdx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 49a1c68..4e2b2e2 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -33,7 +33,7 @@
 #include <asm/msr.h>
 #include <asm/cpufeature.h>
 #include <asm/tdx.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/processor.h>
 #include <asm/mce.h>
 #include "tdx.h"
@@ -1426,9 +1426,9 @@ static void __init check_tdx_erratum(void)
 	 * private memory poisons that memory, and a subsequent read of
 	 * that memory triggers #MC.
 	 */
-	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_SAPPHIRERAPIDS_X:
-	case INTEL_FAM6_EMERALDRAPIDS_X:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_SAPPHIRERAPIDS_X:
+	case INTEL_EMERALDRAPIDS_X:
 		setup_force_cpu_bug(X86_BUG_TDX_PW_MCE);
 	}
 }

