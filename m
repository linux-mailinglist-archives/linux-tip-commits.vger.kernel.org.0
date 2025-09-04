Return-Path: <linux-tip-commits+bounces-6448-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F7DB43737
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4EA37A737F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 09:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8162FAC02;
	Thu,  4 Sep 2025 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qaafeNma";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S+ppxFoI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2E12F99BE;
	Thu,  4 Sep 2025 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978344; cv=none; b=SPgkRPYLoKXMkxBBsizizXj7eEfDDeOXokITrRm1XeKHa7IHElDWKV8ckGpsICDW/5MsrJjPW26REvkRaCXzX/R91/DmxDAokBpxrQkby6DpOiPldXD77TNVKuWojiFwKL8q0lhv+NrxQ+vuEqoMMwlL8gCAFkbe230dYpqqqtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978344; c=relaxed/simple;
	bh=m8GXJRHUGQ0L0yTth3H9/cgB/paKtf95jFsCm91kI+Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iN2FWKnq8mu78WZmYtmPipTKFjrzEI9qjop2o1Z8rE8cPOdwPSQnlvpZZoNoP+Qm1e4cCOFKksl1LFUefRhJe5SYI7v1sQ/zOCfjGOEszURDNATnpkDScEknaY3P26GheCs7w/UwOnF36NnqOISx4csd4ddCl0e4CT1n8rydpVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qaafeNma; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S+ppxFoI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 09:32:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756978341;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lq6jehDr6eJcViP7bFaHoJ9xB7pnT+ZTima8Ew8JIEk=;
	b=qaafeNmaY+jFpIlXLi3Y0kqjevIus1Q7yGu0kLFyaGNJoFy1QJRvuX53TAV2Gk2iAwfNoy
	4mw4tbuzpzsucSSYJDA4Ju5qz7BE0S8YSr0NmJI2xef8V8cHU4Ro8wjro4YaP8qUjnxsFO
	xDh/EhmRrHO7+G8y6MjyBcL1/yQn2IrN3sZeq3FIiRCDBYbyn++osVxuJqYJIkxYI76/OK
	9DPUSe4NCdkfmAYgVb6u0G8xIKvl7IK3v9sbzjVA75AAoq8kpyxP5nrtI4oFwNn7j6tnu0
	SZysD4arNLS/6yIevgXRN7rFVEkvWnK0tedCrsLIWzvie8GqXQN3d+8av9ak5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756978341;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lq6jehDr6eJcViP7bFaHoJ9xB7pnT+ZTima8Ew8JIEk=;
	b=S+ppxFoIvWyzB24EYtnZPPB97v2gBWIovzm51zvvwJgY0qKupagvlBYkdzSk3hhvkh40iQ
	cv9iJC5d9YXvyiCA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] time: Build generic update_vsyscall() only with
 generic time vDSO
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250826-vdso-cleanups-v1-5-d9b65750e49f@linutronix.de>
References: <20250826-vdso-cleanups-v1-5-d9b65750e49f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175697834069.1920.2638083638720281912.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     ea1a1fa919a5b4f39fa46073e7b3a19b12521f05
Gitweb:        https://git.kernel.org/tip/ea1a1fa919a5b4f39fa46073e7b3a19b125=
21f05
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 26 Aug 2025 08:17:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Sep 2025 11:23:50 +02:00

time: Build generic update_vsyscall() only with generic time vDSO

The generic vDSO can be used without the time-related functionality.
In that case the generic update_vsyscall() from kernel/time/vsyscall.c
should not be built.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250826-vdso-cleanups-v1-5-d9b65750e49f@li=
nutronix.de

---
 kernel/time/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index e6e9b85..f7d52d9 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_LEGACY_TIMER_TICK)			+=3D tick-legacy.o
 ifeq ($(CONFIG_SMP),y)
  obj-$(CONFIG_NO_HZ_COMMON)			+=3D timer_migration.o
 endif
-obj-$(CONFIG_HAVE_GENERIC_VDSO)			+=3D vsyscall.o
+obj-$(CONFIG_GENERIC_GETTIMEOFDAY)		+=3D vsyscall.o
 obj-$(CONFIG_DEBUG_FS)				+=3D timekeeping_debug.o
 obj-$(CONFIG_TEST_UDELAY)			+=3D test_udelay.o
 obj-$(CONFIG_TIME_NS)				+=3D namespace.o

