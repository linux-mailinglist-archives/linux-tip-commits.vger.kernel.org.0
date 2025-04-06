Return-Path: <linux-tip-commits+bounces-4704-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D4FA7CF54
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Apr 2025 20:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB69416F187
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Apr 2025 18:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7294F2AEE3;
	Sun,  6 Apr 2025 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eQgrto8X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EjuYjn8P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9A9C8CE;
	Sun,  6 Apr 2025 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743962534; cv=none; b=YTR/LcC/79zcrV/5zJ26FsuL4ya3CX73C9M5PlJpXMYYZV6IsfHCNOW4idMnUIz5aTxKYak8IogpSdyCbKyCSDECwIl1KKx+Oi3aqMI+po6YaLiJy8E/wKRdfslwGe5aOppljURAw5auRY+stI6i/aho8MoaSPuFkse8w5s/JNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743962534; c=relaxed/simple;
	bh=QaaVXr5vmbzzGB8LVkgnvkqyO3UdD+SEMR3QSy+BgNU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y4bZOdGdrYZMCXdnOHcrX3HQ7veOUxUCs4vsOy205NuPBWMXsAILKptPX6wH1N6ozQY+5JGDTquxQ3dFWGZXRZwvRQQ0qFXf00xo7kUfPehNChDUday0GZLhoitfLXUNiZOCHXIsRfqlYICENmZtNTg3fK+QkLw5Kumj3G9JCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eQgrto8X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EjuYjn8P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 06 Apr 2025 18:02:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743962530;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qujhkEeCue36EqZBnlB+QQW2AvVUadjyFugCuhgUDA=;
	b=eQgrto8XGxFXNSHhPND/l60udS3KV4DWp6S4xKW+KpkAlW2XklppZMdUml5xoXAmAfN5nm
	zZgKcQiMinST3IAtzk8W/H1YPk8HB0qT2HuxcZPc6NxtL+rsMk3hUrvVujpSxo38bYrrxz
	hwvlGDv0OlRyOZfjclwphPNryEia6sMlM7eCz/seFeAzq8LNtkmi13JbFwvMnq2MVA5ygC
	YeK5z/szZn6OtqSkhbBc2zUpMS2kdqV1j1IGUCSyGMyE3ejXyAyRvgC6c2a2age+aZQuMT
	EmCyZLZZdpZW49oVRlXlakzyGMoZgDimQoXYi21MgoKAB7T1AHfH3c2wUyACFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743962530;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qujhkEeCue36EqZBnlB+QQW2AvVUadjyFugCuhgUDA=;
	b=EjuYjn8PdBerRlHm0mysFHIoCCIkLvZP4aEwXlARl5FNylsoJvK+i/CH+FM3FEzNGruG2y
	tGb2mdfUM7DZowCg==
From: "tip-bot2 for Andi Kleen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpuid: Add AMX and SPEC_CTRL dependencies
Cc: Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Sohil Mehta <sohil.mehta@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Ahmed S. Darwish" <darwi@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240924170128.2611854-1-ak@linux.intel.com>
References: <20240924170128.2611854-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174396252153.31282.17024689977241698815.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     e37aa1211fbfeb9d5e79f4a4b0da898e6d0d53bb
Gitweb:        https://git.kernel.org/tip/e37aa1211fbfeb9d5e79f4a4b0da898e6d0d53bb
Author:        Andi Kleen <ak@linux.intel.com>
AuthorDate:    Tue, 24 Sep 2024 10:01:28 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 06 Apr 2025 19:54:35 +02:00

x86/cpuid: Add AMX and SPEC_CTRL dependencies

Add some missing dependencies to the CPUID dependency table:

 - All the AMX features depend on AMX_TILE
 - All the SPEC_CTRL features depend on SPEC_CTRL

[ mingo: Keep the AMX part of the table grouped ... ]

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Ahmed S. Darwish <darwi@linutronix.de>
Link: https://lore.kernel.org/r/20240924170128.2611854-1-ak@linux.intel.com
---
 arch/x86/kernel/cpu/cpuid-deps.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index a2fbea0..94c062c 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -82,8 +82,12 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_XFD,			X86_FEATURE_XGETBV1   },
 	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
+	{ X86_FEATURE_AMX_FP16,			X86_FEATURE_AMX_TILE  },
+	{ X86_FEATURE_AMX_BF16,			X86_FEATURE_AMX_TILE  },
+	{ X86_FEATURE_AMX_INT8,			X86_FEATURE_AMX_TILE  },
 	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
+	{ X86_FEATURE_SPEC_CTRL_SSBD,		X86_FEATURE_SPEC_CTRL },
 	{}
 };
 

