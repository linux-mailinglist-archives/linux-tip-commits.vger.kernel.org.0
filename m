Return-Path: <linux-tip-commits+bounces-7545-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81646C8A643
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 15:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF5023581D6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 14:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98D8305E27;
	Wed, 26 Nov 2025 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GNLdkmwb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c1bsAkj2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B9D305070;
	Wed, 26 Nov 2025 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168045; cv=none; b=L/W0bPvryg3zicqTLfL9hV7oxl/ww+i4J86daQaR1NJo3fI1yDgsmA2r9Zy4BcRpUWQc/AFFmsyPxC0eD6mNAmSylh8kcreBIRrq+tbqcbWw+a8aU9Gsf5PjvdtcbBZ4o/dPh5HtA7qh4fS/ggSqZaNx7eJiEnPmZln1f0QPghQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168045; c=relaxed/simple;
	bh=lQqv2MLV0t7l+JlR1k2kQFE7w/QH0Sp0DhFjVKkRnhM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X4n1IHbSGU3ax1zRMHSFfbZ+gzj6DlkEHdiDVokGmbPkDrH7rVnzStHRM8FaYx76NjlCzSxLq2jE/+XICDbZYbN/Ow/y8DIlCZDROaCAuzWurqFH9wNJo4TvGbA2BVxjezYSR4dYk9VZcrar9pFwaiw5ZAwziBZ8dy2nVwIbziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GNLdkmwb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c1bsAkj2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Nov 2025 14:40:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764168042;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtAehLoqP7FI1gWiNtn3licTB9bY3iZ8uDM+GUQ84mk=;
	b=GNLdkmwbOBaXrJk5ZTQPcAEjMuFbnfEqfNa0RnbUVTgLzm8b0y0JCBPHbiXPUn7WXo0fL3
	rIPkVl5zWaJxj2plowO3UyGV9Bo7bjOG9CBzyiQFV6adPA4qBcAcWd/ciXyJtvlRxmHgfq
	6ki2MHAIKFghExMJGxDXQqQFBLVuJgDmzbfB5pGUuzLnJFoRWunVzuZNvtP8MF3eKRsx5N
	c6HvsgqZL2IKK/Hemvw2xJwi0PUYaCQa/NdQN0s5THou+qo7OCbP7UlSxf/W88LRdnyNnV
	G7XKEcjP0DPOVYNQfYgCHj11R1Fotb6ZkOEplSyf+PodmVTPgFA4ULvHc72Ukg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764168042;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtAehLoqP7FI1gWiNtn3licTB9bY3iZ8uDM+GUQ84mk=;
	b=c1bsAkj2ACm7bbqgrI7g0HkHiEYIXyEIC9o+LY0XCfhvOcLK9phXhKHO2jdFKowq/tQReI
	yOq+qGMLsfF/ALCA==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/arm_arch_timer_mmio:
 Prevent driver unbind
Cc: Johan Hovold <johan@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Marc Zyngier <maz@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251111153226.579-2-johan@kernel.org>
References: <20251111153226.579-2-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176416804140.498.4985971315349863628.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     6aa10f0e2ef9eba1955be6a9d0a8eaecf6bdb7ae
Gitweb:        https://git.kernel.org/tip/6aa10f0e2ef9eba1955be6a9d0a8eaecf6b=
db7ae
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Tue, 11 Nov 2025 16:32:24 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 26 Nov 2025 11:24:47 +01:00

clocksource/drivers/arm_arch_timer_mmio: Prevent driver unbind

Clockevents cannot be deregistered so suppress the bind attributes to
prevent the driver from being unbound and releasing the underlying
resources after registration.

Fixes: 4891f01527bb ("clocksource/drivers/arm_arch_timer: Add standalone MMIO=
 driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://patch.msgid.link/20251111153226.579-2-johan@kernel.org
---
 drivers/clocksource/arm_arch_timer_mmio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer_mmio.c b/drivers/clocksource/=
arm_arch_timer_mmio.c
index ebe1987..d103626 100644
--- a/drivers/clocksource/arm_arch_timer_mmio.c
+++ b/drivers/clocksource/arm_arch_timer_mmio.c
@@ -426,6 +426,7 @@ static struct platform_driver arch_timer_mmio_drv =3D {
 	.driver	=3D {
 		.name =3D "arch-timer-mmio",
 		.of_match_table	=3D arch_timer_mmio_of_table,
+		.suppress_bind_attrs =3D true,
 	},
 	.probe	=3D arch_timer_mmio_probe,
 };
@@ -434,6 +435,7 @@ builtin_platform_driver(arch_timer_mmio_drv);
 static struct platform_driver arch_timer_mmio_acpi_drv =3D {
 	.driver	=3D {
 		.name =3D "gtdt-arm-mmio-timer",
+		.suppress_bind_attrs =3D true,
 	},
 	.probe	=3D arch_timer_mmio_probe,
 };

