Return-Path: <linux-tip-commits+bounces-5088-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446F1A95E30
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 08:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB6516541E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 06:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507C473176;
	Tue, 22 Apr 2025 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfRP6yhp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287E5196;
	Tue, 22 Apr 2025 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303432; cv=none; b=Kt1UM53WuQuulwcKo+vxNIzAyEYTunqXiolwEBn3z1YdH7oCQOwAt7S4iTTDINaD9qKu3u+BhbHZh+mRHr29fUcQPHZgaboj91d6Co9LoCUBj+NpNJai+j1Osd4hB0/9kyR8mc13w6DV8hvO3dCaJUmj2gCJbaq/Ne7SPomUQoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303432; c=relaxed/simple;
	bh=6oEcP68OY46EgBJ0bqRJ0eLQMoG6KqgYe8EFBOXyEzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWOG0SfiG2kXne+UkrXh4TFciqHduGugdUef2ADS8eZi7mDSp+E2aRXZRLOjtd6DKL/zLqcc+XshqyZR+bfc1OvOZD31kwMuEFDF8AF1NdCGxo2BxIPLhtN/HCGNU8n2ZFCZ21ewHl0O7PtBZLJTL5SDis9lzNyuvnbV2H93KUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfRP6yhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD7CC4CEE9;
	Tue, 22 Apr 2025 06:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745303431;
	bh=6oEcP68OY46EgBJ0bqRJ0eLQMoG6KqgYe8EFBOXyEzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HfRP6yhpeg2i1/M5DNaoMhU8MgBJzHJNzA7lAWBY9uLqwKkdfI1rDfS9hpBG0o+2/
	 J8TtdJtDnqLt0GggiOafKv47ult25K27PsQzzOx28IaXRBhzavKtIbToNKvxPqKeMh
	 RufxoWBUDqtU/29qgzjxtJtK6a6NK96HwS70iIqPQjbC7ai9zAeTT66sB0urHIX32D
	 AcuCJHHXn+zM/s00C8l2TTIZzq/tA7n5j4OQnGe6hFK3tRSo7WuEKA1RS4FbsbPSB2
	 E6ka43M1iG8GF168qXqjyPq2FpfPqmlV8YFsLqVbgwVctr0stOkAr0maB6s84JwFst
	 13lu3kUn6oWbw==
Date: Tue, 22 Apr 2025 08:30:28 +0200
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: Re: [tip: x86/microcode] x86/cpu: Help users notice when running old
 Intel microcode
Message-ID: <aAc3hCVAnNLVo-Xh@gmail.com>
References: <174526703555.31282.4002502301046834125.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174526703555.31282.4002502301046834125.tip-bot2@tip-bot2>


* tip-bot2 for Dave Hansen <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the x86/microcode branch of tip:
> 
> Commit-ID:     377781ebaa7c35ab3e91af29074d5f39100372f2
> Gitweb:        https://git.kernel.org/tip/377781ebaa7c35ab3e91af29074d5f39100372f2
> Author:        Dave Hansen <dave.hansen@linux.intel.com>
> AuthorDate:    Mon, 21 Apr 2025 12:56:59 -07:00
> Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> CommitterDate: Mon, 21 Apr 2025 12:59:29 -07:00
> 
> x86/cpu: Help users notice when running old Intel microcode
> 
> Changes from v4:
>  - Update list from commit: 8ac9378 microcode-20241112 Release
> 
> Changes from v3:
>  - Update changelog and documentation to clarify behavior when
>    microcode is updated at runtime.
> 
> Changes from v2:
>  - Make cpu_latest_microcode[] static
>  - Add a pr_info() when the CPU is not in the microcode version list
> 
> Changes from v1:
>  - Flesh out changelog
>  - Add Documentation/
>  - add_taint() and pr_warn() in addition to vulnerabilities/ file
>  - Add checks for running under VMMs. Do not taint and
>    report vulnerability as unknown.

These should not be part of a commit log.

> From: Dave Hansen <dave.hansen@linux.intel.com>

> +	/* Give new microocode a pass: */
> +	if (boot_cpu_data.microcode >= m->driver_data)
> +		return false;

Typo:

  s/microocode
   /microcode

I've amended the commit in tip:x86/microcode accordingly, please let me 
know if this version is fine to you too:

  9127865b15eb ("x86/cpu: Help users notice when running old Intel microcode")

Thanks,

	Ingo

