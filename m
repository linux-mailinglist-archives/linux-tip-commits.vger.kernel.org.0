Return-Path: <linux-tip-commits+bounces-6162-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D121BB0EA86
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 08:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC87A3BB7DE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 06:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701BF26B2DB;
	Wed, 23 Jul 2025 06:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eT5Jy7mI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464AD23F419;
	Wed, 23 Jul 2025 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753251754; cv=none; b=r0npdfw94NuJmsBAB2qyU8J59J6q1OfE1aebV7+evig35bae08nNEKGdgJlobycpQ3D2pEtMPCts113H2SHcfwwNZcC25WgYW88FRZjo8EnafUJn3zriZfOgt/o3IX2NbZqxFQivRIfLlz/cGq8nBVTOr3ejzyrkAaZNOjhd62M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753251754; c=relaxed/simple;
	bh=/K2iEoJuym8tI5Hvox2J9vA4aQ5MKATbtIR56kuJSDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhFykest+Ex12G/NPkN2SO6BjSTVUhYM8LPqfhr6qDmhzWKhltVV8OvL5Xg30pkFG/ey4YxomdIm8FPp47QVQyPnFxN5Ibfs8T/U09vMrwp6AAcyhJWeMbIGl/irMQhwwUDibPTHsVDl4ACEod+ztaNlS5jqqgvCbmQ2+wh/JtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eT5Jy7mI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40435C4CEE7;
	Wed, 23 Jul 2025 06:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753251753;
	bh=/K2iEoJuym8tI5Hvox2J9vA4aQ5MKATbtIR56kuJSDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eT5Jy7mIJoma3YMQ0luCrPtDd5M9ckTvOsJgbLfpnZEyoOVPvU1Oh2EZAlhmwHGtx
	 e+k/jDWNKEMdgxMyNE8xZnqkgzpNP2eDIMZfgPGjecLE/Zb5GYgieQydiBMdRLkMPE
	 azXoDY2UkXb4Txr1s0oGxTuNPmJpIJbkh2LuZWoEtkaUDejBpguXWrtoljaWV/gWTm
	 Z1ETNwV0bf4fTac18i9afXd1zrnFZhwl/U8jx1jSoFlVjamV5XFQB+ST2P6CoxEiRM
	 cXzkodxraUWbrqIgY1LOC2FEAkc7C+qPDNXrBZBmcaXPzxh5M1hxq9xDePFrPC1fnW
	 Fg7g1J5PtDIyA==
Date: Wed, 23 Jul 2025 08:22:29 +0200
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-tip-commits@vger.kernel.org,
	Liangyan <liangyan.peng@bytedance.com>,
	Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org, maz@kernel.org
Subject: Re: [tip: irq/core] genirq: Move irq_wait_for_poll() to call site
Message-ID: <aIB_pfGJ1t-WHJym@gmail.com>
References: <20250718185311.948555026@linutronix.de>
 <175318835421.1420.1426076396982442914.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175318835421.1420.1426076396982442914.tip-bot2@tip-bot2>


Two minor nits:

* tip-bot2 for Thomas Gleixner <tip-bot2@linutronix.de> wrote:

> +		/* Might have been disabled in meantime */
> +		return !irqd_irq_disabled(&desc->irq_data) && desc->action;

This has a (pre-existing) spelling mistake:

 s/in meantime
  /in the meantime

> +		if (WARN_ONCE(irq_poll_cpu == smp_processor_id(),
> +			      "irq poll in progress on cpu %d for irq %d\n",
> +			      smp_processor_id(), desc->irq_data.irq))

And we usually capitalize these:

s/on cpu
 /on CPU

s/irq poll
 /IRQ poll

Just like in the surrounding comments:

> - * If the poll runs on this CPU, then we yell loudly and return

Thanks,

	Ingo

