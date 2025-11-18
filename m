Return-Path: <linux-tip-commits+bounces-7401-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B26A8C6B71C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 20:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id EFCF32C40E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 19:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49CF2F12DB;
	Tue, 18 Nov 2025 19:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oAJTu/oO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HoK0OoS1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288052EE60F;
	Tue, 18 Nov 2025 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494126; cv=none; b=hNZ7KTgpLAeRPNBYu6gCy979nfKBNZDgkuiVsedo5GHIONjx8oWCubKverMCkvrd6KhJJy/nitUnsdTNtFLh/8rcHv13tmRM6eKH99Ka4XQsOcmJ+NTbBX+CsYsfR3X2QKAHQ6itteuzrG3E16loe4OMSslOBM/K9/5Hj8OL0Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494126; c=relaxed/simple;
	bh=fGVcDdyHgxfAxSLH6n97cKZNP3zlMTDYTkYH0aeKDfk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=STcqOsa8NHmquS48nOgsBeG3SeTxb8whx3tIif+vtWA9fMoaz0Ph3lvr84dxhW263hyDeta2StDw3O1b1NnWOpdGihQ/9YUKzWz1imEvjOBBLysFIPr1wSO0YjadplB+bXr61eQOo33JPN1Q+kkoL71vkk+AgOf10w4j45kx6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oAJTu/oO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HoK0OoS1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 19:28:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763494123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8wWWUqFsccZuB2ND5XauPkI+AAoP49v6H7Q9mg2BQRA=;
	b=oAJTu/oOm+DBiU9lCprsWQDS0xoGuecNxXP0ueiqqtUIiJzK0zwTUQeu9/zEzX2njsP58H
	VzuZFMn77BbTcmACvXjBnl/yJkJ8mU7YD88tgbCqobPBRE3F5miX9IJUfh+0anvdBIE1Zn
	AnAfkSNFcJXLRbQ+wM9/ZIiO25rYuNBdjXADZI6Z9WZ4/kc0I71WsClQCPZGkfSd1lOtFS
	RnTyu68i8RnglytpIBZFHEHMDwIdeuq4vMsyTTW268qR6Rm69aWmKGR+dkDd7U4h0MUzuU
	mxi1ktV53U1QUC5RESRoWNYXAExxo4le1Jo+2fZprRbfiCefy7sm+rmhfYFcEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763494123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8wWWUqFsccZuB2ND5XauPkI+AAoP49v6H7Q9mg2BQRA=;
	b=HoK0OoS13rASUiT75quVIcf7C2KkeGcpvJM3Xy/rvbTC8Kc0vBtuLg45GNFdopLEtJbxOw
	sW96nrhgfwseSMDA==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Add an LASS dependency on SMAP
Cc: Sohil Mehta <sohil.mehta@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176349412242.498.13461166073125191566.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     e39c5387adebf2839aaf5779cdd09a3506963fc5
Gitweb:        https://git.kernel.org/tip/e39c5387adebf2839aaf5779cdd09a35069=
63fc5
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Tue, 18 Nov 2025 10:29:04 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 18 Nov 2025 10:38:26 -08:00

x86/cpu: Add an LASS dependency on SMAP

With LASS enabled, any kernel data access to userspace typically results
in a #GP, or a #SS in some stack-related cases. When the kernel needs to
access user memory, it can suspend LASS enforcement by toggling the
RFLAGS.AC bit. Most of these cases are already covered by the
stac()/clac() pairs used to avoid SMAP violations.

Even though LASS could potentially be enabled independently, it would be
very painful without SMAP and the related stac()/clac() calls. There is
no reason to support such a configuration because all future hardware
with LASS is expected to have SMAP as well. Also, the STAC/CLAC
instructions are architected to:
	#UD - If CPUID.(EAX=3D07H, ECX=3D0H):EBX.SMAP[bit 20] =3D 0.

So, make LASS depend on SMAP to conveniently reuse the existing AC bit
toggling already in place.

Note: Additional STAC/CLAC would still be needed for accesses such as
text poking which are not flagged by SMAP. This is because such mappings
are in the lower half but do not have the _PAGE_USER bit set which SMAP
uses for enforcement.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251118182911.2983253-3-sohil.mehta%40intel.c=
om
---
 arch/x86/kernel/cpu/cpuid-deps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-dep=
s.c
index 46efcbd..98d0cdd 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -89,6 +89,7 @@ static const struct cpuid_dep cpuid_deps[] =3D {
 	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
 	{ X86_FEATURE_SPEC_CTRL_SSBD,		X86_FEATURE_SPEC_CTRL },
+	{ X86_FEATURE_LASS,			X86_FEATURE_SMAP      },
 	{}
 };
=20

