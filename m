Return-Path: <linux-tip-commits+bounces-6185-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD5FB0EBCC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C678FAA3683
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8BB2798E6;
	Wed, 23 Jul 2025 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wfioX98C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MfGGJ8Qy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA5B279354;
	Wed, 23 Jul 2025 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255067; cv=none; b=ZcXLlcRV3636g4EoLQtD5qZj6pwx8odBfC/icpBm6+nenFOn4WhL4d08qRkmeLBJz8STJpoqYAnGiVpF4qRTUjKrEkQfhUgfdB1eU7bhcxlnxo7q3Za6pFirZGnDa/9Y7r6RZL3m/rkHS/M+g4pshsDqCtM2TYoxfAmkqFOAuXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255067; c=relaxed/simple;
	bh=jLeC2ysJPjq3IP8Y2dSZhaWaez2299CWjACFqFqkcQQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r2gX7FB+PHtvjjtzE1P+f4hhruw4heGH/sN9bjHzBevd9pqPQ+Gyv7exN+9XGmSa3Dge3F/ht4HEOGZhA1WErE32KdQRUVWgn9H9+kSMN4nNQkZX6XLDyc/5TH/gunx+dW6U+iRBP8bMCo321qHc/fOO20zS2oh3QtC1rq5OAlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wfioX98C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MfGGJ8Qy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255064;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SsSJw5fHQxRp8as8AceYex/ytgZBSNgOnJ0/wyiBeWQ=;
	b=wfioX98C64/Jmaf8JcG06O/WirE5y7wMzvanfeqvDZDv1rjAoWgZ1ywHRJy5ViAVWvboR+
	pEEPtIaT4cBet6hPlWGHIMsmFoMWEmTePOt/iO2ekuZ+LnlmJcEFTu1DfxnVLgRi6iafqW
	VrdpRhrSbLCcLiX+mkeO7lWgCKwHiHqpWb31OQ1nuctVCtwW8xzwQOOVqoPT/iAo48vD4q
	BiRVMExS4dsHUHAUyoAswm/GN7V50h6uB1i2egfi7TXL9v0veTMF/78cZvGly7y1teLce2
	J8EOnhieKJvd2YHuOz5Z7nwv65+evSkUhtl4vYJSp1R+htGp9Kh8tmin/N2Asw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255064;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SsSJw5fHQxRp8as8AceYex/ytgZBSNgOnJ0/wyiBeWQ=;
	b=MfGGJ8QyJRi42e6PM1kbfGQqzC8hKBDO7PtOBJ7dDWsITORcZG8yJaePqSVHMncduXEznj
	/h7iaiI4RU8AtACg==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/scx200: Add module owner
Cc: Will McVicker <willmcvicker@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250602151853.1942521-2-daniel.lezcano@linaro.org>
References: <20250602151853.1942521-2-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325506282.1420.8255157483904039651.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     3fcc11a56f762b01063a9013613afc09a785778b
Gitweb:        https://git.kernel.org/tip/3fcc11a56f762b01063a9013613afc09a78=
5778b
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:45 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 10 Jul 2025 11:28:29 +02:00

clocksource/drivers/scx200: Add module owner

The conversion to modules requires a correct handling of the module
refcount in order to prevent to unload it if it is in use. That is
especially true with the clockevents where there is no function to
unregister them.

The core time framework correctly handles the module refcount with the
different clocksource and clockevents if the module owner is set.

Add the module owner to make sure the core framework will prevent
stupid things happening when the driver will be converted into a
module.

Reviewed-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20250602151853.1942521-2-daniel.lezcano@linar=
o.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/scx200_hrt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/scx200_hrt.c b/drivers/clocksource/scx200_hr=
t.c
index c3536ff..5a99801 100644
--- a/drivers/clocksource/scx200_hrt.c
+++ b/drivers/clocksource/scx200_hrt.c
@@ -52,6 +52,7 @@ static struct clocksource cs_hrt =3D {
 	.mask		=3D CLOCKSOURCE_MASK(32),
 	.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS,
 	/* mult, shift are set based on mhz27 flag */
+	.owner		=3D THIS_MODULE,
 };
=20
 static int __init init_hrt_clocksource(void)

