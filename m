Return-Path: <linux-tip-commits+bounces-6017-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B948AFACCF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Jul 2025 09:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82B957A44C5
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Jul 2025 07:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496522882DF;
	Mon,  7 Jul 2025 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UgiJh7v+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cez/XWVu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7420E2877E5;
	Mon,  7 Jul 2025 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872315; cv=none; b=ZUyg8G4/57igs/UXvqSsy6dFEODtR5hGAuNgqY0XpXujHuhZQmCLZ5X9KmCvV+7gj1QetWqkeNguz9lKmGU1JIICKHyU7sp/ig6pvT+yl/aBajsLcQWtb+zf89Tt0uvCv4H6ov2D5cMt+RkWat4CACyRmyMoFTD9x5k2sG0vznE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872315; c=relaxed/simple;
	bh=/vNnjf/OUgIBCPFRYdNdEuapnzmZiv3YytDalsHh8Jc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=moIZqxA29hbJU7q1YRgu9htH+dnDNOS2oeRvYGqeiF7SDy1JlYogWqx+oZ+uNxrT3Ip8VOSgr0pPsT2J+YREm0QDmE5dRg82nqIDV95fDL+ZmDWU1dsepgfQLjEYs0KOww7/KDr+VJYpLfpuoy5SdST3NPTBH1G3zTDpWx5aTYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UgiJh7v+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cez/XWVu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Jul 2025 07:11:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751872311;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6GCxWqk+t7ICeVU4ya9NNR3ZtqYJJPsWmTJXLpslFE=;
	b=UgiJh7v+07u/R+9mpkPjaIRG1EzI7KGI2ddRp1unhG1xcPevIuIHrV13DFklYXMCzD3Led
	n5ctac+nd0SjyCSF+7blX5UVOttHMgneNCVOQr0F7sRkL4Ri73L5UEHwlKRhoRQLtL0As8
	LjvufoQ5p1EoH+jKJrYviT4Qcb0qVnONBEBIsYiyhn6frYZI1wmEoCdcyNFJrLNoXbprGY
	pMglTjvdCLWxxeWekhE2C6xv5L+yZ4WgUJ9ceOszehQ1PvIndV4JzpNcmbgQ3rhyUCqdyw
	o7X2AOVS5khBQUf3HAIko5tgWrPbtU56FDtkcHnOk/hlker/OuU/HFcsPBfnRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751872311;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6GCxWqk+t7ICeVU4ya9NNR3ZtqYJJPsWmTJXLpslFE=;
	b=cez/XWVuBwybCQSHUGOrKtyBoJqy45gmvx1xm+WWWlBVT3CSvBEV7OzLMQnPzsp+JiXWU6
	Vg3N4pnGeny8R+Bg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] vdso/vsyscall: Introduce a helper to fill clock
 configurations
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250701-vdso-auxclock-v1-2-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-2-df7d9f87b9b8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175187231090.406.6216684889897624999.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     d878e2960cb638faf3cc9f1409c6a2a3f9283ec1
Gitweb:        https://git.kernel.org/tip/d878e2960cb638faf3cc9f1409c6a2a3f92=
83ec1
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:57:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Jul 2025 08:58:50 +02:00

vdso/vsyscall: Introduce a helper to fill clock configurations

The logic to configure a 'struct vdso_clock' from a
'struct tk_read_base' is copied two times.
Split it into a shared function to reduce the duplication,
especially as another user will be added for auxiliary clocks.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250701-vdso-auxclock-v1-2-df7d9f87b9b8@li=
nutronix.de

---
 kernel/time/vsyscall.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 32ef27c..d655df2 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -15,26 +15,25 @@
=20
 #include "timekeeping_internal.h"
=20
+static inline void fill_clock_configuration(struct vdso_clock *vc, const str=
uct tk_read_base *base)
+{
+	vc->cycle_last	=3D base->cycle_last;
+#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
+	vc->max_cycles	=3D base->clock->max_cycles;
+#endif
+	vc->mask	=3D base->mask;
+	vc->mult	=3D base->mult;
+	vc->shift	=3D base->shift;
+}
+
 static inline void update_vdso_time_data(struct vdso_time_data *vdata, struc=
t timekeeper *tk)
 {
 	struct vdso_clock *vc =3D vdata->clock_data;
 	struct vdso_timestamp *vdso_ts;
 	u64 nsec, sec;
=20
-	vc[CS_HRES_COARSE].cycle_last	=3D tk->tkr_mono.cycle_last;
-#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
-	vc[CS_HRES_COARSE].max_cycles	=3D tk->tkr_mono.clock->max_cycles;
-#endif
-	vc[CS_HRES_COARSE].mask		=3D tk->tkr_mono.mask;
-	vc[CS_HRES_COARSE].mult		=3D tk->tkr_mono.mult;
-	vc[CS_HRES_COARSE].shift	=3D tk->tkr_mono.shift;
-	vc[CS_RAW].cycle_last		=3D tk->tkr_raw.cycle_last;
-#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
-	vc[CS_RAW].max_cycles		=3D tk->tkr_raw.clock->max_cycles;
-#endif
-	vc[CS_RAW].mask			=3D tk->tkr_raw.mask;
-	vc[CS_RAW].mult			=3D tk->tkr_raw.mult;
-	vc[CS_RAW].shift		=3D tk->tkr_raw.shift;
+	fill_clock_configuration(&vc[CS_HRES_COARSE],	&tk->tkr_mono);
+	fill_clock_configuration(&vc[CS_RAW],		&tk->tkr_raw);
=20
 	/* CLOCK_MONOTONIC */
 	vdso_ts		=3D &vc[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC];

