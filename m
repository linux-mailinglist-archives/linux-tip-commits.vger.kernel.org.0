Return-Path: <linux-tip-commits+bounces-3414-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEF6A39788
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DB33AE078
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A66E23909E;
	Tue, 18 Feb 2025 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XivqMjrh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+OasvWN0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCA9235C15;
	Tue, 18 Feb 2025 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739871996; cv=none; b=OBoWRepDXWvB013SmOYC4c+Aqxc7xYvJ/LmFyr+uoqSalQmHtBVlNpQx4QLkd5XxfkUvaT38LuAOmq1qQFzWnLqdx+j9z16XAb1Cog4Dmx4GGJbIwb4ARigwPkm4N/c1m53KRs+ZTE5yyyOLYz2nJwuuB+IFDbjRLi7IY77vpKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739871996; c=relaxed/simple;
	bh=7vmmvq8WcU4KV797cR5Y+qLLd8CNZM3HlpM5Pz4TY18=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CKfUF3w2nFf4Q3kYyypVEnyvr9x/mYVXBgAH9bXMzKFw/4dcatz1UXKMXs1y9UfVqCuAWZAo9Bmt37WTdCpjMjjzaPGwTkWXb5nfmCKVUwEJ8q9hk6uNT8B4RYoPStRbYAB4Qp7OhI6xYPtoa3+fRmCgS1O7WiyULVns9dJDGH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XivqMjrh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+OasvWN0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871992;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SLv/BY4wRUFwb+7nMN1wO43HFS8KZT6TKtU1HCSavmQ=;
	b=XivqMjrhKQZpOnyWqBzMhEN1acqjG8th9/VNNY2AZXnwZrw4nd7Tgv+w1b8sRjFR/+/1ZG
	KNKdQ5C0ahbRqpnLzuOayo8fvt+9GxXM7t5+wdDPQPUj3NW3KSO7wMzZqfTnIGFqy7mTUh
	ahmmEACM1fgpnLnjxI/EYn6nz7hc1xQdflkNCd9X/oXG2QnsbHTnijuiydzhlhZjMEFZjS
	I5gpth/QWaKW1RwtiLF5JuKFq4oLYKWoWcnSKwPi1v1g0q6+4zqGYlhEHeZunTueGg9/Ji
	WPb0XditIpQ5itIAQB+S5SvuSvpwYwBiFPl7VmIK/tFLtGIdIBpCtNrFoV8khg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871992;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SLv/BY4wRUFwb+7nMN1wO43HFS8KZT6TKtU1HCSavmQ=;
	b=+OasvWN0had+3xRCpJN7IFaAVM6x/fKSWuIOsiJoBVemqim7CM3MyEFL1dtibBg/P4NT7z
	AtTlS1AiN2HasQDg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] ubifs: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Richard Weinberger <richard@nod.at>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cf5767e50aaa2935b3e4a0e9cf1bc4365d6b0c1a0=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cf5767e50aaa2935b3e4a0e9cf1bc4365d6b0c1a0=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987199209.10177.5699241316095419577.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     1654eba8f74d1fcb95dd63e549c621722adc2689
Gitweb:        https://git.kernel.org/tip/1654eba8f74d1fcb95dd63e549c621722adc2689
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:39:06 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:33 +01:00

ubifs: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Richard Weinberger <richard@nod.at>
Link: https://lore.kernel.org/all/f5767e50aaa2935b3e4a0e9cf1bc4365d6b0c1a0.1738746821.git.namcao@linutronix.de

---
 fs/ubifs/io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
index 01d8eb1..a79f229 100644
--- a/fs/ubifs/io.c
+++ b/fs/ubifs/io.c
@@ -1179,8 +1179,7 @@ int ubifs_wbuf_init(struct ubifs_info *c, struct ubifs_wbuf *wbuf)
 	wbuf->c = c;
 	wbuf->next_ino = 0;
 
-	hrtimer_init(&wbuf->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	wbuf->timer.function = wbuf_timer_callback_nolock;
+	hrtimer_setup(&wbuf->timer, wbuf_timer_callback_nolock, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	return 0;
 }
 

