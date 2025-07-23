Return-Path: <linux-tip-commits+bounces-6181-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82931B0EBBF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900136C5483
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D301027780D;
	Wed, 23 Jul 2025 07:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2dyMcG33";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+q4SqYDa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39116277032;
	Wed, 23 Jul 2025 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255061; cv=none; b=i0luzQWl4t9Jz1NosZkzGoKJmahlwlVxRKERSC7DOnETYUDN2NpFx4RXLElB6jRRMHlJvz8yKVFotN8CIEsJBA5k4Mz1GG5hG5U11PeEI4BDmPt+0gM+ihAbDfngCkv4QoCfij9AziSBrMpeXrbUuf5g3Vw5I3wFBFWKKY5aHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255061; c=relaxed/simple;
	bh=FxszVTLKszHW9f2s+x+gRPNM5JJ89XCsA53xSWx1lqo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jAbSVMuVr33TZiqp5SUMdmdOlbGimsn/PNOzJRDkKm7kxgts4186FACIPQlqKXoH0Ba3qOXiLp6WL9viFcXjcd8t1xhoTtLHToxOj390G+5bA/KOK9sdZSnyqvb32O4BEaVs63DjxYndiMCMPft+Ed0Pt/iSpvmAR7Ttn2bUWok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2dyMcG33; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+q4SqYDa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255058;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0vEKDKSl3sHn7EHcQynxn/SdxQCZs7ehQyH1EHLR8w=;
	b=2dyMcG33nILPWiSXCs2GYl3KmcMV63mBTlFjoJ3NycxGnupqUMTGMYGYa6NfsvKofT5Fry
	zmWp5BuAiracRVs3AgOlNEeI+dbkoDp+VFHFmHaTMeSPxF5DL6evkXiQ18UhvuASO2kDDQ
	0/lk6L5RIK+6I7DRCXh3m4ZiZbFBcDmsCB4POHqAr/2u3614Qj+FRr+Lch+rBIFCllgLRV
	gcTXOb6k950LijHIRQxivdxGCgqtoeNnOSPXD2sdg0gfXKL6ZkkMZiGHXTs+c+TKWbK1W0
	wnkm1/3X0/LYLLPV4mb5w8iccQby5uHlJ+igOZvY6/qSlj0K9rCbwdnN6SLYiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255058;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0vEKDKSl3sHn7EHcQynxn/SdxQCZs7ehQyH1EHLR8w=;
	b=+q4SqYDanHUQ+fhvVkOGWEZ28ApetPOYNlAMOhPtrZVzxVF5QHJ/L3dc/IJ/swIAJZxCIp
	pVuK+R9/Pxn+mFCw==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/cs5535: Add module owner
Cc: Will McVicker <willmcvicker@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250602151853.1942521-7-daniel.lezcano@linaro.org>
References: <20250602151853.1942521-7-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325505768.1420.2073807374854776184.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     fcacf38b9e4408619b2f499ac7cbdfac8eefe668
Gitweb:        https://git.kernel.org/tip/fcacf38b9e4408619b2f499ac7cbdfac8ee=
fe668
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:50 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 10 Jul 2025 11:28:29 +02:00

clocksource/drivers/cs5535: Add module owner

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
Link: https://lore.kernel.org/r/20250602151853.1942521-7-daniel.lezcano@linar=
o.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-cs5535.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-cs5535.c b/drivers/clocksource/timer-c=
s5535.c
index d47acfe..8af666c 100644
--- a/drivers/clocksource/timer-cs5535.c
+++ b/drivers/clocksource/timer-cs5535.c
@@ -101,6 +101,7 @@ static struct clock_event_device cs5535_clockevent =3D {
 	.tick_resume =3D mfgpt_shutdown,
 	.set_next_event =3D mfgpt_next_event,
 	.rating =3D 250,
+	.owner =3D THIS_MODULE,
 };
=20
 static irqreturn_t mfgpt_tick(int irq, void *dev_id)

