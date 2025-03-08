Return-Path: <linux-tip-commits+bounces-4080-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9A9A57AA7
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 14:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9DD16D4A3
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 13:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B3F1DFD89;
	Sat,  8 Mar 2025 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W7Mf9you";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XTJQY2Qe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55611D9694;
	Sat,  8 Mar 2025 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441505; cv=none; b=HIn36nvqNwTPCY9y5cA6op79MXvzmIK5lAThWWefx0qSJjYqIDdhmUk7fOTUP/U1ri0MAsVmBN/Tr7ULhwsp6v735mfmIWYFzcm2xWieCMGcvgRXA3ts3jf1oD6Pvb/2YRGWIKOTMacrgonQrzzrL46VEVr+qZIDwUmbltB4PXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441505; c=relaxed/simple;
	bh=Q4FFed7EApju1H2jcDrnjv92sCl4iFujGzlPi08PptI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qenily1qaq2nkHI3DTVzxPdskdRk2WBypEddAQ0HZBfePY4TWm71JAXF9nN28BD3hTFpbHS1q5QE34eVG+W2qq+6VB277302sQV0xCxXC0vULEzjduyLiXuJ/lxccwW2IGpvWyOhhn72qcjoCKSKPQ+69Q4jDKYr97EKr+MAXx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W7Mf9you; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XTJQY2Qe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 13:44:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741441499;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hTebM/Z08woe5csafs2n5cVNN3w+MtW5Yjtwh/O33t4=;
	b=W7Mf9youdOD7BszNUwQM+C4zZXXnzFNgRBCgODNF7RYgPN5hPGVYHcWt884nIbkXVyj7zP
	pa3SncIV3uOwaNFz72oRw/94EUCiPea93JMnOaSCMFbfVPcqSpYP7WGFmEOVq8RGdkY145
	kPvdd3HlWMaf9oJ/ebDuVBQ6t0D8BBM8o+GXHEpu+eeCFsnDFgl4kEkjCKJ8k9OgLnJYRV
	ythDs0qJbGoJp5NAfF/0s3aMD9ZtUyq7yODCJxUIqPLYqPpxECT4oY3xYAK659PzkCg6zd
	KmRNo6C8Wwm5Pv5VgJ2d9kES37qdPFskEyYUjbTSsXd+mK6hS/qzBZYTKDFHDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741441499;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hTebM/Z08woe5csafs2n5cVNN3w+MtW5Yjtwh/O33t4=;
	b=XTJQY2QehyZDKVD6qiP0mwUMBUx/kyNV8mcZr9sj6jSY4FMR8aDc552gp5xIaKXsFE+x6K
	4NHlwFP+4M4PHjBg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] time/namespace: Prepare introduction of struct vdso_clock
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303-vdso-clock-v1-14-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-14-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174144149921.14745.17264034572002454551.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     5911e16cad61f1735c2f8c847dc43f03f8eaccd2
Gitweb:        https://git.kernel.org/tip/5911e16cad61f1735c2f8c847dc43f03f8e=
accd2
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 03 Mar 2025 12:11:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 08 Mar 2025 14:37:41 +01:00

time/namespace: Prepare introduction of struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of VDSO clocks. At the moment,
vdso_clock is simply a define which maps vdso_clock to vdso_time_data.

To prepare for the rework of the data structures, replace the struct
vdso_time_data pointer with a struct vdso_clock pointer where applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303-vdso-clock-v1-14-c1b5c69a166f@linu=
tronix.de

---
 kernel/time/namespace.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index f02430a..09bc4fb 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -165,26 +165,26 @@ static struct timens_offset offset_from_ts(struct times=
pec64 off)
  *     HVCLOCK
  *     VVAR
  *
- * The check for vdso_time_data->clock_mode is in the unlikely path of
+ * The check for vdso_clock->clock_mode is in the unlikely path of
  * the seq begin magic. So for the non-timens case most of the time
  * 'seq' is even, so the branch is not taken.
  *
  * If 'seq' is odd, i.e. a concurrent update is in progress, the extra check
- * for vdso_time_data->clock_mode is a non-issue. The task is spin waiting f=
or the
+ * for vdso_clock->clock_mode is a non-issue. The task is spin waiting for t=
he
  * update to finish and for 'seq' to become even anyway.
  *
- * Timens page has vdso_time_data->clock_mode set to VDSO_CLOCKMODE_TIMENS w=
hich
+ * Timens page has vdso_clock->clock_mode set to VDSO_CLOCKMODE_TIMENS which
  * enforces the time namespace handling path.
  */
-static void timens_setup_vdso_clock_data(struct vdso_time_data *vdata,
+static void timens_setup_vdso_clock_data(struct vdso_clock *vc,
 					 struct time_namespace *ns)
 {
-	struct timens_offset *offset =3D vdata->offset;
+	struct timens_offset *offset =3D vc->offset;
 	struct timens_offset monotonic =3D offset_from_ts(ns->offsets.monotonic);
 	struct timens_offset boottime =3D offset_from_ts(ns->offsets.boottime);
=20
-	vdata->seq			=3D 1;
-	vdata->clock_mode		=3D VDSO_CLOCKMODE_TIMENS;
+	vc->seq				=3D 1;
+	vc->clock_mode			=3D VDSO_CLOCKMODE_TIMENS;
 	offset[CLOCK_MONOTONIC]		=3D monotonic;
 	offset[CLOCK_MONOTONIC_RAW]	=3D monotonic;
 	offset[CLOCK_MONOTONIC_COARSE]	=3D monotonic;
@@ -220,6 +220,7 @@ static void timens_set_vvar_page(struct task_struct *task,
 				struct time_namespace *ns)
 {
 	struct vdso_time_data *vdata;
+	struct vdso_clock *vc;
 	unsigned int i;
=20
 	if (ns =3D=3D &init_time_ns)
@@ -236,9 +237,10 @@ static void timens_set_vvar_page(struct task_struct *tas=
k,
=20
 	ns->frozen_offsets =3D true;
 	vdata =3D page_address(ns->vvar_page);
+	vc =3D vdata;
=20
 	for (i =3D 0; i < CS_BASES; i++)
-		timens_setup_vdso_clock_data(&vdata[i], ns);
+		timens_setup_vdso_clock_data(&vc[i], ns);
=20
 out:
 	mutex_unlock(&offset_lock);

