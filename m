Return-Path: <linux-tip-commits+bounces-6015-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA157AFACCE
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Jul 2025 09:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86273BE479
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Jul 2025 07:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C382877E8;
	Mon,  7 Jul 2025 07:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zx1HOLhI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eKNQn4Ix"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15802874F8;
	Mon,  7 Jul 2025 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872313; cv=none; b=iRT/4R9NRX3yCLf46W67/8BThiVKwfUOn6u7QNNhQfE6DPDM/XxhySlxHJcxgqjPoNrPJLR+i7k52syGfQ8iywaRm3dXqTWDW3L39Y1nXxrEQ2xeqBH9lvm4mLNqTfQvVX826AT+A1QZG3b2v/RSruovF3FRcQaKsgG766OTJaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872313; c=relaxed/simple;
	bh=pkqZnlI9zf5Y/GXqbauIQRGMXgX+MNPQcCisYgG6NaI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oFhiwe5scCCH19I6AnQsIoecTQ6aZJ0IleqFPRKGvs9oBnk2cdHxd3UgRezomBzGRWlIMstHvaRzQVzWWeN3sLQo50Aa8ozZABGtKVpjjoxs6/vpVvxNoCKrWp79gmaI3Dz9d35GZqxXwxCDXMRzXQbuPcXt/Y3JKmDxWvsg4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zx1HOLhI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eKNQn4Ix; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Jul 2025 07:11:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751872310;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ZliDG8byzuoKE2+oEnlCK+EyrKuwuV0t7mN7dQiqc4=;
	b=Zx1HOLhIUYf19xWWFRrOcW8DVd3g2O4n4wXV4tnowSJ+OHDAX+416tWG7y2N7f+lxwUeMp
	+TR+0VBkSnQUZgosIy97qhFeTULeqtuBUG28o4PeS8TBcARZbfr1yxHw/zHVK7UNYWESR3
	bQfdI8zdZ7EgUnribs3QFvEdjYtk1S3LY/cNrJ5csxFHiPxQQHcg6wKz9ycuUKQjpXUN2f
	Vsj3gOeVHavMp3X8GfyU+oEJgM+rztGACuxl+zo4dtpRsta9Pr/dLRdq+Fo9SYHmvFguc7
	Pya3P5L9yde/2359Wsp+s8t1LRduyoh3lUBhq0f/GtCPkszdwgkXZ1KVr8YKDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751872310;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ZliDG8byzuoKE2+oEnlCK+EyrKuwuV0t7mN7dQiqc4=;
	b=eKNQn4IxXG+QEz+cT+aD42VnDeh7Y1EkNF+3U8y06GXOP71EicWnrCkTo6k6FQzSoTF1Gn
	ZuXqAIPfaXj3I3DQ==
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
Message-ID: <175187230917.406.2034980780409611967.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     9916785ef2ce464edd83fce80eaa11fab7792547
Gitweb:        https://git.kernel.org/tip/9916785ef2ce464edd83fce80eaa11fab77=
92547
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:57:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Jul 2025 08:58:51 +02:00

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

