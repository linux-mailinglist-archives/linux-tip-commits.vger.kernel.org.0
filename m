Return-Path: <linux-tip-commits+bounces-3785-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839C8A4BCB7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918D1170D3A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EE91F5428;
	Mon,  3 Mar 2025 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GEhKRlqO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A1a95FU3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23CE1F461A;
	Mon,  3 Mar 2025 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998589; cv=none; b=YlRB4Udq5nRTU+moRrDySElODW/vsJ0dq1FQHBf8vDmM+x6U6VOmfBPgolK+NAiAe8r+TPTk+74uT1gH6/TgzibBMBQ796HbKYw1ol+g78AIlcaRNjqatDqjMBEMnBFiXVnIpyo6ZVwXQ3mPzJZ7pugB01ukTr8MoXJSIoQhwB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998589; c=relaxed/simple;
	bh=U1p8jZzd4YCgBup5MnBtKdmBZrROEW/ZxCYOLTPgQpA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=liYZhl6Oo/PwYSK5rDBL8As5slcprq4ItYfqOCyRTm5dbXuCJS1PoDDe/P3xQeBLiLYnvMpwXdjl3e5+G6ovhffokXJCFX8gOx3f+mbhbWwBcEDUxbvlrz271VWndEYiui1wjWa94h32WHWvJyLgzgZtswCuzhj0/cKw9O6DqRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GEhKRlqO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A1a95FU3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:43:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740998585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qQVhS77Tdm8GB+OZ2WBSwfPZtVIK0FdqIgTqp/Rz4XQ=;
	b=GEhKRlqOY0xnpUp1KBef+q5e+uQdpO51ne+emhXgiWDoAqIO8JGCmIyfs5Z1clvYCkCkWk
	lWYzcQfXebaS/fKPVHLu5VFbr2ybj4JMV5COsIJ4GHM+BlnfYtwythFM9iKdhS0VbM23bf
	d8rWc3uFsEu8jwKO16GxzX67H/yJiXvh1LOx0kIlioMLb/qBkK/pufqCDVYDscuQCf8VLK
	7X1RlrFXVz+5lg2PubRdTLsxHj9n/U7eLcsahOihn928J55M1UW5klbVsKZ0lPQOay8aCd
	zyQl0RX5T2S92OQrO+TjxTH0KY/4aJB16XhqQIb7ZhevjNZxm8nSuJz3aiXS7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740998585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=qQVhS77Tdm8GB+OZ2WBSwfPZtVIK0FdqIgTqp/Rz4XQ=;
	b=A1a95FU3XS+fmrfx+XAwHqRA8ORBCyWPDoNHgGDtTxnkJR6cEerB7xlgwMqG3qIPBfliQn
	rKlveLGZ4v+H7sAw==
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
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099858523.10177.1509794545670021372.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     7b0ac1447135bc819db9954aaf86ff4c72427557
Gitweb:        https://git.kernel.org/tip/7b0ac1447135bc819db9954aaf86ff4c724=
27557
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 25 Feb 2025 13:36:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 10:24:34 +01:00

vdso/helpers: Prepare introduction of struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

Prepare all functions which need the pointer to the vdso_clock array to
work well after the structures get reworked. Replace struct vdso_time_data
pointer with struct vdso_clock pointer whenever applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

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

