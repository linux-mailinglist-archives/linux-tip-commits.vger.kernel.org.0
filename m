Return-Path: <linux-tip-commits+bounces-3544-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347D1A3EF5D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41DA47A1EF6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C5E200BBB;
	Fri, 21 Feb 2025 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rnl+zpY+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P02qbXrA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBB81DE896;
	Fri, 21 Feb 2025 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128589; cv=none; b=CQXE4g8KkS3BgTr/mI+NI6IhksJrEYf3T5IB2di22LFwkM+XqT74ytYHOBrO61CbZ1ujmfnQFDlP28/NBok5iPSKl6mPjv4q0pwxI6Ha1okL+5g3sxVEBrB3R+6SovFZamX4GELwmFWHsGtSjOFu6uFd4+JNxNQdeCtSvtY2lJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128589; c=relaxed/simple;
	bh=mXufvFk8zCVwPxYWHiEMzKFCN75Jgqkp+b1iECOHgjE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q7Fv1XkCZ0YK/tyzr6FdlXOIc3Z/bWJIC9mBDo5nAcEsh9H6CoggpH2vE5McIL28PqeBQEqmWaPdymYwquN+ZSP/ajbT6FbJuEO/YEqvxWFFpthcWk1yV/GjQtZC/z9r/AS0T9VaOAnMHO6LWHAi7UWE08WcsI0sPEE2WO/Hyx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rnl+zpY+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P02qbXrA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:03:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/lLZWozdLHCZCfOAkrrKVD/GUXkizD3R0vluRQIEyo=;
	b=Rnl+zpY+nePrrukzXBg7e7EVIozfVeKqFDJv9i5XvB+/tZgmGA0bk+imUFSshlGDgb0MLm
	rkwKx1eUXuAyirYZoQ1EDT+8jeuB60hPGo7RPQctonT5M7lg/PqLLHOIFcMqNUN2YtgU6M
	mjE3ZRkXTaFqURfz679n/r306OFHj/NMjZ9Tgsxg3QDvdTKU+FvhmlWwyil6RUAf9Vt8KL
	lBesEUKLCSEnjdZ5GngAMEO2DFLwZO4nIAFWlutD3sYXR2o2CFPv655vE2BoANW3OMqQNM
	LrdydruVtd7BlCiGRNSsnI0SIBDFxv36igIxCmXxvarE98PKVM4rf5bcoQPHWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/lLZWozdLHCZCfOAkrrKVD/GUXkizD3R0vluRQIEyo=;
	b=P02qbXrAOSfZfBaIRV+huzg76Gw8RRJxGdvrFSsEThqOMQa+bS8OYglzEIhPFRpIcsgqvm
	/9gfy3DqkqmadkAQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Remove remnants of architecture-specific
 random state storage
Cc: Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250204-vdso-store-rng-v3-17-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-17-13a4669dfc8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012858596.10177.5808758773635173541.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     998a8a2608199fc07c3a49200c73708e9df01e0f
Gitweb:        https://git.kernel.org/tip/998a8a2608199fc07c3a49200c73708e9df=
01e0f
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 04 Feb 2025 13:05:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:54:03 +01:00

vdso: Remove remnants of architecture-specific random state storage

All users of the random vDSO are using the generic storage
implementation. Remove the now unnecessary compatibility accessor
functions and symbols.

Co-developed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250204-vdso-store-rng-v3-17-13a4669dfc8c@=
linutronix.de

---
 include/asm-generic/vdso/vsyscall.h | 5 -----
 include/vdso/datapage.h             | 1 -
 2 files changed, 6 deletions(-)

diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/v=
syscall.h
index a5f973e..13e2ac3 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -32,11 +32,6 @@ static __always_inline struct vdso_data *__arch_get_k_vdso=
_data(void)
=20
 #define __arch_get_vdso_u_time_data __arch_get_vdso_data
=20
-#ifndef __arch_get_vdso_u_rng_data
-#define __arch_get_vdso_u_rng_data() __arch_get_vdso_rng_data()
-#endif
-#define vdso_k_rng_data __arch_get_k_vdso_rng_data()
-
 #endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
=20
 #ifndef __arch_update_vsyscall
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 46658b3..497907c 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -152,7 +152,6 @@ struct vdso_rng_data {
 #ifndef CONFIG_GENERIC_VDSO_DATA_STORE
 extern struct vdso_time_data _vdso_data[CS_BASES] __attribute__((visibility(=
"hidden")));
 extern struct vdso_time_data _timens_data[CS_BASES] __attribute__((visibilit=
y("hidden")));
-extern struct vdso_rng_data _vdso_rng_data __attribute__((visibility("hidden=
")));
 #else
 extern struct vdso_time_data vdso_u_time_data[CS_BASES] __attribute__((visib=
ility("hidden")));
 extern struct vdso_rng_data vdso_u_rng_data __attribute__((visibility("hidde=
n")));

