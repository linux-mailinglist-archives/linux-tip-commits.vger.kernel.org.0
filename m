Return-Path: <linux-tip-commits+bounces-7951-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10652D192D8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 14:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6318530ACE48
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6203921EE;
	Tue, 13 Jan 2026 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cwXxAAdA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FJ6X5VTf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAA83904F5;
	Tue, 13 Jan 2026 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312060; cv=none; b=NWBtAPVlGDA5K9HOU4LRVTNBcIMX0gKnDZ5/0avujkqTlx/UkS8hEzY3rklKKEE8eE3nQxPwqN9Y+U+B82L193DdVPyk3XyMnFWLU5LzCp4h3iitqZG0OMi7x+olIbdqwUuRJ5KDJ2r2UjESKvmUpFBCo4mzGxaRdHM22OLtji0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312060; c=relaxed/simple;
	bh=nzHY9lNTVBjhBxOTC/OI9+XmseXbriQS8jezs+pZxzI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BYq1sN2W238h6J81hBXUvE66YlgCVJa77Bpo+/cXPleljllYuFRthTEQWnhA/NLX+41EUDHqXa8FxFTbHIW8wqkMVJyhXw5RJSF2/s2UCV+i7ayDDe6UuRWNJOHrrR8usA+Zv52/AZQf4Sy60r5xfOV1X3YclgFi6oTecLZZKVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cwXxAAdA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FJ6X5VTf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 13:47:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768312056;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rg63anjNyT2kg6NcrMzzLiNOifMgjjx3Gu139zH7tm8=;
	b=cwXxAAdAGUZNckZZIJFJBbrfycQFmYmTlYucjyCgffC2J0QfcXWETCdJn7hKz1S5bQ2HDQ
	RW8skUkU8XEIq9JUiuI/Z+tp3Kgo+Nq+LzaxsaGF7HpqCuZjKA/WkyY2rfT7caR7vplC86
	OByXXQA1Mwu2Lk8/1HU8C6ktGbTIfbGweZmlrOMrsfDd6/aZIgGo348J0fLM4m/ZiLqZc6
	MRSUA/rvB3Jiqgh7nhB9GCEwFF6S4wOyfWnwEevxfCe+EQkiyS+IDZeTr+grYzbyYQt2La
	DzR46SzGsrJ35N1moR01ztOKxghbCgbvuapx1bFymna3y0+86JtyVHbiDAGJMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768312056;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rg63anjNyT2kg6NcrMzzLiNOifMgjjx3Gu139zH7tm8=;
	b=FJ6X5VTf5RF27X6ptVboUQxxoKKVjp34aKYr4XBG1lzaYXmI5MsaYAwrhFgG5K5Mcg0FUc
	sB/Kk3ZzRBTW2rDw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] ARM: VDSO: Provide clock_getres_time64()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251223-vdso-compat-time32-v1-7-97ea7a06a543@linutronix.de>
References: <20251223-vdso-compat-time32-v1-7-97ea7a06a543@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176831205531.510.4678880551764613269.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     1149dcdfc9ef4b3fa90b431a5752da53dcadb0d2
Gitweb:        https://git.kernel.org/tip/1149dcdfc9ef4b3fa90b431a5752da53dca=
db0d2
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 23 Dec 2025 07:59:18 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 14:42:23 +01:00

ARM: VDSO: Provide clock_getres_time64()

For consistency with __vdso_clock_gettime64() there should also be a
64-bit variant of clock_getres(). This will allow the extension of
CONFIG_COMPAT_32BIT_TIME to the vDSO and finally the removal of 32-bit
time types from the kernel and UAPI.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20251223-vdso-compat-time32-v1-7-97ea7a06a543@=
linutronix.de
---
 arch/arm/kernel/vdso.c        | 1 +
 arch/arm/vdso/vdso.lds.S      | 1 +
 arch/arm/vdso/vgettimeofday.c | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 566c40f..0108f33 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -162,6 +162,7 @@ static void __init patch_vdso(void *ehdr)
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime64");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_getres");
+		vdso_nullpatch_one(&einfo, "__vdso_clock_getres_time64");
 	}
 }
=20
diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
index 7c08371..74d8d8b 100644
--- a/arch/arm/vdso/vdso.lds.S
+++ b/arch/arm/vdso/vdso.lds.S
@@ -74,6 +74,7 @@ VERSION
 		__vdso_gettimeofday;
 		__vdso_clock_getres;
 		__vdso_clock_gettime64;
+		__vdso_clock_getres_time64;
 	local: *;
 	};
 }
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index 3554aa3..f7a2f5d 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -34,6 +34,11 @@ int __vdso_clock_getres(clockid_t clock_id,
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

