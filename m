Return-Path: <linux-tip-commits+bounces-7409-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD291C73ABB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 12:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88966354CCD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 11:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425D932D7C7;
	Thu, 20 Nov 2025 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cu35BCil";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V2nbsJcE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E0A2DCBFC;
	Thu, 20 Nov 2025 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637595; cv=none; b=uSJSRnIa11iE52rR0xfDwleA2f8ymzP1lDgp0LegZYXhSI+JZAIpsEK+x1NAD3JL6FLa4gBGM82zx8epSaFzA+O/+QOSMopfc3B6oq58L5cc5F5phBrUVor0ozfYvX50STq/S4xjfs2VWv8bsSn5C9UwJO72yWPN084kEHRhHRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637595; c=relaxed/simple;
	bh=pTUG8UMa0E1V1WbCcuekQllVg1JvYg8vadOcc19DeoY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bBR6apKNPHSr9YZZIXl4nAQaNy/Y8UesLqFl7vQga4LJsSX6sBFPSggt0WXV687n2PO8hiWsXc2ZgcjzXZZArgRzR0GcMA8yLvr6CJqCZqXmyMgdnDFtwjV5UKddip1++w7Kdrqaa/qf1Ym8wk/C3Z88Gvwopyhda3lS0AlKMPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cu35BCil; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V2nbsJcE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 11:19:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763637592;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0rni3UNg2joJ02x2b9cBFMzXxZsJz9Radejt47XRUM=;
	b=cu35BCil9vaevAm+kcDjycZKhhvbmqN1R4fXZe+46p3EratBnF8MGIlcWwOJM3GYtZ8RNJ
	8RRIrKG0WhsUYQcuJ9ZlmvqAoJvNMbnF7lp/Ez1v4woWgj7UNFE6X1pW7n+6+vPHrx+V2s
	j79SwxOTji2mINCaDAE4q7kNVhYHbJSLYrBynHhQHrlBzBgU0Rq9bFeID5ksnCyCRmk2s5
	F2Ml2MXQ8FHOU95qo/2N5pafPU9KBH1+m2A9sook/t3N2tS2D2GE8qS9ptT6sd6ODVA7+I
	SCHFUn5R23Dsaqi7dYDNX8u91O/pce3cKPMxUEP5AXwImgf8YTymlKt7w2jA1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763637592;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0rni3UNg2joJ02x2b9cBFMzXxZsJz9Radejt47XRUM=;
	b=V2nbsJcEQ7an/7xeUkCediQPXg+tSLYG7oku0fzl6eyojTHcV/azt2ECdZMgkDu5Ewh62W
	I1gNmtZl0Onu27DA==
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
Message-ID: <176363759102.498.15426383301536479502.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     2644779ec144d3e8cce5fed9623b47e70b3e0422
Gitweb:        https://git.kernel.org/tip/2644779ec144d3e8cce5fed9623b47e70b3=
e0422
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:27:18 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Nov 2025 12:14:58 +01:00

irqwork: Move data struct to a types header

... to avoid header recursion hell.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

