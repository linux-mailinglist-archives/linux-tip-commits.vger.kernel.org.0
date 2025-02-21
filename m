Return-Path: <linux-tip-commits+bounces-3560-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485E8A3EF80
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AE817F2D9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C790C205E04;
	Fri, 21 Feb 2025 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dscDtL7e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TaEGdlX2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96316204F77;
	Fri, 21 Feb 2025 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128601; cv=none; b=ox31j3bUBLsIg0ZeY2nfKTnRPJeL76ePM30N3bX0f+15Kft0pHg3GJjK8WPFOSZDOsO2TYXMUcaCBI5Y9dStXcJmqn+uR54G6p0mq8FdOBbtvGUVOOZjG0A/I4zkWbaZvb6bAHkHSdZPB+1L+tzP/z+magyEaLuD9dYvwL9hZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128601; c=relaxed/simple;
	bh=FaJq8+Kd+GDe7w0B3JBtt/rchtwg6nfVeC6NI6frgs8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o5iTXagpiecczYJ2ZaBed/n6tq2A/5r6Lc2OFeSBOo7Wd9QvfG+y26FnhwwuovVXtlPTocyRSS38hNDR8hZrWfe5lmCU9XeRjZQQzbxzhQYTd+gaL56ERTaNXtEhy0MWwuK5Nh+ANdBiHOEprOQMKz41cd+l01YPFBkM0ze3+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dscDtL7e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TaEGdlX2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:03:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128596;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQp1XtJRXstxO6VwTpdTZCnHSOrsSYsdVWtpqGX851Q=;
	b=dscDtL7e3RDS1qYC9SrMxVkjYQFmPDG5VanqfMZSYqropjuODYYVfEE7iYKkEy5Tdpd86z
	wfm8DYIQa/rzne9HC198hrdIP/A8CdAQwaVXzS8JTLVzadPURkcuB708TJSjZTg8EMkrdK
	rcM20EgnmgcpCxBDmp4a5KtGJ5bakdFzvax0Q/e9FS0PzjmsIlakmz6uyQj80rswr77m99
	OZZZfUyuPYGSZocbtI/zSZxNbfH/Rx1MyMcZG+erIlKP48XDGjVHH58emmVo335yc0ounY
	cHDwu2mn+8eh2aYErvCnf4FcboSxUo1s9SwEToEIzIB1YNAYfDPuiAibIwN5pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128596;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQp1XtJRXstxO6VwTpdTZCnHSOrsSYsdVWtpqGX851Q=;
	b=TaEGdlX2BLC8MHJAJJZ/m290dUrlNi2YFO4rAOcKnZf/l6T3R4kw0+Z5p6jQ1CMgJpTQDH
	EB3VDYYj24Qg4mCA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Introduce vdso/align.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250204-vdso-store-rng-v3-3-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-3-13a4669dfc8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012859628.10177.12327041634377924691.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     5b47aba858101639a4442c2140b73f64eb796ed1
Gitweb:        https://git.kernel.org/tip/5b47aba858101639a4442c2140b73f64eb7=
96ed1
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 04 Feb 2025 13:05:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:54:01 +01:00

vdso: Introduce vdso/align.h

The vDSO implementation can only include headers from the vdso/
namespace. To enable the usage of the ALIGN() macro from the vDSO, move
linux/align.h to vdso/align.h wholly.
As the only dependency linux/const.h is only a wrapper around
vdso/const.h anyways adapt that dependency.

Also provide a compatibility wrapper linux/align.h.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250204-vdso-store-rng-v3-3-13a4669dfc8c@l=
inutronix.de

---
 include/linux/align.h | 10 +---------
 include/vdso/align.h  | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 9 deletions(-)
 create mode 100644 include/vdso/align.h

diff --git a/include/linux/align.h b/include/linux/align.h
index 2b4acec..55debf1 100644
--- a/include/linux/align.h
+++ b/include/linux/align.h
@@ -2,14 +2,6 @@
 #ifndef _LINUX_ALIGN_H
 #define _LINUX_ALIGN_H
=20
-#include <linux/const.h>
-
-/* @a is a power of 2 value */
-#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
-#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
-#define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
-#define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
-#define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
-#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) =3D=3D 0)
+#include <vdso/align.h>
=20
 #endif	/* _LINUX_ALIGN_H */
diff --git a/include/vdso/align.h b/include/vdso/align.h
new file mode 100644
index 0000000..02dd862
--- /dev/null
+++ b/include/vdso/align.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_ALIGN_H
+#define __VDSO_ALIGN_H
+
+#include <vdso/const.h>
+
+/* @a is a power of 2 value */
+#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
+#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
+#define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
+#define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
+#define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
+#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) =3D=3D 0)
+
+#endif	/* __VDSO_ALIGN_H */

