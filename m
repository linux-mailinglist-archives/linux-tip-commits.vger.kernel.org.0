Return-Path: <linux-tip-commits+bounces-3456-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D3BA3984B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 083D37A1269
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA09A243383;
	Tue, 18 Feb 2025 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SgozWqRi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eKQDibGA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFE42417F2;
	Tue, 18 Feb 2025 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873216; cv=none; b=j4+h+fqNPA4/8Z7/xWSHKrO/U1fYxF56vSPVQU+eWD8OVecEgvP2cL8r6Tkwf9ZH/WVGlO+u79kh09xgsjYR3wWf7MB+nFXy8a7FLj22Jz1yF07xWUPqMx71KIUEU40ag2d6LMqGr2x8CQIK2m6IRO8S72mn5Z+Qy/s/03OuCAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873216; c=relaxed/simple;
	bh=aVqrkVOuSlId+zB9/bZPYW0Rd9Xhmj61KGe5btzrRj8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bqtVWljZO3IrpJPjflETv6tKyTQpgvWPEv3Kk+f1XaIFLLWX4A8zkCNuDgMAoieuWEk07FvBWQnGjMMamg92XCJr87LmHudCiz365GydL0OYmN+B30ZLZS3UpMeGOS4EknUrqjS6xloyxAAAowfDALfApTt07tzu4n8CM9FAcnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SgozWqRi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eKQDibGA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uc4qPc27VQ69LpKAJsb3HOf1ykhSE9Et4ecsKUhx4n8=;
	b=SgozWqRiCkSk+bE7I+UAyTE646tCSzKExTt1yQ7WjNFGuc7F15uHLCAFSCk3/3byLChntI
	cUvcmMgV/Us57Le60MMly03XFKmJ2RLjSVX0nW9J+wmSQiwL3419N5k0+kcBNoB5WSNMqU
	CmYzywdHdzNJH1FecRHzbscdBFxNyNwE1vIQ3NztRjA6ZXN/Hy9qwl7S7DNSorQVxJXQ3y
	8FIGWIHkNx/5tx+9BJOCJ8aZBx8aeoPAi8hgAKHr6FDUJ7xM+9sTik8JgvFhExQGAn/i17
	JYBfjBhixyuCzxDVPhgrTLxExiILk9XR+m3JHzVqjcXbuQrB9yn2mYrhKGjZPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uc4qPc27VQ69LpKAJsb3HOf1ykhSE9Et4ecsKUhx4n8=;
	b=eKQDibGA3/yxUdnKiy0LI0VDsCzIWkOMIAu83Cec2CuL9BIiDJcKcJE01AiMFiu4W6tMSz
	ZYgs9R/TUk5BfwCQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] tcp: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca16c227cc6882d8aecf658e6a7e38b74e7fd7573=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Ca16c227cc6882d8aecf658e6a7e38b74e7fd7573=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987321317.10177.10335200278717032394.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     553f9a8be728cdf884985b2d9a057d3af09f60f3
Gitweb:        https://git.kernel.org/tip/553f9a8be728cdf884985b2d9a057d3af09f60f3
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:44 +01:00

tcp: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/a16c227cc6882d8aecf658e6a7e38b74e7fd7573.1738746872.git.namcao@linutronix.de

---
 net/ipv4/tcp_timer.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index b412ed8..e7a75af 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -884,11 +884,9 @@ void tcp_init_xmit_timers(struct sock *sk)
 {
 	inet_csk_init_xmit_timers(sk, &tcp_write_timer, &tcp_delack_timer,
 				  &tcp_keepalive_timer);
-	hrtimer_init(&tcp_sk(sk)->pacing_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_ABS_PINNED_SOFT);
-	tcp_sk(sk)->pacing_timer.function = tcp_pace_kick;
+	hrtimer_setup(&tcp_sk(sk)->pacing_timer, tcp_pace_kick, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_PINNED_SOFT);
 
-	hrtimer_init(&tcp_sk(sk)->compressed_ack_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL_PINNED_SOFT);
-	tcp_sk(sk)->compressed_ack_timer.function = tcp_compressed_ack_kick;
+	hrtimer_setup(&tcp_sk(sk)->compressed_ack_timer, tcp_compressed_ack_kick, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_PINNED_SOFT);
 }

