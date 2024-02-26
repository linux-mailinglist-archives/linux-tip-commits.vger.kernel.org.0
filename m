Return-Path: <linux-tip-commits+bounces-567-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CD3866A93
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Feb 2024 08:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA35B21AF1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Feb 2024 07:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CEC1BF24;
	Mon, 26 Feb 2024 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SsKEUzjr"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3BE1BF3B
	for <linux-tip-commits@vger.kernel.org>; Mon, 26 Feb 2024 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708931857; cv=none; b=jcjoiLQSKN9ISa0GMiP1nVPhgJfpAuSvcrWjevLmSJQs4bwaLlPbTdLU/cK3/5r2CMg1UpiTnjQAfIawiQMcipC/ZhDkj92aD89LrbNxMr3ECUiXIwKuiONn3n3Bnk4puiIqhgGbP0HNY9Q91djOB9Do4NJEBGGIOWHoVxfT5bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708931857; c=relaxed/simple;
	bh=7sfpJWS9yPEcYUznneT54gTGOkhkzWcS3MlVJwC5QmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6iZASLhvIktrc0XQvecWCTC5RTNNjlvho4TVKr7I/doXSQrtF4iM9zwnqaKJawLneUOIKvrwX1MguG1WmhQnhUMoUpKu45al/JV8L8DXGDtrnN4QrILud/1kv6Og5bWdcvjpVgM2vo1Ffqu2duRV8CbmChs/+UK1nZ/0+bF5H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SsKEUzjr; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d27184197cso31720441fa.1
        for <linux-tip-commits@vger.kernel.org>; Sun, 25 Feb 2024 23:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708931852; x=1709536652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VmJnXk1/5f8SOZerX82dTM0usf0ZpJTmSgAlaoo8GNo=;
        b=SsKEUzjrtD6zcBMNJM3kFtm894smD71humpOYxZOdFvJCBcWZJ6jW5JAEfbrC8SfGh
         JDKVwK8mfOTifRELahVhNASVlTs4cTPup7mrRdaY2EmTN6eF+ElIUYsnGXrP2X9llrng
         FtfIBd1Wupuv+B4MUp7xt1f5uVEX2G/O++KyAz8lHeTC5L0k1v7nSrIFtZFM6tSvw48Y
         8ze8q1QN+ag1m09pEFeNOWFrjKEekWKKR8t3WiF9YJPG7AQrb675U2iRdnNQE8kJaIGd
         SDBHnpb/886P6QQECkn6nXSzKRm4K3rceNWGZ9iNptVze4N/LKDUlq+OY44wT2HnwljF
         JH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708931852; x=1709536652;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VmJnXk1/5f8SOZerX82dTM0usf0ZpJTmSgAlaoo8GNo=;
        b=UyrvhpsgQ4/za8FmaOOGgAKYWfrZVoyzueKQLoXLwuXPxbvZC9IX91P8g+qll2HI49
         aVRxyqeXElK+yh4pxN3om/mvXhuJg0Pu//mR8SRWUqNQet6sbsBIw26UJczusXAknTIf
         XXGn4eOidtY2ygLgtHSnfTRGEmaBhN0cRHi15b/XKVH8+iLXrI9vgFbFfPObN1ta79wA
         5eozUdURkMkAMW8h/OlIphB9uDxcmWcTezXirOzqhw2WH22Do6hD4FGhy48G8lB43yUS
         JOPQUaEzWoDUVl40/4vFe9Oxayz3i6YlyJ0JncftUgmMBWMq+dEWF8gzwB7rqQENQYZU
         j/gg==
X-Forwarded-Encrypted: i=1; AJvYcCURHIv6femykLUYIZ4tPLG9wA9n1HH4Sck6bbs8FryvvgJwi84qBUyLnp83VOTi04FQfGUZHwHVMW7rzR1CXDw4fVG7/NEghN+LCtF9ZF+tR70=
X-Gm-Message-State: AOJu0YwC5rpx9bGTCxPqqx1qX1ZkKfQVgpKA7dvGidwd+5HNJpTkEjLB
	gK+hvKubtQyb6Qqth18V2wNTeq0EwRDmxpJ6jHeoHpDRc/3TdtBfheC+jiojSEY=
X-Google-Smtp-Source: AGHT+IHivNcDPpisQuQQoRU+uq/yKg2tzhPXkpZXJs8rsL0iMkzFBrJhFnJyQDma7oT61Q10dLwLMA==
X-Received: by 2002:a2e:3c1a:0:b0:2d2:4866:b5b0 with SMTP id j26-20020a2e3c1a000000b002d24866b5b0mr3209661lja.39.1708931852527;
        Sun, 25 Feb 2024 23:17:32 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.216.229])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c468f00b004128f41a13fsm7343911wmo.38.2024.02.25.23.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Feb 2024 23:17:32 -0800 (PST)
