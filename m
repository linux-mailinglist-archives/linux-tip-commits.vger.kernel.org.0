Return-Path: <linux-tip-commits+bounces-3776-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8894BA4BCA5
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D533A7588
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850151F3FED;
	Mon,  3 Mar 2025 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qs7mJbng";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wCVfZzBj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DCD1F3B89;
	Mon,  3 Mar 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998585; cv=none; b=LvcCRuaqQQAXBdmCKy8XpViVwBiVx/QujoL/VuTgG55GKSx+39TfYXsz89ui8gRGtZtIeUQpXTj9mr4fHdRayqt+SatADGVe4bS3dSYmzLV7WFRBm/bNVIym75AmqaKC8SqQDhw78gL+7sgHHD1EJGQWNrUcoIAyqNjcxclkJlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998585; c=relaxed/simple;
	bh=6zi+1smP0zo+vMo0ZB3jEmLpEktvYIcWd8cPSrJShKQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=MHlSCsn1m5tnKbkziYIV5sOD70LpRWpUE6g9fcT88a4ZPm9X4d5c9dwaIj/wWnsnjQGWC/HMWIyDzv8V25bvhd7fIyDEiHE/or0zSJ8uYtEXxmBMLIs7lGOe42KxZwEcd3SmAaRK9F760DJleiJFfuMGvtMvCvUvPAt0R5T1ISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qs7mJbng; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wCVfZzBj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:43:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740998581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=zOsfvuMs/d5ZpMmWBTvstDMnMFxGDxv/cqZNKB2mypY=;
	b=Qs7mJbngjJqkumaNjBAyN9kvozC6leCmyfO6d/eLdp++TiKHaavLRD4l/pD5Df7Fv/FpiK
	1iPv5fW10PG4mDwOwjzfa9Rz1aac6eIkNHnljZ2fjm+HF71taSxr8miup4mi8ipO+UJtf8
	ZwYP3C3pQ9cMEwnd8RGAXQgOi+Jj8RotAzbYfxd8EwdWthDZNubrpvDPMMmmxqHB2drE5W
	Kirosg6R1ay2lz8Zq/0EVqyA5YtifHfQqeuDYxe0cuT0p4k3AKuiW1Sq+0Rlkl0DxBG8vT
	Y2FvEYWFkV+/HT+jjpWg29u12iMvyOKRXfBeD9VhKmSpvNdiIwEXELc6dsl6Pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740998581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=zOsfvuMs/d5ZpMmWBTvstDMnMFxGDxv/cqZNKB2mypY=;
	b=wCVfZzBj/8GcIGAYpG/gimPlM1sPY5eFVMAtDsAxZ+U0kVhW7nKe6OALh6DqwelpKYq0g1
	BZ2dXhWlO40x5wCw==
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
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099858093.10177.9394546321171575767.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     3f58d4793b5d43e5b91876d712b808de8099ff2a
Gitweb:        https://git.kernel.org/tip/3f58d4793b5d43e5b91876d712b808de809=
9ff2a
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 25 Feb 2025 13:36:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 10:24:35 +01:00

time/namespace: Prepare introduction of struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

To prepare for the rework of the data structures, replace the struct
vdso_time_data pointer with struct vdso_clock pointer whenever applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

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

