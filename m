Return-Path: <linux-tip-commits+bounces-2442-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61A199F228
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2322E1C21E2C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7FC1F9EB4;
	Tue, 15 Oct 2024 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dKB4xsdt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aD0ysqYf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6241F76B5;
	Tue, 15 Oct 2024 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007884; cv=none; b=Zm6Ut7A600kvEsGP0TOR/mF4BX0lhCjdwltnFWyELPkP7JxhLjc5pfMWW2sHhBxd6DkEYw+NR15YNPFJ/9lCQ6NNo3nIH3hfJWssekE1erLApMchrXm/3w25mjg0Yx5amo3JdKhWH7Pi4Us5F2F51hD76x5O+KC4opHFMle7Vfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007884; c=relaxed/simple;
	bh=gMX6iTfDMm1OXK+Hb0T2wIQJR4Nsxt1tYvzkW1k2q2o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d0mGTjJcIK6QdXyevFAvZNp+II/mKoZ+L655iovms2iqceUXTTbsJrbH2MZ9GnHYTn/cP+UPSb3uF1XcialAxu5GDXfXtN0JOuFpFYHWj51PtT+dt3A+TrsJvuvGJOEDDplrEiprhNA7z9t3waOGUbW384/j0XLhVIkkHfRm86k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dKB4xsdt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aD0ysqYf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:58:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729007881;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXurgSPJOLKotS50YGrtY+lfyDJTxt6uJJNyHI0gMtM=;
	b=dKB4xsdtNKq3Wo9jx/n3jOiyir4Y6be787ayUa/6t8r7wLNswBadrzWSYBUjay9oZ7Rzuz
	oQjrUgyEZOEWByyOM2EH51RMGl2i4tNTS4Y19oZKcdFBNdJRnHJRjXTUWO6T76n/r2klx3
	ypnGXd0d9P5Z6YROlDJlbdB2+I74jzGgxBoFbGzkbY5DEjaDnm0C+VNLwj+xn9Kwx1a0UJ
	Q1t6iwlNa3pHntU+CHsbpbXAyYKiS8tqydK40bWawzp/O/OEyGGKyOuciylTwGBLy2TGmh
	16OD+zZOX2WBHlvDGWc6L9QkaNEodqNZiIACCx3B74hwDPhCJ+9CaUr4iZus2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729007881;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GXurgSPJOLKotS50YGrtY+lfyDJTxt6uJJNyHI0gMtM=;
	b=aD0ysqYfOMQhTSX4s4sa5V7GFio0S2dUQQinw4oFhhQBCCAbn8e/xA6xeNTRW7pvTJNZhg
	ci4sFBYsei3W4pBA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Remove timekeeper argument of
 __arch_update_vsyscall()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20241010-vdso-generic-arch_update_vsyscall-v1-1-7fe5a3ea4382@linutronix.de>
References:
 <20241010-vdso-generic-arch_update_vsyscall-v1-1-7fe5a3ea4382@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900788089.1442.5849190644686353213.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     39c089a01a7e431383710a566864644cbbc0f8fe
Gitweb:        https://git.kernel.org/tip/39c089a01a7e431383710a566864644cbbc=
0f8fe
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 17:44:44 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:50:28 +02:00

vdso: Remove timekeeper argument of __arch_update_vsyscall()

No implementation of this hook uses the passed in timekeeper anymore.

This avoids including a non-VDSO header while building the VDSO, which can
lead to compilation errors.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/all/20241010-vdso-generic-arch_update_vsyscall-=
v1-1-7fe5a3ea4382@linutronix.de

---
 arch/arm64/include/asm/vdso/vsyscall.h | 3 +--
 include/asm-generic/vdso/vsyscall.h    | 3 +--
 kernel/time/vsyscall.c                 | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/=
vdso/vsyscall.h
index 5b6d0dd..eea5194 100644
--- a/arch/arm64/include/asm/vdso/vsyscall.h
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -6,7 +6,6 @@
=20
 #ifndef __ASSEMBLY__
=20
-#include <linux/timekeeper_internal.h>
 #include <vdso/datapage.h>
=20
 enum vvar_pages {
@@ -37,7 +36,7 @@ struct vdso_rng_data *__arm64_get_k_vdso_rnd_data(void)
 #define __arch_get_k_vdso_rng_data __arm64_get_k_vdso_rnd_data
=20
 static __always_inline
-void __arm64_update_vsyscall(struct vdso_data *vdata, struct timekeeper *tk)
+void __arm64_update_vsyscall(struct vdso_data *vdata)
 {
 	vdata[CS_HRES_COARSE].mask	=3D VDSO_PRECISION_MASK;
 	vdata[CS_RAW].mask		=3D VDSO_PRECISION_MASK;
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/v=
syscall.h
index c835607..01dafd6 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -12,8 +12,7 @@ static __always_inline struct vdso_data *__arch_get_k_vdso_=
data(void)
 #endif /* __arch_get_k_vdso_data */
=20
 #ifndef __arch_update_vsyscall
-static __always_inline void __arch_update_vsyscall(struct vdso_data *vdata,
-						   struct timekeeper *tk)
+static __always_inline void __arch_update_vsyscall(struct vdso_data *vdata)
 {
 }
 #endif /* __arch_update_vsyscall */
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 9193d61..28706a1 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -119,7 +119,7 @@ void update_vsyscall(struct timekeeper *tk)
 	if (clock_mode !=3D VDSO_CLOCKMODE_NONE)
 		update_vdso_data(vdata, tk);
=20
-	__arch_update_vsyscall(vdata, tk);
+	__arch_update_vsyscall(vdata);
=20
 	vdso_write_end(vdata);
=20

