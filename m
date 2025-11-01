Return-Path: <linux-tip-commits+bounces-7146-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB11C28722
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE8F189527D
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7339C30BBAE;
	Sat,  1 Nov 2025 19:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EcsDapb8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I1KLi86G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D530ACF6;
	Sat,  1 Nov 2025 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026476; cv=none; b=F7tvDle/Trjd13nADFNzEoaFAmSpEQUUOMa9pCOelpNROEOX3CdcMwip99r0BExHK0OyxtRGt3HConn0rQpMs3hTwnNcmNXD8FVo9+W5W4+0ayG+M14x1vDteWBF4T5hlWnFZ265f8xksVLt5KnNUrzAD+2BBp3JYUhQEjbE5Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026476; c=relaxed/simple;
	bh=3RVKYKFGq04vm9DG58mTj6Za0jd9HMRW1L0ItKB/7g4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m3ku8NccYZnuSPY56VH6014dVwYG/elik11Jt9cHaAJIDqWxlmWsV3geElM5nc5QHzCXcZAs1KNwCLvI7EwmoQWgpVPHEwGk4txtyxH2j+yS7MyKLPt4/GKzF7PnSlkWMPtXbm4isvDU7z6oiHPa9JyL3gBQNrZrMw2ZilM39Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EcsDapb8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I1KLi86G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026473;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rynh5+zYz5Zg3VXKASTdorWf5KPOA8tPQ7a45X6for0=;
	b=EcsDapb8tSmMhHjdlSzJMd+na3GGfVP5M+wmMbTcpFjmGTgGm2W00AR3oMx5yzCHDrBlWC
	pjjEgkeT33fZRIt4yQ6GGwJq6BPHKTtEboFmW1jTApgFRU/xzWSIQQS99ahFep9h2ZoAzC
	4F+9sVlKLZa5YRlrQhYuYL8lUEEAkFRXpCC0/m+FrrEF5qm6Xqh28P6BSat6jYmZVY0RnV
	i56oNxmPha/YAx/s2TuripFWMGllapM4Sq8Wlzziq32M9maKWatSuw780s1+CLsxiEVqZS
	mRzYz9WpVyVmq71lky22l2sIZo/ZfN0rZ86oWZnH7ErnWrXcg1XRF52iFA/ZAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026473;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rynh5+zYz5Zg3VXKASTdorWf5KPOA8tPQ7a45X6for0=;
	b=I1KLi86GB5lrQuGPu91ypcKaLQhNJkZ9l6HGcZPGPPsNZwILe3G8cs3PRWDKTsemblc2+Z
	8rlIEmE+ycXzQnBw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] s390/time: Set up vDSO datapage later
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, Heiko Carstens <hca@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-20-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-20-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202647175.2601451.13363115783514790648.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     bce2cfa8af4371675facfd35ee21ada27d48a6c0
Gitweb:        https://git.kernel.org/tip/bce2cfa8af4371675facfd35ee21ada27d4=
8a6c0
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:05 +01:00

s390/time: Set up vDSO datapage later

Upcoming changes to the generic vDSO library will mean that the vDSO
datapage will not yet be usable during time_early_init().

Move the initialization to time_init() which is called later. This is
valid as the value of tod_clock_base.tod only changes in stop_machine()
context and both time_init_early() and time_init() are called before
interrupts are enabled.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-20-e0607bf4=
9dea@linutronix.de
---
 arch/s390/kernel/time.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 63517b8..6b948b9 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -78,8 +78,6 @@ void __init time_early_init(void)
 	struct ptff_qto qto;
 	struct ptff_qui qui;
=20
-	vdso_k_time_data->arch_data.tod_delta =3D tod_clock_base.tod;
-
 	if (!test_facility(28))
 		return;
=20
@@ -248,6 +246,8 @@ struct clocksource * __init clocksource_default_clock(voi=
d)
  */
 void __init time_init(void)
 {
+	vdso_k_time_data->arch_data.tod_delta =3D tod_clock_base.tod;
+
 	/* Reset time synchronization interfaces. */
 	stp_reset();
=20

