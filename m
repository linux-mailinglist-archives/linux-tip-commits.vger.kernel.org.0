Return-Path: <linux-tip-commits+bounces-6741-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4293DBA1933
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17561C81ED7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B3E3277AF;
	Thu, 25 Sep 2025 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OOJLGKtT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Dw1rEnA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8310327A03;
	Thu, 25 Sep 2025 21:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836003; cv=none; b=k5SVqGYf1ZUCi+zM4VwhOpV9FsO77rCiYiKlfcjdp6QSlHsUzHgPL83KR7RI3aLTGAif2X6MHxeAaaDxbsbWdwQiPYbrhWBtedKFXVezXwI3divxgN+MHyw5zuVLBbXK/qp49pMp1fB30vHHWZtzN/Tpr2B48oUrNKeb/cGGqlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836003; c=relaxed/simple;
	bh=pM/p1a68OASHckRDPpYweCZ38HBC2/IcmiSVQkW6oQA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=pnbXoTxW5EZ644dbjNb3vBp9dP9OatXC6IRza/fIyx3KTPGr4vN/ntcDXkuFl/5d/M7yVGTNycO9dAQq8onJzyXRveXqXG+1PcoBiSrUnyfba92qJ4wvANYMA0QHIPmElFbgZFuCn/p/fL4EfZs8Y75dccyctqdPma01BbaUDqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OOJLGKtT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Dw1rEnA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=MgR8/9Z1+jGbNB+F+aVgsWsxbK5R+sRC6H6Vjn3DqHE=;
	b=OOJLGKtTxBG1fV/Py+wP/zT0Wi8Mqgz87jEVO/vVnSsxsscD4WtsZyS9nIUWquyjcax2uZ
	X8Dqad2qFarm5/DZnvgsZczqo48mwo+ozEpdvtj81ieUb2Luw1ajVtjv+eMqP7eylrqqN/
	YIjRzg0CSwDg+bLE6TH+Ka/ZV5O/U707nnZ7013rhtHfA50UscpRr3BwEJ6cX1NDO8OeDn
	GFUCWoxzcGMgE27p244F6ZRIU0+53Rrh9CIP6wKIk894W6/dngMtIbsTYfmeSvMc+oCgV9
	2HyPWoC6bIXpABEE9Hal866ajTanWGWHSGwlQe2vnihL8pTw49+/NjuLVFMEvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=MgR8/9Z1+jGbNB+F+aVgsWsxbK5R+sRC6H6Vjn3DqHE=;
	b=4Dw1rEnA/FjOKVvK5LDgeD8Ws5xaPXDAOjk214t9ZpRDX5kMldT9fHhV/dzEwDmXD05GaE
	IE50CJPsdyupRPCw==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/vf-pit: Unify the
 function name for irq ack
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883599938.709179.9060884439995069517.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     3c34321e9b5965fdbf51fd407a35322a64c9e9c6
Gitweb:        https://git.kernel.org/tip/3c34321e9b5965fdbf51fd407a35322a64c=
9e9c6
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:35 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:30:00 +02:00

clocksource/drivers/vf-pit: Unify the function name for irq ack

Most the function are under the form pit_timer_*, let's change the
interrupt acknowledgment function name to have the same format.

No functional changes intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250804152344.1109310-18-daniel.lezcano@lina=
ro.org
---
 drivers/clocksource/timer-vf-pit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-v=
f-pit.c
index 3825159..2a0ee41 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -81,7 +81,7 @@ static inline void pit_timer_set_counter(void __iomem *base=
, unsigned int cnt)
 	writel(cnt, PITLDVAL(base));
 }
=20
-static inline void pit_irq_acknowledge(struct pit_timer *pit)
+static inline void pit_timer_irqack(struct pit_timer *pit)
 {
 	writel(PITTFLG_TIF, PITTFLG(pit->clkevt_base));
 }
@@ -165,7 +165,7 @@ static irqreturn_t pit_timer_interrupt(int irq, void *dev=
_id)
 	struct clock_event_device *ced =3D dev_id;
 	struct pit_timer *pit =3D ced_to_pit(ced);
=20
-	pit_irq_acknowledge(pit);
+	pit_timer_irqack(pit);
=20
 	/*
 	 * pit hardware doesn't support oneshot, it will generate an interrupt
@@ -195,7 +195,7 @@ static int __init pit_clockevent_init(struct pit_timer *p=
it, const char *name,
=20
 	pit_timer_disable(pit->clkevt_base);
=20
-	pit_irq_acknowledge(pit);
+	pit_timer_irqack(pit);
=20
 	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
 			   name, &pit->ced));

