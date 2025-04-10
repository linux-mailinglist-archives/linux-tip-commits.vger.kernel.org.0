Return-Path: <linux-tip-commits+bounces-4822-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A1CA83E2D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 11:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0237E16A8CE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 09:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9BD20AF73;
	Thu, 10 Apr 2025 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I5HiH4zL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="st5ZgiRM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866572040AF;
	Thu, 10 Apr 2025 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744276361; cv=none; b=DJQKs6sTT/8KEkIGe0VYZUQrNWFGzaY40h4VYw5UTQbrQ6haSTT8qS0RJHwsr/ka8EwwIZpQ/rqrMsPiZtmbRgk8Qx6smxJR/PxcyzFbJop+uDVREsZggKGjGkS4X8M+jaHc6ywDDl+4hOTUgPftyFXTL3ugn8OKQTdjsvekn4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744276361; c=relaxed/simple;
	bh=XEDEb02H7yhnwAJt8kqqDs0YKl82XKBm3AvXBZ9V/ZU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P7mosucH8hCsy6Zmg3qJTezNNufg0pcYnuyMO5GGsGWNsMUjYO1EZ2f/iCY/7c/gwPu+DQ4f6TGiTRtmlfWQFGyzg+3Shqm1moBGwQmydsy7xoN7DGgO7Sglj2ua2wjZk3bnb9095Ymun8sevvMxXb5MTfXAhwxPKzR9Bk/DV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I5HiH4zL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=st5ZgiRM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Apr 2025 09:12:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744276357;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MrsOnM766mcJyIVGfiSRe1AzIvxf8uix1V5khQwX5kU=;
	b=I5HiH4zLE7RyLnxB3JZSnSHD4MX54D0xJ+TtRSXwF3kw2j6a8puwLR3tiPFNH7vBSfIF7z
	bHiYXokwLUyC+XMywg24WluoAL5VdZRPMPIXQ9qpyNK22UFIo/oI9q/Fm8cHeU2t4NxbMc
	tM14QnO4G1ZJE5VoALSCtjyz80hR/xIpzEzv5OIvpUZTWEfEbRi2mBTRGu0C4JVnH7GQ8B
	sDX1V399jt6gYu96qtlCgrg9KvqojGiGo0Sw3cHbea6PTxxzsn6JzlmEKLaXU/kGYt1CCN
	31p3GN3AMT1vu8hb81ybDljEHKAGt5TW0yiXoDHjN2yIFP/FKJ8ezooavbmPqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744276357;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MrsOnM766mcJyIVGfiSRe1AzIvxf8uix1V5khQwX5kU=;
	b=st5ZgiRM8NsnXw3EPAo8zH9FMTQHlOPD7H6OGHy55Mr3je4+6v8fSDHca7OxN0fqAMIPL3
	zDFszqA6b9rVgPCg==
From: "tip-bot2 for Peng Jiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] vdso: Address variable shadowing in macros
Cc: Peng Jiang <jiang.peng9@zte.com.cn>,
 Shao Mingyin <shao.mingyin@zte.com.cn>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250324191230477zpGtgIRSH4mEHdtxGtgx9@zte.com.cn>
References: <20250324191230477zpGtgIRSH4mEHdtxGtgx9@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174427635228.31282.10735746636221422010.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     acea9943271b62905033f2f8ca571cdd52d6ea7b
Gitweb:        https://git.kernel.org/tip/acea9943271b62905033f2f8ca571cdd52d6ea7b
Author:        Peng Jiang <jiang.peng9@zte.com.cn>
AuthorDate:    Mon, 24 Mar 2025 19:12:30 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 10 Apr 2025 11:07:10 +02:00

vdso: Address variable shadowing in macros

Compiling the kernel with gcc12.3 W=2 results in shadowing warnings:

warning: declaration of '__pptr' shadows a previous local [-Wshadow]
  const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);

note: in definition of macro '__put_unaligned_t'
  __pptr->x = (val);

note: in expansion of macro '__get_unaligned_t'
  __put_unaligned_t(type, __get_unaligned_t(type, src), dst);

__get_unaligned_t() and __put_unaligned_t() use a local variable named
'__pptr', which can lead to variable shadowing when these macros are used in
the same scope. This results in a -Wshadow warning during compilation.

To address this issue, rename the local variables within the macros to
ensure uniqueness.

Signed-off-by: Peng Jiang <jiang.peng9@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250324191230477zpGtgIRSH4mEHdtxGtgx9@zte.com.cn
---
 include/vdso/unaligned.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/vdso/unaligned.h b/include/vdso/unaligned.h
index eee3d2a..ff0c06b 100644
--- a/include/vdso/unaligned.h
+++ b/include/vdso/unaligned.h
@@ -2,14 +2,14 @@
 #ifndef __VDSO_UNALIGNED_H
 #define __VDSO_UNALIGNED_H
 
-#define __get_unaligned_t(type, ptr) ({						\
-	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
-	__pptr->x;								\
+#define __get_unaligned_t(type, ptr) ({							\
+	const struct { type x; } __packed * __get_pptr = (typeof(__get_pptr))(ptr);	\
+	__get_pptr->x;									\
 })
 
-#define __put_unaligned_t(type, val, ptr) do {					\
-	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
-	__pptr->x = (val);							\
+#define __put_unaligned_t(type, val, ptr) do {						\
+	struct { type x; } __packed * __put_pptr = (typeof(__put_pptr))(ptr);		\
+	__put_pptr->x = (val);								\
 } while (0)
 
 #endif /* __VDSO_UNALIGNED_H */

