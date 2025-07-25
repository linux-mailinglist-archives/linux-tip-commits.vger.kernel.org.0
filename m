Return-Path: <linux-tip-commits+bounces-6192-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CADB11C5D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD0F1793B5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6628E2E06D2;
	Fri, 25 Jul 2025 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kcYCiRTI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JDYYRB1L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F542367C1;
	Fri, 25 Jul 2025 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439503; cv=none; b=VlQrFTDUDkRUh6XEVZrkh1NgREy056kja6iWb4PXkr78fIEzd5SzCgw3OMjhaSM1mapSCBTWfIHHBjOLZyDp/70T5QmUC0i6YEl1dobot12+BSU9whQ6MFfMo4s0/s85ubbdvtvyhfxR1pAXCHEolIfZEviws19oeLoseVMUFZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439503; c=relaxed/simple;
	bh=GsalUD9BCpA5ehNIVH9caVWfjvnHtUtBMPOVJbZixVo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M0fDohOgm/EvOnz6+ZtVBgIYgcyrTjaM1JgmLXhzcFcf4o6pT6m04ircIBwg1/44dWRxysMbCqKJffF5lO7qiru98qnXyh60TXlFYZP8PyPZOUzXcUVMjkhxzZDNpBcVLJa1NAJMJW8TgVssV1VRw2UD7sBAarSCPsBc+GR63GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kcYCiRTI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JDYYRB1L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XkQ/nRMNDGZeLSiH9lqGTUYduDHD6ZMy3nq+AdsK3Bk=;
	b=kcYCiRTIl+LmiMYdVDd/965V36HKf4/7l90rRjAbwVC98n0/xZZoU8srnWp3au0FnCnqqy
	8z92PCA3iQdNrDkfE8lW+dwgp2yDry8VSIGK7dtVWXJsaS4QS0YGUqvn6q6vJBCXNmd0jr
	6fA9a3ZluwGINP89UnMeSAunP6uP2oFGqW9gxjcACKEFa3IhLxb/Nut2t89CiHWoFMmMM6
	8lEeq5p89hthT99hRC5jRQDVSxKWuEfCLKarAQH0BtpMMptl4KFtvYVd4YPC7aboEqOwQe
	Fc3Q3KFJVf00VGRnHfejUhGzuB/lPtW+efgL3WeibUS/dS/smnaatCG1LPSQDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439494;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XkQ/nRMNDGZeLSiH9lqGTUYduDHD6ZMy3nq+AdsK3Bk=;
	b=JDYYRB1LlO09BRWh2n+yywq3QC6E5QJbFfW7G75ob1cbLU/VEJGfmx9Ncuwy6uhYR4ie5B
	//NuEGSDKREmdVAQ==
From: "tip-bot2 for Chen Ni" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/timer-econet-en751221: Convert
 comma to semicolon
Cc: Chen Ni <nichen@iscas.ac.cn>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Caleb James DeLisle <cjd@cjdns.fr>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250603060450.1310204-1-nichen@iscas.ac.cn>
References: <20250603060450.1310204-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343949332.1420.3105498016966827953.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     7a3174ef0ce3b507a4a22b25822f13f454eab9f4
Gitweb:        https://git.kernel.org/tip/7a3174ef0ce3b507a4a22b25822f13f454e=
ab9f4
Author:        Chen Ni <nichen@iscas.ac.cn>
AuthorDate:    Tue, 03 Jun 2025 14:04:50 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 12:07:01 +02:00

clocksource/timer-econet-en751221: Convert comma to semicolon

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

