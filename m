Return-Path: <linux-tip-commits+bounces-6731-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544A4BA18E2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34CE7422C4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020D0323411;
	Thu, 25 Sep 2025 21:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qd6Pev0J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GI68N/AJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443A6322C9D;
	Thu, 25 Sep 2025 21:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835980; cv=none; b=RO1sOqiO/XCJDkN+GQMA081+o7NWY15yyVc3kjkdtYCzzLVLkDRXXzl0FYDP7UxB65Ud7LP0czXjr/LhAIPZPN8s2a8EwuskHVgwzfR7McZIfo5HnCXJCzEiQXckGausmnm2RLd4hnCPuXGaXfAqnVO+ORIBe7x07NQF20RhD9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835980; c=relaxed/simple;
	bh=6Ay1pCUWaPxOus8ydyBGY72YZOXl4gRuHxbvGd7BBck=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=syJXINFmJRMMVPqTDLAhfN5F2jgYfUvuhFTi6NhfTWNZXl1Qhn5Orse0VEVHAEfR8EP1rdeKw640DKZ7r6j4hq1qPxcX77HDW1fs/n7TaoV9bVJ8UB4aBnJhXvOwbNxJ5IIs/mj4rPf7Ep6D7G93Cp1Qnftl4+CuN66hKNglmNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qd6Pev0J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GI68N/AJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:32:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758835977;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=pjd7ZZem0NPn57c4q+1IkWxHHxbr10Wgb/uzvWCM4oE=;
	b=qd6Pev0JaRbk004pbilwUG0FaSLMSze5gHhV0m55MKGvGgs+dNlRziHDgDcMli0kWm43KC
	gnhxtyAZaf2TnJtM8EUXj65QtpyUhHYbiDPTYNp/SzhLGRyhfEU61LWMDGt7pldeATdcVS
	zVcYKVOlbNvrJ3msJSr7Qhyak8WQeqxNqF6Tj4r2VJ6ObRIZJMHyT4barWeDOan25Pu7Sd
	uX0sPJwwKmdha0ItiHdk9WGcjaQwZAeqt7tGdfhnrJsQZhDtwngvdCEPj3EtTJk9eIHcU6
	l49Cj5L2AxJZK5MA7fm9qx+rSLgSecdz5FldrXJlvhNosYLxK2Iy62cxoL27eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758835977;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=pjd7ZZem0NPn57c4q+1IkWxHHxbr10Wgb/uzvWCM4oE=;
	b=GI68N/AJ8BrCCUR7bDlaVfP2egYewhnavYIfYOYPf1WiWq0/Gdybzmk9B1PPhU4GMjTV5v
	TSghhsCR+HFdFvDg==
From: "tip-bot2 for Markus Stockhausen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-rtl-otto: Drop
 set_counter function
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Stephen Howell <howels@allthatwemight.be>, bjorn@mork.no, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883597627.709179.14781725175015297000.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     ca90147e55a78441794aef5cb4a8d1cf8d0e209f
Gitweb:        https://git.kernel.org/tip/ca90147e55a78441794aef5cb4a8d1cf8d0=
e209f
Author:        Markus Stockhausen <markus.stockhausen@gmx.de>
AuthorDate:    Mon, 04 Aug 2025 04:03:26 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:33:17 +02:00

clocksource/drivers/timer-rtl-otto: Drop set_counter function

The current counter value is a read only register. It will be
reset when writing a new target timer value with rttm_set_period().
rttm_set_counter() is essentially a noop. Drop it.

While this makes rttm_start_timer() and rttm_enable_timer() the
same functions keep both to make the established abstraction layers
for register and control functions active.

Downstream has already tested and confirmed a patch. See
https://github.com/openwrt/openwrt/pull/19468
https://forum.openwrt.org/t/support-for-rtl838x-based-managed-switches/57875/=
3788

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Stephen Howell <howels@allthatwemight.be>
Tested-by: Bj=C3=B8rn Mork <bjorn@mork.no>
Link: https://lore.kernel.org/r/20250804080328.2609287-3-markus.stockhausen@g=
mx.de
---
 drivers/clocksource/timer-rtl-otto.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clocksource/timer-rtl-otto.c b/drivers/clocksource/timer=
-rtl-otto.c
index 8be45a1..48ba116 100644
--- a/drivers/clocksource/timer-rtl-otto.c
+++ b/drivers/clocksource/timer-rtl-otto.c
@@ -56,11 +56,6 @@ struct rttm_cs {
 };
=20
 /* Simple internal register functions */
-static inline void rttm_set_counter(void __iomem *base, unsigned int counter)
-{
-	iowrite32(counter, base + RTTM_CNT);
-}
-
 static inline unsigned int rttm_get_counter(void __iomem *base)
 {
 	return ioread32(base + RTTM_CNT);
@@ -137,7 +132,6 @@ static void rttm_stop_timer(void __iomem *base)
=20
 static void rttm_start_timer(struct timer_of *to, u32 mode)
 {
-	rttm_set_counter(to->of_base.base, 0);
 	rttm_enable_timer(to->of_base.base, mode, to->of_clk.rate / RTTM_TICKS_PER_=
SEC);
 }
=20

