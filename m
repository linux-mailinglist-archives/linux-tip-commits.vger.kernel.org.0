Return-Path: <linux-tip-commits+bounces-7277-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC76BC40F49
	for <lists+linux-tip-commits@lfdr.de>; Fri, 07 Nov 2025 17:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 652D14E1147
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Nov 2025 16:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2470330D22;
	Fri,  7 Nov 2025 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rNTT9/nJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RPeQUKv1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D948D328638;
	Fri,  7 Nov 2025 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762534562; cv=none; b=sZOPrmLoq60DsJGQXYmQzfqjwV+ZHqXoBlSDm6Funw8Wysc5pEUvtCJj4jcIxyLeMMq3IACsjXRq6Ks4KvUrax/gXhybzcJz6jW/2ZS1hSXhNKwn4aqt6IzCb+PgG5WNOPoR53mm4PT1Y+XEj/xlg8Rin7JaCh7lOyTyqp30ZXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762534562; c=relaxed/simple;
	bh=3PgWySEyYvaSHE7oqiHAGd8vKq+yDYI6JQ0QjQRlru4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ss655tWrK6Up/12KOr9HQuYz5eB6+zFkjkeB4h1HkqFYVQecd5AYyFVXC7L9NUQeEZDmprEoXAPh+xwRU47frpipj//6NENjZ2GVRO6b6m4ivg8ZKbEfG03vxG/7zHT7NzrGCI4Y2g4j6+xyJwl9Rf8jBu8WnqJhBTE6fjvlgDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rNTT9/nJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RPeQUKv1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 07 Nov 2025 16:55:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762534558;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlmpcdTJ1xyMjTXn7cZEMHhaJU7dCbv7DLRRYptdSj4=;
	b=rNTT9/nJfrNwqWznb+Vzr9rqYFsj8I9SG7omP2Aev9kzlSWu54DhvAWkuLo0+HfXgVeUCh
	DT6i8MGpamwunDDbRUhhQGXHO2FaX6kgEm6o2S7W3pAWvCKmIgFC6kLTQnt0NhCMCCRrr4
	ezTifSnouIiGmrezNbVSBJjGMa3EtBUHtKqa1Ad2q8LdVZLFYJXcPnfI26S1hlxJtyYeSZ
	9AG62mPOt9pacUaLg1FBcETGtr+TuZ0SfAqN04lf7jv3kbplx58q6GsKdscH1Q124Z8J0r
	BK6uBw17rxUzYKD3R5wsJawWcX+ch1l/G1ozNAwbB9kCQ8vlyMJwy3Jl5M+YBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762534558;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DlmpcdTJ1xyMjTXn7cZEMHhaJU7dCbv7DLRRYptdSj4=;
	b=RPeQUKv1su7SmN2nqcwkUtyMWHu171E3zoep+sXLP16LjjAb6lgWxDO9oNRLFhfFmuNekc
	f19Y2X/vBVOsy+DA==
From: "tip-bot2 for Julian Stecklina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Fix frequency in apic=verbose log output
Cc: Markus Napierkowski <markus.napierkowski@cyberus-technology.de>,
 Julian Stecklina <julian.stecklina@cyberus-technology.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20211030142148.143261-1-js@alien8.de>
References: <20211030142148.143261-1-js@alien8.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176253455697.2601451.9188609795419552925.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     ed4f9638d905a97cebd49ecea85cc9b706b73761
Gitweb:        https://git.kernel.org/tip/ed4f9638d905a97cebd49ecea85cc9b706b=
73761
Author:        Julian Stecklina <julian.stecklina@cyberus-technology.de>
AuthorDate:    Sat, 30 Oct 2021 16:21:48 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 07 Nov 2025 17:48:14 +01:00

x86/apic: Fix frequency in apic=3Dverbose log output

When apic=3Dverbose is specified, the LAPIC timer calibration prints its resu=
lts
to the console. At least while debugging virtualization code, the CPU and bus
frequencies are printed incorrectly.

Specifically, for a 1.7 GHz CPU with 1 GHz bus frequency and HZ=3D1000,
the log includes a superfluous 0 after the period:

  ..... calibration result: 999978
  ..... CPU clock speed is 1696.0783 MHz.
  ..... host bus clock speed is 999.0978 MHz.

Looking at the code, this only worked as intended for HZ=3D100. After the fix,
the correct frequency is printed:

  ..... calibration result: 999828
  ..... CPU clock speed is 1696.507 MHz.
  ..... host bus clock speed is 999.828 MHz.

There is no functional change to the LAPIC calibration here, beyond the
printing format changes.

  [ bp: - Massage commit message
        - Figures it should apply this patch about ~4 years later
        - Massage it into the current code ]

Suggested-by: Markus Napierkowski <markus.napierkowski@cyberus-technology.de>
Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20211030142148.143261-1-js@alien8.de
---
 arch/x86/kernel/apic/apic.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 680d305..ca1c8b7 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -173,6 +173,7 @@ static struct resource lapic_resource =3D {
 	.flags =3D IORESOURCE_MEM | IORESOURCE_BUSY,
 };
=20
+/* Measured in ticks per HZ. */
 unsigned int lapic_timer_period =3D 0;
=20
 static void apic_pm_activate(void);
@@ -792,6 +793,7 @@ static int __init calibrate_APIC_clock(void)
 {
 	struct clock_event_device *levt =3D this_cpu_ptr(&lapic_events);
 	u64 tsc_perj =3D 0, tsc_start =3D 0;
+	long delta_tsc_khz, bus_khz;
 	unsigned long jif_start;
 	unsigned long deltaj;
 	long delta, deltatsc;
@@ -894,14 +896,15 @@ static int __init calibrate_APIC_clock(void)
 	apic_pr_verbose("..... calibration result: %u\n", lapic_timer_period);
=20
 	if (boot_cpu_has(X86_FEATURE_TSC)) {
-		apic_pr_verbose("..... CPU clock speed is %ld.%04ld MHz.\n",
-				(deltatsc / LAPIC_CAL_LOOPS) / (1000000 / HZ),
-				(deltatsc / LAPIC_CAL_LOOPS) % (1000000 / HZ));
+		delta_tsc_khz =3D (deltatsc * HZ) / (1000 * LAPIC_CAL_LOOPS);
+
+		apic_pr_verbose("..... CPU clock speed is %ld.%03ld MHz.\n",
+				delta_tsc_khz / 1000, delta_tsc_khz % 1000);
 	}
=20
-	apic_pr_verbose("..... host bus clock speed is %u.%04u MHz.\n",
-			lapic_timer_period / (1000000 / HZ),
-			lapic_timer_period % (1000000 / HZ));
+	bus_khz =3D (long)lapic_timer_period * HZ / 1000;
+	apic_pr_verbose("..... host bus clock speed is %ld.%03ld MHz.\n",
+			bus_khz / 1000, bus_khz % 1000);
=20
 	/*
 	 * Do a sanity check on the APIC calibration result

