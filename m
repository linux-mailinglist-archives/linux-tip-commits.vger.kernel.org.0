Return-Path: <linux-tip-commits+bounces-4448-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A17FA6EB9F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827C4169F0A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EEA253B5D;
	Tue, 25 Mar 2025 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UV1ZCBZr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XvxFJtlW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7271EB5F4;
	Tue, 25 Mar 2025 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891695; cv=none; b=hONyWHj2eJoIUxC8tOwQ1/huS3T2lV8sEwAZTAqjb5g2NGpt6UY+kvcIsf7U8tZpzBFSiWRiCbd8k6vRVAipOW9dW7+BRewkT5A+qz0jTwLfcIx/b/RT+EEJeKSvX+I5fwS8Qx9lHax1sRAraLe7srsNAGtsGhNbNy/RB0RV7Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891695; c=relaxed/simple;
	bh=Oe0gnzMpwALs7rqq8kJ4tVIrxCzbXpuL3OLDEmWh7tk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Szyh8jzRDo9YUgxrpUEGd0431TZAoxyvycy7XU+UpqMKpGCsx6cIfuuJfrUYhk3+/hLJCqBAy27Hhmn5HjipGgH4x22DcWtJE0h4Llmz3KdFi3l0NMyA6j6aPctLaeQFkgKUseRv15BxfZNizE8mCnuXyEZbyPp7GdjFxqVIW7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UV1ZCBZr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XvxFJtlW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:34:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891692;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63ANLf9kisoT4yXQfQbhIXnMNAofiKq7VeByHwgRVwg=;
	b=UV1ZCBZr1Ub27YoS2Y5eEyfKN+aVURtZMMebMFxxjMnBhebeuMxTHxZPK3OV1bCUW+JKr3
	0T8ZeXb5gJRJJPLW1ic5ZWkMqkEMguRhTT5txNTfKX0OpeGuoJY71PATkGki/lpPocAUWG
	F09Hp5w8M+Z43Q/58vediOzjTKDVWv7Neo81VGO0EObdzxCJn1PyQWMp1L937jDOSoAa7u
	YZGK44Vm3bSsBQiwLXjajvKIUZQ6u1qSbP+p/ou+r9XRYwxKlOIrKh9u0393fNAeNHO0VO
	q96hrT8TYfo/MIlE9idck80cK1FCoii59sxkmDmOmQyrvpo3tDFkFZtTOsB6mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891692;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63ANLf9kisoT4yXQfQbhIXnMNAofiKq7VeByHwgRVwg=;
	b=XvxFJtlW5rZZk07SYECFa5hq5pEWwQQ8fomE6exJ3m6FuZu6KCbtqHv6naeaMDPktNMTtO
	dhTrE0A0dzODerAw==
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
Message-ID: <174289169184.14745.2432058307739232322.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     2becbc66a151500636046503f541255af6acf4fa
Gitweb:        https://git.kernel.org/tip/2becbc66a151500636046503f541255af6a=
cf4fa
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:56:11 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:32 +01:00

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

