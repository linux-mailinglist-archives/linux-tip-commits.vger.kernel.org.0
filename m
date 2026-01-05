Return-Path: <linux-tip-commits+bounces-7784-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E35D5CF44C8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 16:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16EEA302F915
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 15:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C122FBE0F;
	Mon,  5 Jan 2026 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z30SjNqx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yw/5YKgM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F5920A5E5;
	Mon,  5 Jan 2026 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625543; cv=none; b=MFlzvE0AgzFx/PBeQyKHCd7A5Sjrc1IFSp6B9cEzZEI4UE8XILPSQ0evfG6a5rtal800HLm0gNPMaeyZ8ZHAvBZf82MQi4afPVV9Fc27BJmHGfVw/jCv9IVmxCbnDFhc+ivSqG0B51svxts+VBD+8N1QV30V0fWzY+rf9TSvJvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625543; c=relaxed/simple;
	bh=lWPX0xERmGe8TAj+xJWnm3EGNd/vP+m9fJCvkt9M4MI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=olKVl2iw+kejGEUF7u5VUFgCONAUdy/2l211O+ITE+ZcgSioLNtc5DDRYb0vdamIcuY32wJAc9RVcJU8X5m3w19dal43BG+JtH0yfRnXX4U9pslMVvSmaUj9USNtkTmBQOJJnVR28aA5O5PkiwyEIR0KYbjf9b4E0CwWf4O+tps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z30SjNqx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yw/5YKgM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:05:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767625540;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llPSXTVLrcOrjBYnEufJ0Yj1M6nuLDHG1RQILRM2PMw=;
	b=Z30SjNqx/htZ71x4MOS00AYFgTNVKKhF1FP6v/CO3tfFcXMbQZcaOpeBsrRuYsnR/snTnM
	+RkY72iyq7ak2S+n7AUOeS50eDPxIOUDCMpJ5hVHoKgeCkz6M240qef2ItdsZdHo0wHKAx
	1bUilsLJd4/wFscnQL8pjP40OtbkZZNAlAxIhrJAz+9jYDAhrUy5p0XyEg4KseqBVoT0eE
	isj5vN46AsBw7CQX53QrPSH3eD/iKO8EuQLPBenq48Lu2OnvmcSdoQepQULujHVd/xqSva
	NYWqzlcfnUygTp8XUvjRmjQwhAZF+RlWQ5YgLEGr9CGwqaqpjvcSld87Z5EtOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767625540;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llPSXTVLrcOrjBYnEufJ0Yj1M6nuLDHG1RQILRM2PMw=;
	b=Yw/5YKgMFWQNdrL9cwaOaELseFhIwMv8HKTzCHh1EiltLKZnA5wUHSM23u9EAUGWY8kweN
	IM38WB3SMEABMsDg==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/platform/olpc: Replace strcpy() with
 strscpy() in xo15_sci_add()
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251124125455.5495-2-thorsten.blum@linux.dev>
References: <20251124125455.5495-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762553877.510.3060286115582642750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     c957072d44a735ebbe8385fc3511a4f5e6ccea93
Gitweb:        https://git.kernel.org/tip/c957072d44a735ebbe8385fc3511a4f5e6c=
cea93
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Mon, 24 Nov 2025 13:54:53 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 Jan 2026 15:58:57 +01:00

x86/platform/olpc: Replace strcpy() with strscpy() in xo15_sci_add()

strcpy() has been deprecated=C2=B9 because it performs no bounds checking on =
the
destination buffer, which can lead to buffer overflows. Use the safer
strscpy() instead.

  =C2=B9 https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20251124125455.5495-2-thorsten.blum@linux.dev
---
 arch/x86/platform/olpc/olpc-xo15-sci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/=
olpc-xo15-sci.c
index 68244a3..82c51b6 100644
--- a/arch/x86/platform/olpc/olpc-xo15-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
@@ -7,6 +7,7 @@
=20
 #include <linux/device.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/workqueue.h>
 #include <linux/power_supply.h>
 #include <linux/olpc-ec.h>
@@ -144,8 +145,8 @@ static int xo15_sci_add(struct acpi_device *device)
 	if (!device)
 		return -EINVAL;
=20
-	strcpy(acpi_device_name(device), XO15_SCI_DEVICE_NAME);
-	strcpy(acpi_device_class(device), XO15_SCI_CLASS);
+	strscpy(acpi_device_name(device), XO15_SCI_DEVICE_NAME);
+	strscpy(acpi_device_class(device), XO15_SCI_CLASS);
=20
 	/* Get GPE bit assignment (EC events). */
 	status =3D acpi_evaluate_integer(device->handle, "_GPE", NULL, &tmp);

