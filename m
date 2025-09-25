Return-Path: <linux-tip-commits+bounces-6756-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28762BA198A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D891A32292C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5C132D5AF;
	Thu, 25 Sep 2025 21:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ei8lG7/A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1D1AdZgA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E732CF87;
	Thu, 25 Sep 2025 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836022; cv=none; b=o5iuUi3TyiSOqah4CSeDrTG2hqPlIREE8CWnnU7ZZueIjKndvQks4mDSfGqwvv3ahOHKGsEeOXJsTIhNYD5rAxpIKKzzD9BR/Xx755CcvsDse82plKuppYV9Um84wk4r7ySf/tzPEqPf0atONL5M72Sl725QXc6eFTUpH5eMqXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836022; c=relaxed/simple;
	bh=xPFGyocWsyR6sxf3FLjnPFFtXeDRIo/5R4LZ7ZMP+w4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=kfEqn+qyg+WoH86VTyYrm+sFjed3+O5ZzAlOmU1bWkKH5qBBp5o3vkiQIvhRbfWv5CbuEZTVRIZc/PJmGmTLHJ115ZljbPyqSjwyWKympMNWtg71QmNn1SeoNvRM5vRB0lCn3Fi+QoU4ndn98wMi1lPgzNGiJIx/KOgDmONnfq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ei8lG7/A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1D1AdZgA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836019;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=fINxxjz6yXhc3sYtKWr6G/4bKxPSrY+yG8rSWkS9WwA=;
	b=Ei8lG7/Ah0SJHRAKmA3q84F+/mJl2pJKRVmo4cNxaPRSvhuzgZqksJWkW3TRoAqjGZEA5n
	7JZg8d8lDqq5gGGCNhn+gj+qCJQLm4UiwTJpM37vqWXaZllibaj+5x/ePmlAdmQMgLhjkO
	Vc/DiT+iAK1edorSgrdL56lGqUf8Cym9TKzPdOcimXihM4f8cpBHVezwZjLEaDJcumPK7N
	BbYY4p/ik9b2eEOZtMy9QZ/6eC+tZSiNq7IXVtFvRwODsOHSTYGKcny3lb06xXj6+axMqy
	snpfw3CfnJnIZebLIy32NB1Rl3rmlm6/17qTV1UkqMqFtn35hpwNdp+9cf2TVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836019;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=fINxxjz6yXhc3sYtKWr6G/4bKxPSrY+yG8rSWkS9WwA=;
	b=1D1AdZgA7lFqzPpWnxVz40HQRexH8XQ6IcqGsZGRhyirGK+NDPe1XSr9PzIQft1quYpZPK
	8dvEHXMQqHWHb6Aw==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/vf-pit: Add COMPILE_TEST option
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883601798.709179.6333379584915824802.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     2decd0b63eb0a6773e9a5541300cd92e469f541b
Gitweb:        https://git.kernel.org/tip/2decd0b63eb0a6773e9a5541300cd92e469=
f541b
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:20 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:28:25 +02:00

clocksource/drivers/vf-pit: Add COMPILE_TEST option

The VF PIT driver is a silent koption. In order to allow a better
compilation test coverage, let's add the COMPILE_TEST option so it can
be selected on other platforms than the Vybrid Family.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250804152344.1109310-3-daniel.lezcano@linar=
o.org
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 645f517..6f7d371 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -475,7 +475,7 @@ config FSL_FTM_TIMER
 	  Support for Freescale FlexTimer Module (FTM) timer.
=20
 config VF_PIT_TIMER
-	bool
+	bool "Vybrid Family Programmable timer" if COMPILE_TEST
 	select CLKSRC_MMIO
 	help
 	  Support for Periodic Interrupt Timer on Freescale Vybrid Family SoCs.

