Return-Path: <linux-tip-commits+bounces-7529-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E8CC880EE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 05:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6656C3AA6C1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 04:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6228420A5F3;
	Wed, 26 Nov 2025 04:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OqmbCMMm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C4vdUjwH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BE31A9FAC;
	Wed, 26 Nov 2025 04:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764131771; cv=none; b=T5oxtxra6LD+4wFdVUc/KXtv5+ABqGkk2yAxxltzz5vHp5DZDCKbUzZmVovmoHbDyHV/duTn7Sf98XQOS+zeJeBe8MYhlvwXqHCYCb85exjIGbhu1RHbKcuooBHGP2084+uqN9fsVnRQwySrozQR02UU49ZocuQbxfgQD2KtSko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764131771; c=relaxed/simple;
	bh=i/KfQ52NxHPZ4ObsdxA8+9apyPYnV1fUisPIzjKWJCs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lt4tJAfqRRJtwxdFHdH9j53/RSQbX9mMO/vR74ZHu/xrhBUGqOUHmOb3tXISBEpT3FsJdWbK2U7qF29oPHDs0CDp/ZVZcarusimCa8R7oMCk5A9ylG7Gy0xKhDtnPSwmFNwYq7iAHqnCvK9hC0YCBGJXYB4tdeLeLHeQ9Shwa3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OqmbCMMm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C4vdUjwH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Nov 2025 04:36:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764131768;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6EokGo1SNkGifxsCSXzNShyndAJ7klaqhGLVNebJfgw=;
	b=OqmbCMMmafIZqMEyTguW0tKD1Cic2FgIpOCGLkVl9xT/fNHBmWDDjgCwUS7KHP3F7W4vG+
	5y0nlwFmOkUlTxdxEY53iGm4KkAslJgnO8D0QkvAkYP9QbyoF2A5hoL+G96bbFBumT4gjF
	u5CgNDB+YAyohlLlvLshNMz8M+xJPhGKuM1E031H7WmJ9COGoYnXtNbBCgW5n78oDkQbxc
	Li+KHo1R8BtQiiPMZcMOtqqMpLJiW6BqfnLfnjB9UW3uJZrx2aBGVVo3WJBG/XTsUEMHEd
	232tX8Ppv8oUj8WxzlepvrlyLdLWMZJDjEuVYQb9cCXiqJ89vr7Jgfmx30lyOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764131768;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6EokGo1SNkGifxsCSXzNShyndAJ7klaqhGLVNebJfgw=;
	b=C4vdUjwHLIS7eHCEKkpkjwF2iRgOBwtkYqdRNVZQVOdoMa55fzyu8ljaF6pbJBYsO3PK8d
	1nge1tWd3GgltcBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] irqwork: Move data struct to a types header
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172550.152813625@linutronix.de>
References: <20251119172550.152813625@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176413176693.498.11963442562554610868.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     c809f081fe400cb1b9898f4791c0d33146315161
Gitweb:        https://git.kernel.org/tip/c809f081fe400cb1b9898f4791c0d331463=
15161
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:27:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 Nov 2025 19:45:41 +01:00

irqwork: Move data struct to a types header

... to avoid header recursion hell.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251119172550.152813625@linutronix.de
---
 include/linux/irq_work.h       |  9 ++-------
 include/linux/irq_work_types.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/irq_work_types.h

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 136f298..c5afd05 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -2,8 +2,9 @@
 #ifndef _LINUX_IRQ_WORK_H
 #define _LINUX_IRQ_WORK_H
=20
-#include <linux/smp_types.h>
+#include <linux/irq_work_types.h>
 #include <linux/rcuwait.h>
+#include <linux/smp_types.h>
=20
 /*
  * An entry can be in one of four states:
@@ -14,12 +15,6 @@
  * busy      NULL, 2 -> {free, claimed} : callback in progress, can be claim=
ed
  */
=20
-struct irq_work {
-	struct __call_single_node node;
-	void (*func)(struct irq_work *);
-	struct rcuwait irqwait;
-};
-
 #define __IRQ_WORK_INIT(_func, _flags) (struct irq_work){	\
 	.node =3D { .u_flags =3D (_flags), },			\
 	.func =3D (_func),					\
diff --git a/include/linux/irq_work_types.h b/include/linux/irq_work_types.h
new file mode 100644
index 0000000..73abec5
--- /dev/null
+++ b/include/linux/irq_work_types.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_IRQ_WORK_TYPES_H
+#define _LINUX_IRQ_WORK_TYPES_H
+
+#include <linux/smp_types.h>
+#include <linux/types.h>
+
+struct irq_work {
+	struct __call_single_node	node;
+	void				(*func)(struct irq_work *);
+	struct rcuwait			irqwait;
+};
+
+#endif

