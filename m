Return-Path: <linux-tip-commits+bounces-3094-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 565B19F67E6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638FB1894AE0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3285A1F1905;
	Wed, 18 Dec 2024 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mX+u6zzc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="380cFSKL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7966F1E9B0D;
	Wed, 18 Dec 2024 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530607; cv=none; b=hjgfOeSC/7A+7Uy8fEPaP64pNs37q1VbE3nJIZ8Et/odrPJpwrZtatUI8x9BgAl7F3Y8Xpgf913yiBrHwnmtnsQHddhKxJ2qaJM+2qni8Dx6dh+Kz2YrJuVjHgJOfNQOsUJPiBrd2Z4Sm6FXX+7SSU83QBPtNRaY5SCy4ewyKmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530607; c=relaxed/simple;
	bh=qH+LfraHJok3LKlc/iMuYziuvhOlAt2ybwqNRK2PnGA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=OvwTxqmUtT2KNdtZ99EYH7HFGNysfpUhsz0+4nOG2C9wbaZpIhjmh5nTViY2pPcDF3u8PweSHyXGSXhzy4po+OIpwvXkakC5oF12iFOPtgrwVEW/otJlAayvsAl3chxgl9qFOu9ff5TaOVyEoYf0yaKHv0cqTkJreHvxWvGHx+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mX+u6zzc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=380cFSKL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:03:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734530603;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=VxrzjOhXHG791MZggBRbEelYl9j9lLc4PZqTADeuhq4=;
	b=mX+u6zzc1gLZAKJRtBlBwMMUgrq4rgW688zHtQo6iT+pSPCdp26J8JfrBy5pCPGPNBXI9T
	cTr+hCysPTTzyU6/+eTO4OudYmpE8ayLCvNBOde3eJ9ymgAA4eCP7hI+/fNNyxtn+Kkx/8
	fX9gDaNLHc7d7l5yY+K796EfZdVXEqKpn/gUDqIq447JJRzOUW6lLFb9EkPc4WNbmwRf5G
	DpnkyPu1RPLPKMJCnQUgKMDeBUB0SfLgmzmoLGbUzsik/NtfjwBlm1xjU/eWtCVTspxHr6
	RbZLT9jq0vakx3rQ7ronyF9gZKddh7XyISy09MS97obH0d/dhU4LPZJKGZEpuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734530603;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=VxrzjOhXHG791MZggBRbEelYl9j9lLc4PZqTADeuhq4=;
	b=380cFSKLmPlU9FrwqZ8JICMckpOdZPEIUCvCZExRXlTnY/rKd1xQFPtYLcjuADI019pQQp
	W+8tQVXT0D1FhTBQ==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Use MWAIT leaf definition
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173453060272.7135.12088300268106233380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d88d11ebed2a17658f9b6b7de0da2681d06fe24a
Gitweb:        https://git.kernel.org/tip/d88d11ebed2a17658f9b6b7de0da2681d06fe24a
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 12:50:29 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 05:24:42 -08:00

x86/cpu: Use MWAIT leaf definition

The leaf-to-feature dependency array uses hard-coded leaf numbers.
Use the new common header definition for the MWAIT leaf.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/all/20241213205029.5B055D6E%40davehans-spike.ostc.intel.com
---
 arch/x86/kernel/cpu/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d21b352..853e373 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -29,6 +29,7 @@
 
 #include <asm/alternative.h>
 #include <asm/cmdline.h>
+#include <asm/cpuid.h>
 #include <asm/perf_event.h>
 #include <asm/mmu_context.h>
 #include <asm/doublefault.h>
@@ -636,7 +637,7 @@ struct cpuid_dependent_feature {
 
 static const struct cpuid_dependent_feature
 cpuid_dependent_features[] = {
-	{ X86_FEATURE_MWAIT,		0x00000005 },
+	{ X86_FEATURE_MWAIT,		CPUID_MWAIT_LEAF },
 	{ X86_FEATURE_DCA,		0x00000009 },
 	{ X86_FEATURE_XSAVE,		0x0000000d },
 	{ 0, 0 }

