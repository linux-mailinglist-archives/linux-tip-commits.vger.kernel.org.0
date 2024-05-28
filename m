Return-Path: <linux-tip-commits+bounces-1306-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E9C8D22FD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 May 2024 20:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12801C23309
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 May 2024 18:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72C1174ECD;
	Tue, 28 May 2024 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qaHC8dMy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ThEQsPy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426E817082B;
	Tue, 28 May 2024 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716919513; cv=none; b=Qaphpd5WVp4DqUBDAts7zQp7NEnwTwUzYXh3B2QJwPBDMflcogNUa2uZNM6XkCgBpe1vQazyIXouQ9wS+z41YbY8lXWEsgDp0Sbek2+09T9Ykq/JNqqc2sDlSlcbNOl/3918uZUtMQPt5KiT9PZFRjwumceeGN+NWmzu4Akmrmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716919513; c=relaxed/simple;
	bh=xw3dqRvKipl4kEur8cFjgd8oD2SF2xa6dmTmSO/FZeI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=U/1HVz/4b0iBc4g0fgDjg83jx1Lor9uC6CS+egV1RS3uq8FoMeV5kO1meWa5duykH2jbNkCL9lf1if7hCLy7F8kjubPx5I382mtXVzGwuwIGsj0YKzU25o4ypAtCjBoKw8OuoGuz9H9pNHLEIyqYNFYw/jPFKzxOZumGaLw3ZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qaHC8dMy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ThEQsPy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 May 2024 18:05:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716919508;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=V5K6vVk5IN24s1UzTbyLTePN4kT77iSBjP/YyjG075c=;
	b=qaHC8dMyTImbr7QOHGLT2+yznKfzSYI1kwjt1JH5fzkke93K7wirTiVhnOls3mZpk5MhZE
	QFH5whWE0Bx/1G7J1ZarTD13ACW0U585YHeozWKnV5Sp9FMrdWZHdLGGV/QupSUAc/7V+q
	XaEhDSzKsk2woJUfi7MKVEwfY04Mp05uzGKzGxyIdjWllHL1ibp0JhuVxJUjDXOohU0AG+
	bEyHfGjftNHRapGJFJORLzE84hAXQjJxxTuyH+IegYHUzdfhUYIhysbCf2c32UECwWvnSl
	19vx10Y/dslqDT5FUT8AnzqxeQfV047WMSibslfA7PR0huyEe2Ea8JGnjj7fgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716919508;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=V5K6vVk5IN24s1UzTbyLTePN4kT77iSBjP/YyjG075c=;
	b=3ThEQsPyQRscts6AHKcTnuMg6okONbzfEalB3h5+F4S86iUrniLKilBhNPm8jU9d/wpTcb
	jz1it68E9j/YHABQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/platform/intel-mid: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171691950792.10875.1205586224750520432.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     2cf615a4519b29a3ad283883d7638279ec1e6b44
Gitweb:        https://git.kernel.org/tip/2cf615a4519b29a3ad283883d7638279ec1e6b44
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 21 May 2024 09:10:01 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 28 May 2024 10:59:02 -07:00

x86/platform/intel-mid: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

N.B. Drop Haswell. CPU model 0x3C was included by mistake
in upstream code.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Andy Shevchenko <andy@kernel.org>
Link: https://lore.kernel.org/all/20240521161002.12866-1-tony.luck%40intel.com
---
 arch/x86/platform/intel-mid/intel-mid.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 7be71c2..f83bbe0 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -22,6 +22,7 @@
 #include <asm/mpspec_def.h>
 #include <asm/hw_irq.h>
 #include <asm/apic.h>
+#include <asm/cpu_device_id.h>
 #include <asm/io_apic.h>
 #include <asm/intel-mid.h>
 #include <asm/io.h>
@@ -55,9 +56,8 @@ static void __init intel_mid_time_init(void)
 
 static void intel_mid_arch_setup(void)
 {
-	switch (boot_cpu_data.x86_model) {
-	case 0x3C:
-	case 0x4A:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_ATOM_SILVERMONT_MID:
 		x86_platform.legacy.rtc = 1;
 		break;
 	default:

