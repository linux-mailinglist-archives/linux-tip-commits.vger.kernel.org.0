Return-Path: <linux-tip-commits+bounces-8039-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 191DBD388E4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Jan 2026 22:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29EBC302D6F9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Jan 2026 21:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973C43093BA;
	Fri, 16 Jan 2026 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q+zW7M21";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8uPtwzl+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE65B2E2679;
	Fri, 16 Jan 2026 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768599988; cv=none; b=n7rXDOV9Z0JIgzHJVHsKAfba1zomnoHrTB/rLEHbRm+mRWL7kOYrmKoygjqpfUgnZ9HcSggE/ZyLZpIB3meuL0A2fPOZFlEesMK/x90ZNahP8V9V5tmH5iAECJ70oWW48VlB81ueI7K7QrEyfKsHSbxeFy9NEnwMpXZXFWDthxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768599988; c=relaxed/simple;
	bh=cS5ruYFF6XBiTjmhfT10QPtW6PXuz1CY/2LC9oqzyj8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Q9Fg1tDMfPgOwDUyQZ54LbLGfDJJUK1AN7jG+MfNwtfetQXhVe9mrjwz2/KiD5pMd+JhBRsY1O+C8Q0K8QDyduEifuZQ8kntuczrsV/HjnW7lsHk9nO8Ws9OlP4dS06Goy6aNyC9IB2QMtBru4qStE4KMe0Q3Qr6locsSvLTuOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q+zW7M21; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8uPtwzl+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Jan 2026 21:46:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768599983;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4U5pOqlJbxvTPtld8eP0B4wNoR2YUL07Ijl1CmZm0A=;
	b=Q+zW7M21mF+CQ27JdCsWKFxxULIwvXYjGl8cgU8WgK6g/0Dwz5Ecfq8hL6SEi8jHplntPa
	oHolBmGNPyE/vP5PUY4TOdeIlaKMat1s+joZuCcX2DZjqM/UKUW0sYXloExUOiJem4r+lN
	MiYQMOfFo0fKEO/QJ9I0UO/vGxaRCCTky2KpTolXhLT57Q/ju/u+7Hu9QfoN0qsHJKZL6a
	7+xX2+QflmqcAFo5vpRPOPRVdBcOcq7AXeI27/6GQTe3lBxa6MJcy1gZwlSmGtgT1+OuVC
	i94TvfKLxXPzPHzRL9Ni/+CbcnyKqFUl0+UR0EihD6sUBp/yt/yIyxfzTWxCOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768599983;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4U5pOqlJbxvTPtld8eP0B4wNoR2YUL07Ijl1CmZm0A=;
	b=8uPtwzl+4cF0EH7eedWelGQwa+16BmZ9SdBqQqcvhuiQrlHbr8OtjM9LOBPpkxr3eem60k
	vW4AwSWv+8X2+hBg==
From: "tip-bot2 for H. Peter Anvin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/vdso: Update the object paths for "make
 vdso_install"
Cc: Thorsten Leemhuis <linux@leemhuis.info>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260116204057.386268-2-hpa@zytor.com>
References: <20260116204057.386268-2-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176859998250.510.12948900356441481283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     b3683f3ba079940f91f4a26004250559f170eda9
Gitweb:        https://git.kernel.org/tip/b3683f3ba079940f91f4a26004250559f17=
0eda9
Author:        H. Peter Anvin <hpa@zytor.com>
AuthorDate:    Fri, 16 Jan 2026 12:40:54 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 16 Jan 2026 12:58:45 -08:00

x86/entry/vdso: Update the object paths for "make vdso_install"

The location of the vdso binary files in the object tree has changed;
update "make vdso_install" to match.

Closes: https://lore.kernel.org/16ea64d1-2a9b-46f9-9fcc-42958f599eb6@leemhuis=
.info
Fixes: 693c819fedcd ("x86/entry/vdso: Refactor the vdso build")
Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20260116204057.386268-2-hpa@zytor.com
---
 arch/x86/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 9ab7522..5f88146 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -318,9 +318,9 @@ PHONY +=3D install
 install:
 	$(call cmd,install)
=20
-vdso-install-$(CONFIG_X86_64)		+=3D arch/x86/entry/vdso/vdso64.so.dbg
-vdso-install-$(CONFIG_X86_X32_ABI)	+=3D arch/x86/entry/vdso/vdsox32.so.dbg
-vdso-install-$(CONFIG_COMPAT_32)	+=3D arch/x86/entry/vdso/vdso32.so.dbg
+vdso-install-$(CONFIG_X86_64)	   +=3D arch/x86/entry/vdso/vdso64/vdso64.so.d=
bg
+vdso-install-$(CONFIG_X86_X32_ABI) +=3D arch/x86/entry/vdso/vdso64/vdsox32.s=
o.dbg
+vdso-install-$(CONFIG_COMPAT_32)   +=3D arch/x86/entry/vdso/vdso32/vdso32.so=
.dbg
=20
 archprepare: checkbin
 checkbin:

