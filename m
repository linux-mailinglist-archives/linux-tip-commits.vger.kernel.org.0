Return-Path: <linux-tip-commits+bounces-4076-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE89A57A9D
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 14:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975283B2F7A
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 13:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139991D63CE;
	Sat,  8 Mar 2025 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wLEJjgm/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="saUkpGNr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805BF1C3C14;
	Sat,  8 Mar 2025 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441502; cv=none; b=FNNouOQAHnO60BGStJI1qgYEZKvAPgS6L72M0/U8Xk2xEA22SieTpkhGZJueif0InsggcvaCktXxZ4X4Bae81YLtvfmAoaeF5xLc20VYu+vOtTEUr5GFacfRo90aJV7ZyYI4RdX2AzjRJaJsW3fdxGMnEgD63ozp9bmf2uBCZMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441502; c=relaxed/simple;
	bh=093qitaZscckIDSpCCIN0aJ7R+GxB6gbAnZkILj2PMw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gqhfDLORfeMUBr79gvA6tMSq2Mswe/qDIOzP/g0pt5s6QVebXtmQxlAIB/+eLkT9NzgcZDzekZJ62saExhLftpkFmPJ2j2DTrtxE9Izc/YlAcdFPWnJCOgGS7btIH2e5lr3gtJJAA+Y05/IDTrMsDt9C/Moa2OMv3h972zjYG7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wLEJjgm/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=saUkpGNr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 13:44:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741441498;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=20NYpG4Rg5JVfYvxZFTBBZmrA5bgRXFxuLHzpL91U70=;
	b=wLEJjgm/uX9l22eP3/q/DJuOGeY7Ft6NsYThAfx0iwya4L9xUG5tlbxvbbmtJ5WHPvccwX
	i9wWfDM150pRSmGP6lCls0/VlujjZL0zoims2IXWCQFbqQDW3lYcKe0ZKUTXLze0spuAad
	2LEPKP3VtaioQapKVe/PSZ6Ez+GfnlGZ17o0ZEibDqFMI4s0MPertJojroyxPtpjOfdQB8
	2Q6x7LIQIRPS1YpUGAIb7MEFiga++05IkdEYr+go5wvhX5gqYAcFLveGIga4k4P9lk79zk
	6SA6rbtMFSDiKRB/JUig8FfL2/5D2xYxJO1fPJxmumr5niHh818IoTXJbfU3jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741441498;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=20NYpG4Rg5JVfYvxZFTBBZmrA5bgRXFxuLHzpL91U70=;
	b=saUkpGNrMVAYvICQHszZUaHDTlRJqHFAvSPKYSZUo8x2COvsJ21Z4kRgtLY7HJQh5LXOTW
	7yNanF1cwLeb7+DQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] arm64/vdso: Prepare introduction of struct vdso_clock
Cc: Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303-vdso-clock-v1-16-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-16-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174144149790.14745.14337622437039708314.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     5340f3cb20989ec9562f7fcd65005e25b2365e6a
Gitweb:        https://git.kernel.org/tip/5340f3cb20989ec9562f7fcd65005e25b23=
65e6a
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Mon, 03 Mar 2025 12:11:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 08 Mar 2025 14:37:41 +01:00

arm64/vdso: Prepare introduction of struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of VDSO clocks. At the moment,
vdso_clock is simply a define which maps vdso_clock to vdso_time_data.

To prepare for the rework of the data structures, replace the struct
vdso_time_data pointer with a struct vdso_clock pointer where applicable.

No functional change.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303-vdso-clock-v1-16-c1b5c69a166f@linu=
tronix.de

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

