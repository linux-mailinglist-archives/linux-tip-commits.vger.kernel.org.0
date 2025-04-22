Return-Path: <linux-tip-commits+bounces-5090-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8307EA95E61
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 08:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FC13A4418
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 06:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B477622ACEE;
	Tue, 22 Apr 2025 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXZxpicp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43323C8A9;
	Tue, 22 Apr 2025 06:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303806; cv=none; b=eljZeKgcWfla4pTPXOJyd/l3iezIitUynM3BkDfpvjtcMcLHO+L4pTR/SuemkMf/0Yz871KRHs/ZipmQrcNXTp7i+MQg9CNzXrZgDRQlf4hncptkWZ8OxL5onr9J5Pz37IjO+g/5balrOMhlg98RnGuv4MjqCYAQkM8b0s3zc3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303806; c=relaxed/simple;
	bh=UG4Rz5ctntks1zAtB00ipnWD4DUEj8IhiVeC2SB8244=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEv61NUrq7RjrHbGgba2OPeKBYIYkH9FU0lGPSIBU3LpqDGxh/ZyBELKqkwMESTqu0OaQNNlwVa1Aaqc8dmfUyy2MtmGW0UpO9PU1VEc8lfrFUUwp3DjlgN575jegY22l925LVeEdnLULrgHlLLB2kCrZuZxuhBAsAQnnNd6HMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXZxpicp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3857C4CEED;
	Tue, 22 Apr 2025 06:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745303805;
	bh=UG4Rz5ctntks1zAtB00ipnWD4DUEj8IhiVeC2SB8244=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PXZxpicpqmwOvjFgPjjONP0EMkcMhO+5viagPRbkbGofHWSWXfDe0/QdHt2B4oX15
	 5VKK93aTOBtznjf93edI4sgpIs/jJpLUFU3LUM8HW9hvOZqZd5VIv23Kb2v4mwdl+R
	 RKftLlokAQv4xi03/tH63ySZGr5X4VnNfbxbToFnUMQA2TxDEdjUBTwJbD50l4o81v
	 KW/dbSuiE3aYQjL+8vhsGdOZWFj0vgZoFrUPn3Z286Y27QF8uzE9EZdtiScAB5AM9e
	 wOaADZ5W7/gAOp1QWP07v+sgUXXxKhRJBps/+2Nfj3ClvgGtcq4VCiau/ZDH2dqpVT
	 cy5jBiSComSRw==
Date: Tue, 22 Apr 2025 08:36:41 +0200
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-tip-commits@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: x86/microcode] x86/cpu: Help users notice when running old
 Intel microcode
Message-ID: <aAc4-eFLp_QeLOUu@gmail.com>
References: <174526703555.31282.4002502301046834125.tip-bot2@tip-bot2>
 <aAc3hCVAnNLVo-Xh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAc3hCVAnNLVo-Xh@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> > +	if (boot_cpu_data.microcode >= m->driver_data)
> > +		return false;
> 
> Typo:
> 
>   s/microocode
>    /microcode
> 
> I've amended the commit in tip:x86/microcode accordingly, please let me 
> know if this version is fine to you too:

I've also fixed the format of the new X86_BUG_OLD_MICROCODE entry to 
the canonical format used in <asm/cpufeatures.h> (see the delta patch 
below), and pre-merged tip:x86/cpu with fixes/changes by Boris in that 
area. This avoids a tip:master conflict as well. The current commit is:

  4e2c719782a8 x86/cpu: Help users notice when running old Intel microcode

Thanks,

	Ingo

================>
 arch/x86/include/asm/cpufeatures.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 4d7ed8bf1770..426c7e8f0158 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -533,6 +533,6 @@
 #define X86_BUG_BHI			X86_BUG( 1*32+ 3) /* "bhi" CPU is affected by Branch History Injection */
 #define X86_BUG_IBPB_NO_RET		X86_BUG( 1*32+ 4) /* "ibpb_no_ret" IBPB omits return target predictions */
 #define X86_BUG_SPECTRE_V2_USER		X86_BUG( 1*32+ 5) /* "spectre_v2_user" CPU is affected by Spectre variant 2 attack between user processes */
-#define X86_BUG_OLD_MICROCODE		X86_BUG(1*32 + 6) /* "old_microcode" CPU has old microcode, it is surely vulnerable to something */
+#define X86_BUG_OLD_MICROCODE		X86_BUG( 1*32+ 6) /* "old_microcode" CPU has old microcode, it is surely vulnerable to something */
 
 #endif /* _ASM_X86_CPUFEATURES_H */


