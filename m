Return-Path: <linux-tip-commits+bounces-6187-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BC4B0EBCE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A15AA2816
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5307927990A;
	Wed, 23 Jul 2025 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f2SIZFvk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MLxAxpiC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91FD277C8C;
	Wed, 23 Jul 2025 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255068; cv=none; b=RHtog4ykYa0oK2FYU4PBjNBnsw3twRdJjSbOoJUSMxQecj21KaHoZf7cZld7ADVuIXVmMd687wI/2GjVwattqo7WyGfJMR+zQnSNiwcSgQe1a5MBrtQY0+eCSr3EqGyMW3mer1YqYJnsjnvvd/xKoxqcwsMqGQwiDa3Qur7OYDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255068; c=relaxed/simple;
	bh=y50RhrZVJ3U4Y4K4WmFUgsRI+J/ijmDnFLYnaVCShKk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=upEVDc0Ct4Ol4NN5BnORIdH40XyJgvMYVk8PuOYNxiSs5fXbt1/SW4AGaSjk+CgHwuEPaJ1nBozgpgEgU/Nfew0G+Js4cShXMalDJZNNa3F9fh6s3+6PWTiqxfhZICyA9TNJoulGdMlBpL6Nd0G55Lz59y5b0HrE1O+wIIITIH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f2SIZFvk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MLxAxpiC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255065;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6bLhb/odmEvDRad6om8NZHLtEUMz02n6n72EGJzANM=;
	b=f2SIZFvkMkUWFLBKVlbCfG/Xk4Gz0spdJsDQ8o824xCtOoGM80qpSGjYWLrkodgeukzy5Q
	1k4ksVSu1u7Crsxxp5Am0qJa8YG+2jYwoy/AursArrSoTQt6s+Nnzoo+5ProjsqEHzA6/c
	gUbhFbgoQTXPH/PSJd90IIhXnG/O3nf9ZtNH0ciV1ZfWCngBOky7zpAJ2/2U/CNibIhRLo
	BnNEIUbWg+BjjTG0Gk+U82hr8ZzEMmB1SBtMidSJS1Lmy7KGeWlC3hsDqOcc/IeDz6YfM/
	pS99EJQdgnzDIh1O1oMO585mm4wsGo8l64tGKv/1nOC0qvf1pQ+/+MzkZFp0uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255065;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6bLhb/odmEvDRad6om8NZHLtEUMz02n6n72EGJzANM=;
	b=MLxAxpiC20D/DShSFEqBWEKj6EObTbF46s8LSgqOBTzxBALb/Q3n9C1HKL6mAqwCL+wk61
	in5a+xT1Ck+cxRCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] Merge tag 'timers-v6.17-rc1' of
 git://git.kernel.org/pub/scm/linux/kernel/git/daniel.lezcano/linux into
 timers/clocksource
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <03a99cba-7b63-4816-942f-b99f98779955@linaro.org>
References: <03a99cba-7b63-4816-942f-b99f98779955@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325506386.1420.17303027403816641866.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     799387f1da4e58be5bfa16dd4b4d95244e875c7f
Gitweb:        https://git.kernel.org/tip/799387f1da4e58be5bfa16dd4b4d95244e8=
75c7f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jul 2025 09:02:42 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 23 Jul 2025 09:02:42 +02:00

Merge tag 'timers-v6.17-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git=
/daniel.lezcano/linux into timers/clocksource

Pull clocksource driver updates from Daniel Lezcano:

  - Add the module owner to all the drivers which can be converted into
    modules in order to have the core time framework to take the refcount
    and prevent wild module removal. In addition export the symbols for the
    sched_clock_register() function to allow the drivers to be converted
    into modules (Daniel Lezcano)

  - Convert the faraday,fttmr010 DT bindings to yaml schema (Rob Herring)

  - Add the DT bindings compatible string for the MT6572 (Max Shevchenko)

  - Fix the fsl,ftm-timer bindings by using the items to describe a
    register (Frank Li)

  - Add the DT binding documentation for Andes machine timer (Ben Zong-You
    Xie)

  - Fix the exynos mct driver to allow the module support. The changes
    include fixing the empty IRQ name, changing to percpu interrupts and
    preventing to use the clocksource as a sched clock source on ARM64
    (Will McVicker)

  - Avoid 64-bit divide operation which fails on xtensa and simplify the
    timeleft computation with 32 bits operations on Tegra186 (Guenter
    Roeck)

  - Add the fsl,timrot.yaml DT bindings for i.MX23/i.MX28 timer (Frank Li)

  - Replace comma by semicolon which were introduced when moving the static
    structure initialization (Chen Ni)

  - Add a new compatible for the MediaTek MT8196 SoC, fully compatible with
    MT6765 (AngeloGioacchino Del Regno)

  - Fix section mismatch from the module Exynos MCT conversion (Daniel
    Lezcano)

Link: https://lore.kernel.org/all/03a99cba-7b63-4816-942f-b99f98779955@linaro=
.org
---