Message-ID: <6380ba8d-4e99-46e6-8d92-911d10963ba7@suse.com>
Date: Mon, 26 Feb 2024 09:17:30 +0200
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/urgent] x86/bugs: Add asm helpers for executing VERW
Content-Language: en-US
To: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc: Alyssa Milburn <alyssa.milburn@intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <170839092792.398.3678407222202963581.tip-bot2@tip-bot2>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <170839092792.398.3678407222202963581.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20.02.24 г. 3:02 ч., tip-bot2 for Pawan Gupta wrote:
> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     baf8361e54550a48a7087b603313ad013cc13386
> Gitweb:        https://git.kernel.org/tip/baf8361e54550a48a7087b603313ad013cc13386
> Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> AuthorDate:    Tue, 13 Feb 2024 18:21:35 -08:00
> Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> CommitterDate: Mon, 19 Feb 2024 16:31:33 -08:00
> 
> x86/bugs: Add asm helpers for executing VERW
> 
> MDS mitigation requires clearing the CPU buffers before returning to
> user. This needs to be done late in the exit-to-user path. Current
> location of VERW leaves a possibility of kernel data ending up in CPU
> buffers for memory accesses done after VERW such as:
> 
>    1. Kernel data accessed by an NMI between VERW and return-to-user can
>       remain in CPU buffers since NMI returning to kernel does not
>       execute VERW to clear CPU buffers.
>    2. Alyssa reported that after VERW is executed,
>       CONFIG_GCC_PLUGIN_STACKLEAK=y scrubs the stack used by a system
>       call. Memory accesses during stack scrubbing can move kernel stack
>       contents into CPU buffers.
>    3. When caller saved registers are restored after a return from
>       function executing VERW, the kernel stack accesses can remain in
>       CPU buffers(since they occur after VERW).
> 
> To fix this VERW needs to be moved very late in exit-to-user path.
> 
> In preparation for moving VERW to entry/exit asm code, create macros
> that can be used in asm. Also make VERW patching depend on a new feature
> flag X86_FEATURE_CLEAR_CPU_BUF.
> 
> Reported-by: Alyssa Milburn <alyssa.milburn@intel.com>
> Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Link: https://lore.kernel.org/all/20240213-delay-verw-v8-1-a6216d83edb7%40linux.intel.com
> ---
>   arch/x86/entry/entry.S               | 23 +++++++++++++++++++++++
>   arch/x86/include/asm/cpufeatures.h   |  2 +-
>   arch/x86/include/asm/nospec-branch.h | 13 +++++++++++++
>   3 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
> index 8c8d38f..0033790 100644
> --- a/arch/x86/entry/entry.S
> +++ b/arch/x86/entry/entry.S
> @@ -6,6 +6,9 @@
>   #include <linux/export.h>
>   #include <linux/linkage.h>
>   #include <asm/msr-index.h>
> +#include <asm/unwind_hints.h>
> +#include <asm/segment.h>
> +#include <asm/cache.h>
>   
>   .pushsection .noinstr.text, "ax"
>   
> @@ -20,3 +23,23 @@ SYM_FUNC_END(entry_ibpb)
>   EXPORT_SYMBOL_GPL(entry_ibpb);
>   
>   .popsection
> +
> +/*
> + * Define the VERW operand that is disguised as entry code so that
> + * it can be referenced with KPTI enabled. This ensure VERW can be
> + * used late in exit-to-user path after page tables are switched.
> + */
> +.pushsection .entry.text, "ax"
> +
> +.align L1_CACHE_BYTES, 0xcc
> +SYM_CODE_START_NOALIGN(mds_verw_sel)
> +	UNWIND_HINT_UNDEFINED
> +	ANNOTATE_NOENDBR
> +	.word __KERNEL_DS
> +.align L1_CACHE_BYTES, 0xcc
> +SYM_CODE_END(mds_verw_sel);
> +/* For KVM */
> +EXPORT_SYMBOL_GPL(mds_verw_sel);
> +
> +.popsection
> +
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index fdf723b..2b62cdd 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -95,7 +95,7 @@
>   #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
>   #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
>   #define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
> -/* FREE, was #define X86_FEATURE_LFENCE_RDTSC		( 3*32+18) "" LFENCE synchronizes RDTSC */
> +#define X86_FEATURE_CLEAR_CPU_BUF	( 3*32+18) /* "" Clear CPU buffers using VERW */
>   #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
>   #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
>   #define X86_FEATURE_ALWAYS		( 3*32+21) /* "" Always-present feature */
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 262e655..077083e 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -315,6 +315,17 @@
>   #endif
>   .endm
>   
> +/*
> + * Macro to execute VERW instruction that mitigate transient data sampling
> + * attacks such as MDS. On affected systems a microcode update overloaded VERW
> + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
> + *
> + * Note: Only the memory operand variant of VERW clears the CPU buffers.
> + */
> +.macro CLEAR_CPU_BUFFERS
> +	ALTERNATIVE "", __stringify(verw _ASM_RIP(mds_verw_sel)), X86_FEATURE_CLEAR_CPU_BUF

Any particular reason why this uses RIP-relative vs an absolute address 
mode? I know in our private exchange you said there is no significance 
but for example older kernels have a missing relocation support in 
alternatives. This of course can be worked around by slightly changing 
the logic of the macro which means different kernels will have slightly 
different macros. Relocation support landed in: 
270a69c4485d7d07516d058bcc0473c90ee22185 (6.5)

> +.endm
> +
>   #else /* __ASSEMBLY__ */
>   
>   #define ANNOTATE_RETPOLINE_SAFE					\
> @@ -536,6 +547,8 @@ DECLARE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
>   
>   DECLARE_STATIC_KEY_FALSE(mmio_stale_data_clear);
>   
> +extern u16 mds_verw_sel;
> +
>   #include <asm/segment.h>
>   
>   /**
> 

