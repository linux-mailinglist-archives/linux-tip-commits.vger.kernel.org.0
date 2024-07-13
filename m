Return-Path: <linux-tip-commits+bounces-1695-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE307930501
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 12:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF88A1C20E53
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 10:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2470153389;
	Sat, 13 Jul 2024 10:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aZDrzCC2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fkez75MX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B61311AC;
	Sat, 13 Jul 2024 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720865827; cv=none; b=gQ5L0Eo6EcDLn4LPrScdBbBFpB1tFMmlV9oApU6IfuZnzsBjs1xDVMFTwFVUA65IFAh6NDDGG6QuQ1GpRdVKNwcZDnQ+dTjgXH3kIqLVTNZ08VbQX2Mr0/iBraACmrPHWAwGsZ2y4z/6jAhO8O6jySb3hGZFldYu85W2onUnGjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720865827; c=relaxed/simple;
	bh=zEX2upoX2ikDbKRZuntJoUnPQxy5xPMYgyLAWcq42nI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DY0PPGnD/lm3R7RcoVX/UpgvCjh8+xFL9z06svR0OefhINiqgIiyfUTd90MVi5zz+HNuin45xO6HRUuN8IIRJgr1/4UvbWmYltbWxsMChujrHY8xXTTifOoOFVVMa8QyWmX1UOMOtUj4tPYfDEtNJEHowxIh8dbyj8edIRTDB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aZDrzCC2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fkez75MX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Jul 2024 10:16:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720865816;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IlMRdJjI6yHttYlcwLr8otThfBFz1oM3E9yWSWFfDs=;
	b=aZDrzCC2SocQO21Z3FUZsu3YRD+YrO1R+m1JvB4JdKI1zYzFisqJYkNjSUmmEvLB7SWvYr
	Iicre+noJqTVVQ2oON54Htz1pTnpWUpuVcwP31YCIUotdkSv3dvGMLfih8shWOnBOhlelE
	64mrmmQDK5JWDC9i1vKnWGaB5qpQbyKm43O4Pay0kqPJyKmoDjikZ5d+5saJuVpXTUSaog
	O2ZToAj7rJIAH6ZjGWfDE3YSxztj3BgBRIna9ILlPZPXB8Yf9iKZWBJsddzXXErcWtlMN/
	sDZiiIRB4IaDe1YcGUg/YNsgW3fZtVlUeWGs2ogy5Owezi73+/Z9H3lcfveSAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720865816;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IlMRdJjI6yHttYlcwLr8otThfBFz1oM3E9yWSWFfDs=;
	b=Fkez75MXMaeC8CNdxvXAWXmLba3IVj2TKqp3ImoLCpXeMO1EnKwdYhYDFP2Ps9q6umi5Ju
	fP5dTCnWpqb57pBQ==
From: "tip-bot2 for Li kunyu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/driver/arm_global_timer: Remove
 unnecessary =?utf-8?b?4oCYMOKAmQ==?= values from err
Cc: Li kunyu <kunyu@nfschina.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240705052159.22235-1-kunyu@nfschina.com>
References: <20240705052159.22235-1-kunyu@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172086581592.2215.7896627490526190130.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f3539a6a6998e1e662fdb30af435f239d5931c98
Gitweb:        https://git.kernel.org/tip/f3539a6a6998e1e662fdb30af435f239d59=
31c98
Author:        Li kunyu <kunyu@nfschina.com>
AuthorDate:    Fri, 05 Jul 2024 13:21:59 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 12 Jul 2024 16:07:05 +02:00

clocksource/driver/arm_global_timer: Remove unnecessary =E2=80=980=E2=80=99 v=
alues from err

The 'err' variable is initialized whatever the code path, it is
pointless to initialize it when it is declared.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
Link: https://lore.kernel.org/r/20240705052159.22235-1-kunyu@nfschina.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_global_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm=
_global_timer.c
index ab1c8c2..a05cfaa 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -343,7 +343,7 @@ static int __init global_timer_of_register(struct device_=
node *np)
 {
 	struct clk *gt_clk;
 	static unsigned long gt_clk_rate;
-	int err =3D 0;
+	int err;
=20
 	/*
 	 * In A9 r2p0 the comparators for each processor with the global timer

