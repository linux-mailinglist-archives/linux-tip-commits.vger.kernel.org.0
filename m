Return-Path: <linux-tip-commits+bounces-2876-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB82E9D823F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Nov 2024 10:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BEC9B293D0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Nov 2024 09:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0633F190055;
	Mon, 25 Nov 2024 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1UFGlZjT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3NHGPIjB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7A918FDDF;
	Mon, 25 Nov 2024 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526821; cv=none; b=u7LRTGVfCkHPVhvPhkzEqlXY0k9O2YUKjcAH9+syOmEitprg3v5WMXWTl+u7/MeZkZOWjQ5ccSDqYa/ymxOJwuHAOvJeC25EwhPHbfqSUVpPl1TrYEQJh90c6IOdCxdh6PYF6i1vBCLSXd+mImLnZPspg9H4+UTi/+Szd2cKeNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526821; c=relaxed/simple;
	bh=ZOvArFyPV+QITwaKJRBEskoL/eFx4L+3CD98m9bbb08=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d56bElBgCXy7A9EwuP1Y5GyijIgclFJCCvvFDcMhk3eFm8NOakXbNcRsMewqnQ5N/Tg1mx+QaeubkgFzZv2FyaTUpnT9d3KYPu1YUWn2fQ6o8uPzUlit4WzO7+LArFZZx7nNcPz+JbxzR2vaIkM+rGk6PpWNqzO9rg9qBwiR6l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1UFGlZjT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3NHGPIjB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Nov 2024 09:26:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732526818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYZusqvymI8BXMcEKbOA8u/Ian2JBuiU4YTg5whKRvk=;
	b=1UFGlZjTd90xmWb83fkQJ6AGBwlRx/NQIW+k4R6mz9uw+XGCoTfc2fEXUKnezdAxnE5E1a
	p6AGJoc47I1FJc/wx7ydorOyTzVmeMNlq7HSXbg8UvuTH9gcQwR1jPnUQBsw/7P6m+UoM/
	bkHxjzhSnAVr1R7sH9EnxUhY9OzhNTxSgZAvabz0OQ9OYgI/R//Gdqv7sdAwiwkpgjCYpR
	k3Ti0YKX/+Tc9YCYPBn74PHFf9oGYGaBHgl4JGGFSr3mrKW0HRti/OKGiB9dctQTz0UseM
	t/FfR7jPVeNVi9Krjx4sOX/8aJKWI0kFqNt9UFWKnyxWG8hs3Tao0genFyd+Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732526818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYZusqvymI8BXMcEKbOA8u/Ian2JBuiU4YTg5whKRvk=;
	b=3NHGPIjBQBGzs3mS98Ha3nAsjhCxS9wvcJOAAfxqySkBBqfY3NeUll+cyxyi0RoQknm/rC
	eK975JcLED7hQkAQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Fix PPIN initialization
Cc: Adeel Ashad <adeel.arshad@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241122234212.27451-1-tony.luck@intel.com>
References: <20241122234212.27451-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173252681739.412.4757446080039715116.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d9bb40544653cf039fe79225ec1d742183e2339a
Gitweb:        https://git.kernel.org/tip/d9bb40544653cf039fe79225ec1d742183e2339a
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 22 Nov 2024 15:42:12 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Nov 2024 10:11:33 +01:00

x86/cpu: Fix PPIN initialization

On systems that enumerate PPIN (protected processor inventory
number) using CPUID, but where the BIOS locked the MSR to
prevent access /proc/cpuinfo reports "intel_ppin" feature as
present on all logical CPUs except for CPU 0.

This happens because ppin_init() uses x86_match_cpu() to
determine whether PPIN is supported. When called on CPU 0
the test for locked PPIN MSR results in:

	clear_cpu_cap(c, info->feature);

This clears the X86 FEATURE bit in boot_cpu_data. When other
CPUs are brought online the x86_match_cpu() fails, and the
PPIN FEATURE bit remains set for those other CPUs.

Fix by using setup_clear_cpu_cap() instead of clear_cpu_cap()
which force clears the FEATURE bit for all CPUS.

Reported-by: Adeel Ashad <adeel.arshad@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241122234212.27451-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 06a516f..d9d2d19 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -169,7 +169,7 @@ static void ppin_init(struct cpuinfo_x86 *c)
 	}
 
 clear_ppin:
-	clear_cpu_cap(c, info->feature);
+	setup_clear_cpu_cap(info->feature);
 }
 
 static void default_init(struct cpuinfo_x86 *c)

