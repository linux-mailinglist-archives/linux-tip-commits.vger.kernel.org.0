Return-Path: <linux-tip-commits+bounces-3625-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A255A44F77
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 23:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B279169C2E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 22:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B5C210F58;
	Tue, 25 Feb 2025 22:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2IMn18Ot";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UmJdPG9N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D23213E8A;
	Tue, 25 Feb 2025 22:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520894; cv=none; b=hduVuuxumOaHmLLcxEIPSrr0RTflDw+C2cSM2ZEv3LqjFjcsooNH8K4C4iMqUYSgOLu2/cydLZnrs5Nz7mPpRIaZG+oR6GGJxwI+hcB1McnAUP2xZgdoh8/AKjwnmVyxNAfPQLITrA36tWcB2Ik7N8dbeZE+/9+y7vRtiYOs13s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520894; c=relaxed/simple;
	bh=mUFqFrUmE2xpp5y+ciiaJp9Tms2xhtUitgQIxUYuEBk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aaFIWvienTvCl8sg0FdPmg9vF9wpnxqrbBfCrDdZ7SJ+BvpWXBmjX+uXbQRE7Vb2soxxURwEusZDBVhkXELNaqxJ5y8blBYdwmOO+E5X5jO9H9Jl7iQ9DZGKcs0P/wif9POWWaJHbPJz2kkBpyykAoEQdVMfY2O7+iE9DlxMwDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2IMn18Ot; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UmJdPG9N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Feb 2025 22:01:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740520891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hL5efWH5krulfWdyCEDRfFI594ElHaIBqMGzpMJyORQ=;
	b=2IMn18Otn1/8/9ALKYOUVd3hh1hfdo4ERfrQbeKIabg8oeIp3/DLNjVi39s7Xn8QvSATB6
	tKav3GSdxz5XSZzVt+MSs2/Ors3u1VSd1vgnU4crMQ/DWNHA+jP5jkspQm8HA9IWHW5aWq
	AyUzLMQsUZq2q5J95bbfJIh5bLheF7iB9qfLU+g0T3TFRIeyQOkY3W7JUbCxeE71xbuI9D
	7OnSGrFOVhGJg/LpYwrJCRGVca/J7ocK6eXCqODzva3rVnnLSH4qPwpzQw5KYli6oQKVs2
	ABhH6FW8LWnvI+uaXSmONVvJE+8GTDef4rL2pu5Elt5CP3PWTUtsa4HiepbOkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740520891;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hL5efWH5krulfWdyCEDRfFI594ElHaIBqMGzpMJyORQ=;
	b=UmJdPG9NNvk/ABeYzp157soLWgoxw2/9R7ZVRCk3r7ZR8axIaZISHYUAxVXw0sAciM20pr
	IzwQaIFsRpF53SDA==
From: "tip-bot2 for Aaron Ma" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/rapl: Add support for Intel Arrow Lake U
Cc: Aaron Ma <aaron.ma@canonical.com>, Ingo Molnar <mingo@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241224145516.349028-1-aaron.ma@canonical.com>
References: <20241224145516.349028-1-aaron.ma@canonical.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174052089028.10177.2125405174996624736.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     68a9b0e313302451468c0b0eda53c383fa51a8f4
Gitweb:        https://git.kernel.org/tip/68a9b0e313302451468c0b0eda53c383fa51a8f4
Author:        Aaron Ma <aaron.ma@canonical.com>
AuthorDate:    Tue, 24 Dec 2024 22:55:16 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Feb 2025 22:48:50 +01:00

perf/x86/rapl: Add support for Intel Arrow Lake U

Add Arrow Lake U model for RAPL:

  $ ls -1 /sys/devices/power/events/
  energy-cores
  energy-cores.scale
  energy-cores.unit
  energy-gpu
  energy-gpu.scale
  energy-gpu.unit
  energy-pkg
  energy-pkg.scale
  energy-pkg.unit
  energy-psys
  energy-psys.scale
  energy-psys.unit

The same output as ArrowLake:

  $ perf stat -a -I 1000 --per-socket -e power/energy-pkg/

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20241224145516.349028-1-aaron.ma@canonical.com
---
 arch/x86/events/rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 4952faf..6941f48 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -879,6 +879,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&model_skl),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&model_skl),
 	X86_MATCH_VFM(INTEL_ARROWLAKE,		&model_skl),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&model_skl),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&model_skl),
 	{},
 };

