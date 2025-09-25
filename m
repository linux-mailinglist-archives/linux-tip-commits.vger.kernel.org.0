Return-Path: <linux-tip-commits+bounces-6759-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48660BA19A2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8847D1C24E55
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D3C32E2F7;
	Thu, 25 Sep 2025 21:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Fh7lllt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mffg+tgh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB5032E2CE;
	Thu, 25 Sep 2025 21:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836026; cv=none; b=bB224vZbJdXUBS2Si8KrxpYmD7wPi0gFIjXuKDD34cJTkz83kVArUlkx6yYxtUaXWAglEnrUDMNpG8SM/KYYXjGLgmznrgakyMlDGkjqbEC5uFaZORRY5ybICIHp/5WI1PxvrxZ9hU1e/tDHwQ9kpnR69v8g+F44IKFUeKacdqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836026; c=relaxed/simple;
	bh=7zBtrZ4WT9sKuNOE7L7QVl4UEtkqccRsgGWXh6f+v+4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=fFmhL6qbbikbNqKUDMQs2vn8tnIR2LmyNGwZuxg487+agb3lMjedpGs6B1absrRtNB+zYrxHaW+vMkHlpijgyauB8RFeNO37e3+LKPQWw/fOXvXmlHjEDBD8RKIoosZUfN3V8+Lj9G3iiv9A15qmdPy52fVL3gOu63eRpViV9cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Fh7lllt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mffg+tgh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836022;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=StiuQHDHui1pzEYqlnzYsbqFleC4//BQ5wBvb3sllRw=;
	b=2Fh7llltuo1H+97nV7cLbA/nwid04dAO8XUWgM7LW0Cnw9m9ZuglkYW2gelln62EXdO2pt
	3uQxqOa4XDi9xsaFCfITU8cUyIgFmPrCBa46fPgj3Z3UN3Ku5zesrizkbl5Ut7rdqql1ic
	p9GbzpkPmRg1GtVPbUNwPZKRG0N1Xjj8UekhBrrHjagN20yCpGsrnWDJyQXomnMlZcV05J
	/1TsJ2A0f56/sSSEcdPrPlFAcZb6+CvpxEutsPm8yz+i860CqEe1pHuuPvYeW7g81X04ah
	6tj/f7T73qdXokWjqC2R6B+HZgLQ4tCf+z6kmAiFjz4AVlTQ5A1ZJhJuhXVLUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836022;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=StiuQHDHui1pzEYqlnzYsbqFleC4//BQ5wBvb3sllRw=;
	b=mffg+tghaPpFrxq18OzHmpJU37VKG9nsXlGe8NL/fpXoNtdvZxI61gYkGVNzCgthmC9eaf
	aZfrEnpJWSZklWDg==
From: "tip-bot2 for Chen Ni" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/timer-econet-en751221: Convert
 comma to semicolon
Cc: Chen Ni <nichen@iscas.ac.cn>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Caleb James DeLisle <cjd@cjdns.fr>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883602153.709179.13637548367591625468.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     d27b4e33c954f5fa6b6e366736838c98d3996f02
Gitweb:        https://git.kernel.org/tip/d27b4e33c954f5fa6b6e366736838c98d39=
96f02
Author:        Chen Ni <nichen@iscas.ac.cn>
AuthorDate:    Tue, 03 Jun 2025 14:04:50 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 10:56:13 +02:00

clocksource/timer-econet-en751221: Convert comma to semicolon

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection. No functional change intended.
Compile tested only.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Caleb James DeLisle <cjd@cjdns.fr>
Link: https://lore.kernel.org/r/20250603060450.1310204-1-nichen@iscas.ac.cn
---
 drivers/clocksource/timer-econet-en751221.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-econet-en751221.c b/drivers/clocksourc=
e/timer-econet-en751221.c
index 3b449fd..4008076 100644
--- a/drivers/clocksource/timer-econet-en751221.c
+++ b/drivers/clocksource/timer-econet-en751221.c
@@ -146,7 +146,7 @@ static int __init cevt_init(struct device_node *np)
 	for_each_possible_cpu(i) {
 		struct clock_event_device *cd =3D &per_cpu(econet_timer_pcpu, i);
=20
-		cd->rating		=3D 310,
+		cd->rating		=3D 310;
 		cd->features		=3D CLOCK_EVT_FEAT_ONESHOT |
 					  CLOCK_EVT_FEAT_C3STOP |
 					  CLOCK_EVT_FEAT_PERCPU;

