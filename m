Return-Path: <linux-tip-commits+bounces-4542-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFF9A70C8E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 23:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC993AF398
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 22:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C859269827;
	Tue, 25 Mar 2025 22:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EO0CpCqC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FEOnd8h5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFDC269802;
	Tue, 25 Mar 2025 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742940597; cv=none; b=p+BIPfIpSSPP02d26fNv8Aijt/gaJGoO7eNRUqSC+sEMgp5uW1MiGr5BOMsLhDeOQSV8o/sS7BRKrT6iO3htkXnhf8nnfYHQ2vhJxDw/sdTdBMr7Iw/0TdTU4wtAktmEorKd6fsXbeTmboMGKH7pXTRFuX8oP2qDp5VrQO2b6vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742940597; c=relaxed/simple;
	bh=9SP55NkCHydcc5zh6KgOQN3mm+HxRetxnkh9pO7ypUY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZLHZkbymyhzwKx/8os0ekB2xiRH+ExDjJLw/0U2OXf+Wam/95tmmRkqYX1iT0XRe6BlgXjgsU59FbJzOlSbZEZwasSU/XWnOGj0iki14JCv0xgnBTTfvPLiDfrPfyxZahKEiKJxi4zIB6Xh2TITr7s8zIZ9kDYttuYwyY6GSHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EO0CpCqC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FEOnd8h5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 22:09:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742940594;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fb7kPfi+Wy9OanhkRs32iZos+tRRQjKsa1fUaMypXY4=;
	b=EO0CpCqChoSB/EQHFXTq8P8ymdcrhebJ98DO9ypMwGpZkAVZLqifQQU3uPdrlZHxrCJ684
	TYHZSt0/rvjrxErHK7VJ8xhoALWq1J8yT84fxyq6LPOASXjvztC3P7d3Jt7dUcLwqxOhZf
	5Bfusf25qif9RUN+Fp/f1icB7Rb4wIC3BGtIEDHX7q7m+G7JdgE40U74gNrwEdWYqKQkN2
	C/uNsMvF6AL1/33/i/kRvQLpJLgoc9ApVPIO9OdjK5JcWhnI80zpZghRPYU9WGFqP/rv1F
	sH3CxcjCv7zQf8kafslXw2nakCHRAb1Ffa2j0fbl0TDt8NK6p5zMJVrOSckINw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742940594;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fb7kPfi+Wy9OanhkRs32iZos+tRRQjKsa1fUaMypXY4=;
	b=FEOnd8h5+cOcMr140KP9e5UGxvg8D73MZt9/u7Kow7N1BOniEV+PheIZKIXdwYkl0Nws+l
	OxLnn19leoApeGCw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool, pwm: mediatek: Prevent theoretical
 divide-by-zero in pwm_mediatek_config()
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 ukleinek@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <fb56444939325cc173e752ba199abd7aeae3bf12.1742852847.git.jpoimboe@kernel.org>
References:
 <fb56444939325cc173e752ba199abd7aeae3bf12.1742852847.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174294059350.14745.5018812024386911589.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     2dad2ba8f2487de932d503a6cd1095c31b2261c9
Gitweb:        https://git.kernel.org/tip/2dad2ba8f2487de932d503a6cd1095c31b2=
261c9
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:56:11 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 23:00:44 +01:00

objtool, pwm: mediatek: Prevent theoretical divide-by-zero in pwm_mediatek_co=
nfig()

With CONFIG_COMPILE_TEST && !CONFIG_CLK, pwm_mediatek_config() has a
divide-by-zero in the following line:

	do_div(resolution, clk_get_rate(pc->clk_pwms[pwm->hwpwm]));

due to the fact that the !CONFIG_CLK version of clk_get_rate() returns
zero.

This is presumably just a theoretical problem: COMPILE_TEST overrides
the dependency on RALINK which would select COMMON_CLK.  Regardless it's
a good idea to check for the error explicitly to avoid divide-by-zero.

Fixes the following warning:

  drivers/pwm/pwm-mediatek.o: warning: objtool: .text: unexpected end of sect=
ion

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "Uwe Kleine-K=C3=B6nig" <ukleinek@kernel.org> (maintainer:PWM SUBSYSTEM)
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/fb56444939325cc173e752ba199abd7aeae3bf12.1742=
852847.git.jpoimboe@kernel.org
---
 drivers/pwm/pwm-mediatek.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 01dfa0f..7eaab58 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -121,21 +121,25 @@ static int pwm_mediatek_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
 	struct pwm_mediatek_chip *pc =3D to_pwm_mediatek_chip(chip);
 	u32 clkdiv =3D 0, cnt_period, cnt_duty, reg_width =3D PWMDWIDTH,
 	    reg_thres =3D PWMTHRES;
+	unsigned long clk_rate;
 	u64 resolution;
 	int ret;
=20
 	ret =3D pwm_mediatek_clk_enable(chip, pwm);
-
 	if (ret < 0)
 		return ret;
=20
+	clk_rate =3D clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
+	if (!clk_rate)
+		return -EINVAL;
+
 	/* Make sure we use the bus clock and not the 26MHz clock */
 	if (pc->soc->has_ck_26m_sel)
 		writel(0, pc->regs + PWM_CK_26M_SEL);
=20
 	/* Using resolution in picosecond gets accuracy higher */
 	resolution =3D (u64)NSEC_PER_SEC * 1000;
-	do_div(resolution, clk_get_rate(pc->clk_pwms[pwm->hwpwm]));
+	do_div(resolution, clk_rate);
=20
 	cnt_period =3D DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
 	while (cnt_period > 8191) {

