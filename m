Return-Path: <linux-tip-commits+bounces-6947-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF13BE48C9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 18:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9835E5BD3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 16:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AC2301000;
	Thu, 16 Oct 2025 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="khc0T9rn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eA+cpOsg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE1D32D0FE;
	Thu, 16 Oct 2025 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631551; cv=none; b=ESQM9BSKl2yjGI2iYl2Yb/L2Lz3WoIJoSgwjBmZztHHPYCvkjYrLlCfCj86RUxJsPhwhKWnMv/KQta//nnS7XBQKRaBLoemIITFTisfMWTOhH6hxQAzYw3xkBtNhtmPchGOimb0F88hsIB9rsJPAyUyHeo4OCRz/YkB7HHL6aRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631551; c=relaxed/simple;
	bh=TG1LH9f0ugAp6QShBhpVnT0/N/Vk86GE7yOip/fY3E0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DE21/TrYcxwC+OPFunf1ucCMM0+mgJ7ZV/oIZvienGkPiLtSEImU/lXuiS5SMnDYMXAd+1TTGtw46nrlZ33qAjKSPaeouZZGISziJipnwiZdT54OZdLAIhAa3zrq9v6HkyviX9/YPtChBOQE1/Bnpm4qwYVbZNfzivfCz1qAw0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=khc0T9rn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eA+cpOsg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760631546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbacNbZ8PoU0CnMy/mXPEaA+xmgiFkgVX5e5fxm4LWM=;
	b=khc0T9rnmavU9b+3ItRiXXAVIIVushGALKxP4I/GbGC6+FviyntGDGgex68FQJVq6j696u
	qDtlMoCjW8Zr/Gaii32D0S6t79g0b6DETd4M149a+miAE9Y8O6pieqVbiDCjaheG7vwXRd
	Nun51YWy5jnQB5a5UIn4KRR4MPD6ebR4ww2Ev/FgLZjZWQLmgoeXIHPGj7oC7f8cd663z2
	xkkNZncz0QFQxVanqc6XcmnYWEBLYwp+gd2LAeZU1vCTUVr47XRYwqnmFNboNhX5NVpsXr
	aJf3/eeXtWEKLRbM5ox5ZaAYP0Cy1noOO55LICEBPyVbksGW3BLv0ug2qN1RpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760631546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbacNbZ8PoU0CnMy/mXPEaA+xmgiFkgVX5e5fxm4LWM=;
	b=eA+cpOsgn/jbHG+8XNVXKn8vDPbj1e5R0+MSNvW326TFlz1xPOe/cNwiUlfpALLOFoF+Zc
	pi0H4+R6hFrww2Dg==
To: Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Florian Fainelli
 <florian.fainelli@broadcom.com>, Changhuang Liang
 <changhuang.liang@starfivetech.com>, x86@kernel.org
Subject: Re: [tip: irq/drivers] irqchip: Pass platform device to platform
 drivers
In-Reply-To: <aPEVtDo1CHibAGxn@hovoldconsulting.com>
References: <20251013094611.11745-12-johan@kernel.org>
 <176062960151.709179.10135307807179758941.tip-bot2@tip-bot2>
 <aPEVtDo1CHibAGxn@hovoldconsulting.com>
Date: Thu, 16 Oct 2025 18:19:05 +0200
Message-ID: <87jz0u251i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 16 2025 at 17:56, Johan Hovold wrote:
> On Thu, Oct 16, 2025 at 03:46:41PM -0000, tip-bot2 for Johan Hovold wrote:
>> The following commit has been merged into the irq/drivers branch of tip:
>> @@ -296,10 +296,9 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
>>  		  },
>>  };
>>  
>> -static int imx_mu_of_init(struct device_node *dn, struct device_node *parent,
>> -			  const struct imx_mu_dcfg *cfg)
>> +static int imx_mu_of_probe(struct platform_device *pdev, struct device_node *parent,
>> +			   const struct imx_mu_dcfg *cfg)
>
> There's still an editing mistake here; the new name should just be
> 'imx_mu_probe'.

Not my day today. Even enabling the correct config knob is too complicated it
seems....

