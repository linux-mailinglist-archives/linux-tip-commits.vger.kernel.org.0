Return-Path: <linux-tip-commits+bounces-3773-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DB3A4BC9F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C3816F927
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A545C1F37D4;
	Mon,  3 Mar 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q4vpar12";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eRb6Txd5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2871E1F0E2D;
	Mon,  3 Mar 2025 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998583; cv=none; b=eUk+hMCk3X0G0YtwWpXt0WVESzd/Q2w5K6t/V08d076uNqVi9zObLstFDvkYcfZQSfZ2htq5x84bUWSo1SDvqFKnZbpfOvgKxc1DNZU8ZzgF+gKF/QC3aEXBelODYfPEWMMgZm7iy5DHNRO0bKESV2RLVIifNtCSUCddk4oqywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998583; c=relaxed/simple;
	bh=AAQ8rU6cn6S9xRp5a6WToMjQP5ynst8dCQzNCrA7jcQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=IUcpqKASkCVtl5Wqn4yx5vHkCpYhCXWLhNRmi5p00+ttK6/oDml/+4eV6kAC2h5gf+hfbJFy9AwzSNEbllpFMZVi8tWlLWMkPORkLpTGgBVna2IaZ7wTUVxmarZWGT4Q3PrY8TTqoHRXT3yIP5rdjZWtDInAx6N24n11eCQIxzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q4vpar12; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eRb6Txd5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:42:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740998580;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5yrEVnlhh1ZN6fJivEbpRZKXP76FXLW67f9nq56+Drk=;
	b=q4vpar12bZZyXRqhhft39YMGkNV7FVbxhYNyrK7MKvoCBRbXS5iKCBnw4DI0ks3+yKGrrN
	jUs+2Oj2zCKSHG3DIYPTodoBIqSkDbhUxpnI0w1dlrd3r/aMNOIGii/onUjVqF1wZet4l4
	YUQHRXCfhl+9yni5EdK87p7g25qe6LaQSrCZgctdhlDZKtU6+yk0g9O69/WrWGsj8On5B9
	wZRG0uLJcxCEClDEeHX0Q6woNKZNqsvPty4FO9gS87p4i9QIJMeGuwAc95vhwrUaqSf4Ga
	+/rn4x0hWmWPMDLV53gYxH9NqHWnv6Rhf6cxYCwv+YBD2kCt+mwDc3p0KpDmFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740998580;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5yrEVnlhh1ZN6fJivEbpRZKXP76FXLW67f9nq56+Drk=;
	b=eRb6Txd5thavF9qYjMhEnjMEGJnmnsUQL9CQ8t5sa1VFptjZjnn8+YM1R1FyNZHAymI+La
	LKaBUU+s3X8D5NAw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] arm64/vdso: Prepare introduction of struct vdso_clock
Cc: Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099857992.10177.5813819140006515141.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     493d34f40dabcc29a195310382efeda32ceb18d6
Gitweb:        https://git.kernel.org/tip/493d34f40dabcc29a195310382efeda32ce=
b18d6
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Tue, 25 Feb 2025 13:36:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 10:24:35 +01:00

arm64/vdso: Prepare introduction of struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

To prepare for the rework of the data structures, replace the struct
vdso_time_data pointer with struct vdso_clock pointer whenever applicable.

No functional change.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/i=
nclude/asm/vdso/compat_gettimeofday.h
index 957ee12..2c6b90d 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -155,9 +155,9 @@ static __always_inline const struct vdso_time_data *__arc=
h_get_vdso_u_time_data(
 }
 #define __arch_get_vdso_u_time_data __arch_get_vdso_u_time_data
=20
-static inline bool vdso_clocksource_ok(const struct vdso_time_data *vd)
+static inline bool vdso_clocksource_ok(const struct vdso_clock *vc)
 {
-	return vd->clock_mode =3D=3D VDSO_CLOCKMODE_ARCHTIMER;
+	return vc->clock_mode =3D=3D VDSO_CLOCKMODE_ARCHTIMER;
 }
 #define vdso_clocksource_ok	vdso_clocksource_ok
=20

