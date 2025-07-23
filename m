Return-Path: <linux-tip-commits+bounces-6172-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4728B0EBA7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCEF67B567C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A75274B5D;
	Wed, 23 Jul 2025 07:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LqLjzyaA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xDRD+FCe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A422749F9;
	Wed, 23 Jul 2025 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255052; cv=none; b=QmQBtJgils+8z3DFf+pUzSIAmFL4jvKXNPJM6pfJ5F0I8RJW96jlnvN8lhSE2whlqsvGQj2GM3BJ9CZHDIumcdf8GvGahb14WHPMVO8wFfzK4dJRh3jUhaSanKxr+mXWcjJWdyLhDiHniBecmeIsoOGwvkY6dwg+nv98WAVxaqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255052; c=relaxed/simple;
	bh=jSz60p4te3lBCnTZAjbKtwSKzD+S2IichRaJn49hnqU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZJMx1CT8Z2uR512gbJPcdhkfhiqbWfgmaX3BKF/WVuW4VYMZF6bz17gKLGDouNN/PGuY3p4gdbHeXAnTahc+XxAwu2QQcvQDiTOctxhDnF9L6saNNllf9+duuvsI5j1uwBwZ/qmMjCy+OPZk4U+AF4QfNsfewI2+A4VXlp+/RBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LqLjzyaA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xDRD+FCe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNbHqeue1jKBeockQt0xK20kPOB9/WEHSR1oMGboaPw=;
	b=LqLjzyaAXl6nC54JLgkcrm/IIV0Dz7fMaafyx4DSn5OGGaHpMlhGZ8bJ8U8C8IlZpBMP/N
	MLELpuYtdnmPeFDeDVvQu4FXvU4JAMAA/hFHbpUYRz+HVjFXFxP2r/K+gE40AccOBqnkAc
	XaLJFEtqrRTuY8+wH0onNvEVS1yzJ5mS45prLnqU7jON+G7J+mbV2uyYFkJ4JFqxapHTqJ
	POdIP/7Q3qreFO2kF/kCoHaYxaJDXfTTRoAoXo+uDaokLhXlt25O/4FAonyIOMhlocOlhE
	VzKajNq6KftjFxLeweVwdVwDwDHHKbMUpDE/uJMDLbtUr3nHxd0SmJ8BobvalQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255048;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNbHqeue1jKBeockQt0xK20kPOB9/WEHSR1oMGboaPw=;
	b=xDRD+FCeh6/3iPC0u5kpPEJWkWtAVv5a6L75XrgZg5lpAcjW+SkwmyQgh1HUW7yDjVicxW
	LAQewt2XH9KFPsCg==
From: "tip-bot2 for Will McVicker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Fix
 uninitialized irq name warning
Cc: Peter Griffin <peter.griffin@linaro.org>,
 Youngmin Nam <youngmin.nam@samsung.com>,
 Will McVicker <willmcvicker@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250620181719.1399856-5-willmcvicker@google.com>
References: <20250620181719.1399856-5-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325504763.1420.10555993979341331557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     60618eec98f059ad688251f5c9990e6929e14632
Gitweb:        https://git.kernel.org/tip/60618eec98f059ad688251f5c9990e6929e=
14632
Author:        Will McVicker <willmcvicker@google.com>
AuthorDate:    Fri, 20 Jun 2025 11:17:07 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 15 Jul 2025 13:00:51 +02:00

clocksource/drivers/exynos_mct: Fix uninitialized irq name warning

The Exynos MCT driver doesn't set the clocksource name until the CPU
hotplug state is setup which happens after the IRQs are requested. This
results in an empty IRQ name which leads to the below warning at
proc_create() time. When this happens, the userdata partition fails to
mount and the device gets stuck in an endless loop printing the error:

  root '/dev/disk/by-partlabel/userdata' doesn't exist or does not contain a =
/dev.

To fix this, we just need to initialize the name before requesting the
IRQs.

Warning from Pixel 6 kernel log:

[  T430] name len 0
[  T430] WARNING: CPU: 6 PID: 430 at fs/proc/generic.c:407 __proc_create+0x25=
8/0x2b4
[  T430] Modules linked in: dwc3_exynos(E+)
[  T430]  ufs_exynos(E+) phy_exynos_ufs(E)
[  T430]  phy_exynos5_usbdrd(E) exynos_usi(E+) exynos_mct(E+) s3c2410_wdt(E)
[  T430]  arm_dsu_pmu(E) simplefb(E)
[  T430] CPU: 6 UID: 0 PID: 430 Comm: (udev-worker) Tainted:
         ... 6.14.0-next-20250331-4k-00008-g59adf909e40e #1 ...
[  T430] Tainted: [W]=3DWARN, [E]=3DUNSIGNED_MODULE
[  T430] Hardware name: Raven (DT)
[...]
[  T430] Call trace:
[  T430]  __proc_create+0x258/0x2b4 (P)
[  T430]  proc_mkdir+0x40/0xa0
[  T430]  register_handler_proc+0x118/0x140
[  T430]  __setup_irq+0x460/0x6d0
[  T430]  request_threaded_irq+0xcc/0x1b0
[  T430]  mct_init_dt+0x244/0x604 [exynos_mct ...]
[  T430]  mct_init_spi+0x18/0x34 [exynos_mct ...]
[  T430]  exynos4_mct_probe+0x30/0x4c [exynos_mct ...]
[  T430]  platform_probe+0x6c/0xe4
[  T430]  really_probe+0xf4/0x38c
[...]
[  T430]  driver_register+0x6c/0x140
[  T430]  __platform_driver_register+0x28/0x38
[  T430]  exynos4_mct_driver_init+0x24/0xfe8 [exynos_mct ...]
[  T430]  do_one_initcall+0x84/0x3c0
[  T430]  do_init_module+0x58/0x208
[  T430]  load_module+0x1de0/0x2500
[  T430]  init_module_from_file+0x8c/0xdc

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20250620181719.1399856-5-willmcvicker@google.=
com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mc=
t.c
index a5ef7d6..62febeb 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -465,8 +465,6 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 		per_cpu_ptr(&percpu_mct_tick, cpu);
 	struct clock_event_device *evt =3D &mevt->evt;
=20
-	snprintf(mevt->name, sizeof(mevt->name), "mct_tick%d", cpu);
-
 	evt->name =3D mevt->name;
 	evt->cpumask =3D cpumask_of(cpu);
 	evt->set_next_event =3D exynos4_tick_set_next_event;
@@ -567,6 +565,14 @@ static int __init exynos4_timer_interrupts(struct device=
_node *np,
 	for (i =3D MCT_L0_IRQ; i < nr_irqs; i++)
 		mct_irqs[i] =3D irq_of_parse_and_map(np, i);
=20
+	for_each_possible_cpu(cpu) {
+		struct mct_clock_event_device *mevt =3D
+		    per_cpu_ptr(&percpu_mct_tick, cpu);
+
+		snprintf(mevt->name, sizeof(mevt->name), "mct_tick%d",
+			 cpu);
+	}
+
 	if (mct_int_type =3D=3D MCT_INT_PPI) {
=20
 		err =3D request_percpu_irq(mct_irqs[MCT_L0_IRQ],

