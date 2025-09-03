Return-Path: <linux-tip-commits+bounces-6435-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7A5B4249C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 17:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA43B16119C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 15:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8634301463;
	Wed,  3 Sep 2025 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bVpcKvfL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="URXL0YCt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D343126B3;
	Wed,  3 Sep 2025 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912352; cv=none; b=uAbNlCte+PnxfcUnLHWzqI08tlK3Pvh4UqeKvfxi0R+VxDDlHX+A7lzEqg/13NZsi2pCCibG08k5IvNHJTaPfTxiO5Xq0MF0yLthTZssWQEf8VzzxqSJGvbSrXlHyptCGqJOqRgebvXm+kNCKf0EKmWaA6Hi5NEs+YYkwEX21zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912352; c=relaxed/simple;
	bh=nO+/TO+snez19z+L/apEGT2c2lVn/5o/qQFdvxgjUuk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eqB8hqtKayM9NNCYwnllXvmJiosJ6PQxgeYyoBQgDha7rYzNEC785DAZOAB0MVnAKwR8Torh3th4GPPKueV1cSF5nOfJfPyIQF/m7PJwnChItStCHmMm0bA4amCEc9J02raO8yPNFBvS/aa3Ya+dBCB7XGv5MeeuWrHi13Tq/Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bVpcKvfL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=URXL0YCt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 15:12:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756912348;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzAa6mbHaKP8EFSv69vSDhUvmVsuzIj7roDOMg3vhEk=;
	b=bVpcKvfL8ElaPT+A5Uun5aqIFIivlCmWC9UIziIbhVY97106tCdO9l7OL6UtpwpCgad6y+
	rJqbGPWJqmYHFAxp5IJXJC/lxcE3V/ThCmt5dzI/9miOdewB/xrNpWQXaLhSP9GX54ZlEL
	zi733EZNqTSj2HMSE+vLAhsd1VQGekym4WBmEC8hzdoAQ54eAgVErpSFWycuOyOFI2IrOh
	L7FDVNvfAG8xejZ4zeFusYlkq54LDWscXRzRMUyxoAa1DPnVT3Fz1Wxc316PJr+Uc9scgI
	U0ta0qeHVPDwg0Q9tpwLYypqlVNQHKeIqYw5O9VnbagxKYxLVkzb8ppXQ55SRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756912348;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DzAa6mbHaKP8EFSv69vSDhUvmVsuzIj7roDOMg3vhEk=;
	b=URXL0YCtLIW/FyRNLvFPLXoB3y8emiER+IBjtMLNpYB80hrvFdBp36Q8zzLiyK3OD3qBKm
	83xVBM622AQEf3Cw==
From: "tip-bot2 for Brian Norris" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/test: Ensure CPU 1 is online for hotplug test
Cc: Guenter Roeck <linux@roeck-us.net>,
 Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>,
 David Gow <davidgow@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20250822190140.2154646-7-briannorris@chromium.org>
References: <20250822190140.2154646-7-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175691234688.1920.17485143048251122696.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8ad25ebfa70e86860559b306bbc923c7db4fcac6
Gitweb:        https://git.kernel.org/tip/8ad25ebfa70e86860559b306bbc923c7db4=
fcac6
Author:        Brian Norris <briannorris@chromium.org>
AuthorDate:    Fri, 22 Aug 2025 11:59:07 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Sep 2025 17:04:52 +02:00

genirq/test: Ensure CPU 1 is online for hotplug test

It's possible to run these tests on platforms that think they have a
hotpluggable CPU1, but for whatever reason, CPU1 is not online and can't be
brought online:

    # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:210
    Expected remove_cpu(1) =3D=3D 0, but
        remove_cpu(1) =3D=3D 1 (0x1)
CPU1: failed to boot: -38
    # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:214
    Expected add_cpu(1) =3D=3D 0, but
        add_cpu(1) =3D=3D -38 (0xffffffffffffffda)

Check that CPU1 is actually online before trying to run the test.

Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: David Gow <davidgow@google.com>
Link: https://lore.kernel.org/all/20250822190140.2154646-7-briannorris@chromi=
um.org

---
 kernel/irq/irq_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
index bbb89a3..e2d3191 100644
--- a/kernel/irq/irq_test.c
+++ b/kernel/irq/irq_test.c
@@ -179,6 +179,8 @@ static void irq_cpuhotplug_test(struct kunit *test)
 		kunit_skip(test, "requires more than 1 CPU for CPU hotplug");
 	if (!cpu_is_hotpluggable(1))
 		kunit_skip(test, "CPU 1 must be hotpluggable");
+	if (!cpu_online(1))
+		kunit_skip(test, "CPU 1 must be online");
=20
 	cpumask_copy(&affinity.mask, cpumask_of(1));
=20

