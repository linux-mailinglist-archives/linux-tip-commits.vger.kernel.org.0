Return-Path: <linux-tip-commits+bounces-3943-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE28A4E65B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 17:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21836425F9B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 16:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A14827CCEF;
	Tue,  4 Mar 2025 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GEhKRlqO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A1a95FU3"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FD12517AB
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104735; cv=pass; b=CG9njuxkNSNF5UqlnfPr2/jz8AnvjUVjZTFpUZQ+x2bPC/wOBn/I3RjwImr8ScKrTKhXBmR5CU3qrfOvCotXWVvIvpHbUeAoXHJiYU0tnqGV3FPtSRhVOl3qW03JDKQapKj3P/ynhE59Pm0kzv6jkUz2QX0YAbpPfxUr4jRdCTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104735; c=relaxed/simple;
	bh=U1p8jZzd4YCgBup5MnBtKdmBZrROEW/ZxCYOLTPgQpA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=CqItH/CMoz9CsrjJuWpvEgr1oJF2QSqk2fwv8l8vfc6ZYOxoxdOD3yZbjrH7LogkLxC6BprgAc1/b2H8V21GiAoM9z781JJaK48MwkUkOBTXh5o4l/O1lPfhadYAuo/jw62NpzsR486L7eTTNRCxTNrjXs6hfYzigS6Ru5Vynvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GEhKRlqO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A1a95FU3; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 59A8340D4DFD
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 19:12:11 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=GEhKRlqO;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=A1a95FU3
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gd172dKzG2ZT
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 19:10:13 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 55C804274D; Tue,  4 Mar 2025 19:10:09 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GEhKRlqO;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A1a95FU3
X-Envelope-From: <linux-kernel+bounces-541421-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GEhKRlqO;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A1a95FU3
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id B891D42DE1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:46:53 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 8C8F72DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:46:53 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D022C1894191
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F36C1F30CC;
	Mon,  3 Mar 2025 10:43:13 +0000 (UTC)
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
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gd172dKzG2ZT
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741709435.65199@j2fIEt3d7uvxBK8fHJh/iQ
X-ITU-MailScanner-SpamCheck: not spam

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


