Return-Path: <linux-tip-commits+bounces-1693-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E42E9304FF
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 12:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707271C210E6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 10:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05D213667E;
	Sat, 13 Jul 2024 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LNZrEMN0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5GIDvHa2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BF2130A4D;
	Sat, 13 Jul 2024 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720865826; cv=none; b=T4DBO27lfiYFZ9d/t+L2/2eWSVyYATXH7MY/vp72XmbxFZ+DPQ3mRuuIiXMIXLnNUetpf96n1wOsl1i14WWJZ8Hpu4PzPf8wYkKU0oEoRMTvHWlhl2Yp6wEbEy3OUc5MQw4PnK5QkQcgsfaQUGQcjIAHXAHYoh8K/SeJL40p05s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720865826; c=relaxed/simple;
	bh=Ymm0IG2Y8sB8rNsbKzCzJCKFBF8eukJ5XExNUEKYAAs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S/5MRvlrXQEbcNxfsbvg3ccpe7kMm2XHm5Wuo0AjimqVsUgz71FwHl2q0b55aX7lQq6KWZB+1YiGdNClrm3YQQanXjleU0zqIvN5t3AVWEty8+HkpZOy9Ez2WbXr78GJvyii8/j21+oB5ZKgg+ITLYn03ONkbF29j5n+WxEf8/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LNZrEMN0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5GIDvHa2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Jul 2024 10:16:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720865816;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZRk+11ioElw52gvALyzF/lM/DVY93lpua3I2d9PHb8=;
	b=LNZrEMN0U+p9Te3JOr1zjjOj1Gqi9Tf9YnocxmrmoVIwMJekP3kRZo9Wdco8PNxEOYeo1I
	cR6bUJtnGhroWZb0lvRk9VzWn+/PGi5EUs6ha1SNlSnnnVvMjkqcEWKg+zGFWaQNP7+oix
	fjifX19o3VXENyZnrn+4+/gI3cYZSBQ5s4kV+tY5kxDSQVKk50fFzY9WdfjfJi0wvgicAD
	rDU0XCAp9KTfsSNEp+xP87kliRFwbc5TUuHrdT0HT1kN9o0sfrWSCSf/TyfCCWB2Gq8kIf
	e7LyN+qvo12n2xcNslZcJ59TSX5g+4U+qT/NHlKBmQfsLlOQSVlVolb+iA9oYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720865816;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZRk+11ioElw52gvALyzF/lM/DVY93lpua3I2d9PHb8=;
	b=5GIDvHa2EmFDBpWH4JqefLlKDkUqFyjnfnQbk3kLqwDiuLbhdZPmeHpBJkX9bQZ9cnMb9s
	WGGm2WwfXax2GVCQ==
From: "tip-bot2 for Li kunyu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Remove
 unnecessary =?utf-8?b?4oCYMOKAmQ==?= values from irq
Cc: Li kunyu <kunyu@nfschina.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240705040729.21961-1-kunyu@nfschina.com>
References: <20240705040729.21961-1-kunyu@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172086581618.2215.7971263654324532005.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7cbbcbd4b5bb68a6208b872612bb301683dc7114
Gitweb:        https://git.kernel.org/tip/7cbbcbd4b5bb68a6208b872612bb301683d=
c7114
Author:        Li kunyu <kunyu@nfschina.com>
AuthorDate:    Fri, 05 Jul 2024 12:07:29 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 12 Jul 2024 16:07:05 +02:00

clocksource/drivers/arm_arch_timer: Remove unnecessary =E2=80=980=E2=80=99 va=
lues from irq

The irq variable is initialized whatever the code path, it is poinless
to initialize when declaring it.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
Link: https://lore.kernel.org/r/20240705040729.21961-1-kunyu@nfschina.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_a=
rch_timer.c
index 5bb43cc..aeafc74 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1556,7 +1556,7 @@ static int __init
 arch_timer_mem_frame_register(struct arch_timer_mem_frame *frame)
 {
 	void __iomem *base;
-	int ret, irq =3D 0;
+	int ret, irq;
=20
 	if (arch_timer_mem_use_virtual)
 		irq =3D frame->virt_irq;

