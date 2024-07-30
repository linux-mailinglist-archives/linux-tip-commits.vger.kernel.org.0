Return-Path: <linux-tip-commits+bounces-1813-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA46D940A9A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 10:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95035285F42
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 08:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFB118D4DC;
	Tue, 30 Jul 2024 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXWjlGMD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADD31922FC
	for <linux-tip-commits@vger.kernel.org>; Tue, 30 Jul 2024 07:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722326363; cv=none; b=R3UBNtSBHC7a7itVeL5xt4krZD99UGF7I3colWdu3C7qedyDpRZKiflmJO1HjOEEblIEL+q2f+3Yqn6Vcok/3+8PLyg2DAN5Ld15PdDnT/C+uYq9+GLK/adFJfnBMvVMD0rRZQlQ0Xa9ZtRsAxu2Uvu2UWWryd8pSeJRT9VJ0D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722326363; c=relaxed/simple;
	bh=JiVkB37Kct7HMhrjIS23mZuyLLwhNw79Hb9et98fb1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZS6oTzhbvxn2s12iCnnHfatuZ/oSiFUhakFPNZ5MfoXWmFHquJqTXOSGUDt6BB4R8nK/5yrNmkAPMHZLG9DvAVB4TvsYJMpnRcimHgVmRhxozB9+2y11MKaiZrKwAUB/Y9WIKVBvBYCCq4atq5prKMd4+U0gGZN3pFQgu3IWw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXWjlGMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6F3C32782;
	Tue, 30 Jul 2024 07:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722326363;
	bh=JiVkB37Kct7HMhrjIS23mZuyLLwhNw79Hb9et98fb1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hXWjlGMDiZ/o2ZYd3xO2Ya3bxubjMAr7D6hBxiqW8jupNxXEQiaKM767Yb4tewgPh
	 oTi6A1Ni93jISUQw4apfX0II77GW1PCI42MH07CbmrRWvgOhHRl8AHymOr/M7jQ5cV
	 j9wJNtCS4gnsYj89cCzEUbHMnfMqaw4Jnt3ZIJ9BMoHe5XuGk4pSRBUDmgOLm9Njbf
	 EOO5C8darQutpVA0dhtnS8CZ+HG7Aal6hGNdr/BmBUY2wApRQBC+RQJBDfe462FXyQ
	 5udMNjFj94/Hl+UjoRrNI8PauJynZ5daV+YNoYJFJz14ARI91w0I3ds7fwgXbhUOaX
	 q+wAIczTmY93A==
Date: Tue, 30 Jul 2024 09:59:17 +0200
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-tip-commits@vger.kernel.org, kabel@kernel.org
Subject: Re: [tip: irq/core] irqchip/armada-370-xp: Change symbol prefixes to
 mpic
Message-ID: <vfz5jnch7fpet7zunhtjghtxixqcgoorowsjtopcvkq77wgoyg@kvburewiv7wq>
References: <20240711115748.30268-7-kabel@kernel.org>
 <172224658404.2215.1380801249029241672.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172224658404.2215.1380801249029241672.tip-bot2@tip-bot2>

One more thing:

> -static void armada_370_xp_mpic_resume(void)
> +static void mpic_resume(void)
>  {
>  	bool src0, src1;
>  	int nirqs;
> -
>  	/* Re-enable interrupts */

This line after 'int nirqs;' was not removed in the original patch.
You remove it here and then add it back in the next patch you applied,
  irqchip/armada-370-xp: Don't read number of supported interrupts multiple times

Marek

