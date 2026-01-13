Return-Path: <linux-tip-commits+bounces-7953-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A70CD1925F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 14:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0BF2300F690
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 13:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB3B392812;
	Tue, 13 Jan 2026 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q0JuMN64";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RDwur9Me"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA203904F0;
	Tue, 13 Jan 2026 13:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312061; cv=none; b=p3Cr6f15leaXdbjZMjIO/20WHKC8pGj5RGxg6Wn7bWDGIqE4dmZHdenXh2T6zMH7Q7+L+83m1Iz4IBEFCOjyq0JP4hppohjuaWvdVM/XQeSVvUdAdlY9YM6VmLPFD2UoRYWVxsPysEHC9KEr4ZxB7197w75RWX1n3SP4b16Kk3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312061; c=relaxed/simple;
	bh=rZEOiaJD8ghbBlZUcSY4krOdbZUFAfcuywO7/3fXp+Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mMyNAh1RfKMb/Z9VjPPKR9EvfTQUwdYlfbFaYVIrL3bxY6evWn6tSzjpHKM9AynIfCj6XrIyycJmzyQ4rWZxFnbiA1MF6Nb/eMbjxjWR4zuQ0SgPjEXm1i9jIHoD1p9AEdmbO2ZzKiZOmzeP6NLIcuwMMsrE+gA+y7wxHpB7/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q0JuMN64; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RDwur9Me; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 13:47:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768312055;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ln1w8n3dupznu/DZjQAWkW1VQYFcqUOyZ6Zv5wrCk38=;
	b=q0JuMN64OIElSn7HCd4EiRCE4Dgpgl9DCyK1C7zF5Ax9hqjyvfkos20fYz57y75uipCrLC
	y/9XPxNE5fO64chp3CClU3gISqpgzwTLY85tV/kGHIT8awAWCagHW0uzPGCFCETTjausmB
	0y5AMJ+kz6EdMFrzvOJnALToIx0BNa1gKF1IsCTjvWJRjch1o+ejub9Q9c73CvUgSgEusB
	N8yADEkv5UhAOqGEuKiYBozuBPNkusDQ24qB69VgMnsDdrst8HzvAmfND0zXy9FhRMjTVq
	rcNoDEVzwzlAPpRJ08TiUiY/0R4FMNAdq6fczFtg24rheNRyAe+qVsHDcSjSHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768312055;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ln1w8n3dupznu/DZjQAWkW1VQYFcqUOyZ6Zv5wrCk38=;
	b=RDwur9MelOJ9+AV2EmCs3vZK+bQgx+f0usxSnGy/liXCPgd8bLKVP1V/gvdKGSO2RFLvs6
	+JFGphnFA2kJwOAQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] arm64: vdso32: Provide clock_getres_time64()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@kernel.org>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251223-vdso-compat-time32-v1-8-97ea7a06a543@linutronix.de>
References: <20251223-vdso-compat-time32-v1-8-97ea7a06a543@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176831205420.510.16851151516374277758.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     f10c2e72b5dea0bc7485a05da8e21781b69d5508
Gitweb:        https://git.kernel.org/tip/f10c2e72b5dea0bc7485a05da8e21781b69=
d5508
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 23 Dec 2025 07:59:19 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 14:42:23 +01:00

arm64: vdso32: Provide clock_getres_time64()

For consistency with __vdso_clock_gettime64() there should also be a
64-bit variant of clock_getres(). This will allow the extension of
CONFIG_COMPAT_32BIT_TIME to the vDSO and finally the removal of 32-bit
time types from the kernel and UAPI.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251223-vdso-compat-time32-v1-8-97ea7a06a543@=
linutronix.de
---
 arch/arm64/kernel/vdso32/vdso.lds.S      | 1 +
 arch/arm64/kernel/vdso32/vgettimeofday.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/v=
dso.lds.S
index e02b274..c374fb0 100644
--- a/arch/arm64/kernel/vdso32/vdso.lds.S
+++ b/arch/arm64/kernel/vdso32/vdso.lds.S
@@ -86,6 +86,7 @@ VERSION
 		__vdso_gettimeofday;
 		__vdso_clock_getres;
 		__vdso_clock_gettime64;
+		__vdso_clock_getres_time64;
 	local: *;
 	};
 }
diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vds=
o32/vgettimeofday.c
index 29b4d8f..0c6998e 100644
--- a/arch/arm64/kernel/vdso32/vgettimeofday.c
+++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
@@ -32,6 +32,11 @@ int __vdso_clock_getres(clockid_t clock_id,
 	return __cvdso_clock_getres_time32(clock_id, res);
 }
=20
+int __vdso_clock_getres_time64(clockid_t clock_id, struct __kernel_timespec =
*res)
+{
+	return __cvdso_clock_getres(clock_id, res);
+}
+
 /* Avoid unresolved references emitted by GCC */
=20
 void __aeabi_unwind_cpp_pr0(void)

