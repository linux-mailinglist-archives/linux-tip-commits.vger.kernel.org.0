Return-Path: <linux-tip-commits+bounces-3951-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1708DA4EB49
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54D78E59C3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7019C2673BA;
	Tue,  4 Mar 2025 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hV8E4UQC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E0gW7N7a"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D130A260A3E
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111082; cv=pass; b=QbJ1iIWlYTJoFYTm1VbCHzRwl5ioY/SoA/RFRNQiKJu8GP2O0EUzuFpdO1m1uNdLU4L3uc0n01vcbiiTUA//UHXfK/+4L4k6EJlOQq60/G0IOBro5bwaJts4gQM8m1ap14J2pUcmamHOuSlg4zLEh6UHvEhaMeTEHzDuox98ZjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111082; c=relaxed/simple;
	bh=1QnWUTMaGq1CSWuPNkJ+lfEn7r+nafrHffycB6LM/RY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=L59gfgpVWd9wTVNoHG9J9PwuwS89HWbsD37zofEnIVfv9w9xAq9qGjb57LxLv7ILEEKufjiVgs4IZs4xZL/js1COCLyD46iUXrqcVV3hQcT12wXYHthoS/dgmamy6aey89Xktp9swD/KCYrxT1tmhuVFKEG6xEz/+rpAeApGXqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hV8E4UQC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E0gW7N7a; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 056F140D1F4E
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 20:57:59 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=hV8E4UQC;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=E0gW7N7a
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h6n0kRDzG34y
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 19:32:33 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id B17A34274F; Tue,  4 Mar 2025 19:31:59 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hV8E4UQC;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E0gW7N7a
X-Envelope-From: <linux-kernel+bounces-541405-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hV8E4UQC;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E0gW7N7a
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id DAB7B4314F
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:43:40 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id B361D2DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:43:40 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABBF188F5C9
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A405F1F3FF4;
	Mon,  3 Mar 2025 10:43:05 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EC91D7E4C;
	Mon,  3 Mar 2025 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998582; cv=none; b=qSQJoSpsdI9peuJKqwnQxg5itN6L7DS8zpxB7ZlpNcmrW+b6fe++xJraIo/UwOZXsyFTdWbsY3D/eFAcv1X2BrqSizw+l6K92BgKVLj5UkADwXQ1nsOu4v/XFhgTgPMI8JgW1HVcWJxHuodmjQ33Cc0mlfVqf7gqSPt2Gbl4HDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998582; c=relaxed/simple;
	bh=1QnWUTMaGq1CSWuPNkJ+lfEn7r+nafrHffycB6LM/RY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=GB+aN5Zesq0dBRx6QYIlB8duVnuwoOpnrIkJpv7DHytBcAPfMpX/8DQPCVskxaejdkQGOiOqhsPfdB3eie7KblwBY4+fbUtOKLzLJeSXudoDZ7Irj5lyoHwUtwRWZSbxVyHlGZgMGn2nNa7Sj6g0W4n6OXi+ufy0CG58XGSqFJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hV8E4UQC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E0gW7N7a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:42:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740998578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lwpKAzS+0ovIZb5f6DDlAfZQC9muuFrDY3J442cbg7o=;
	b=hV8E4UQCGvO0jR1TxmrG3CvjfOKna4guouF1m9ULFH32aIjk9Sqo45Ki2JYCcs/pY2YRTQ
	m/1rJ1Vp33JX/KOldO06BRuNNqI1rOIYG4h2+D95YPRGaU/w8Ivs6uNKydbx0n+DqoNni+
	IwRzgbOM+LD1Acft9ml7flU7ZbluJ5LAPZAHAkHJ1W+bioHFDgNlett7mgzcPvj/Nr71Y8
	DO6ConK74ENneMqKT/tx1dHHQfROG9JXSh8K9uvSzCgOw6ey0WNFsCfWa1iDiAGPH3Jtl1
	+7RcGy6/Sluomt/6EbhwJc4VyMqRC3aZZFZMfH+fY93azB2zvvhNLqowYK8zfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740998578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lwpKAzS+0ovIZb5f6DDlAfZQC9muuFrDY3J442cbg7o=;
	b=E0gW7N7abzvG1+Ja+EqjW8RyvK1kRN6X2S0q0kJ4uedpk5jCC1/i5Q/gTpL/C8Dz4zM83T
	x6o5Qq8iPSJ20MCQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Move arch related data before basetime
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
Message-ID: <174099857821.10177.8446012809637932009.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h6n0kRDzG34y
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741715748.95646@CsJjqDHg06ZtFtBlLR7B5g
X-ITU-MailScanner-SpamCheck: not spam

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     ece1e22d2caea94d1d836c22c4262c221f3b7f95
Gitweb:        https://git.kernel.org/tip/ece1e22d2caea94d1d836c22c4262c221f3=
b7f95
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 25 Feb 2025 13:36:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 10:24:35 +01:00

vdso: Move arch related data before basetime

Architecture related vdso data is required in the fastpath when acquiring
CLOCK_MONOTONIC or CLOCK_REALTIME. At the moment, this information is
located at the end of the vdso_time_data structure. The whole structure has
to be loaded into the cache to be able to access this information.

To minimize the number of required cachelines, move the architecture
specific vdso data struct right before the basetime (basetime information
is required anyway).

This change does not have an impact on architectures with
CONFIG_ARCH_HAS_VDSO_DATA=3Dn. All other architectures could spare reading
unnecessary cachelines.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/vdso/datapage.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 1df22e8..bcd19c2 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -70,6 +70,8 @@ struct vdso_timestamp {
=20
 /**
  * struct vdso_time_data - vdso datapage representation
+ * @arch_data:		architecture specific data (optional, defaults
+ *			to an empty struct)
  * @seq:		timebase sequence counter
  * @clock_mode:		clock mode
  * @cycle_last:		timebase at clocksource init
@@ -83,8 +85,6 @@ struct vdso_timestamp {
  * @tz_dsttime:		type of DST correction
  * @hrtimer_res:	hrtimer resolution
  * @__unused:		unused
- * @arch_data:		architecture specific data (optional, defaults
- *			to an empty struct)
  *
  * vdso_time_data will be accessed by 64 bit and compat code at the same time
  * so we should be careful before modifying this structure.
@@ -105,6 +105,8 @@ struct vdso_timestamp {
  * offset must be zero.
  */
 struct vdso_time_data {
+	struct arch_vdso_time_data arch_data;
+
 	u32			seq;
=20
 	s32			clock_mode;
@@ -125,8 +127,6 @@ struct vdso_time_data {
 	s32			tz_dsttime;
 	u32			hrtimer_res;
 	u32			__unused;
-
-	struct arch_vdso_time_data arch_data;
 } ____cacheline_aligned;
=20
 #define vdso_clock vdso_time_data


