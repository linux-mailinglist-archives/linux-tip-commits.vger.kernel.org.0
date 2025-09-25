Return-Path: <linux-tip-commits+bounces-6774-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1489EBA19F6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600261C826BC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46656323416;
	Thu, 25 Sep 2025 21:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MmprvKTK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QITdyjWb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858F5330D5F;
	Thu, 25 Sep 2025 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836044; cv=none; b=HsixMvnlJvLE1UrOH5KsHfU89b2HTAlXLY6dBzQDcA/9XZvRQDiQrIOlk38CHkIicGLAJZR3nTesU9P39/jV2XaS7MHgk08TKS+KqdWMiDRe6jIIi3WZ9+R61oTVV1R8T+NNqax4sAmhQGjBRtuXr6oueHbj7B77KT5nacvFIjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836044; c=relaxed/simple;
	bh=3wLMKJyeW7pRZ7hIuiDWdHCDT7rcjqQJi6WULipNpis=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=rWiIP0I9LKo+EuBe2On3ZEYh+Wa3/SGssw1CIUWRdcQ+HLOBZ9t/GHYFlo9yO9l107q+p6znpiqSQOZuS8/rcikjL5nynF44yipCOp+mpZMPPlMerXnWV+j5q2IAHHG5uPw4S5m/fIZnlaQZ42pdVKzXOKualGgC2UNfSoMsQaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MmprvKTK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QITdyjWb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=l2MwczNxxyimBNqHsLji7dpYTFZzb91q8wRPbRIVZ1E=;
	b=MmprvKTKIvOEHNvAwFGzEmriwaM4h7AuHF5Fvc8ZfIdcn7523CsvYSgXQAcrzmHW/peU6S
	ilyboXHzKHGHW6vv4F8Bh9fKdVglYQa+D5n0ynFyyL8iywAbe6adL0qwPYPtqjsmo5WKD1
	Sl7/h17qx0dYVB7ExrHPrHP+A3P34KQs7Ld+0Ch9r5yy7BfuhYbUH2az1TsJ7mBsMDwV0/
	8Q6QoGEc3jTqy4gVecvMnkTtlpVFOgpB0PJTQrsuLmrIxp0JmdF9SQ7i0bkUheLU1dMzKf
	BLYQlE7+f5+ZcHIl6uBp0EkwSDPGVn4D65s8oMjSph0I3TfOC4GxuAExwt+wBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=l2MwczNxxyimBNqHsLji7dpYTFZzb91q8wRPbRIVZ1E=;
	b=QITdyjWbDZNOu2bgTFI7T3jaVzzEULWHqeoH1gefJXr+5+Le3wQ5y6H8qhSgX0tvncGvRn
	nmQ0vjQrwjnywSDw==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/scx200: Add module owner
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Will McVicker <willmcvicker@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883603962.709179.6961086929028236937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     d6bfdeb4fde74c9a0e227cc1af9dda69c57489f4
Gitweb:        https://git.kernel.org/tip/d6bfdeb4fde74c9a0e227cc1af9dda69c57=
489f4
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:45 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 10:21:24 +02:00

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

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20250602151853.1942521-2-daniel.lezcano@linar=
o.org
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

