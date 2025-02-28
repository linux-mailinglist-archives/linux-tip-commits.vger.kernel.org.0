Return-Path: <linux-tip-commits+bounces-3728-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC51A48D12
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 01:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95D2168DDB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 00:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430A336C;
	Fri, 28 Feb 2025 00:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fCen5HXq"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D63625;
	Fri, 28 Feb 2025 00:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740701662; cv=none; b=cno8zCf5omiWQrZ4JL0TJnkUGMM9/Z1EBRlagkCXyy7o25GFOEdPPk1UpDcSh/GiiD8RYuiN9cQiC3r9a08GB7ks1WT7VYm5vVjoFt94pybXkD3Z0kNTUoHggzKF8VsGzfXX1x8+Mf79R7tpe4ibUJd1jvIENsvL0knyG6LwqRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740701662; c=relaxed/simple;
	bh=YpFKDckJcGlaQ12DrPDrRSEdA7hf5lD/qWGC/iBYyaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqnJjutw7Zqz2VHf505Azv74ouX7Krejskm8077GJ7g2/dHmISNvFAAQCyaH6+09NGm1Vh9XjxYPnc3I3i47TJef1FBWnWAZuPMJbbDNwwH8PxFk5Q6y+VrA8EgUYTB2jiwyHQHadfOjmeRcurT69MXD0Y0HFGFtyUaF5aQhciA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fCen5HXq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C35B340E01A3;
	Fri, 28 Feb 2025 00:14:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XuBg49EtYIA9; Fri, 28 Feb 2025 00:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740701650; bh=qVstrUsxYc2/NoUvp8ScFWEXiT4iBru3dhQ7NsRBFPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCen5HXqFPb4/NNMOrj++SNb+z5qXcNPwm5hTZLvnj6Aedfy5710/HL5sbDxYWcNb
	 brPLzPrgx3+YiBYI3yipFirrpMPkeDXffgWjQTz8Q915tBCj5DQsmF2EOZy7L5BmYA
	 Y62IIgPWy4XYtci3yjlIglCawk9ZHe2jxPwmWa/GZqS3C8De3HKXqhMSAf0f3P3L6p
	 gXguxaqbA+J5vbMHwLQphcts6e8OIWfXxNiotLP9pal2P4cYFjj7ll22e6QH4WHr/t
	 0szPSvfLnJys/vo87a/5zhSoOXsPnrYD5yKCRDtOp21wDCkp58Ybo5msKU5qvZpF8i
	 rn8RHRwpfVZJDQ99mvYsN9dKtylhv8tVhOs6+M68BgRH5x5sHmkjiIdBd1aYpJqIwY
	 pnLiN8cdNtLjfXNmnsBoy0Ca6Kj7sx8eqyuI7p60jLANiYcxVROuma6ziIAmBpvOlQ
	 8GKETJwCy49lQK6X684XGvYMAWXq5xpsEKmR9KdoQZstVNWuiDLTYKHshiJggcVVNh
	 zAyQvGgH1zhYju6lAivxqeef6lT0OIqxbuUQnVQu3Jxf1moFtS1FswjN8wQFxVwwC+
	 7OOU9yBjcSVS0QBPOzxwQ0LmseS923hKDgtBQeikbuXdGpMrVhjC79VL6EytYwnnbx
	 fbk5c0e/eihW+ZErREwgTCk4=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D78A40E01A1;
	Fri, 28 Feb 2025 00:14:05 +0000 (UTC)
Date: Fri, 28 Feb 2025 01:13:58 +0100
From: Borislav Petkov <bp@alien8.de>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Max Grobecker <max@grobecker.info>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Subject: Re: [tip: x86/cpu] x86/cpu: Don't clear X86_FEATURE_LAHF_LM flag in
 init_amd_k8() on AMD when running in a virtual machine
