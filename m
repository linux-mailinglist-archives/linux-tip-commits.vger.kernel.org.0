Return-Path: <linux-tip-commits+bounces-6728-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010FABA18D3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDEB956468E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867F8322C83;
	Thu, 25 Sep 2025 21:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1tb/AGro";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I1/Sg/G9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89C02E7F3F;
	Thu, 25 Sep 2025 21:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835978; cv=none; b=IlovSq2fVnpuWH6k4AbORGMVidjLiu0S+ppCibpCXeZL2ME3ozdMMjkrvAWqECn8RmHQ1MVjOcTAv3XqcuftShdBH0lYAYvDHcZGyLWF+oAFdpBIIsX9s85w27/OAfRseTqJ4W54nFGOOCWNOjecNgYUUp11f2IrMVGkLnDTzUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835978; c=relaxed/simple;
	bh=OFfh640ro3NkLFnSNA3cTnvpBhlCmozwAf2TlOKNWAU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=OlN1oActDtUY8Eyghz2mouX/mLcWlxElMRPMbhH0YZ1KwJgGKmWDFXnXrsgR3oU19Pr2ankqvUfZrYrwW+Jkaz/bCAGQqmhKpa/L9D2gU18MgeQWAjVj95gE6B6tA+0cs6L6YrNjxS/WMldZSBKLBD3sCZeGl0aSk8DIRZhnMxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1tb/AGro; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I1/Sg/G9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:32:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758835975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=KMO3aFz2JkQe8FAqLJDJBHPX1CM6eMSdtvCG+79aQpw=;
	b=1tb/AGromjHb36mDQjePXRifXO5D/pCZ+c8Yo0BIja58zX+oMXP5bHBH/HbYINtikXAL6J
	5WySo4zJ9hsIPA8/N949O6o1bIPfxIk0XQfudB4WWcIpjpwyPAWHJlNx5LdyLf7CS0jgaq
	OPgGYtIbjqUybvHiOpxlRCfyN82aKmyqZyYKv7Ab9pg7e+eFLDckDNjMMAQ9S6JAAfGlgA
	nlGxJ+RvXp1FilnpxS0CcxcIIn9gR7TftwdyC14SJyCy3sQaCTcrb8nauVCuxCzHq++FHs
	WVoL9A/xHFZWeIDzc4D3dbg4rNNtLEgacb5VS4Ed+Zm8rB3DEqXs7CDJTGQYZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758835975;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=KMO3aFz2JkQe8FAqLJDJBHPX1CM6eMSdtvCG+79aQpw=;
	b=I1/Sg/G9nkK+5/xRckLAZvB06eQhHeSFuV+NS1PJzqq75LFRklRxrq2grOi45Jf0BTIikQ
	AWIVOZbBs/FY2VBQ==
From: "tip-bot2 for Markus Stockhausen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-rtl-otto:
 Simplify documentation
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883597390.709179.11596900908202103472.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     931bd9273848aca9dc40dd5cad3fcfe5d0818972
Gitweb:        https://git.kernel.org/tip/931bd9273848aca9dc40dd5cad3fcfe5d08=
18972
Author:        Markus Stockhausen <markus.stockhausen@gmx.de>
AuthorDate:    Mon, 04 Aug 2025 04:03:28 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:41:26 +02:00

clocksource/drivers/timer-rtl-otto: Simplify documentation

While the main SoC PLL is responsible for the lexra bus frequency
it has no implications on the the timer divisior. Update the
comments accordingly.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250804080328.2609287-5-markus.stockhausen@g=
mx.de
---
 drivers/clocksource/timer-rtl-otto.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-rtl-otto.c b/drivers/clocksource/timer=
-rtl-otto.c
index 42f702a..6113d2f 100644
--- a/drivers/clocksource/timer-rtl-otto.c
+++ b/drivers/clocksource/timer-rtl-otto.c
@@ -41,12 +41,10 @@
 #define RTTM_MAX_DIVISOR	GENMASK(15, 0)
=20
 /*
- * Timers are derived from the LXB clock frequency. Usually this is a fixed
- * multiple of the 25 MHz oscillator. The 930X SOC is an exception from that.
- * Its LXB clock has only dividers and uses the switch PLL of 2.45 GHz as its
- * base. The only meaningful frequencies we can achieve from that are 175.000
- * MHz and 153.125 MHz. The greatest common divisor of all explained possible
- * speeds is 3125000. Pin the timers to this 3.125 MHz reference frequency.
+ * Timers are derived from the lexra bus (LXB) clock frequency. This is 175 =
MHz
+ * on RTL930x and 200 MHz on the other platforms. With 3.125 MHz choose a co=
mmon
+ * divisor to have enough range and detail. This provides comparability betw=
een
+ * the different platforms.
  */
 #define RTTM_TICKS_PER_SEC	3125000
=20

