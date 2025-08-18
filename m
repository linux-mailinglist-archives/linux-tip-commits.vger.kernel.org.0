Return-Path: <linux-tip-commits+bounces-6279-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF5BB29F1F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 12:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF3D17E3B5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 10:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAB5258EC6;
	Mon, 18 Aug 2025 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="koXpIq8M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l1Y0oZ/F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345E4258EE1;
	Mon, 18 Aug 2025 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512674; cv=none; b=JUE60tNkpgG6XwEskDugMl7rEAGDc9mRhAaHHRLqDUmFsNzoB8Sd5Hlg0keoaP7555obQJW3HjH8ElUh7Ex8D/GfeGr1SrTfitm97HtLY/OHsqs+j0b39ZtEXBD8QBQF0cwBY09nViFt891qxfU88ec1rIni6grt3huwnc084xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512674; c=relaxed/simple;
	bh=i7L1+014Gw6IR4a8hiXhJ84ors+Gx3KHFz/0DrqQHoU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pHjwhxqe8lH7tyhhr/ImKGhVKVi4xkdybPWlMMZPoc42q40slUaYEBf8aVykYW5i1OSJmh5ZjPuVs9a3WRHDw6CqPZhbSIooVYNjet4Xe6yyRCMnPChZoaJeLR8MnyZTfpYbXxZdo9xxar/xWfiOa02REorsWtzY6NnEL93Sl7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=koXpIq8M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l1Y0oZ/F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 10:24:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755512671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fycdq2+B028Urj8Do+r7JEmXzROMYovSgMC1n7RdKho=;
	b=koXpIq8MxYw3N6aT2YSnEwoa6Q5mc8CXtpuGL/OSbpRd7nqbbIt6SaSBjGAnbxLZawe+z2
	cAADGD186YjsqO8jUwUhqHBJOPvagIKP+NRJ1RHQw0CfU1wtupwoKc5xMwLQR/eyeqSz4f
	fKS0dBdXS42BgSmcsRiEaQCzBFk3yX3m+GoGqIaSqf2I3o8olII+VVBwiZeDICvVkrr5e8
	Cc3zhSOcmdfMSmzqruN2H5b7OY1pcWECWzvOJwNUBw/4QK65EhLW3LvUQ3R7RapM/rBiKE
	1gfqEYijAHcwrDwZtM5ag8Wfkb8i0ShEpd1csISGFT81uMaMeEeGg1BNgVwFCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755512671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fycdq2+B028Urj8Do+r7JEmXzROMYovSgMC1n7RdKho=;
	b=l1Y0oZ/FLPLkSE7bG6nMEuz1xO9wmZovcWldKkWk49ek/Z8VT5bnKQLuj5pP+0vhTRGy0Q
	FobVsnLwOiyAHeAQ==
From: "tip-bot2 for Tianxiang Peng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu/hygon: Add missing resctrl_cpu_detect() in
 bsp_init helper
Cc: Tianxiang Peng <txpeng@tencent.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Hui Li <caelli@tencent.com>,
  <stable@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250623093153.3016937-1-txpeng@tencent.com>
References: <20250623093153.3016937-1-txpeng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175551267061.1420.18279444837028370483.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d8df126349dad855cdfedd6bbf315bad2e901c2f
Gitweb:        https://git.kernel.org/tip/d8df126349dad855cdfedd6bbf315bad2e9=
01c2f
Author:        Tianxiang Peng <txpeng@tencent.com>
AuthorDate:    Mon, 23 Jun 2025 17:31:53 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 18 Aug 2025 12:09:26 +02:00

x86/cpu/hygon: Add missing resctrl_cpu_detect() in bsp_init helper

Since

  923f3a2b48bd ("x86/resctrl: Query LLC monitoring properties once during boo=
t")

resctrl_cpu_detect() has been moved from common CPU initialization code to
the vendor-specific BSP init helper, while Hygon didn't put that call in their
code.

This triggers a division by zero fault during early booting stage on our
machines with X86_FEATURE_CQM* supported, where get_rdt_mon_resources() tries
to calculate mon_l3_config with uninitialized boot_cpu_data.x86_cache_occ_sca=
le.

Add the missing resctrl_cpu_detect() in the Hygon BSP init helper.

  [ bp: Massage commit message. ]

Fixes: 923f3a2b48bd ("x86/resctrl: Query LLC monitoring properties once durin=
g boot")
Signed-off-by: Tianxiang Peng <txpeng@tencent.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Hui Li <caelli@tencent.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/20250623093153.3016937-1-txpeng@tencent.com
---
 arch/x86/kernel/cpu/hygon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index 2154f12..1fda6c3 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -16,6 +16,7 @@
 #include <asm/spec-ctrl.h>
 #include <asm/delay.h>
 #include <asm/msr.h>
+#include <asm/resctrl.h>
=20
 #include "cpu.h"
=20
@@ -117,6 +118,8 @@ static void bsp_init_hygon(struct cpuinfo_x86 *c)
 			x86_amd_ls_cfg_ssbd_mask =3D 1ULL << 10;
 		}
 	}
+
+	resctrl_cpu_detect(c);
 }
=20
 static void early_init_hygon(struct cpuinfo_x86 *c)

