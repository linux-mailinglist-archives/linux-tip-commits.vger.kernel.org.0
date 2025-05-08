Return-Path: <linux-tip-commits+bounces-5500-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BDAAB01DA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 19:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4073B0BCC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 17:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0409E286D4B;
	Thu,  8 May 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hwCFxeQp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ko/Hlbdy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C29286D52;
	Thu,  8 May 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746726873; cv=none; b=t4mkORdceY+tPp54csOCd5XJkJRQrOlnKKJooz0AseiqktYxNQ+nWPOby87L1vS5rtknGlNYoIYSt03ZZblZc31Lmww0ov7fXcOvYMWSM8mAmARkCGwgbqhaHflkVggk9V4dbUQ5KOkpyc/zpf/kSFBsb8e71kY53rKFcIWeS0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746726873; c=relaxed/simple;
	bh=RcxntvE7qmghh3Go5o8Ap5SQjcKDybFb7zRNFRPN/ro=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NwSKUSfUHKX9x/R/qf7iKEhCfNOQmcsUtZy15nat7yWCtnTKDKPaq0399O5bK5XqkRiMs1rDblAvIxtSTAgVi2lEirpDBDIM2UnpQP3nm8Jz94qmBgqc2fKngJmQuq6wVUzgpeOiKlICNT+ggqqBvZxZ3g5wPoejDOPJ2OokkJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hwCFxeQp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ko/Hlbdy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 17:54:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746726870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8Ih8Vn+XkudE6lcT2D/ZzQJXxWk1verLr7+g8M7OSE=;
	b=hwCFxeQpeky2ySDLcmneTRrX4O9lIfy28obD/pThZXDdICQPcJ9ggn83jKhk5oj6AfVjnV
	upGBPSj1JBlKB7C+DjWlAQBHDhmbsmmUe/+rhHhuPdCTNFUK6gqnBgfX19sUXHILh5orPp
	iQlT+wSN6kzTTXmxCO+s6PzZwsDqRqRAidcfBrsMahYkA7ltJZXOd0zsHI9/eeVGpXGp4r
	2Ca4XH4SM9z+RygIkeBrXBJB/tsxM695WhpYeHBCKr74il4YBxNAy9Jur04Tm/MepnjfHM
	Hw62MfON4Z0/0DLpuUvdQWuN4DXIkaDphKRYokOZhNu5Rsr6bPYag+PxKnlqXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746726870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l8Ih8Vn+XkudE6lcT2D/ZzQJXxWk1verLr7+g8M7OSE=;
	b=Ko/HlbdydEKSc3bDQYYq46LMip6OM0tYJZ9Jalp3Z7sx5UR3bK2DV4qqpI+M6SCVkhuphP
	PEvA+gLzP4Ir2+Bg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] timers: Rename __init_timer_on_stack() as
 __timer_init_on_stack()
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250507175338.672442-6-mingo@kernel.org>
References: <20250507175338.672442-6-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174672686979.406.127620117259096504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     9a716ac6eaaa73599921fa081c99b67bef589171
Gitweb:        https://git.kernel.org/tip/9a716ac6eaaa73599921fa081c99b67bef589171
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 07 May 2025 19:53:33 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 May 2025 19:49:33 +02:00

timers: Rename __init_timer_on_stack() as __timer_init_on_stack()

Move this API to the canonical __timer_*() namespace.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250507175338.672442-6-mingo@kernel.org

---
 include/linux/timer.h     | 6 +++---
 include/linux/workqueue.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 11e1fac..4e1237f 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -94,7 +94,7 @@ static inline void timer_init_key_on_stack(struct timer_list *timer,
 		timer_init_key((_timer), (_fn), (_flags), #_timer, &__key);\
 	} while (0)
 
-#define __init_timer_on_stack(_timer, _fn, _flags)			\
+#define __timer_init_on_stack(_timer, _fn, _flags)			\
 	do {								\
 		static struct lock_class_key __key;			\
 		timer_init_key_on_stack((_timer), (_fn), (_flags),	\
@@ -103,7 +103,7 @@ static inline void timer_init_key_on_stack(struct timer_list *timer,
 #else
 #define __timer_init(_timer, _fn, _flags)				\
 	timer_init_key((_timer), (_fn), (_flags), NULL, NULL)
-#define __init_timer_on_stack(_timer, _fn, _flags)			\
+#define __timer_init_on_stack(_timer, _fn, _flags)			\
 	timer_init_key_on_stack((_timer), (_fn), (_flags), NULL, NULL)
 #endif
 
@@ -121,7 +121,7 @@ static inline void timer_init_key_on_stack(struct timer_list *timer,
 	__timer_init((timer), (callback), (flags))
 
 #define timer_setup_on_stack(timer, callback, flags)		\
-	__init_timer_on_stack((timer), (callback), (flags))
+	__timer_init_on_stack((timer), (callback), (flags))
 
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 extern void destroy_timer_on_stack(struct timer_list *timer);
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 985f69f..c84da78 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -324,7 +324,7 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
 #define __INIT_DELAYED_WORK_ONSTACK(_work, _func, _tflags)		\
 	do {								\
 		INIT_WORK_ONSTACK(&(_work)->work, (_func));		\
-		__init_timer_on_stack(&(_work)->timer,			\
+		__timer_init_on_stack(&(_work)->timer,			\
 				      delayed_work_timer_fn,		\
 				      (_tflags) | TIMER_IRQSAFE);	\
 	} while (0)

