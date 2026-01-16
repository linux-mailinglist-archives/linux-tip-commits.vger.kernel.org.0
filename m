Return-Path: <linux-tip-commits+bounces-8037-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A60D388D0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Jan 2026 22:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74F6C300A6D8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Jan 2026 21:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A38A3093BA;
	Fri, 16 Jan 2026 21:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S6seng/E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zt+W4+P3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FDF3090CB;
	Fri, 16 Jan 2026 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768599986; cv=none; b=rDahMUHjLM1GBColuM1GeevD1Ybzn50S5wvk6BL7lll6ybBesFBpDzQRIyBKwMy6EcQeagQdstKFgq+F//6ZFcm8ZnGFXkCAXqqI+rul577ksaioSuu+hxz0p/On4nA6bqeeana8b+aZvNiQ2b1iVlPhMKrjfyZFuYR//uFeLU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768599986; c=relaxed/simple;
	bh=bkYWCGKcVbZ4wXhxt0zP22beTMx1m7tKrc2wuwCfPS4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mC0JRCxOGR1xudearMYs8I4f+lcrzgO6M8MaycJgD/r2tDjhcp658f81qDRn++Sz7pSVQllzqHlYPkJTmWHhHp6P/EeLGhQH8VHvm2BfYlZCmSAV5FnivPDbw3Rtjy2KjJwyEc/92M75Tv8YT2fuA7V58zq5KH0frqONLzgOf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S6seng/E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zt+W4+P3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Jan 2026 21:46:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768599982;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUPUAc481EykTjYOypiXffIX/pIjBpn2inVrZsWhR7c=;
	b=S6seng/EIVm1+ctF5rk4Q1XxnfrlbDX/E/FpC6dJGIioXD3FlVz45/cNUOIr38zJqv86hg
	49r2fYzJIBwpzTL7yKCfmemS6e78PXR32GGR1HviIwzGHKHXrdPEuLfa9eW+qcyJU52aCX
	l2bPCmn2mIzvY1Ss/GrrR20CT646+1RtdsbT2MTlrPqb+enT1Y0rB+YZnoy5Q5fEl0HHbj
	N6YZ1FYvltpZ2ZbMnyC2sLPE1z4yczKcoMIHUCIaiC4DhfTMD0QucEXjt4ITJAWbbv4LX5
	k10ZD+Ell3oCw6N8jdMJStuuqnE6C5B1ob0W2ExhzSPGVvAjyJUtauS1cyKu7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768599982;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LUPUAc481EykTjYOypiXffIX/pIjBpn2inVrZsWhR7c=;
	b=Zt+W4+P3/cEJnbXbiDV9fG1KeqOxXybjz+zkIIexihVquZPePDSFYBxeatmFcPZqXCARWJ
	sq2jHISC8e12s7Bw==
From: "tip-bot2 for H. Peter Anvin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/vdso: Fix filtering of vdso compiler flags
Cc: Chris Mason <clm@meta.com>, "H. Peter Anvin (Intel)" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260116204057.386268-3-hpa@zytor.com>
References: <20260116204057.386268-3-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176859998152.510.2900348916176021001.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     a48acbaf99d239e60a09a9e2b7d0f7e9feb62769
Gitweb:        https://git.kernel.org/tip/a48acbaf99d239e60a09a9e2b7d0f7e9feb=
62769
Author:        H. Peter Anvin <hpa@zytor.com>
AuthorDate:    Fri, 16 Jan 2026 12:40:55 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 16 Jan 2026 13:25:33 -08:00

x86/entry/vdso: Fix filtering of vdso compiler flags

This fixes several typos in the filtering of compiler flags for vdso,
discovered by Chris Mason using an AI script:

1. "-fno-PIE" was written as "fno-PIE".
2. "CC_PLUGINS_FLAGS" was written as "CC_PLUGIN_FLAGS"

To the best of my knowledge, none of these actually had any real
impact on the build at this time but they are genuine bugs which could
break things at any point in the future.

Chris's script also found that "CONFIG_X86_USER_SHADOW_STACK" was
missing "CONFIG_", but it needs a different fix.

[ dhansen: remove CONFIG_X86_USER_SHADOW_STACK munging,
	   add mention in changelog. ]

Closes: https://lore.kernel.org/20260116035807.2307742-1-clm@meta.com
Fixes: 693c819fedcd ("x86/entry/vdso: Refactor the vdso build")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20260116204057.386268-3-hpa@zytor.com
---
 arch/x86/entry/vdso/common/Makefile.include | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/common/Makefile.include b/arch/x86/entry/vds=
o/common/Makefile.include
index 3514b4a..687b3d8 100644
--- a/arch/x86/entry/vdso/common/Makefile.include
+++ b/arch/x86/entry/vdso/common/Makefile.include
@@ -23,9 +23,9 @@ $(obj)/%.lds : KBUILD_CPPFLAGS +=3D $(CPPFLAGS_VDSO_LDS)
 #
 flags-remove-y +=3D \
 	-D__KERNEL__ -mcmodel=3Dkernel -mregparm=3D3 \
-	-fno-pic -fno-PIC -fno-pie fno-PIE \
+	-fno-pic -fno-PIC -fno-pie -fno-PIE \
 	-mfentry -pg \
-	$(RANDSTRUCT_CFLAGS) $(GCC_PLUGIN_CFLAGS) $(KSTACK_ERASE_CFLAGS) \
+	$(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(KSTACK_ERASE_CFLAGS) \
 	$(RETPOLINE_CFLAGS) $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
 	$(PADDING_CFLAGS)
=20

