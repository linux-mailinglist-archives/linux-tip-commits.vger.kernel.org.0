Return-Path: <linux-tip-commits+bounces-2199-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B93096FB9E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 20:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A4C1F2A8C9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 18:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621121D86FA;
	Fri,  6 Sep 2024 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bml8UmL3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="994oFEE3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C70D1D6C50;
	Fri,  6 Sep 2024 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649021; cv=none; b=thrdHCurwAaueIBiLYU8IYULaizPXj33vl3VrUuw8Vr2E6C8ARi2jh0KjCJFf4aV9BmiywhqTIRC4e+CqawMKyjKmhN0DKmgLS3IQRpqp2Gxsi0/trQFT/OEwBm1GqhP6Bh6WV+WnFktjAQ/Q46zJOUQzWsmfHP3Ja05R0jYFGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649021; c=relaxed/simple;
	bh=BktgniehShrX5h0Pzy6+ZXW7dudyEc3jt1y7VwRZevA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PASSejfq196yu6bGYFwf2717hWQMoPY7lRf/+JShHLsfBsW5nZas3SFKno+G+S2sYN2+nfAjVVssQ0LvqCr9+chXt3njmqE5BZFX2Z6DwdGtebrOmXd73gRF+r6yxbZkxWpg+ofPInDl541GNPwhd/Ufh8WmkM6U7KTRmk6Luvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bml8UmL3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=994oFEE3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Sep 2024 18:56:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725649017;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bh4QVnrx0NCUJwyLjCDelrPGi/0j8bTTehyRyq3Eyts=;
	b=bml8UmL38jxo8VYQXnYK3Xl8MXReuQqJ6zN2vmlFDRjG8mfgqyyg+uSx/KPyr1fmtC3UZP
	0Z0MTY2/CmrOIo75rEoJA5bB+/ePNwdLByHEpVgSNZoYhkXifwKBdvcDXOBR3vnbK7r02o
	JJaGM7oBTSo8uPYyErQikhT5gaAZy3R2KJMye4qFKyt/Vt2GcnUELHAOpl+jZrE8i7KfnN
	vY9KU+RbfRxfoLZsW8ZYh7ufIfe8StVWV056CxVWX6HLvMKcEFm7t56tBU7M9snnrRC63v
	uDBW3/3rgpk//VtH7wfIcOj+nqi8YdUgt2s8/CjzLsGVGNVgU4VV5Fd/3XwGJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725649017;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bh4QVnrx0NCUJwyLjCDelrPGi/0j8bTTehyRyq3Eyts=;
	b=994oFEE3BAkxH6K+K2i0OCdW8RQRT6TrXagIle5yn4gzhkgwohZ4lovD4xhWU/IAwuy+Ff
	2WYerNDgGxsG8WAg==
From: "tip-bot2 for Zhang Zekun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Using
 for_each_available_child_of_node_scoped()
Cc: Zhang Zekun <zhangzekun11@huawei.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240807074655.52157-1-zhangzekun11@huawei.com>
References: <20240807074655.52157-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172564901751.2215.14803402203161931282.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a7456d7d1b8e781fdaa16c10947bd2363c6fd342
Gitweb:        https://git.kernel.org/tip/a7456d7d1b8e781fdaa16c10947bd2363c6fd342
Author:        Zhang Zekun <zhangzekun11@huawei.com>
AuthorDate:    Wed, 07 Aug 2024 15:46:55 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 06 Sep 2024 14:49:20 +02:00

clocksource/drivers/arm_arch_timer: Using for_each_available_child_of_node_scoped()

for_each_available_child_of_node_scoped() can put the device_node
automatically. So, using it to make the code logic more simple and
remove the device_node clean up code.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
Link: https://lore.kernel.org/r/20240807074655.52157-1-zhangzekun11@huawei.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index aeafc74..0373310 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1594,7 +1594,6 @@ static int __init arch_timer_mem_of_init(struct device_node *np)
 {
 	struct arch_timer_mem *timer_mem;
 	struct arch_timer_mem_frame *frame;
-	struct device_node *frame_node;
 	struct resource res;
 	int ret = -EINVAL;
 	u32 rate;
@@ -1608,33 +1607,29 @@ static int __init arch_timer_mem_of_init(struct device_node *np)
 	timer_mem->cntctlbase = res.start;
 	timer_mem->size = resource_size(&res);
 
-	for_each_available_child_of_node(np, frame_node) {
+	for_each_available_child_of_node_scoped(np, frame_node) {
 		u32 n;
 		struct arch_timer_mem_frame *frame;
 
 		if (of_property_read_u32(frame_node, "frame-number", &n)) {
 			pr_err(FW_BUG "Missing frame-number.\n");
-			of_node_put(frame_node);
 			goto out;
 		}
 		if (n >= ARCH_TIMER_MEM_MAX_FRAMES) {
 			pr_err(FW_BUG "Wrong frame-number, only 0-%u are permitted.\n",
 			       ARCH_TIMER_MEM_MAX_FRAMES - 1);
-			of_node_put(frame_node);
 			goto out;
 		}
 		frame = &timer_mem->frame[n];
 
 		if (frame->valid) {
 			pr_err(FW_BUG "Duplicated frame-number.\n");
-			of_node_put(frame_node);
 			goto out;
 		}
 
-		if (of_address_to_resource(frame_node, 0, &res)) {
-			of_node_put(frame_node);
+		if (of_address_to_resource(frame_node, 0, &res))
 			goto out;
-		}
+
 		frame->cntbase = res.start;
 		frame->size = resource_size(&res);
 

