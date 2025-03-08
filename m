Return-Path: <linux-tip-commits+bounces-4086-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCB9A57AB2
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 14:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C93FD7A7CC0
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 13:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5E21EB5C0;
	Sat,  8 Mar 2025 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BtEQFz/M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wn32xY0p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A84D1C84CC;
	Sat,  8 Mar 2025 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441508; cv=none; b=BkIyaa+wVCF/Cs9Li28yhCoQxMycfOfDvNkOQMoEQ3TJJs9LZx2qEyTJAr1FLBDJz8DKSVvULndN4EV8343FG211ou/DxLD3dlxwe8LaX5Pih/NYiYLZI5FLuGxkN/9p6dM/Dmansc8LALhis/HozVkE59JaMZXAzE1SIDHzW0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441508; c=relaxed/simple;
	bh=Lm603i6B8HVeh6jFNbnu+pZVMF/ZqvgN9xAJFL69zlU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YqXiCRqd8dcW9ENdGLTBdX9zuvswOrZJiV82LoNviX1TQCpf3IFrJlbk4wRj6fbkCcT67yjeOHWHjQyGL/BQanV3nrwD5/KOK1dvGrKM2vu/qwVS/bACR6qCfQAfUNMyQhiQ8yuo+ElpMfPLPRpdw0cXI/oSI0q8rKFKy1jW4ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BtEQFz/M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wn32xY0p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 13:45:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741441504;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sr3exRsu33OHuDXo/d9jtEK0SOWIpt3Z/quNJZ0foNQ=;
	b=BtEQFz/MwVZebQperm2tifNiixpmdzTu3l3hB6LZRBjrqutvBk56Y6QRumwm3ueZNZCMX9
	eQp8yepx2Hglq4O/r050vDPgDh8aUm6j26Edb73hOha+FWQPjfft9TDlkp8SdvLfDMurBj
	RN3tSZdcy943NzWi1IwfJzrFftievZHMLuaymTWNUVAABofEbE/GFK6KFDEbZTC8HVc11B
	igSVqmtzjDwgl3exFbmc9XqAYZG9KVSLM0861/IiXUOWfoi3eVTIBd5i3PTM5VKou2r0rJ
	VHkVCnuLAYrSTXlKcDXdaUIZCpGKzXt/2yfCvfZ0+L32NeQZUE4NUS2QnhVBqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741441504;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sr3exRsu33OHuDXo/d9jtEK0SOWIpt3Z/quNJZ0foNQ=;
	b=wn32xY0pRJK3Hii7etIuO1Jfxi1gHDIJgO9pdcDJsm1nksfH1+mQBVsunHD4GNvbhAaFvw
	2X6ueAoebwMuYJAA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] vdso/helpers: Prepare introduction of struct vdso_clock
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303-vdso-clock-v1-5-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-5-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174144150374.14745.184225322975142640.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     e15bf9e34b5716e8c4a50b32a98752ff1f53d647
Gitweb:        https://git.kernel.org/tip/e15bf9e34b5716e8c4a50b32a98752ff1f5=
3d647
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 03 Mar 2025 12:11:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 08 Mar 2025 14:37:40 +01:00

vdso/helpers: Prepare introduction of struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be an array of VDSO clocks. For now,
vdso_clock is simply a define which maps vdso_clock to vdso_time_data.

Prepare all functions which need the pointer to the vdso_clock array to
work well after the structures get reworked. Replace the struct vdso_time_data
pointer with a struct vdso_clock pointer where applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303-vdso-clock-v1-5-c1b5c69a166f@linut=
ronix.de

---
 include/vdso/helpers.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 41c3087..28f0707 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -7,49 +7,53 @@
 #include <asm/barrier.h>
 #include <vdso/datapage.h>
=20
-static __always_inline u32 vdso_read_begin(const struct vdso_time_data *vd)
+static __always_inline u32 vdso_read_begin(const struct vdso_clock *vc)
 {
 	u32 seq;
=20
-	while (unlikely((seq =3D READ_ONCE(vd->seq)) & 1))
+	while (unlikely((seq =3D READ_ONCE(vc->seq)) & 1))
 		cpu_relax();
=20
 	smp_rmb();
 	return seq;
 }
=20
-static __always_inline u32 vdso_read_retry(const struct vdso_time_data *vd,
+static __always_inline u32 vdso_read_retry(const struct vdso_clock *vc,
 					   u32 start)
 {
 	u32 seq;
=20
 	smp_rmb();
-	seq =3D READ_ONCE(vd->seq);
+	seq =3D READ_ONCE(vc->seq);
 	return seq !=3D start;
 }
=20
 static __always_inline void vdso_write_begin(struct vdso_time_data *vd)
 {
+	struct vdso_clock *vc =3D vd;
+
 	/*
 	 * WRITE_ONCE() is required otherwise the compiler can validly tear
 	 * updates to vd[x].seq and it is possible that the value seen by the
 	 * reader is inconsistent.
 	 */
-	WRITE_ONCE(vd[CS_HRES_COARSE].seq, vd[CS_HRES_COARSE].seq + 1);
-	WRITE_ONCE(vd[CS_RAW].seq, vd[CS_RAW].seq + 1);
+	WRITE_ONCE(vc[CS_HRES_COARSE].seq, vc[CS_HRES_COARSE].seq + 1);
+	WRITE_ONCE(vc[CS_RAW].seq, vc[CS_RAW].seq + 1);
 	smp_wmb();
 }
=20
 static __always_inline void vdso_write_end(struct vdso_time_data *vd)
 {
+	struct vdso_clock *vc =3D vd;
+
 	smp_wmb();
 	/*
 	 * WRITE_ONCE() is required otherwise the compiler can validly tear
 	 * updates to vd[x].seq and it is possible that the value seen by the
 	 * reader is inconsistent.
 	 */
-	WRITE_ONCE(vd[CS_HRES_COARSE].seq, vd[CS_HRES_COARSE].seq + 1);
-	WRITE_ONCE(vd[CS_RAW].seq, vd[CS_RAW].seq + 1);
+	WRITE_ONCE(vc[CS_HRES_COARSE].seq, vc[CS_HRES_COARSE].seq + 1);
+	WRITE_ONCE(vc[CS_RAW].seq, vc[CS_RAW].seq + 1);
 }
=20
 #endif /* !__ASSEMBLY__ */

