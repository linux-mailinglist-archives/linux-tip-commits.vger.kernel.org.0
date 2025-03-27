Return-Path: <linux-tip-commits+bounces-4571-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF90AA72E71
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Mar 2025 12:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55731179478
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Mar 2025 11:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F65B210F6A;
	Thu, 27 Mar 2025 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4G6zAMPt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DYn/x+Y/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3BB1C5F0C;
	Thu, 27 Mar 2025 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073580; cv=none; b=iJ3cK9b1zqxsp0qvgZeKCVtmABdPS7ITGqGQ6pKMBCm4p66hmlKZRhTLQ3eZty8em2S57YteJR1n0vu4iMU1yiCLmFQcAE+zgXhKYnq6SV7OJBe77tNqIo108NstVw9kcpXxSt9bKrkwkOMBbFasSjijwerT6+e+n8alKqGe7U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073580; c=relaxed/simple;
	bh=8UUznqJLxUHqllIRI8qBPHeFZBZRwz7mZOFkmk1D6wg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oWxcvaLtuXSFuZeqWpvD7B7dhs7g2Zu/rY+P/m4xht37WPUiPf7t2tfHhN1TlcbiWZx72fReGo8zw+XgMjgfyXaMTX4y2XDpSpqoY+lFAHdvomABxfVgFjITNkYPPveZ+eBo2skLyEYa7BsIHanEHDTxbtaTy5Al3j71SI9zfh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4G6zAMPt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DYn/x+Y/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Mar 2025 11:06:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743073573;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oi1QEh6TyWE+/E+NgsgA9xeiEXGongDXbr9Dv7hhQV0=;
	b=4G6zAMPtvAkPSNfeSK0y64L6nWe08qW6XtnOaO2Tpq3WLxdObrRQtKK1mB8mM7+IMwm1Lr
	sbc3Q804wpT5lB6wFiPYftMZOdzCJw4JUOwmP88tO0Pvhaur1q+33b55eCk8O0hllpn8/f
	ho6QCjRdcwIxdwGR3g3ygoyp6ini0LWgE2qFKiE3D+8vTKUUpbeDAGNKhYzruhFtONr7hC
	VKhNmuoF/EI8EgCw91n65Iw/y2CKkYephFkaURNcBO9U9PQDlnPQiKUXspPVm5eEUYnT4o
	DpXdIDLLQAgwLxErsCkm1xZCQASQWY+FNQXQDhetATLfiKuEQu+Wl1pW7Lijzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743073574;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oi1QEh6TyWE+/E+NgsgA9xeiEXGongDXbr9Dv7hhQV0=;
	b=DYn/x+Y/h/VDJ5Cd+IK+IokRsmFWkcUaeBctXsNC8DNY1C91wT1F/wYcXSG16NZUox+nQY
	ZyYfONY9WfT3cyAQ==
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
Message-ID: <174307356945.14745.9373897017806755891.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     4e8af314386ec3e0b842f47705321e074b1dd556
Gitweb:        https://git.kernel.org/tip/4e8af314386ec3e0b842f47705321e074b1=
dd556
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:56:11 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Mar 2025 11:57:45 +01:00

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

Fixes: caf065f8fd58 ("pwm: Add MediaTek PWM support")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: "Uwe Kleine-K=C3=B6nig" <ukleinek@kernel.org>
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