Message-ID: <20250228001358.GJZ8D_xlMr6DxUT_sO@fat_crate.local>
References: <533f9cf-1957-41e8-a8cc-ddce5438f658-max@grobecker.info>
 <174069015279.10177.12820241052987007054.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <174069015279.10177.12820241052987007054.tip-bot2@tip-bot2>

On Thu, Feb 27, 2025 at 09:02:22PM -0000, tip-bot2 for Max Grobecker wrote:
> This can prevent some docker containers from starting or build scripts to create
> unoptimized binaries.

Who does docker containers with a K8 CPU model? What's the advantage?

> Admittably, this is more a small inconvenience than a severe bug in the kernel
> and the shoddy scripts that rely on parsing /proc/cpuinfo
> should be fixed instead.

Yes.

I find such "wag-the-dog" patches awful.

> This patch adds an additional check to see if we're running inside a

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> virtual machine (X86_FEATURE_HYPERVISOR is present), which, to my
> understanding, can't be present on a real K8 processor as it was introduced
> only with the later/other Athlon64 models.
> 
> Example output with the "lahf_lm" flag missing in the flags list
> (should be shown between "hypervisor" and "abm"):
> 
>     $ cat /proc/cpuinfo
>     processor       : 0
>     vendor_id       : AuthenticAMD
>     cpu family      : 15
>     model           : 6
>     model name      : Common KVM processor
>     stepping        : 1
>     microcode       : 0x1000065
>     cpu MHz         : 2599.998
>     cache size      : 512 KB
>     physical id     : 0
>     siblings        : 1
>     core id         : 0
>     cpu cores       : 1
>     apicid          : 0
>     initial apicid  : 0
>     fpu             : yes
>     fpu_exception   : yes
>     cpuid level     : 13
>     wp              : yes
>     flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
>                       cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx rdtscp
>                       lm rep_good nopl cpuid extd_apicid tsc_known_freq pni
>                       pclmulqdq ssse3 fma cx16 sse4_1 sse4_2 x2apic movbe popcnt
>                       tsc_deadline_timer aes xsave avx f16c hypervisor abm
>                       3dnowprefetch vmmcall bmi1 avx2 bmi2 xsaveopt

This dump is purely useless - it is clear what the code does currently. No
need to dump it.

> 
> ... while kcpuid shows the feature to be present in the CPU:
> 
>     # kcpuid -d | grep lahf
>          lahf_lm             - LAHF/SAHF available in 64-bit mode
> 
> [ mingo: Updated the comment a bit. ]
> 
> Signed-off-by: Max Grobecker <max@grobecker.info>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Link: https://lore.kernel.org/r/533f9cf-1957-41e8-a8cc-ddce5438f658-max@grobecker.info
> ---
>  arch/x86/kernel/cpu/amd.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 54194f5..c1f0a5f 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -631,8 +631,11 @@ static void init_amd_k8(struct cpuinfo_x86 *c)
>  	 * Some BIOSes incorrectly force this feature, but only K8 revision D
>  	 * (model = 0x14) and later actually support it.
>  	 * (AMD Erratum #110, docId: 25759).
> +	 * Only clear capability flag if we're running on baremetal,
> +	 * as we might see a wrong model ID as a guest kernel. In such a case,
> +	 * we can safely assume we're not affected by this erratum.
>  	 */

This comment needs to be in the commit message - we don't document every use
of X86_FEATURE_HYPERVISOR.

> -	if (c->x86_model < 0x14 && cpu_has(c, X86_FEATURE_LAHF_LM)) {
> +	if (c->x86_model < 0x14 && cpu_has(c, X86_FEATURE_LAHF_LM) && !cpu_has(c, X86_FEATURE_HYPERVISOR)) {
>  		clear_cpu_cap(c, X86_FEATURE_LAHF_LM);
>  		if (!rdmsrl_amd_safe(0xc001100d, &value)) {
>  			value &= ~BIT_64(32);

But again, I'm very sceptical about K8 and docker containers and don't buy it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

