Return-Path: <linux-tip-commits+bounces-6045-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A33AFE4C3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 11:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011835A0428
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 09:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DDE28BA90;
	Wed,  9 Jul 2025 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="unrfWTVU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ffyItNbp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937D128AAE0;
	Wed,  9 Jul 2025 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055065; cv=none; b=K3GYBzwe5XbUcnWo6SwrZexxlKJ/QaYhYkRGf8+xRugni+5+lg3RT7gZKfOlIm2fEryhTWV1i0jjkifikDqqGjj3JIIfJFECh+AS8m27136nCk33p6W6jwKpTh1z12FEH+Niw0rOTTZChHGuOPngp8SVLZZTgH+jhOI1g3TexuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055065; c=relaxed/simple;
	bh=7Vd9OfjPAIvxAHryi9I3/2iwmV94dRNqLVWLb9k6T6g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EObzpcaZzK76wq4IFOjzIePe+4TqGXu372+hQbFCZOkeXUHqeGZEe+zrc4RMVfa1bDmEFm6sKk2gwN+cgLYU0MfeHfJuQYdp7mpTicFsbIJM5vR5Q2lGtdFXi0FyfHrPQNMU+UMFW8HB7E9oGOvlZJ9h203p5bbbSdVxd1iZA7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=unrfWTVU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ffyItNbp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Jul 2025 09:57:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752055061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFG+5lj6woKDfFrHgOMp1GNT/frw1rtZLhl2zuTQS+A=;
	b=unrfWTVUQ94AaVpcWWg9m6zU6trOhBdIRdwHMxKQXO/06iUjay7LqoDrnCGTaafxR6Hliq
	/vdRBunb2AdMt6bsMtwYvcqtewasSiRdqn4sg/0tSD4UaxKbx26LUZsK9SCXcrgRbAMAk0
	boCipcLN/WYasy54MXHK27wWzpX3IPlOvcynGXSbl83jNd25qN/GxktMyTUPUxtyVkSgQq
	m/L0z6gQr0V+cfDkXiU80yLN8lYVgBC95FpAo6RIV5HPGmiQkfUZCXU6XKgk7dtmD12FrD
	KfLXoBbXpDdvyInNPWeCzxLZTefrbqFe9Cggq8DMWjq//PifcKJ7StUgV6yBpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752055061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFG+5lj6woKDfFrHgOMp1GNT/frw1rtZLhl2zuTQS+A=;
	b=ffyItNbp2SzgocXZuYlWMBuMJXK1W78kT8s678f0fnDgMKc5/FHPP2ucOIc35venLI5gn+
	Ow54j/i9ivfyPeCg==
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
Message-ID: <175205506093.406.3971514362419734380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     6fedaf682a5e1866efdaddc70ff0ada329825d53
Gitweb:        https://git.kernel.org/tip/6fedaf682a5e1866efdaddc70ff0ada3298=
25d53
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:57:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Jul 2025 11:52:34 +02:00

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

