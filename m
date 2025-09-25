Return-Path: <linux-tip-commits+bounces-6775-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3CFBA1A26
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8193E4C2784
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE88331ADA;
	Thu, 25 Sep 2025 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TERnxLKE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ylqlY1WC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846953314C5;
	Thu, 25 Sep 2025 21:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836045; cv=none; b=W3Bep3J8f5fEcZrDQinGt8QQON53ALfssGg86YgmayP5F8bGAgI+U0jGmo+D/h8osBaCU+Kjyv9lYOe/EB/SDdzM2MmBcDZ4jhq24piY0xwFEYV2qjj6JmgthT6HG6AY0mCvX2/xDYad4f40nAhJDhuED5/vRnaJABOml/tkh/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836045; c=relaxed/simple;
	bh=0cef7OdPqWnKuDfzPOLV/mWrEqCy4ovLwoeed+Pn95o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IgNgli5R0kyCLzdaEm9jbXzvrEqcT/ItlWsrNPg+Ceop/eisoMWMCecDwexjA50Lwd4I3sGy9ixJQQ2ir05Fkm6h9k2ykqIOU+dIWOr8vYxmKSwvWl7EOvb9rLAS3uTZuAdSV267P4bE/bE+gUJw9bgLJgcnI8Q1K8whuVfdrIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TERnxLKE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ylqlY1WC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:34:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836042;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4cGgLzGGbksjDe9i5sYQKjbIf4x+5IStVFVHnDA3s8=;
	b=TERnxLKEt4rqB8SsijZJqmPLoZbJNV5tR4Ijhh0OwO9ivpoKSe95Qphtxp1XDzFwjzizcr
	tRtua2b3qRRkZDq/qWzXR3TtLHZcbN6UTvq/DH00XemKJ1CEVzxxBG1U8DWudadhsef3kx
	fiyPFCvVRLUzb/yAXgtKExCoLdNYDhEPhMS+siUzCQLv2JDhVvIaAD/atunW3Q4AggsoA8
	JGyrKCaq4aPITJNcPZQuHS3bCNa3B8ujDcZCpyEHwN7l7CxNzk9YE7xSV4izfzt2vrt5xz
	9LkEPzLBXC60wYdmjrylAa3yaauyfb7S6qL350RgLwViOg69dyQh+vnD3/DVeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836042;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4cGgLzGGbksjDe9i5sYQKjbIf4x+5IStVFVHnDA3s8=;
	b=ylqlY1WCrbTi+WUicaHFWamdtIYWvSpETTIlYbdI9NUtBKkv4bErshG1X9VcQ7cpfY5ji0
	lwGgmKWBRD3xbxBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] Merge tag 'timers-v6.18-rc1' of
 git://git.kernel.org/pub/scm/linux/kernel/git/daniel.lezcano/linux into
 timers/clocksource
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <685b0f30-9abb-4148-bb02-c15e044795c5@linaro.org>
References: <685b0f30-9abb-4148-bb02-c15e044795c5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883604088.709179.113368927417006658.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     749b61c2d6a91c81732860f22925ae9884de95fe
Gitweb:        https://git.kernel.org/tip/749b61c2d6a91c81732860f22925ae9884d=
e95fe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 25 Sep 2025 23:14:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Sep 2025 23:14:04 +02:00

Merge tag 'timers-v6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git=
/daniel.lezcano/linux into timers/clocksource

Pull clocksource/events driver updates from Daniel Lezcano:

   - Add the module owner to all the drivers which can be converted into
     modules in order to have the core time framework to take the
     refcount and prevent wild module removal. In addition export the
     symbols for the sched_clock_register() function to allow the drivers
     to be converted into modules (Daniel Lezcano)

   - Convert the faraday,fttmr010 DT bindings to yaml schema (Rob
     Herring)

   - Add the DT bindings compatible string for the MT6572 (Max
     Shevchenko)

   - Fix the fsl,ftm-timer bindings by using the items to describe a
     register (Frank Li)

   - Add the DT binding documentation for Andes machine timer (Ben
     Zong-You Xie)

   - Avoid 64-bit divide operation which fails on xtensa and simplify the
     timeleft computation with 32 bits operations on Tegra186 (Guenter
     Roeck)

   - Add the fsl,timrot.yaml DT bindings for i.MX23/i.MX28 timer (Frank
     Li)

   - Replace comma by semicolon which were introduced when moving the
     static structure initialization (Chen Ni)

   - Add a new compatible for the MediaTek MT8196 SoC, fully compatible
     with MT6765 (AngeloGioacchino Del Regno)

   - Add the support for the s32g2 and s32g3 platforms in the PIT timer
     after cleaning up the code to support multiple instances (Daniel
     Lezcano)

   - Generate platform devices for MMIO timers with ACPI and integrate it
     with the arch ARM timer (Marc Zyngier)

   - Fix RTL OTTO timer by working around dying timers (Markus Stockhausen)

   - Remove extra error message in the tegra186 timer (Wolfram Sang)

   - Convert from round_rate() to determine_rate() in the Ingenic sysost
     driver (Brian Masney)

   - Add PWM capture functionality in the OMAP DM driver (Gokul Praveen)

   - Autodetect the clock rate to initialize a prescaler value compatible
     with the frequency changes on the ARM global timer (Markus
     Schneider-Pargmann)

   - Fix rollbacks missing resource deallocation in case of error on the
     clps711x (Zhen Ni)

   - Reorganize the code to split the start and the stop routine on the
     sh_cmt driver (Niklas S=C3=B6derlund)

   - Add the compatible definition for ARTPEC-9 on exynos MCT (SungMin Park)
---

