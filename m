Return-Path: <linux-tip-commits+bounces-7446-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 562ABC78491
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 11:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id EA9922D55A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 10:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C523D345740;
	Fri, 21 Nov 2025 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1CWHu/aU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NcF0GF9a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75B03451CC;
	Fri, 21 Nov 2025 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719078; cv=none; b=YYx9QEVJv8uz3w0Ddq/uOZJQYuvUcjaA9yRIrB9082SCeoMy53owMjVl61zs8yNwDNlPIl3iqvmvTjSutwOhyaMlVeFFVi2fIdl8B8sRnMJbvdq/HkC734gdODSwuX/IgwXIHkIvAu/7asyHDfuYiv5givUwlyh+45yCvzWPSz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719078; c=relaxed/simple;
	bh=uLxw6EfJ22cOL0leviOokBKjCCAjQM4Ah4MeovvmYe4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XGAwiA6w+yGSs6eNhDa1i2ydmiqtkBCCvyynxYqLQeXI8GrzfqwUp/Z5aNkbOHZ+PFNiT4gJ5K8iTKpxFZnSsiRUnCINMYcdyHo61+6wSeV1BffGn15jAhWnggb1EorPjKU7KovF5NtYFoqxsG2v31048ulSXSvEbIavan9R0tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1CWHu/aU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NcF0GF9a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Nov 2025 09:57:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763719075;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6n0KdRNgiLQ6Mu/vdUDmKNQ0WFM5/WbzRrCBhzh84i0=;
	b=1CWHu/aUa8RB5HHlGnIFfBw3FMWsdE9fOTLo2ZbGS+X5xA7RP91U/VMQzOKXzuEJ7PFetJ
	9tU2xxCoEA/BCS30dTFmHanJtpxRlp1DQKf7K+q2Z6AJnqAcVeKCifih5lPw1eFJdPl191
	it0xMAkFCza4W1nNh4LiQiHXyUsRKDxVdVfYJ4I1Y6yT/2IblXyxJdqjC01WB3P3wJ5cwA
	RQuWSoIh9DFFA0qXUW4T5LzK4rarsoMXj68QBZcRww91YnXYrTe9/uijdkD+WvnBkXfJdm
	WOcJ4TQMfG18i/YNZgV9z/akj/V8JiHYzYeIfQRNH20gkAutTPriqaxun5fCVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763719075;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6n0KdRNgiLQ6Mu/vdUDmKNQ0WFM5/WbzRrCBhzh84i0=;
	b=NcF0GF9aij2sSICQgVBsIkcNgIb3rGKt8HXDh68bELJG+QsHvcH8rTGTBEx3j+c6s1sYjh
	WkMb9r/3xq5IJ2BA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] media: atomisp: gc2235: Fix namespace collision
 and startup() section placement with -ffunction-sections
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <d28103a6edf7beceb5e3c6fa24e49dbad1350389.1763669451.git.jpoimboe@kernel.org>
References:
 <d28103a6edf7beceb5e3c6fa24e49dbad1350389.1763669451.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176371907371.498.9090157932452273999.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2c715c9de293b6c05bcdff1c22a7626f3bb42492
Gitweb:        https://git.kernel.org/tip/2c715c9de293b6c05bcdff1c22a7626f3bb=
42492
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 20 Nov 2025 12:14:17 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 10:04:09 +01:00

media: atomisp: gc2235: Fix namespace collision and startup() section placeme=
nt with -ffunction-sections

When compiled with -ffunction-sections (e.g., for LTO, livepatch, dead
code elimination, AutoFDO, or Propeller), the startup() function gets
compiled into the .text.startup section (or in some cases
.text.startup.constprop.0 or .text.startup.isra.0).

However, the .text.startup and .text.startup.* sections are also used by
the compiler for __attribute__((constructor)) code.

This naming conflict causes the vmlinux linker script to wrongly place
startup() function code in .init.text, which gets freed during boot.

Some builds have a mix of objects, both with and without
-ffunctions-sections, so it's not possible for the linker script to
disambiguate with #ifdef CONFIG_FUNCTION_SECTIONS or similar.  This
means that "startup" unfortunately needs to be prohibited as a function
name.

Rename startup() to gc2235_startup().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/d28103a6edf7beceb5e3c6fa24e49dbad1350389.17636=
69451.git.jpoimboe@kernel.org
---
 drivers/staging/media/atomisp/i2c/atomisp-gc2235.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c b/drivers/sta=
ging/media/atomisp/i2c/atomisp-gc2235.c
index 6fc39ab..6050637 100644
--- a/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
+++ b/drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
@@ -491,7 +491,7 @@ static int gc2235_s_power(struct v4l2_subdev *sd, int on)
 	return ret;
 }
=20
-static int startup(struct v4l2_subdev *sd)
+static int gc2235_startup(struct v4l2_subdev *sd)
 {
 	struct gc2235_device *dev =3D to_gc2235_sensor(sd);
 	struct i2c_client *client =3D v4l2_get_subdevdata(sd);
@@ -556,7 +556,7 @@ static int gc2235_set_fmt(struct v4l2_subdev *sd,
 		return 0;
 	}
=20
-	ret =3D startup(sd);
+	ret =3D gc2235_startup(sd);
 	if (ret) {
 		dev_err(&client->dev, "gc2235 startup err\n");
 		goto err;

