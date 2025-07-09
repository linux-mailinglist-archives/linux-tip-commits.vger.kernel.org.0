Return-Path: <linux-tip-commits+bounces-6043-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBCAAFE4C2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 11:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4584E6E1D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 09:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C7228B7E6;
	Wed,  9 Jul 2025 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rE0Vu77F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BvEyDvHa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5280F28B4E0;
	Wed,  9 Jul 2025 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055064; cv=none; b=D5C3rPx2FQU1+J5eVGrW6m1RQPMfv76YqYkwZD17PW3mKUdh00u789GKbg2HNlvb4+w3dsPmOcPTL6pYjts3pPZtAssEuJmT+/4eN8SAyX6jhlAWjsiqASSOTedT8inGPd3Bs7gf/M4ljNmzH9K7hlADBQ+ayxPRmSxVTsYsdEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055064; c=relaxed/simple;
	bh=ubdZ/FUZntjwLEuYBOz6XXkpHfbzLaTWWeB6FwPeyDs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VzgpzFK0KQAjM9i2YB9cInl12xsG9+D+q22Yoi1Ia4XpoV2yezzpvKhAsyVK10yvozLa+1fqzCpI+dJwyFA8nZyblMwYJPXgPhIF5tp7Ff+uAcCZaygtER+gZVP+hYtpuK5qeVfKCDGanXAbiLWbQUQRx89LcDMR/8vrp3jCYy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rE0Vu77F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BvEyDvHa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Jul 2025 09:57:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752055060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9yuSojMY3eNA5Ma/ZpRzOWM8XUga9JnO21893vzG2JA=;
	b=rE0Vu77FJqAznpZomdNhBA+ORnna7/bdcdTxDXCAvP45kh3FGVNd29+hoPU+oxsggqTzbh
	npY2qhSS2pm+Q5eUZ8c3Oc2fsamm1NDDivAWiqdmE+liPWm6FKNzL/tDErhoxAe9AVy885
	yHsoRP22lhqErnDQNq3VdfkbXGyweoAuN1b4ge209xsgoaKDzNU4H3xhjveeHiBH4lpAaS
	2bqi1l3do6Sd8as+Om0UAWpuq1qmIbQiKveDdr64ahNL6Gt0OvztJDvJITqubkc0AZ2Nqy
	yY7rJReLzZgkTDE3rGUVuYjvPrJSilETAKCXv03Z6cqf6tej9TtabSlwNCVYiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752055060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9yuSojMY3eNA5Ma/ZpRzOWM8XUga9JnO21893vzG2JA=;
	b=BvEyDvHaf7ZoUKbTJmkg8XKN/FOhw+QcU4Si1wrSJ66LdxwEyH0nYyXALE7ScEesX5hay/
	6YFkRA+7Z6S8bKDQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/ptp] vdso/helpers: Add helpers for seqlocks of single vdso_clock
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250701-vdso-auxclock-v1-4-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-4-df7d9f87b9b8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175205505899.406.10400525712978291809.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     ad64d71d7409a0602b50ee71c7f9663a3385c286
Gitweb:        https://git.kernel.org/tip/ad64d71d7409a0602b50ee71c7f9663a338=
5c286
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:57:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Jul 2025 11:52:34 +02:00

vdso/helpers: Add helpers for seqlocks of single vdso_clock

Auxiliary clocks will have their vDSO data in a dedicated 'struct vdso_clock',
which needs to be synchronized independently.

Add a helper to synchronize a single vDSO clock.

[ tglx: Move the SMP memory barriers to the call sites and get rid of the
  	confusing first/last arguments and conditional barriers ]

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250701-vdso-auxclock-v1-4-df7d9f87b9b8@li=
nutronix.de

---
 include/vdso/helpers.h | 50 +++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 0a98fed..1a5ee9d 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -28,17 +28,47 @@ static __always_inline u32 vdso_read_retry(const struct v=
dso_clock *vc,
 	return seq !=3D start;
 }
=20
-static __always_inline void vdso_write_begin(struct vdso_time_data *vd)
+static __always_inline void vdso_write_seq_begin(struct vdso_clock *vc)
 {
-	struct vdso_clock *vc =3D vd->clock_data;
+	/*
+	 * WRITE_ONCE() is required otherwise the compiler can validly tear
+	 * updates to vc->seq and it is possible that the value seen by the
+	 * reader is inconsistent.
+	 */
+	WRITE_ONCE(vc->seq, vc->seq + 1);
+}
=20
+static __always_inline void vdso_write_seq_end(struct vdso_clock *vc)
+{
 	/*
 	 * WRITE_ONCE() is required otherwise the compiler can validly tear
-	 * updates to vd[x].seq and it is possible that the value seen by the
+	 * updates to vc->seq and it is possible that the value seen by the
 	 * reader is inconsistent.
 	 */
-	WRITE_ONCE(vc[CS_HRES_COARSE].seq, vc[CS_HRES_COARSE].seq + 1);
-	WRITE_ONCE(vc[CS_RAW].seq, vc[CS_RAW].seq + 1);
+	WRITE_ONCE(vc->seq, vc->seq + 1);
+}
+
+static __always_inline void vdso_write_begin_clock(struct vdso_clock *vc)
+{
+	vdso_write_seq_begin(vc);
+	/* Ensure the sequence invalidation is visible before data is modified */
+	smp_wmb();
+}
+
+static __always_inline void vdso_write_end_clock(struct vdso_clock *vc)
+{
+	/* Ensure the data update is visible before the sequence is set valid again=
 */
+	smp_wmb();
+	vdso_write_seq_end(vc);
+}
+
+static __always_inline void vdso_write_begin(struct vdso_time_data *vd)
+{
+	struct vdso_clock *vc =3D vd->clock_data;
+
+	vdso_write_seq_begin(&vc[CS_HRES_COARSE]);
+	vdso_write_seq_begin(&vc[CS_RAW]);
+	/* Ensure the sequence invalidation is visible before data is modified */
 	smp_wmb();
 }
=20
@@ -46,14 +76,10 @@ static __always_inline void vdso_write_end(struct vdso_ti=
me_data *vd)
 {
 	struct vdso_clock *vc =3D vd->clock_data;
=20
+	/* Ensure the data update is visible before the sequence is set valid again=
 */
 	smp_wmb();
-	/*
-	 * WRITE_ONCE() is required otherwise the compiler can validly tear
-	 * updates to vd[x].seq and it is possible that the value seen by the
-	 * reader is inconsistent.
-	 */
-	WRITE_ONCE(vc[CS_HRES_COARSE].seq, vc[CS_HRES_COARSE].seq + 1);
-	WRITE_ONCE(vc[CS_RAW].seq, vc[CS_RAW].seq + 1);
+	vdso_write_seq_end(&vc[CS_HRES_COARSE]);
+	vdso_write_seq_end(&vc[CS_RAW]);
 }
=20
 #endif /* !__ASSEMBLY__ */

